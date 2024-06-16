Return-Path: <linux-iio+bounces-6316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCACC909C30
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DD41F2109A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DF180A82;
	Sun, 16 Jun 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TOrZKG3D"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2025.outbound.protection.outlook.com [40.92.40.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533F1802D7;
	Sun, 16 Jun 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523487; cv=fail; b=qbQz7FPcVJudIssyKc03DPNGZYHJFNP+CJNA9mQfOnRGPGljlIwUlYhymmRM+7zQ18uUnKlX8ml1FbkSyhalzv8Muo7ywA4sjT+bS4NNv0jJUalab/oh0ZfY2O8w3SS3fttPSV4KiEHlMPAxDA9i4FifgqoF79rCtofI6hIMacI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523487; c=relaxed/simple;
	bh=BWk2kgM9/yGpqcSHOrGMbcQDb7fdaWWwHrEYVJwW+AU=;
	h=From:Date:Subject:Content-Type:Message-ID:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EzpleoRiEQxq5lM5ZRl0/mJOVboUAyGDyQakGd1eOfmEng/63vVTN1XJrV8wHjiIfkrrNyKqSqigRH8A6zENIIpYFea2rQwcp0/DR7XEOtBXPmlnkfps90CBt4d3Y9Lf/16OZjJZ+qUtGbaFDvwHx6T+wCUTCbwcb5FYuQe2lFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TOrZKG3D; arc=fail smtp.client-ip=40.92.40.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcMoGI3QMbZylej2vCz+6RpdCiYvxr0K/CgTxcwxeROABTk14oRXwliOMTtveYKStCQ6r/zGRJHtz6V7/6yZqsfzURuxOenRdlY1Vx3XnLKN5vhbI3j9FtbbBlbg+oLMfSOrqbhEy0uYV9jfafVZctB9TpqKi6emKdEFAowV/z7Uzha/XO1H/TQnQ7AW+DbCUwydxBLbMqGju5rE3DF3G0VDjJUGC3eqcX12EL6gU3BDF6Gh4q1jIWNEo+LQRswLjD/pPBfQ6y+rlz+uglnkMSD+epqxdTQwkRO/m/q7rHVhuf/n/FhbzY4q9je8AOypSqxfGwxesNewDtuvoRfP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG9c4Fy4kKxOZiQtFOHp0wSDGWOwoIFHEGsVZI3CgIE=;
 b=W4tE7xLiQAXSdGk9UJWpYo7kf3Xm+Y85B0Tqq1BwxXYF7d911TRfbAHM+6zsa2NIeNO1TfEyQqnWoayDCT+I/1UZD/93h0Es3lPqlmrPAHzkH7CTJLuekHP5yIfPM5KHKKsMiKJKTsZkIpWDBqF1gV0+RDyJfGxAtIwJUkjokIHe9peFUD7QsT+sWOGlDw/G270SLwjeo8/7XF/U4/zbvUIN7gOEQt+5XqchnBXOzLJCxiXpWrnu4wa1jI+lAnBKZlZddGUnb7+mVcreoosNHHrOlQRbKa46C8R025FNOVn2p/u+3zvUmjnn854nQd3pL6NxkpyTST2KjglVK7RIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG9c4Fy4kKxOZiQtFOHp0wSDGWOwoIFHEGsVZI3CgIE=;
 b=TOrZKG3DUnTO/9soKd5QA58dDFHyZptMUg3tp7t1eJrGiaEMom6uupFWFjIcoAFtGQvMBYjZO+8ly4fwNyLbObv83etlOkv5uor0YtIX99JAMMNZgqHceno/o/9GAAteKiKZwSfRtTcJm6J+xgm/Xc5ANIfRD9iMUxTKBEc6I0JDkcQFqHziVLSxtpopeS7US8YoDp7pDDnA2pXADAORUYsxzZ8b1OrBJs8vNtMhk4K154RHmaeIbkkIiQWXFRiU45EAq8BazaaxJ4enjcMEcYo/Y6gvWpWLRAZZU+W6I5R6fA+0TJy5+m1jXFJ6EpYQCKYdoLJSNC+0mcyUy/A8Fw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Sun, 16 Jun
 2024 07:38:03 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Sun, 16 Jun 2024
 07:38:03 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
Date: Sun, 16 Jun 2024 15:36:48 +0800
Subject: [PATCH v5 2/3] dt-bindings:iio:proximity: Add hx9023s binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
In-Reply-To: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718523473; l=2834;
 i=yasin.lee.x@outlook.com; s=20240616; h=from:subject:message-id;
 bh=a7JGtTvNqb+GFEOpgRVDt+r5nhb3oOmk8w7HIQefdNc=;
 b=CPQJEqFr9YrwpbZSXtyPFQ/uVd6SNwYh3AjNQlWDJ2zWAiud6hGZA7DRmgtzkRppAcLfnJtLm
 PEQFG587CvyDBFBkQ5WcAvlJBZ/yQbLVdjDpujrA92+xT7VBlrpklt6
