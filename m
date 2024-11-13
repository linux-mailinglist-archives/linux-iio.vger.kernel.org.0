Return-Path: <linux-iio+bounces-12207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1699C76F7
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 16:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32B9B2513E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7691DE4F6;
	Wed, 13 Nov 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="u3OqUxts"
X-Original-To: linux-iio@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020137.outbound.protection.outlook.com [52.101.169.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA227E575;
	Wed, 13 Nov 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508877; cv=fail; b=fqDUp5qbnltxiwn0OFb0CNenC6icG3nb6+bla1ZpZglGbFJFlzzodyPMbI0BOlfu5PGXYoPCAQJ7Q8+UlVGXsaMlJv0dQSh1ck7o5LavMUZXdhPVVuEQvf0DJIgtd5KwsnqjF1stKMAGuMfZmG5B34Dt2vr43pNf2i9XHL2hRpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508877; c=relaxed/simple;
	bh=j++X3JYMFjPfKwPSdKAlbBwgkZL1XwYODGx3T6CPjYU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=un7Q2bKyAHovDvgOb/XafDr3pAQk3G2niZjMUCN0C/CCbjztpZWJ3zuZ/o33T022W2yNZvOP1rwQ/O07V/GgZf4vnMH8oqVRHr4gh69CuJ0XRK5eh4fqdWvvDp2BRX7BWmz92QowJTqLpeA3onoikvBhVZYAETMWg8VG3X4VcyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=u3OqUxts; arc=fail smtp.client-ip=52.101.169.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey8FfrHotWqEV+GKAVCDj4wN7tiBYEXMi08g+8SPfdYC8Nmd3KLbATToG9tHA3DY4VIIqk+MworXFJt36jMBXx3vpE8waC9e6N9f+vbeVA2jRlNWTpWkmAmGAmyBp6i4lkXyT9Mv+RHVqKk92Bjjho3cTczZhNe1gh1ZXsZwHZey/kwe8A5RnOdkfO0VHIUgfEq5tS/VFccD4wM/QTr5tEu6CHTIH9Vh1W0o1ifiP5t13u7aQ5Zgr7zd48mh5E164onwiHjvSf4Wun6ZkDHsuQVOrBMVmtt6VcL8DIptEU+4OAlRk87nqzdc/yoSvK1CSKQuU3J21ph4TttVYVYY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ID6gxStJ+/ofoae7PXLsLfBiUmrJbcIhAiS6cBLwWM=;
 b=LMChWhuwqbtrpIPYGVbcnGMGIKn6ez3OpOY7CfWKJXWEN33WAB15ioCNsUQlXGrzTZTslMnLyGp7Fy4V4CWFZGIEVkby671cp+ky7x7rJAvuBMsfUm7vrLrmlBbKfH6Hag1OPuCszbg6nng2EnFIRSo98jOcMZflOoHIDH3XmDz/ANGY0YXvPW6WWgNrke0kUgZBAnjc2xxPoths1ibfr81ZOSBCk0feYCvu+Tmtl40xfW7WT+RqZDZzXwo51Y8AJrnSX5yMt5x/6GklUboKGW0qzZ8Tc9elTnS8OqFrSPJ3V7Fyar+OuqhEo1LPSLy1slCntZ3TFXdqgd5cMtOVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ID6gxStJ+/ofoae7PXLsLfBiUmrJbcIhAiS6cBLwWM=;
 b=u3OqUxtsFDIW+WUOTEh7vNuA31NTgP/vPJbleXyBgEFzPYsOugAzMAi4g+uVX97t1IpidvsrQKG/WSWp3wm5ZUCQsznQwZ1An4OBP336l4ZUkKcE3Tq5Lp1SwsnxKkdiQUJJ6RPBR94T/Gegf7RJndFPyMjMyKegx0LYcibGuouEUqSfSX4WZgjS5DuegqUADWbJ4EHpCLvo09cia8WHyv4j2s1gP5eakuAlg6Iwlai5yyUHZesnWfsvGspCZbCELo+SHy+ZCkOBs3DWG44Ks2pTqsI1vNsHZmlSu1OtPldscJJDBOQVwst2j44dkcYbUDwpD+vIF+3Kri8kyHDNIA==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR4P281MB4149.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 14:41:09 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:41:09 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, "Sperling,
 Tobias" <Tobias.Sperling@Softing.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Thread-Topic: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Thread-Index: Ads12IHP2U4PDLQ0TyOYbwP76vIxkw==
Date: Wed, 13 Nov 2024 14:41:08 +0000
Message-ID:
 <BE1P281MB24207662EAC941780807F88BEF5A2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR4P281MB4149:EE_
x-ms-office365-filtering-correlation-id: 2bec4047-bd67-4f42-3784-08dd03f13652
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NnKEWk2B/C1fa5XtQkwL3praDzj+Hlo5zZPY+8pk2R/Uh5AO8RvAUXib6j3I?=
 =?us-ascii?Q?bAcKLR1NJ5mRH4sLQ4c8ZmqVgxOg3AWN0bD91gUvd2hXXNBQgv0xN3xPNSrH?=
 =?us-ascii?Q?Mnxkamap7o9g/VnecyBRIlLLSFv2LtKqc3d4OYT5NRNkb1wUGdr5AQrOaXhu?=
 =?us-ascii?Q?5vNLIj4YiFyv2OoCNLmpWNC4YxoRouOrWYK9e0RY0ZrZj4ePl0YgoY2Im5fE?=
 =?us-ascii?Q?yAGFGGvf8qMuuq+lrT0MvZ0cKORl/LBJh5PL0l85fEoSadCJ+26bSXCmLg5S?=
 =?us-ascii?Q?8bpXsuOZgczvvCOo8TNfMYhDvtBGsuOdpd18LLL9xB5ojqfMznq4zg7uEqDl?=
 =?us-ascii?Q?6v6Zuc6iEvsqUMo1s0WS5Ft6SIJjbqyVLU+3yqsMDSO0O1lMKT2iDzxp1Rwh?=
 =?us-ascii?Q?pkZWxAB7K8Uwx25KHBpN6FFshjoLBXl631T3clDEY/ePInMIRnOppcvoWVo3?=
 =?us-ascii?Q?OnVMEexAvLqiz3TBKIqyIfgl3g3Na4ecfG24yYvizY2qpyvDRpV+fqkEddx1?=
 =?us-ascii?Q?7eAbNKakJ/0mydxnxM6Pn00AHOYFbZ5vHZlASOBxo/LAX1eqfupU0aPdBOwp?=
 =?us-ascii?Q?h0Fb9eIr5t8LAysj0mpaB3528oFMhdwOxlOnG4M856TOqyxDxsmDPgyeMjs1?=
 =?us-ascii?Q?UgzV2G4Q8C8wE4XC1aQSr1GrOXXqnScpdU10JuGtQvLuajLmi0p3XhBbGS8d?=
 =?us-ascii?Q?09PON7fiJhUf+62cdTJiP6dK2sIMXnAoGLfg4tTD5C1y0J7jokL/nYF/gUBf?=
 =?us-ascii?Q?LVlF3xGdsEVUNRbcb53Per1FekqmM8x5gvaxL2N9L96C/eIiajdXmx/ysNre?=
 =?us-ascii?Q?+An9bDFmnINGeqqSZLh77eiheUebu58JIVY1Rkx9Uu5Esp73LB6NrIbjkQMC?=
 =?us-ascii?Q?UwC7us/tH4aQwESnltIlh26UyanR4HLBjKv4cWaVPz2gMJv4xNWCqhOKEsMv?=
 =?us-ascii?Q?SkHscq6YU4LWhQ1CoBbABlQIiMSfdNCAyKrVlB+vHo9a894DPa2t+tiH7lvj?=
 =?us-ascii?Q?wgZFRk0HYYxKOar0A67+sKBkIcigIpLZAujIQ8kIoYnMjxy5/k5HErEp4VfO?=
 =?us-ascii?Q?LkQkRJpgITymzGxOjOFYX/7Y/3XRH3bLxdLg6lM8nzYZgOKdWWgsKMjtAX44?=
 =?us-ascii?Q?Gc1vIzqCgTnsfSKwHeFRXfYvd5crOEB6vKB8Az8c4n0OfCinF6ABbOoieDPN?=
 =?us-ascii?Q?I2yB9BUakA+vY2cZUmfM+8APwTb54x01meP3577+pW8uXU2ONw9mkqlpeTfi?=
 =?us-ascii?Q?r7hGyg9G4Xb/fTQt8fSRBl9cjg22zWtg6frUBStSKvWAG8+D/wmYZWGAck9n?=
 =?us-ascii?Q?pNWpekyiZTnN6gRqgeXqYPel?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wIVkPScy+iK86titDdgzSk4Vv1yjifyJtDaATvATRYZ7Mu5SK4DHc2c8cmTi?=
 =?us-ascii?Q?1KKl6miHyzNDio0HsKRRy3bbeXYxoUw+FBcdbR34F6ANmI08a23qadASGDNK?=
 =?us-ascii?Q?6nclu8yItc0iAkmF9NTD5+ixzsreZLX/aVzowIS5OZ/rW46SZRXzLBMJpLl2?=
 =?us-ascii?Q?VdpIl6zIzQYgiVUhT+I4ND/hnq/uUbqdVybNzdPo4CnRUgu12z9ncKQQYt0c?=
 =?us-ascii?Q?W9Y+m1RaWudUkkUuma7csOyn9uA7Ph0gNRCCVamR/Rc/lmWVrnckVmjzu8va?=
 =?us-ascii?Q?x8XLD5by3ntx/WhNbtD1PfVdrMclL/jQDB+L3MBANnOobs/5kscwjbYGC8ED?=
 =?us-ascii?Q?Rprs+UcVkJS2tKfFZKyPYeF59Z/qSGeg2ugb+vM4awx1K5dTZrT6roX2KzZH?=
 =?us-ascii?Q?iNaQGZ62ONwy2f/mknp1rG3mZ0bZT4A3DGgvX+kwDudkmy6km/wvANq2o6NT?=
 =?us-ascii?Q?s2ajk7m8dXqC8dmU2c2lV2HYdyOUeFygf8yJYTqI1Sknp2DBcHEavSClVG0F?=
 =?us-ascii?Q?DrthqDFw3Qi/f/TwpBnduyy815QGKeu7BOAo9RC1lCGFBDYetLYg2lKb7BGe?=
 =?us-ascii?Q?LWYS0P6VRopalmkBBG1gVS1q132JFQllEoRSlEPlfG3IOY78WG0OL6qpBK1y?=
 =?us-ascii?Q?DF9q7cT2YX13Z/d6tY1CTqVGI3qACEW1Zh/sKA/ukqBhZ5scmSFDX7t6M/U1?=
 =?us-ascii?Q?aZKQhSyBD4H4o416oOFWmTBIWGPimuD//Rk+QlWAHvE4xAqykdIR//jQ7hLS?=
 =?us-ascii?Q?kNlQ3LOvbcA93fkx3w+9Pd91NJZS0k1ZqYrc9Lr5eXt/dQEbnQFLob7LtYtw?=
 =?us-ascii?Q?WsjVyrv3r3coU4KmiRfot2O/ZzCVgiDZ/iZQfph1V4yp30QUmswQfJehNsQp?=
 =?us-ascii?Q?brAo2JYtxhaT179fI3hYKgg4ZuuV4Ey3u+kWIrkXveEynFAXmvwgKvXHk5og?=
 =?us-ascii?Q?Nxt5k/ORhOj1TSkAa6gxjdOrHNt4pzKMi4urLk+2yjrfLwM/He6agaP1Gi3f?=
 =?us-ascii?Q?22OymwV9xPIWzs4WFRLb4gkdsZXItkHdzPyNhDy99Alc83UvQSNMHsyCraDE?=
 =?us-ascii?Q?GfEYZSTx4VJivsrqdPmTh3JA7XXruR9JJQZkaoOf2bmfDxocpRlYHFFg5KGj?=
 =?us-ascii?Q?ELr07ToOzx88+H+PqN0byUXYoudTLMafpOwyo24LYBTW+sOTyp5QYAkcTEON?=
 =?us-ascii?Q?CoItlhcVHPpSFADqwg+Cq/NIQJHxugRLsbfUNqqkVKfx2zyicE/p015obLP6?=
 =?us-ascii?Q?fCjwDwyENfNXDOTzrHofBhBMtSUT1ISSBxYFTsP4sznudRSAqq3SGXBuC31t?=
 =?us-ascii?Q?hMBuOO9oT/ndt5XWKYWPeVh6wZPsHIXDFt/Wws15YIzA5eYqAJTeMt5Z4jWa?=
 =?us-ascii?Q?TTrVjQNqCdffCXI5Lf7DhVp/9e0qF4WWH9ub6+AXvb21q4Oxfr4NEc/OaDMz?=
 =?us-ascii?Q?yrRmD0LwNC9qUDkfL7AhVENYA7NgOGTk9Lzj/4Z1JnMAe0QhhjEsb64ONPz0?=
 =?us-ascii?Q?bHUJ5jdlrUF/Vt2H/XFYA2U35QYx5zlQyhwP81PAmTRfNwV/SDgGElVeM4dc?=
 =?us-ascii?Q?1rOlUpWJHZCEPghevXeOL1cqHK9mAI3Ql/aEL7Sl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec4047-bd67-4f42-3784-08dd03f13652
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:41:08.9595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSZyF9dL1Rl7IyV5StPXj4AfZUFzsjICk6UUcE7j7bsQsVvoo2usGhYxDLmolLGnVpQ6EsJNwAnNWpBAiX2rMbw/POfzsujO1JPWw1lffw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4149

From 6a06973e1023ca6a128c8d426b4c87887117c084 Mon Sep 17 00:00:00 2001
From: Tobias Sperling <tobias.sperling@softing.com>
Date: Wed, 13 Nov 2024 14:52:49 +0100
Subject: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138

Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
analog-to-digital converters. These ADCs have a wide operating range and
a wide feature set. Communication is based on the I2C interface.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 .../bindings/iio/adc/ti,ads7138.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7138.ya=
ml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
new file mode 100644
index 000000000000..c70ad5747828
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads7138.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (ADC)
+
+maintainers:
+  - Tobias Sperling <tobias.sperling@softing.com>
+
+description: |
+  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (A=
DC)
+  with an I2C interface.
+
+  Datasheets:
+    https://www.ti.com/product/ADS7128
+    https://www.ti.com/product/ADS7138
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7128
+      - ti,ads7138
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      The regulator used as analog supply voltage as well as reference vol=
tage.
+
+  interrupts:
+    description:
+      Interrupt on ALERT pin, triggers on low level.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        adc@10 {
+            compatible =3D "ti,ads7138";
+            reg =3D <0x10>;
+            avdd-supply =3D <&reg_stb_3v3>;
+            interrupt-parent =3D <&gpio2>;
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
--=20
2.34.1


