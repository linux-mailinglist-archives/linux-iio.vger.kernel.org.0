Return-Path: <linux-iio+bounces-17925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD9A84FA0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 00:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4C44C1D5F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5820FAAB;
	Thu, 10 Apr 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GlcyBZft"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1B1EB9F9;
	Thu, 10 Apr 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323931; cv=fail; b=bs4m9jrciOYYQ2J+u/2zpckRwSx1mneHW/rIp2zlnpXxnXvxkVRF/HMkZLnyiERxzxPaSVQPviLeI0lWuphLj5ALk3sXrl6rA2+GS56A2Ah8Ds9pRCMIPms5LtoMoRkzwLwIbby4JDfp/L1xm6QKZNw23v7B0Ocvb+/TNRBXFdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323931; c=relaxed/simple;
	bh=Wll/dItWJbcHIFxyalwWK6ZjXSOIp/0yJkSuYc7W90o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sdYPFc0k89R4vLJUt5ZdxxRQbmQTI9jltNao7K+4JOKDLDRQTbJN4OWwTUhCDu6Sx5pj4Syz40tksBiPP2x0GRUXcfV/H9jPkLk6qjXxhFRPh+SJeI1eQBEabxz6AhKAMlt25ALq74tcl8rtO8B6HKaoamg9dWLnCqrv8DhFXRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GlcyBZft; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKuLjdNiwTBt9fVqNpmahOgaOo/iW51DZ5RSfOfD5epoVFKpuzpOZ8lgN5mspfVk5u7FdCR3KOlFseuiwyUOdMXQuHTw2EzXQwWIk/CBCt0vTroyyG7oNJTIC+70BQA1Wd8ycbFTcA3qxWWXYJmYZfvGPWF2Zgq9uoQPSBeG1fwQQ/oDALvVPkEi0pGlQoy/hCj3gSe/c6+lrrfVxXCKzeO6byilYiLNruvtDLUaAuE6atJ+ccF9WV0UWQxZ58w4hOweHtl4lP0RNJK0mUWRAXCM42AD8ja5LHsswEUuCK+JSecEAPvcdPMpqfLcFCjsVUF6RKocXJj1pp8nyl4CLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWyVzC9N2xF6D/01QaIhtA1JN17CuhYXgBS1pZtjQUs=;
 b=k+3/aMNdUN9QYV+TZxPY0kJAQfGEfs6QokD+bZaAo/TlAL5yIDmtWQjsZEEyweV1sBKWFvgRRwchd4Wpy7j0kGARTQype1KVvqSl8ys3RlKGNLbNgU132btrm4Or7Y1n7STRj7vMD92MAWgm7M5qmUxgBqL2GUBolCWTNBfth+NcoCcJm4JwAEbymvR/AjeJ8amAXlsn+4sYmfA/0FYQcDV2Qg9CeQIPT33eERzyvH9T6yNYyfmtSTA8sxb//SXm25uwuMDR/20YHYlOVWezji2ky9TRQUO36ouGFYgQFPnxT839OSdaRjfzK3BnG+jwb5CaLDMcFNuu1LDQigeNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWyVzC9N2xF6D/01QaIhtA1JN17CuhYXgBS1pZtjQUs=;
 b=GlcyBZfttn/pPjBEkujZ+MUXDJKNjScdhjJ44ESIF4AcYy4LT6TFKsCkLSjOehrKSZ22slDDfW3vmlZJaRiG/KwKXJ+WVXR/ZqhzVexBdAetIJfix6Nf7G/N8pLcSKV1T0e6b7madusHiWYxzQTtxeiayR1bUyesWwaeOduQsxmpT149Lx+7Ykw5mF0LAcM3rVp3B/6Sxi5WUnwzPnt0NYO/RBv5IIxfFX4DwluKVmJhdRCRPLbo/LKMqTEQC1nfIeYhO1eZC+bmhwgxZMymu24RWmV6tnjjwJmw0QxCv0LgS2eOM7rEO30CiC1C9bbw6vJCHl01RO/3ViGFdcYoMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10300.eurprd04.prod.outlook.com (2603:10a6:800:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Thu, 10 Apr
 2025 22:25:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 22:25:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Havelange <patrick.havelange@essensium.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-iio@vger.kernel.org (open list:FLEXTIMER FTM-QUADDEC DRIVER)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: counter: Convert ftm-quaddec.txt to yaml format
Date: Thu, 10 Apr 2025 18:25:05 -0400
Message-Id: <20250410222509.3242241-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1c8563-f30d-41db-1b32-08dd787e95e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JB3kAb2e+6zGKJGmptSE2XuJDjn98v95s+0bwqVwPgFNQVnMJz+MSDeVYy0T?=
 =?us-ascii?Q?ajKvV9pqk0ePx3GHcWkKWrUhhSeKP94ywl1hbSap5qkdk+TfAYUsedYytqqV?=
 =?us-ascii?Q?mOFW5QYTCQBYjtXHCdnhDUbio3NpRDvkxr8rmCpU8enptJHFFwYOOmjHPs6C?=
 =?us-ascii?Q?vJmJWVdBHeodeloTluClIJeXDfwx7EWATOzixKu7NaIwBxt5quSK3490p/HP?=
 =?us-ascii?Q?r3w8hm1lwabaq80R4ZQOPpnyk+7w+ZVXRGW+Zcz82NbYiHvemBsY0dASoJ7C?=
 =?us-ascii?Q?O3P5QP9Nit47faz4hW6OEoAQdEwkRur41dXxB+x6ox3stvQgRIyrX04LWwOe?=
 =?us-ascii?Q?8lXBw6yX5N/Aee6YelBzrHBOv6YnjTLFqbvk20kWqeOie5grqBL6EWnemJ2Z?=
 =?us-ascii?Q?jLEbaCynJ79m4WMDJai3l2qlBiCR1nlzFhdeJh8GIZVEf+lRdAXessIK/J16?=
 =?us-ascii?Q?EVXR84WWh1EoYx9RDhIEhp1NlTJmYuM127Yj+91IGCrGssAxe+E1gAqWFX/O?=
 =?us-ascii?Q?gAotVsEDoawWuIJfHXdsZyNgUMrXsTvRFhJ3b0QbcQJKXj0WRd7F9II3F69K?=
 =?us-ascii?Q?DLnhDNhOPwyGRJ5NQsiKvVRE5dy7iXo1q0mU4ozKv4I84IIMwMuJ81HgckZx?=
 =?us-ascii?Q?qQz96/n03ulb7SvEPhDXG7QBG9e4y0MK9uwzinTbzQf7urNPsjya19+L4MYI?=
 =?us-ascii?Q?eFIP7EQgoK9DyIJ80yrJPhjCSo9bsUKjwzFvK8i45Aq6bMuMa28qsh8JcR2O?=
 =?us-ascii?Q?IerEPS820/1DpA3+VflTqUVjOEWSteYD1iU/FcOkJlpq+tp5uiNTOqggmGhn?=
 =?us-ascii?Q?TtnZu5hO9hIi3/az5ZvZ1oAo2MTumrEXLxByuEb65kGbpp4K0AeGTJVI1vUy?=
 =?us-ascii?Q?6TxKQw5H1ptImNh7UCw9CAYrGK1ZJFw3tdc3CJdBYVSX5IObZP8zwfZ+ZJZ3?=
 =?us-ascii?Q?lr+eEElV9XNdvX34hs9CmhxFUdjp2VCUfab5J/w6WKxivaQz0EYxL/4KXmek?=
 =?us-ascii?Q?iaoe0ea5Y5QPJANTofCOWh7cz6teaLGqzmPcBjlJWt3LF7Pba6kSUgAwmQYh?=
 =?us-ascii?Q?1USfFK3oBXKok7kcRbEJeG+JIZ3ZOyIcI/PLt4tdOn34LAavNt6O8ZCfcJwu?=
 =?us-ascii?Q?2sLZx8bblfWRjmEgMLCZQPlPc1aQgIT/Utz9sL5Jny84FvGQrRkIb6S/65ko?=
 =?us-ascii?Q?YpaC/FMdyIieloA1K8qbZaArmUNgg5w57Ktfjf8HZdkAJj8Pm3/76qAtDhGN?=
 =?us-ascii?Q?h1594tDF19WSSiyR0/hxIa7fM0y7xKtv2DybVc9JJJ7EK3ktMN9+STC7LFS5?=
 =?us-ascii?Q?Ti01rL8H4B1gBR1+cfpQjYVhslOO5ihHQTkeBs2SgLVDILqgSedR8PK5k9mJ?=
 =?us-ascii?Q?vc2wRy08AsC8ey9Jo4tpdTlOapkJ0+VbU3X+MoRplZIm6OCPv9K1L0F+qUTz?=
 =?us-ascii?Q?GqHloHb8U/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LuKgHf63IjuyVANfLoBj2OXQRKqSBLRwiaZwYkfTtNx+fiEUgU6jTjXpSIvT?=
 =?us-ascii?Q?48/E9m7sqetYzSu915dKzET/KlbffWZ+Fp9PdaMN9fhHWd/PE4E6HXMEv370?=
 =?us-ascii?Q?SFms3i/7x+nrB7pg9spI3DGAJ9+uOw4H+5yaeiU/fLbO9vP8hGxVSbkPnrk3?=
 =?us-ascii?Q?DorgsUGjoIrUoEpdo+jEZMVmkaUjxOiLLU2akTBGUL4M2rJg+gmbbPLb/l8+?=
 =?us-ascii?Q?bkUjSwA3LewEYOvC4B1ElbDC9kpoj5rz9KfRAhFxG2/ZLNA2r555Mdlb409X?=
 =?us-ascii?Q?X2G/styqtaTXszdXXPvuiu7Xiias+nor3zKCFLOoCjwV3rRbLHGs0gKhGabI?=
 =?us-ascii?Q?YJYZWnLc8NUZyj7Hu/foQyx6IPT8aAMOXs1f7TiCaaB6iPwK9V83MrmZTAT6?=
 =?us-ascii?Q?gp816P3iwe3DZrDQKn8iqIPtaXjcG5dFSgCGaAVLIrGBFcnGu/Hu94Ptmy7v?=
 =?us-ascii?Q?7SEJeZ3jahJpyNxnCnuVG3zh/hYzCd6I5Uci/OCR0ewuydysaXTKRyStNVkh?=
 =?us-ascii?Q?3DazimHFngh8WMJJ+Z5EWD0BUtfBLWtM84aZFebigReddCXYj5vO9lHD5zsV?=
 =?us-ascii?Q?nQlg7sfbgqmW+lc0uZY8qXME2kFLqHcsespuGcukt6UlVcImng0cEmZDq5tn?=
 =?us-ascii?Q?oR58s7PXMSaD6QgZT29+/4LbCt0sMpvnDWhm7Oiq+O/IcyEwm4o2GOjHQtsa?=
 =?us-ascii?Q?y8wBssXmQlfBt9iwsYJOMLLjxotY68SAFh54r7UnSoVlS2jnrmXcI/7g9C3O?=
 =?us-ascii?Q?ZuJpk4WtTd8Pwy4xOKcavCGCCKcD8j9EhYZD2zS2q98DkqtDlF3JINAIxSTJ?=
 =?us-ascii?Q?wxsORGf0DJcSx0TIRepcH0i1JERnUfRgDR7ClpacZHQSoESQBvSW3uyoBPoV?=
 =?us-ascii?Q?fC/L9IyKDpl3UMUSoPlj5Ox9djWoT+ZlEcfkiwIRSGhsYjDNP2DA5KVc+rJ/?=
 =?us-ascii?Q?mb2gWWntNtlgyyPHp50V7U0rtaDaTOD0MpHBjthwjWXyPXeJJEqqwcKUlD8Z?=
 =?us-ascii?Q?dn1Uxdpz/8VqKXZqWGfux2PuQAWv3a7EMxfbHPhRh7vA005KRLCyWMA51Mvo?=
 =?us-ascii?Q?mrYf7ctE+VbiBmWFWyMIHtO74ewy0dO8fqTIBIBiDuIWh5JWiEnBYDs6Jadu?=
 =?us-ascii?Q?FOZRBNcRlFsoI4Top/oLhFPM93IImtaW4m+N+HjovNhGlk5JHkRlEFFYWXCy?=
 =?us-ascii?Q?2OKWo4oJdxDTmzbL4eZ5Slr7L7V2amJT1G7frbQg7B0B0tlrO8lYxqdsLMT6?=
 =?us-ascii?Q?OeIcCpwmb3NAeDVI5YJoxNsRcyUeBf7xb2Yo8Q4Qk5rDyltObQoMDfl16Wwj?=
 =?us-ascii?Q?9Wk6t4BGSTq2CVVjSKp4ooe1KRAqckMf+dqDkqmnJXR1/b6fqj1yjvjjMFnr?=
 =?us-ascii?Q?Yg4xjiNRIrexoZHHvnyNn6gOtANjgLjegAfZTEUh56wj4/tzvfxNnytu6DP8?=
 =?us-ascii?Q?hJA8aNT50J78MWC2eQ3ro4yNTsQOt5UH9p4cC2vtdcY/ig0c7o3rzIzNOpg5?=
 =?us-ascii?Q?NzFSon4jrKFy9s0GlRI0RA7rNPy0PC4eE10eMss5ZM1bFwUmuuY64g0cp/0A?=
 =?us-ascii?Q?z/Z93UzTtIJisGBHYZ4pWA35bZY1uH17D4mJW3gm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1c8563-f30d-41db-1b32-08dd787e95e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 22:25:24.1645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9tLZ1c+5742UgvhdTtZAs4VpBbmXZkdC9wdKDjWM/Ln+pHkMngXTo9y/i6kO8zYCGpd8jVeffGL+s87VZ0PSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10300

Convert ftm-quaddec.txt to yaml format.

Additional changes:
- Remove "status" at example.
- Remove label at example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/counter/fsl,ftm-quaddec.yaml     | 36 +++++++++++++++++++
 .../bindings/counter/ftm-quaddec.txt          | 18 ----------
 2 files changed, 36 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml
 delete mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml b/Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml
new file mode 100644
index 0000000000000..384ca63b64d53
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/fsl,ftm-quaddec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FlexTimer Quadrature decoder counter
+
+description:
+  Exposes a simple counter for the quadrature decoder mode.
+
+maintainers:
+  - Frank Li <Frank.li@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,ftm-quaddec
+
+  reg:
+    maxItems: 1
+
+  big-endian: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    counter@29d0000 {
+       compatible = "fsl,ftm-quaddec";
+       reg = <0x29d0000 0x10000>;
+       big-endian;
+    };
diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
deleted file mode 100644
index 4d18cd7220745..0000000000000
--- a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-FlexTimer Quadrature decoder counter
-
-This driver exposes a simple counter for the quadrature decoder mode.
-
-Required properties:
-- compatible:		Must be "fsl,ftm-quaddec".
-- reg:			Must be set to the memory region of the flextimer.
-
-Optional property:
-- big-endian:		Access the device registers in big-endian mode.
-
-Example:
-		counter0: counter@29d0000 {
-			compatible = "fsl,ftm-quaddec";
-			reg = <0x0 0x29d0000 0x0 0x10000>;
-			big-endian;
-			status = "disabled";
-		};
-- 
2.34.1


