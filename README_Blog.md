Lab working Document

BACKGROUND
---------------------

- OpenSSF - Sigstore project method for guaranteeing the end-to-end integrity of software artifacts.
- Why? Software supply-chain security is the area where threat actors are focussed, and these are increasing exponentially. SolarWinds is a good example of the devestating effects.
- What is Software Supply Chain Security? Refers specifically to the security issues introduced by the third-party components and technologies used to write, build, and distribute software. As an example, if an Orgs own code, led to the introduction of a SQL injection attack in the production environment, this would not be a supply chain attack. If however they introduced an OSSC which was maliciously tampered with to send secrets to the attacker, when the code was built, that would constitute a Supply Chain Attack.
- Software supply chain compromises can involve both malicious and unintentional vulnerabilities. T
- The insertion of malicious code anywhere along the supply chain poses a severe risk to downstream users, but unintentional vulnerabilities in the software supply chain can also lead to risks should some party choose to exploit these vulnerabilities. For instance, the log4j open source software vulnerability in late 2021 exemplifies the danger of vulnerabilities in the supply chain, including the open source software supply chain. In this case, log4j, a popular open source Java logging library, had a severe and relatively easily exploitable security bug. Many of the companies and individuals using software built with log4j found themselves vulnerable because of this bug.
- Malicious attacks, or what often amounts to code tampering, deserve special recognition though. In these attacks, an attacker controls the functionality inserted into the software supply chain and can often target attacks on specific victims. These attacks often prey on the lack of integrity in the software supply chain, taking advantage of the trust that software developers place in the components and tools they use to build software. 
- Notable attack vectors include : Compromises of source code systems, such as GitHub or GitLab; build systems, like Jenkins or Tekton; and publishing infrastructure attacks on either corporate software publishing servers, update servers, or on community package infrastructure. 
- Another important attack vector is when an attacker steals the credentials of an individual open source software developer and adds malicious code to a source code management system or published package.

Sigstore aims to help restore this missing integrity, ensuring that software developers and downstream consumers can verify and trust the software on which they depend.

CONCEPTS
---------------------
There are a number of concepts and terms that software professionals interested in software supply chain security use frequently. Not only are these terms generally useful, but these concepts are also relevant to Sigstore and the Sigstore project’s mission.

SLSA Framework:
---------------
The Supply chain Levels for Software Artifacts (SLSA, pronounced “salsa”) framework is an incremental series of measures that protect the integrity of a software project’s software supply chain. There are four SLSA levels (1-4) with higher levels representing more security. The incremental approach allows organizations to adopt SLSA in a piecemeal fashion. The security measures associated with SLSA span the source code, build system, provenance, and any associated computer systems. The SLSA framework is itself an open source project.

Software Integrity:
------------------
Software artifacts that have integrity have not been modified in an unauthorized manner. For instance, an artifact that has been replaced by an attacker or an artifact that has had bit flips due to hard drive corruption would not have integrity.

Code Signing:
-------------
Code signing refers to the creation of a cryptographic digital signature that ties an identity (often a company or a person) to an artifact. This signature proves to the consumer that the software has not been tampered with and that the specified party approves the artifact. Signing an artifact typically requires generating a keypair of public and private keys. The signer uses the private key to digitally sign the artifact and the consumer uses the public key to verify that the private key was used to sign the artifact.

By signing software, you can authenticate that you are who you say you are, which can in turn enable a trust root so that developers who leverage your software and consumers who use your software can verify that you created the software artifact that you have said you’ve created. They can also ensure that that artifact was not tampered with by a third party. As someone who may use software libraries, containers, or other artifacts as part of your development lifecycle, a signed artifact can give you greater assurance that the code or container you are incorporating is from a trusted source.


Attestations:
--------------
An attestation is signed metadata about one or more software artifacts. Metadata can refer, for instance, to how an artifact was produced, including the build command and associated dependencies. In fact, there are many different types of possible metadata for a software artifact. Crucially, an attestation must also include a signature by the party that created the attestation. The SLSA project contains more information on the definition of a software attestation.

SBOMs:
-------
SBOM (pronounced “S-bomb”) refers to a software bill of materials, or a list of ingredients that make up software components. SBOMs are widely viewed as one helpful building block for software security and software supply chain security risk management. You can find more information on SBOMs via a Linux Foundation SBOM report. There is also a Linux Foundation training course on “Generating a Software Bill of Materials.

Provenance:
------------
In the context of software security, provenance refers to information about who produced one or more software artifacts, and what steps and materials were used to produce those artifacts. This information helps software consumers make informed decisions about what software to consume and trust. You can find a specific technical definition of provenance via the SLSA website.

SIGSTORE
------------

Sigstore, notably has 3 compnents that provide a system that makes widespread signing and verification of software artifacts possible. Software developers can more easily sign what they create, and software consumers can ensure that their software possesses integrity and was not compromised by tampering.

Cosign - creates a key pair with public and private keys and then uses the private key to create a digital signature of software artifacts, that is, any item produced during the software development lifecycle, such as containers or open source software packages. This is the first step in creating a system that supports end-to-end integrity of a software artifact: the software developer must attach a signature to the created artifact. And, unlike previous approaches, Cosign (in combination with Fulcio, described next) reduces the burden on software developers by allowing them to use their identity associated with popular internet platforms (like GitHub) and therefore avoid storing private keys, which is both a hassle and a security risk.

Cosign: Supports software artifact signing, verification, and storage in an OCI (Open Container Initiative) registry. While Cosign was developed with containers and container-related artifacts in mind, it can also be used for open source software packages and other file types. Cosign can therefore be used to sign blobs (binary large objects), files like READMEs, SBOMs (software bill of materials), Kubernetes Helm Charts, Tekton bundles (an OCI artifact containing Tekton CI/CD resources like tasks), and more.

Fulcio - is a certificate authority that binds public keys to email addresses (such as a Google account) using OpenID Connect. Fulcio serves as a trusted third party, helping parties that need to attest and verify identities. By connecting an identity to a verified email or other unique identifier, developers can attest that they truly did create their signed artifacts and later software consumers can verify that the software artifacts they use really did come from the expected software developers.

Rekor - stores records of artifact metadata, providing transparency for signatures and therefore helping the open source software community monitor and detect any tampering of the software supply chain. On a technical level, it is an append-only (sometimes called “immutable”) data log that stores signed metadata about a software artifact, allowing software consumers to verify that a software artifact is what it claims to be.










Verifying an Image using an Admission Controller
--------------------------------------------------