X-Developer-Key: i=yasin.lee.x@outlook.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=
X-TMN:
 [QsHrLe5h0sXbGUCS9Nsg7TezSsG4oamSMhtIwyePVtsG/Lr8s/RqlXC4mESQ5vOBE+t2upF7bWE=]
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240616-add-tyhx-hx9023s-sensor-driver-v5-2-ebaf280bbf0e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: ac04d32d-5713-4b16-7f67-08dc8dd74136
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|4302099010|440099025|1602099009;
X-Microsoft-Antispam-Message-Info:
	ZNh+gvF0HRllloqgcP70mQyBKtJlEWrhAVPai1Fwm5DzTIFN0qGKD9kSOz9tFpxX5DwCmdfVNwriVQ/1H2jPkb5FAKHPn+7ap6c0/qiwEqoC4vqQ6kYIv+l8HXhcrGouyWTWZoXjFDoeVrx05krQxNRka/VznICSM9hw8pUgxOV1TkBwJ28lp6Dsa7bf7+wm1KmBjrofftz/BnembjpPSNXqGAR/o8+flB7izLfmYsqaU87XZK/ume7JJAN/yKgznrWuxqg6Z2UQKLWLCJeKov8c/dRnrIGlUNHBlNG+AUUXIB5JzxTXBZXoyCYZp9/t4WXc6eDTJHQQHEBRnRberyUMyf/vxD4ibfjHR7RVACxWyCPZgJ7W7/48uxsVtrwxti3L3ZKWrP1jk1Gh6c81EeQZB6oA0WrctQe9jUxhrFFtgbx8/4N+G6VK5WdyoPnXrhVrSuOOJv3QDL537DDknf5rD/WCtqSFQ74c1pCRwP9oAac12qdO3cQ30yaiwTLMZ7jikNx2nawjJ1rC7NAL1i6X3q4jOpPB0JgFdfX8lPddGOLUp+yj6m3GBEDKgY6DsG7tN0/xnWvw5umBUKmnsMdbnwvH7VudYMXvin71OkvYtdwc+VR0dSn8M3t32oUOhGjWjavzw0DVn+l9ahZymFN5urJ7YWhqLxZ7DgWhfGmHnjxlGYWBnvCNpGG/fR8426HCrOhmNlQaO2r/vY6vNg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGVob2FpRVFhS0ZHelRRTUR0WjVBVzVsbVJSTzJpaVZESDRyYnNubVlmaHdB?=
 =?utf-8?B?ZVhiVzVrTTFTTXB3d3I0UEIwTlIrTDc0Z20vT1hmb214RFdTeE4vMmdkanVD?=
 =?utf-8?B?cC9VcU5LL0xwVC9BVHQ0NllWUzhkdnFDYUVHU2VtZnFhelJMSXBSYStGVnV4?=
 =?utf-8?B?M3JNRHBxRk9rSU1rNUNrRXQ5bVRCUHBrTS9LRmNMK0lRNGZoSEJocjdOdlZO?=
 =?utf-8?B?NmdrSnVTdjdCOWtCYjBXOGtyNHlEaitxMWNnUURrM3hiNkQzZG1VWkZGejdi?=
 =?utf-8?B?cThidytMbTBUS3E4Z0ZuODMwNkZGRDl0S0dBbUR6RGsrR3hDR011d09lbFIr?=
 =?utf-8?B?UGhXZmoyUTBnTDZ6UUgxYWlkWUhkc0tDeS9oOXU5aUtkRUU2WVJDWnh4V0Rx?=
 =?utf-8?B?QTQ2ek1RdmZXVlZkQUc2c0V1dG9pd2E3Q2dxTGlhd0k5QnVINjRwOW0yTThV?=
 =?utf-8?B?ZlBOTjVheXExUWJsY1hQeTBuMzA1NnhKVHA1SUptdlh6Q1VGSmlPdDNjRS9T?=
 =?utf-8?B?WmRkVGhuellFYXBtWmJMQlM0TkU0aFN5c0pWdnhGbTJZaU00eEVkUitIRXp3?=
 =?utf-8?B?UlRHa3kzMm84KzRVZ2kxOXA0Y0pZcGpjc2xiMUE2L1krb1g1UFdnK0VVRW05?=
 =?utf-8?B?R3Ayd0hpSk1PV3hjUm9scFY5Rjk3QXhMY1puYU5tVVlxbngxY0F6eFc5TVdB?=
 =?utf-8?B?UHczY0VSYUk3cUZnelAwQ3ZOZzA4NitTdTdSVFZpNmp6d2Noa2dEVGdQYnR4?=
 =?utf-8?B?ODd4N3FBcy9yNFZhNFZ2alNkbUJSdkM0NWswUkdBZElnNzllMVREODQrZklW?=
 =?utf-8?B?Zm90YWVPTmNkUC8yT2E4R0IwazhNbmx3QUFIVzR5ZGlCVVBHVStRU3RCKy9N?=
 =?utf-8?B?WVNSVDkxR2R5WWZYd1Q4SjF6anYvVmhyV3AvYmxvcEJjQWxmcHhGWlNDaEo0?=
 =?utf-8?B?ci9iYXVGMXRNUVgwNS9Sam1nUjRXRmcwRkJRaTN6R3dGeStOOW5BY2hOTVNM?=
 =?utf-8?B?WTV4dmMyc3lCd0V1RHlxSldtU28wdmRRbjJKR3ZaSndZV3JxaDRoKzZOZXNW?=
 =?utf-8?B?aE9QOCs0Q0JmQ3huSlZUK1dHQzFXMFh6VHd1bUdKU0NWeWFnSXhXcG0wcmhR?=
 =?utf-8?B?NlRhNEhqcnBJZFluREtmckdUVHV3aTNON0t4Z01FMCs2RGJsQ0Z5ZVJPN0l4?=
 =?utf-8?B?aGFIWkR5M2R2WG9MMnJtMlZ4SWFuOU05L29ZQlg5TVpOQkkyeXp3cCtzUEZo?=
 =?utf-8?B?dStxVmcwSWh3amJjNXh0a1BqRW8zb3F6NWdrSnBOQ3JYbzlUeEk4M3JpZlVG?=
 =?utf-8?B?UVBsYVN0dlIrVWxjaFk1ZE1jQVJkZkpoRlVzRU16VHRZeThaT2ZBMW02Zllk?=
 =?utf-8?B?bFZrY3dCRVlYRDdMVXZWVkkxRy9LVUVSazBqZ0E5Z2NwM21oK1A4bFZYNXNj?=
 =?utf-8?B?M3QwKzhQd2FYMW5VK1hDdEt0NkFvam1lTGIzMFNMMkpaMElvaUZnMSs5TVMv?=
 =?utf-8?B?anQvRWlvaVpkWDBUSkRhRmhLelA5cHBaK1pRKzZBVDBEamRJbUZPYzlNbmYr?=
 =?utf-8?B?dEpxRjcreDJDdjBYZHRwYjRRb1lWR2F0Tm9QdVJXc05JdWE1SkpDRXh5V21O?=
 =?utf-8?B?dFB5TjQ3SnhudFU5SXF0Z0kwWUV4WngzU0FjajgvcHVHUER1VGgzUVdVQlYw?=
 =?utf-8?B?SGdRYkUvd2NTSk04SjlWVUp0SkxZcmgyQ1V5T2gySXg0R3lRTnlOQ0p1aFYv?=
 =?utf-8?Q?50fR4TFIcHRrhRjMntjK5sobBBJgLRrStiaWAVH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac04d32d-5713-4b16-7f67-08dc8dd74136
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 07:38:03.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818

