Return-Path: <linux-iio+bounces-13823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771F9FD4A5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 14:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6C61640A9
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6381F2C28;
	Fri, 27 Dec 2024 13:12:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020105.outbound.protection.outlook.com [52.101.225.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288DF1E48A;
	Fri, 27 Dec 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305132; cv=fail; b=f4HwyKOqC5muxALUsHXxV/ZhiXPJXCTbqF02Nrj63MveOREoBGOANMFPK0deKjmRqsrHfOGm7E/0gpQNp2mOG3YO81lroAufKlxk1utuAhFhVmHgvt7QZpCTxbBA82ZOXY/ZoEE2ENt2nCIMnnBPp20s/aE+KNOAYxWO6c+duy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305132; c=relaxed/simple;
	bh=MBSsffENcE11k79SYHWxI5tYqhbjKLxLK9ARoF42i3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JufLYO7qzYfa/8kf62AtB6EQn+1dsj31PvStlSkCvjQKbjENto9xQzT6yoOyZBSP+F4F9X4MX0wvNIuF/xzD0kV9AGzvsV3lH4zQB2cqOCac5ebBKgE5/bdOf/hD2PRZh2sSWmJYcUzMDQjfMuXFG1xjf1/bPtlVtZnvJVFWfaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsHGyd41Cpb09Kh+VbeL71oGnuAZAHJQOj86o+iHdEIjy1lWadnvatDx/Xrwo8dcS/ZiQYMln1hBIytDr6vFvsrnhZhnyWdDY5AdJve04EmNkNLi5f3XcAv0RBBqJUNFjnHA/kDB1TTIPB8CG9scsMWYZomCVg/pDCkwQBZHsAdx26WL81eTSicZIJZR1xxpIZSXqc1SPVkhEOELwVWtBMajKSoKouivipfNv2LyoGVutOoRILkmjLvBibomZxfwLSJ7r5uDjfg5aHLC46anM/JOebDXoqSuve8UM6Fh9nP9186aV0qZmcG1FjZITZaUkW7s2ZW/+QC0U4auXSK/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1CGvtk3k/43A1lWfPGMW6aoUYmaycZ+V8FbgJlx0Js=;
 b=N0Tcs2jna/h9FIoDw4f/GlEOGbudNIyNPhD3+NIfquSAM0SjnbAaisa954FE0pxP7ZFqnzUP+jOErofuI7mn/lyrviBCEylKxr/D7do/mJkNiVSO0BFCJjuNCUy9oRz9CwqFdIidoTE/4mLaJaxInmMP9AUTu/n8r2IG3wSTgYi1tn4ViaWrffrCu0vTthS40h1M2y1Jn6FOS0PuvmWdt1Mr/YWlWEzwZ6KBchsuVuMN4kYJzicqOpjWxs184ed/5yZyreoO6IQX9KMf3l3Qm6RADW60sTelzSGNrQ6recFVDNX9vZD+GebBxaE4jPMXkPQEFLp75yeNdYioj//yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB1443.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 13:12:07 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 13:12:07 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: jic23@kernel.org,
	krzk+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for opt3004
Date: Fri, 27 Dec 2024 18:41:32 +0530
Message-Id: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN0P287MB1443:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef55a0b-05f2-4947-4c22-08dd26781097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GP/w+kmSYK70qE+o+XQqw7SsTqy2y0ch5KKdQ8/HcleCbnX9AxBH9h6Ke/n?=
 =?us-ascii?Q?5tcHUesyYyRVQSJ5PH1zOmhV6k78QrnfeIBUwkBXgIKBmu/3C2BvUAZQU5fL?=
 =?us-ascii?Q?z+q9O4Y5BcIjwhgq9qofOWGfnTRy2IFh40ucPzqFa/Kml5zR2fuj6qIFTwgY?=
 =?us-ascii?Q?l4P+hhpijoBTaP/F6fBykdu9slZqCuNyhEP6UHTsEwRUMscseglrQ+KuHZt2?=
 =?us-ascii?Q?8Iv7gfLXY4LJrMx8b/DHOc0mHI0PgsdebLBXOoDH/qfoNjgfpN6fgGVdYJt4?=
 =?us-ascii?Q?IM4Yo5hkTJkKsWe/t+5aMYseLUZgqT7qW/QA3HXoiQ7prvTBqCH5qDE06vmz?=
 =?us-ascii?Q?4eD03VPT0s5EZGrVV905DbOhZTGc1Re3UUjHmLq9oxF13MZ6LPnvtNATg/4z?=
 =?us-ascii?Q?P6gYeo69FzNOORLq9PLKB6udk+1aLmyn0IhfPPGabmZF6zZGs9PFb28BgzK2?=
 =?us-ascii?Q?n8atMSNXWr0ytbWLmbEkp3fTY7VrfmyjdrtkpmEGMYG6yF9d3dlSHU8Tff2h?=
 =?us-ascii?Q?D/rdyED+EqO+pw6+dJvzcspzccc/pWpRjSfOJnRtZ6a2cX+O2M9jIvoBmsG/?=
 =?us-ascii?Q?72XrTICMRaK74eshLXq4v7xgm0HBXEJfT3uXAB84JRj4/jSFW3CiMKImXKJE?=
 =?us-ascii?Q?v9gKuNDRiM8Usx7YWqpr+yPpbV0A/y3t62IeLq6ochCJwe3mYljpy1XFl9lK?=
 =?us-ascii?Q?YzTnqEG8qxiJhMmvrkLt/MeE+G0uKFrYHGSkk4BBTdD6zp9RnBdZZUMgs82T?=
 =?us-ascii?Q?XJgBRVX4NiMq7tVxOAR5FNpisPa7T0onnFXDhS0zVOt+Xw0fDLTh/Sos9Xql?=
 =?us-ascii?Q?P+nw55rFQ7a3xIugagOP4G2+g7e4fU1vSB17bOEu8TW+NfcI2BC0PXmd1u05?=
 =?us-ascii?Q?/+UGxwyvg0XtByxWKJQog0yStyZHYPtlDbvtpcwcubnjiJhLK5/F+pTMdrrw?=
 =?us-ascii?Q?JQf6xCdVxqwszqlNu0Ltvx/tGqwR3wevjHAO+C6JRopb92aulYwBu3wkYGif?=
 =?us-ascii?Q?6JyPrkyZOs9gU7fSNqlGTg6AFbmvs0CvxR8DlhIfj96zwd/bJv0Z0d8yJtOs?=
 =?us-ascii?Q?pU7XqzLGz4/VQWTmmf96fkV9GePXZz5bPVsEeax25NGcscmRTww1oc24uMAl?=
 =?us-ascii?Q?e0ajE3ZMj3337XLl7Qq6NtOq76DHOYXRfoEZSfr10mt0RaM1/snFVw/1EsUC?=
 =?us-ascii?Q?/05lYLdLbyxfpf20gcrFmCmy6ug8KSteeF3oTTCJkxPV8yBXBsCqgauXk2T2?=
 =?us-ascii?Q?0Fupt+aaoR4yqKhfHCNrGS8f+pzob9oMqG8Y38iuxiXHyJZIHPSwgcl4FDuD?=
 =?us-ascii?Q?HdVEOKzaYDKDZZOaFoNqyH2UAYo3aorniR1PM9sai3zVd5sthRwA+KFpzs2Y?=
 =?us-ascii?Q?o6NN9aQlinbnHSpYebY8PENkk7FM20phBD+3dp0W5GQNiJ45/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TogqKNPCNNlz7r6cKTkzr7zvGlrt3U7TMOWH2sbF+7RbHGd14J+4SFEEvWKk?=
 =?us-ascii?Q?hXDaFvP8Vc4jkE6FP2hfyoz7b5pqcGKJodw+LF/VnmxL0G+dtFIa7fMWcR8V?=
 =?us-ascii?Q?w88o2qgDoaFojsY86+ae/LWSat+LVIt4bFpERvc/TMvCygVEJw1guI9XSvis?=
 =?us-ascii?Q?UnvBJ7pAfN50znLWGmHirUMNI4FgPz8h19b1aqRiaBbLSreZlfbnxqqT0PRc?=
 =?us-ascii?Q?eMn5VZEasVfJouYBi5qgCBqjw7FzvWvE018GkTTCou7sKKTdX28mEDRbr+4c?=
 =?us-ascii?Q?hiXCsP0UdRYoRSe0NuejI/uaVTZpuDVYqC87hFU3avn1iqg44Dvru+cpICne?=
 =?us-ascii?Q?qiSOE23E7KlkPCdOpqxHOLLT6Ew7q+cp6zppUPDDWlc5QVnO59hUYENSrMp5?=
 =?us-ascii?Q?5j30fQIv9loKwed8Q3EbVHDGi8IkHhT4woDEEB+H/kqqGB3m5/ERrEKZSl7N?=
 =?us-ascii?Q?n4r43uYWXGhkj2lFXKSAACiMVolLyWTbWfmSf4WMIS18ECs4Oiu7h6w1Q01O?=
 =?us-ascii?Q?4l2iD9SWa9Q0/zb0J4pG+QDBQDRTeQI6ag8QsZNClFA8USE3N4nXUOS3AAyw?=
 =?us-ascii?Q?MeVZCaT+Vjxta/ecC9KlwLe7L0k25eIE5pkHr6h9wICJbzsl96nzdgH+Bfx5?=
 =?us-ascii?Q?O8Um6zkTmAm9eGbkJejoZugaFW7wTK5+FBgglDY/1vOdkc8tHcy+jYt0HncD?=
 =?us-ascii?Q?phVSldQY4i5eR4QS5QJ9BpLIGWoredDn+7MsphT4ncBqBoMbGoFJ8HDmKja+?=
 =?us-ascii?Q?/3PuQNvRiwBmLf0jKzxWcmcekWVLVMjA9HOe/iTQS3j+Icdzaoo835ggWbOu?=
 =?us-ascii?Q?i1pfTWv9IBF1r7WIhwfi5yLImRFwqd6NWJdP7OCBj0Q9vd6Lp8Km5URbbF58?=
 =?us-ascii?Q?P5I529PkBs7MoakcTz07e6STp39USRkhroiVI1XyiPDJasovUN6hSYmQOSHl?=
 =?us-ascii?Q?5VdbDR/L9mILPTkTjZ76gwmjsvaJrNwn7uo4+sUZZQy9KYaeaQwBINuA+ixa?=
 =?us-ascii?Q?6mBJWmIIRUecZdhvnj8vnBh86ru8fVUlYJF7sLZMwJiQosVZEept1bYCklpw?=
 =?us-ascii?Q?WKYj4gvLXia378p/Wz4ESaWfzL5A5GZSOwn6JNF4VEa4a51UQgupiumtW1Vb?=
 =?us-ascii?Q?WVhUVZD4QOVaLNBl848iqgLBfPPhUG9LXG4ZvfHx+EqDjGwVlmKgVzDYv8Te?=
 =?us-ascii?Q?XlX9J/hYScUuGM7zusyJWIsggG07wnerIM3csXrkxKXN+f0iQtgz/yYHd7qB?=
 =?us-ascii?Q?Ta0XizcT7pK1s6HrbmDkQ6JNsdntx03UBfVl7t4XHISSlgjYYW9tOelyYIaR?=
 =?us-ascii?Q?RiQvfJMBT7Ykl0NC07qcmIA4D+l8WR3RJIJzx1nNDIdZnew6FEfFTTpmjDfy?=
 =?us-ascii?Q?8XquWpy48Oy4RoS06IzrqbYJdkWm5mqcQ0ErwlnX/0J36LgsHbKj1Rj8LD8j?=
 =?us-ascii?Q?IC0haRZ0yXKCcofrTwSGp975/isWJ7rslEhcivSZz+I6oeu/NhWc6gOStDxu?=
 =?us-ascii?Q?E8AhSFc6ZHL15Vc46WCUPwGdDZZ3vIfcyu3O+wRtxFXkKHQlk0KIfuQR5JZO?=
 =?us-ascii?Q?RL99T9mKK7xFXOZNYtSc3zW1I2WFgP7JqMkO4XdFoi0LZHssLMkbQaapubpk?=
 =?us-ascii?Q?bdgSSDGK2Lb25wgjA/oeEZU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef55a0b-05f2-4947-4c22-08dd26781097
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 13:12:07.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCpSxIbZgaeUP6G5ZafNaiYEmnNAMekBIju6tjapp1JRjFQEgPOEuLuaYt1SIgUD0l69X4+HSOKp68X9kNn9M4BfexNj2g3sFBYwTf8pqsggu5Cjhp/zKEcaVN87Kwgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1443

Add Support for OPT3004 Digital ambient light sensor (ALS) with
increased angular IR rejection.

The OPT3004 sensor shares the same functionality and scale range as
the OPT3001. The compatible string is added with fallback support to
ensure compatibility.

Datasheet: https://www.ti.com/lit/gpn/opt3004
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---

v2 -> v3:

- Reverse the order of compatible string

v1 -> v2:                                                                       
                                                                                
- Use fallback mechanism for the OPT3004.                                       
- Drop 2/2 patch from the patch series[1] as per feedback.                      
                                                                                
Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io/T/#t

---
 .../devicetree/bindings/iio/light/ti,opt3001.yaml      | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
index 67ca8d08256a..015860bfaf12 100644
--- a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
@@ -15,9 +15,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - ti,opt3001
-      - ti,opt3002
+    oneOf:
+      - enum:
+          - ti,opt3001
+          - ti,opt3002
+      - items:
+          - const: ti,opt3004
+          - const: ti,opt3001
 
   reg:
     maxItems: 1
-- 
2.34.1


