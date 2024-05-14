Return-Path: <linux-iio+bounces-5052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577E8C5C47
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BFE280FFA
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B92181B9F;
	Tue, 14 May 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AYgGjquO"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2047.outbound.protection.outlook.com [40.92.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D8181339;
	Tue, 14 May 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718370; cv=fail; b=CEt0k1s6eaeFTibyzqQJNT1xZqImB0+D+McXvl3j/MdNUmgvxOHTN0+hTyK3oxV2Fz/Ko0p4fJ4/ZeptDraxNsh5HDKT60x1RXUhmUS11/5dWdoyry3uVZa8V8t9W7sFpaPyCGC7TVS4sUjybYC82ZyYC6kleeSoqJeUIRnFApE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718370; c=relaxed/simple;
	bh=5pboIw39JhoJODYeL4x4qtMhrpgK+XZ1RF0mHrSn7Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkgqlsqUZqiGNoFozzwT3/qjQigcjWSYIkkynYB6NO4eNrz6SOyPgZG+27WWF9jPqBByioSQSIm6UriqmsLbL+3+3k/zw/8Pxxcq25cpfqRm1+CCc3oHM2mbWZ9lbLSE8W0Gm05sdTHi6Zy49t1G1XehwMbUnojBgmh8/AqVdJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AYgGjquO; arc=fail smtp.client-ip=40.92.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vup3jrIi2XlR+DHcKaIBlopHuIjeg+7x0axvblW87etz/45qMXFZgE3MYJmCiNKrsLrFuHf7m8Rft+pJ7zoxxcKA8ue4s/vgJ89VrBt3IA5GPKzC/p6Sja04+tnWbzyB/l9wiPpM811kH0XoLKR0N+gTNn0dotRrU4IMOD4LSQtykCTp+Mnw7xT782Cfe01cHgHzbhjRfyub02HRFG9+STTjVBwvgOdiHKbiE7ppUpB6SSg61/3X7T4ntcg5qiiurgL86gdh4BxfAh/wqYYeFdUnUBSRo4NHt58F/rlrtRzxIlIiP2fHO7WoiNCnKZMoTALyd3jrQtHSuC1lRkVJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azGEV+/Ab1SjWFpttR9J3K9v3HUaBIrpjBIQyw36txo=;
 b=jUOnONzGKtnKqeeLqhU3RPqzzq8QrKXWThYwfWjF6oM1GFjdGEC1h6gpXSnGhwjAEM3g60qgGgVLIu597GOBjUiUxTpRA4eno2vF3RBXQZm687Lj3/ktT9RA/kpE7b/wlso/o0O6Nkta2n7dOu9jWYfxXE7IEObWwGuqMmHK4AxvRLrjadZUaGTX06aB0zJDEvlyyhfrIKwp2JKSB15oXIAyKzmWz5rw6I+ukXj15KVcCNxgVQlWtiEqkNH7j7z8nRm5fzQ9ziEfyzRkhuuFcgchmwPWCXsF+CyA/ltZ3iIKVNMyUo1YBxV7oF+oTNo5Hd8KU6xwW3Gmzfv9ZtN69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azGEV+/Ab1SjWFpttR9J3K9v3HUaBIrpjBIQyw36txo=;
 b=AYgGjquOHCyK1YA2zSvyacEF5E7Lf/FhQfJt9shuRiW97GUVG5TYh31LUZuIb6iC7WC7/X3c541JEL955YLcKRbwKDv42wogr3KXWGkLeUUfi4RvRQ4o3c/IK2O7IPxJ9f2LWABPNr7V4mnTRRIQUjTQPeMIPDzKfxLIlvME863vvhXfnBVy5ZpeFapsKWNauX0OpjRd32154FkZjQXgQKBVVqTbbg7033+cf+IlGumbRKFdkdpfTYahleRCinc+rXyRmjo8jxzXNruyDET6Q6t5FQFHHP7hD7nDnIn/2HUcVeo9FFP1vIfm3w6DTajBOQB+VHaxidV4sQZrfiAFPg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 20:26:05 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 20:26:05 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