From: Yasin Lee <yasin.lee.x@gmail.com>

A capacitive proximity sensor

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
new file mode 100644
index 000000000000..e012290f055b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TYHX HX9023S capacitive proximity sensor
+
+maintainers:
+  - Yasin Lee <yasin.lee.x@gmail.com>
+
+description: |
+  TYHX HX9023S proximity sensor. Datasheet can be found here:
+    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
+
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
+
+properties:
+  compatible:
+    const: tyhx,hx9023s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply: true
+
+patternProperties:
+  "^channel@[0-4]$":
+    $ref: adc.yaml
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 4
+        description: The channel number.
+
+      input-channel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 4
+        description: |
+          Specify the input pin used in single-ended configuration.
+
+      diff-channels: true
+
+    required:
+      - reg
+
+    additionalProperties: false
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
+      proximity@2a {
+        compatible = "tyhx,hx9023s";
+        reg = <0x2a>;
+        interrupt-parent = <&pio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&pp1800_prox>;
+        channel@0 {
+          reg = <0>;
+          input-channel = <0>;
+        };
+        channel@1 {
+          reg = <1>;
+          input-channel = <1>;
+        };
+        channel@2 {
+          reg = <2>;
+          input-channel = <2>;
+        };
+        channel@3 {
+          reg = <3>;
+          diff-channels = <1 0>;
+        };
+        channel@4 {
+          reg = <4>;
+          diff-channels = <2 0>;
+        };
+      };
+    };

-- 
2.25.1


