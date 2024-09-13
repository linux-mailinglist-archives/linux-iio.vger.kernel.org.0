Return-Path: <linux-iio+bounces-9492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9811977CC7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 12:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BAD1F25FCE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C081D7E5B;
	Fri, 13 Sep 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="extuTXXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529B1D7E35;
	Fri, 13 Sep 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221695; cv=fail; b=Qx/kWS+ASvnFq9Fk56aYw8LkfxD19gmeZQE1WAyuYVJBODkGucZSxP8NBJDWf9J7LtlZ0zvEiEWhVvE8rJ81jQcGsamHdTo1p395QIQcLsFlRsg7viE0qeuYog6mGQ4+3Qx62hPzx/fqwcz5eEP5guRWn9vmkm7JtP755aFgQ68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221695; c=relaxed/simple;
	bh=Ssd/8UAGu7KN3UPkq4A0vpHmzXq9pQBl/b8vBAU57uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFUktNGqyhdP93ST7u1EO57BUoKcvtWFSA82VzLqBGdqrEou862GzugmCyNweDHrSV0gOtMskrqdTP0fcvxg6Lf9TDOJW9lEQmYrbrRzUlLzQbpkJHWCGQ133Lcnvspg2A6/Yj00bmcCuJkhycZYrLtyfOvZ5FmoqIbHTxWOTtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=extuTXXq; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb2JbsWbuJe1bUvXFsNq34u5Z/ZXk9hjQ+26SLHvpueuzBa/bugE3G6F4Nc8k0KUp5MlQBvJau8lRl/H2XFC8xu39uNSjP9oABZvhLX3UrF88wM8RKVTiWE67ro1f/y18B2I116Re07tbd5scO1KIogNpAZ7ujzfoF4QWwusc3W/7wKriKaNE3g1yxEJBAupZwTycEE0R82MoIhFyWV5qUbVByrzoW12pMIfngiZmL7350kYSazBL6zw8LsGCgIYQijbXBtNIZp3sbRmeEw5anbTUWOUO5V1YZLEiIgP7b7A2zD74tlG8cYbR9kQcl+LWwwuRk6/V3veFfz5I6jlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WEXVP/5HzeyB1dvLgThCvPsnkBRL1Wtx1l62Qj1A0c=;
 b=fUYZ/wNArZw5sF7bJWBeEh9IwziMDE+LPY7bvlDLd1/ZvHiW4uZQ4p9YicOEZlKYCq616Twx6qe93+iGLIdPMT+r//8e+cb63bn56sZLSoGzPdFK2CTxcEJyiRMmjIOAgzjcy2sVpBQz64oILg0hb+FwzX38qt0ImAVVkE4M0N78DRABZiD5dp+vEvuo0eYvsjHs5Cs4gzy13/HHjWdK2chWuipRboSzJozFEEasJZn2baQuYiWZy0yDUV7K9AJDcBty6bwV7/MHZB7Tx0jZXc9VBY1nqdIOjNUJbjXvn0deVtBdj6bUdti+FbxHCSJDRnc+keDDMFrgeXVXkRXxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WEXVP/5HzeyB1dvLgThCvPsnkBRL1Wtx1l62Qj1A0c=;
 b=extuTXXqHeAI1VEAgpJlTKPCvIBYsxN2SwI4kcDJiI43JdMGJ5imWHeFaNJo3UN5OOuSZ761r3qlX+aFZMPCjdoB8UEODUHoOaTsnYrJ5HE80bEGBkJLgYtLmwzAwd03vD3U6gNKVOMi+80z8kxbVCCHIIURVE7EjbdSGagd7xJfjC9s3ho60ZeDYJjAUdMfvjrA7t3o6JQBKudBvg3IdN32008vFfDQt5901utEfhwcMeqGJg9tH4XW/hWQ7ckJT3kdHUrYjfipA15kMIMlrDVpeDIGGxzF4JD2OQYWs2HYiJ9urcm+eEkC1j75EGDLMpSE9HxpwGFIicB3Wz2kdw==