To: jic23@kernel.org
Cc: andy.shevchenko@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.a@analog.com,
	swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: [PATCH v1 2/2] dt-bindings:iio:proximity: Add hx9031as binding
Date: Wed, 15 May 2024 04:25:40 +0800
Message-ID:
 <SN7PR12MB81012845A114E1FE7C49DFC3A4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514202540.341103-1-yasin.lee.x@outlook.com>
References: <20240511170143.7ca6a410@jic23-huawei>
 <20240514202540.341103-1-yasin.lee.x@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DfehfolV4rkwPx6Ualzj1AccClJdTs9pMULZcd1XI1FzudxQKgTuoogUUCESV0K8]
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240514202540.341103-3-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 41196339-b294-43ce-f4d3-08dc7454145d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|3430499023|1602099003;
X-Microsoft-Antispam-Message-Info:
	3jNtKStYx9W6tjCNQEmH13igE3T9dppFIHKaDGapBDtwI+UvfaAOxSn4gg/yajNB+NYtf+AOw3TWUpMVOTiqpcIIbQs6DJNDp6LSog4lePeGpzIhJHZOd9icz4o1i+q7XIvcAHDc9i1VziKJW1Aap2e0YNRcRXVyXszsQhdptn2qqDCS+8OCZHqYRESESwtzkL2l0ap2eIzsI+GZK78UlAnc/coV3dK9S0oMq20C5ymkzgkq8BP1pKRpEbMWjg3XV+zQYniLIlo9cXpxEb7WlbDEf3z3gBJClPYK19c3VwxHuab80HWnBDNH8IZD+9Di3YT2o28clnv5wpsV1S+gWVxbOpbIriJQSKHVkmPdXieaW6FPr3g3X2JMpgHemrMsd6emBGHf9qcaxGsRyxbVuycL9VdiKLAvK4jRv6js+G1aR6Fg2eMp4KqCEK727eUAiRhIBSoYiu5HH7SPnqnzKpM8ffxWQZHQ38MgZSYZWESrsMSH4jOQVHClws9lmzUbnhJWz3UrLAdFD2/6Ci2QdjfCMXAdxHwdtACRfgXPbrtrwChC4fqH/7Nv23ouDv/Lkp3Et2rULlu+5/6wGWPPcsUcm9pUeLG+xInLfXJP5sqUgNEIIOgomfaQ8cdVLC7dZDc24ukMEBLukJq1nyHS9ncMHLHgu9/gAFwlJmkfOiE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPUMpOWUDvBSlkpyETlBum0oVR57305onveS93uo743rAYJFh/1kYYgkkxLH?=
 =?us-ascii?Q?A7gXJ2tgSFJc8x9JHWToF8db8X6NGutQt3uezC2rGV41/cu+R/auBRSrT9UW?=
 =?us-ascii?Q?RVDIKESRZ2VvTi68VHY7uI91SIWhLU4iFdQZqqpFFsSrS4VIs8GocXOrLFQ7?=
 =?us-ascii?Q?vhfttDc+snf1R3J4dm5ddu1vj9/GN8K9Tm4ZwnQMbC+9vACKG7Qqx5RCP52l?=
 =?us-ascii?Q?+lBCImRF4q8iO6g6KPTLMMc6FTVyqc7pT+Hj13Crvc49zhGye9fk9wP1R2MX?=
 =?us-ascii?Q?2PAb+ya1KRTJDhZzTW77L9Jkz8PStR2KiehgylJUXOACNQQ0JjmYlPdsc8If?=
 =?us-ascii?Q?Lomog6jNJ4A1bXlrauKZQkdtPtpR1lCaZLiMWifRkXE7mW7n3FNQas9T5xr/?=
 =?us-ascii?Q?mHTsmKbjOho60BNpU9nD5ilXfgn2vtkbC0wZ2e8j/w1BONE2KZtMLdVcALHQ?=
 =?us-ascii?Q?K68+WYj32UL3tBevavAbQORC1SDjVkZm1jm/jN2R7mAtSNuzejDjdaIplV+d?=
 =?us-ascii?Q?dKbQeg6eIxMYMgZZbatOBoDcORs5ckwDmvRjSlk+f0Jxo6FazLdIaV+6wuEc?=
 =?us-ascii?Q?lXBQBkFea1UgQEcPe+rv2VVykhzjwsoGUM6BldELzeCuxQPMrkJL9ox0Xu54?=
 =?us-ascii?Q?Z8nyiwlp2r9di9Co28tEyVSl6g5NQL4eLUXppfo32aom3FF/DIfGCklZapcq?=
 =?us-ascii?Q?h2xLpuaoJhftof3zX1K3qP1mo59CSoNObfj52A/I90KkyvUWwlARtRniOQ+q?=
 =?us-ascii?Q?Bbqseype5pDUmTmuiSsPkl47kOCrdHfrF3vNMUTvInT384NC8QV+TKDU/hVi?=
 =?us-ascii?Q?hOqVUU/Zdtl2Q6akUZ/dbtcDQ/LcXm+0XqsHRSTPANpjsXXrmSOPrrvfOryh?=
 =?us-ascii?Q?nNqaZ6QN+YwJRC72wdus0A6QgSfTXWGrAvElkwerJ0mZPXiu5tOutew3E7px?=
 =?us-ascii?Q?TZ3TfrgZEepXCnuqBHk3NjsKctZM/iP43uWwWErXdzryXC/cdmXVIaOKOOyN?=
 =?us-ascii?Q?Eyqvu7RhySpmVvvuHS519TUT0nLkkpZYPK4PgPUQAAlPHeLpjkc4+5n4fa/P?=
 =?us-ascii?Q?6ENFzlnD4aqynfqgkFdBAui2KupdhZt+VRHixP6UFBxaB/NSvNAU/vrGXmea?=
 =?us-ascii?Q?0eSXsVzSYZtecrrotGFyTAPo7IP9IcVM2OWQK2Abkm5Dxl9HiCXzSWh9UDzU?=
 =?us-ascii?Q?vXVrfjQsMWDyv+1eLuWHsJ18kkIUELJY+37mvO0FzAlU30L3x8xRyG+Pkqu0?=
 =?us-ascii?Q?lavl8nG1g6Ro/Dz8/8Lzzuvg9VajX9LdfxU8d4Sb/Tajv6KMVbW0KtkZu+8/?=
 =?us-ascii?Q?70xdUmpefZjHAp1g5Uk29eHW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41196339-b294-43ce-f4d3-08dc7454145d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 20:26:05.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

From: Yasin Lee <yasin.lee.x@gmail.com>

A capacitive proximity sensor with 5 channels

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9031as.yaml | 60 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
new file mode 100644
index 000000000000..62a71c0c4d04
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9031as.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tyhx's HX9031AS capacitive proximity sensor
+
+maintainers:
+  - Yasin Lee <yasin.lee.x@gmail.com>
+
+description: |
+  Tyhx's HX9031AS proximity sensor.
+
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
+
+properties:
+  compatible:
+    const: tyhx,hx9031as
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      hx9031as@2a {
+        compatible = "tyhx,hx9031as";
+        reg = <0x2a>;
+        interrupt-parent = <&pio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING 16 0>;
+        vdd-supply = <&pp3300_a>;
+        status = "okay";
+      };
+    };
+
+
+
+
+
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..e2224eea9ab9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1507,6 +1507,8 @@ patternProperties:
     description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
+  "^tyhx,.*":
+    description: NanjingTianyihexin Electronics Ltd.
   "^u-blox,.*":
     description: u-blox
   "^u-boot,.*":
-- 
2.25.1