Received: from DU7PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::8) by AM7PR10MB3272.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:105::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 10:01:28 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::31) by DU7PR01CA0013.outlook.office365.com
 (2603:10a6:10:50f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 10:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 10:01:27 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Sep
 2024 12:01:11 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 12:01:04 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Date: Fri, 13 Sep 2024 12:00:10 +0200
Message-ID: <20240913100011.4618-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AM7PR10MB3272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a39a836-cce0-4eff-24f5-08dcd3db08ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEltK2hjUFFaOVU4elBhUmE3OEs2WWJsMXVRdUFnZmVpZjNMSGducFpURlNi?=
 =?utf-8?B?Z1l4TFBnVEZjQWhMNm9ERFNQc2pnbllxM2NlV0U3UlhZdFpCQWluUU1XZnRN?=
 =?utf-8?B?Vis3dWpaVmcrSzM5emVwSExXdUtXNEYxWmluNmgvVXJwNWdtWGlyV1ZnRFNl?=
 =?utf-8?B?Y2taTlZ0L3NtZ3BRTm1hdWNSRzFFeGpPT1c2OHQwYWxHekV3K0JlQzA0T1BP?=
 =?utf-8?B?anpwVzZhK2paM0VRdjZDSFZ1bW9YSUk2SThpMXh4M2tXcGM1VldQbzRlS0dh?=
 =?utf-8?B?WXBOenk2MVp1Wk9qcDRsUUYzSGloaThiN2xyVmxaSnNtbFphRkNycFdXa09S?=
 =?utf-8?B?aEIxdlZkTndScjlobm53bGpGRjF6dWNET0JhTmNHdFlIQlM0UkNLYnErT3g0?=
 =?utf-8?B?eVgxTnpuWkFFQ28vcmlydnNHdnBSRWlvSTVMalVMSlBPVW5hLzlBVEtuamlz?=
 =?utf-8?B?K1djVjdTVVBYNWtwVFh0NXNqb0JsQ2xWbzRmOGUrQ3hCU1Z1U1BEZnVSSjI1?=
 =?utf-8?B?UGtINUsxckJnUDBWUGpRWjJwYTg2TjJ0TmoyZWtjNDNqUnZpb2NQWmY0RTZX?=
 =?utf-8?B?OGduNFE5RmlyeDJFNXZOUzJjSFFibjhka2o2WXpxbFkyenY1SDVBMlY2NjBh?=
 =?utf-8?B?bnBWYmNuUkx5eEROWGhhb1BqZTF6QStGUkR6OWRSb0Q0b2V1U25aVEZGS3Vp?=
 =?utf-8?B?TUlRQ241NmZCZzB3V1BKeGhub3R5UUlNMFRJZmJLS0JFNlgxZkZvdkhHYVFr?=
 =?utf-8?B?Q3hqUmdCd3o2Q0UrQzREM2N6bjFBTWs3SlRHWmc0K2dQYUoxcXdkSmdZams5?=
 =?utf-8?B?cDRDVUt6NDlSRnFVN044VEZneWN5SWladVNjUjlzeUc5UzVyT3FLK1Ixc3Zm?=
 =?utf-8?B?dVQ3ckEvdTBRdXRNdTZnekdld0hIbmwyWU5adGg0MEZvaERSYncxalhJanZ4?=
 =?utf-8?B?UThvVHJMQWx5UkIyY0d5b2QwZ3JkU0gyYkFGTVczY2R1SjVYbUFsK3YvZ0dM?=
 =?utf-8?B?T0JJSXNmTkVlL2pqOE5RcWw5UXE3MzI2ZXFQYnkyTXROVGsyWnVsNkoyMnlR?=
 =?utf-8?B?SXIzM0YrdVJVZWs3YXRhVVgvNkNSaFhicHdmTDB6TnF5bk1Qbk5HZU4vRVRL?=
 =?utf-8?B?aDdJZXB6bXU0Zk5JZm9GaXovNkpKbDlVM1ZGSVRUdlg3VWhVUE1CVkMrSXNl?=
 =?utf-8?B?Ui9pZDlueEFnMllvSWJacE1ndnBKTGUxeDJPeW5WdGhpZkYvcXN0d0xQNDVP?=
 =?utf-8?B?V052L0p5Q3lZR1NlYnM2RWJNUmZNbXU3OWhBaEdFdDdVNVM1eGc3QjY4NzVU?=
 =?utf-8?B?cVZSUlFScFV3b2ZXZkQ0dlNsMVpxYmlyb2NLeTQrTkdhcUhaMk9JM0V4RFY2?=
 =?utf-8?B?NEFzUWh6K1NrNm5WSXZORTRJeUU3MVRuMENLcUV2R1dmcHRwWEh3QWRXNlVL?=
 =?utf-8?B?eUJ5N2tSVmQxVGFvVmt4aHZBSU1WMXhpRVFuZW83OU9icXVNV1VESU12SmpR?=
 =?utf-8?B?dUdXUFZLVUF5b3Q2OFNBUVVQK0xScHdSSmxqZnRrL1owWkVTR2hEbkU1SDNu?=
 =?utf-8?B?SUFxS05qc0xqY2xvMG5Mb2xpUzUyTkszRGpOZlFxQ0QyaC9NK1pObWxKUkM4?=
 =?utf-8?B?d2JXTy9RclJUV0NSbSswc3BqcndxcGdKelNoZkU0ZkE5VkdFTzJKbG13clZm?=
 =?utf-8?B?eTdzZzBOSlN6VWZyaXJIczdGTDU0VlVjRmdFRUIxWEtDODRnYmVTQnVjZGps?=
 =?utf-8?B?Z3p1cTcrMDVCU2ZDZTVZNTRhUlJEWmZkMlNVRzNjVTVtSnF2QXZiMFJhcmE0?=
 =?utf-8?B?bWNULzVGendXb0lDOHZKNy9vS2NlRGVTejV3cG40SkgyRVBpVzlHZ3pkUDln?=
 =?utf-8?B?TGloMW9QaFhvRnNINTE4WWpsWXZsRnFIc3hjSmtsbHBjQWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 10:01:27.9953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a39a836-cce0-4eff-24f5-08dcd3db08ee
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3272

From: Shen Jianping <Jianping.Shen@de.bosch.com>

add devicetree binding for Bosch imu smi240.
The smi240 is a combined three axis angular rate and
three axis acceleration sensor module.

* The smi240 requires VDD and VDDIO
* Provides only spi interface.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi240.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
new file mode 100644
index 00000000000..58f1411728f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch smi240 imu
+
+maintainers:
+  - Jianping Shen <Jianping.Shen@de.bosch.com>
+
+description:
+  Inertial Measurement Unit with Accelerometer and Gyroscope
+  with a measurement range of +/-300°/s and up to 16g.
+  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
+
+properties:
+  compatible:
+    const: bosch,smi240
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "bosch,smi240";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.34.1


