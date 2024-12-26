Return-Path: <linux-iio+bounces-13809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650AF9FCB1B
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579577A13A9
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD61D5AC2;
	Thu, 26 Dec 2024 13:18:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020072.outbound.protection.outlook.com [52.101.227.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DB186E2E;
	Thu, 26 Dec 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735219088; cv=fail; b=BjhUNF+IjYaifC2EpGwUAPRjGy+bWX/LP2S0AzgCQ5OhrzC501XPJyI7du8Z5vGJxFQIC5mxQnaVtGQMcLqJTBlBP4MAFEaC6vWQHCTprKpbYnO2p8452+AUtCvW/m6PPst8uvPZq9QQl9vgBn7476ust2pCbiq1cCP+D41wgB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735219088; c=relaxed/simple;
	bh=dZSCISGgG5nsZswF+XNl0B4I0j6i+vWmQUq+xCFBmHc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mcR2Rnalg7wrH6SeSM9gc2fVf/4AGNJsSOrvDjfornfkrZxWfljrruxhLjp0UJHq5VdbJ2LIyeUaTUGWJ4cjyo8TNOnpNsVHxN0pt90MqOQuk1G77qFwnT9nbeU6jVoID5hpQRKPQNxZhhO/lfE5GL+PbENoN6FuaJugNUrH3uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O867dZtiqW8y7kiR5UPMeKTvysopyW5hHORYYKf3icoAvoA5nL4wm/4zF+p8kMmIF0kyMxTMgYoBaU5y2zk4POwkAUdg5xFL/Ty978DkHba5EBh7egMcP1CCNtMemdCfp5ncv2n0S503E8lohgAT1InYXNtH/Xfn2b0UDGp7hdRs8WRt+AMSoZL3kpCav8M0MIvHs0Ov4JA466lsNzgRFgf849RPxnSTIBL7vnoFT/i9iI6iLWaBGY4ik7ko2eD16QAti6DtiCJQM5Hpq8I/rxNcXBFInvDqWoJk1gDLiuSv5ozlRnEB+s3KFaWZokU8WNGx20KydsdogaDKiKVs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjnKpVv6GEM2LdR9aO7Fyo0YlwHoRdlEB5ANvDWKP+0=;
 b=jxI2hsFVjhrJGblfafzjnFQhsPgGhGEFkWFhrIwnCUbb93Xi3S0PIV/rKInMpI5ZbTwxoI027ZpLfGe8ysLQLUT6X7z7JynywOq819521ynedXZwnGD2KpmvEKH7e8YfHX3xoUSX5VjColM1O3RPSfOFPWb8IGKZRQJSClpcEbvwiavfkTtthNmdpqNMtkIzkT0TH5BelKi0STkWMOWAZekb6HVgkkWWh4mpy2srygliJdlKILtTGgObKNi9N1+w15BYzClFXzE7hOl+2axWWY8OgnEZONtblQtVvZWzp4WXdGhL4E0PhrPRZEW6FDmPeCT2Fz9uEjSCnbDqgjp0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:20f::13)
 by MAZP287MB0645.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 13:18:02 +0000
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933]) by PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933%6]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 13:18:02 +0000
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
Subject: [PATCH v2] dt-bindings: iio: light: opt3001: add compatible for opt3004
Date: Thu, 26 Dec 2024 18:47:35 +0530
Message-Id: <20241226131736.23095-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:20f::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB2845:EE_|MAZP287MB0645:EE_
X-MS-Office365-Filtering-Correlation-Id: e160ea2f-7ac4-4134-3688-08dd25afb981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50Oht3lHJkp9+NrzWOWrSZuCpf/dSM164rpGdE3UKteeQRSaC8ypKPK8jcnS?=
 =?us-ascii?Q?mY2vIkWLW6ftnr4FZt87KywItRx244gw+m6wxTP1r0vnTGVknX49BzDfAENv?=
 =?us-ascii?Q?LzFf1SsvO91L2zP+uEdkrZen7oeGrCWnsAuD90QUSzrR8Oa12MOXI9jFA3qa?=
 =?us-ascii?Q?HEJ7nHCntdrQltVwkNxH4thua0hg5Wvec1hv/5VN5+/xU/ArLF+NaNbmF4uF?=
 =?us-ascii?Q?vBF+NdD/814bcaVhkjffZDGtsb/kSDmjrdLyuzybSchKEyd3S75kjQprxjCo?=
 =?us-ascii?Q?x+g+jdYX6T3XiFWIROdphqvtfwflSj7dr3e8ZkPHaq0U8t51mNPHk9fpok3z?=
 =?us-ascii?Q?ua3uSqxk3bh4e7V8A6RjQjSZHglIfgtOa0NV9cC0JA1LpzScYh2Li38QZHqF?=
 =?us-ascii?Q?81praKEB2YKBpvzJ9vBCr8cU66eaFy8Z9NQC4aP3zPZ4aaapkLPzlX8AMiIh?=
 =?us-ascii?Q?ce8L57YXqIipKcQPRuZqFvpZlG/FKlkZi+5C8aJm7e0HJ1pleTB1RGNOS6ei?=
 =?us-ascii?Q?RFbRdJJEzuQCyrWlE7UsNCYxXVUGj+EREaD+YrAkUDToEDbD8c8EZX3AB0ZS?=
 =?us-ascii?Q?jDuTHOQr3iQFQF/oj+NqF7PJkH39SteygxHvofFbzqRFnSINgIH00tgaYbat?=
 =?us-ascii?Q?u4x+5/+7C/sRWC2AlR5ffH2oxyCuJI/Duri0kSd5fGvz6O0OjSXYHsX1IbzQ?=
 =?us-ascii?Q?I0uZGO+SILRzy8ESyIOjOIXmAaALc3CBItu1e4e/LOLSGjtOo9G4unOUuRYl?=
 =?us-ascii?Q?5HS50CbEWxvbn2TClV6RJv0hbV6UYzDQ+mJzr+z84/fjc+o3n2Jg7hsA0BKQ?=
 =?us-ascii?Q?spsahxmNLYDJs9IzPC3NImDErrk0EY7f10u2qzVmWHJxtQl5MKbLML2d2IeV?=
 =?us-ascii?Q?faqoKZ30CAvJo1azQdCHSaQ2NWmUrll4sewim9DLQthSAhWSY/MJO4ed4Aev?=
 =?us-ascii?Q?f6Ea0Goj8ALh28ZZSpLjsyDnQrSyYgYov0Dg6lmNGg40eQtCV2YSSOty1WNy?=
 =?us-ascii?Q?aJr5TtjgVCWzZBzRsYrqvVpwO/8RySQhYiLE3OlFrpUMiYEFXRR/rpdcZrzD?=
 =?us-ascii?Q?EcqzuHXM7FDUeefjeMFIRwrvw2W6Qw/bqi33ArzqsjjLVCQUIDnrdIM3aXGC?=
 =?us-ascii?Q?g6KdhyAa5/airLLC8ifff4Tc1YnrW7PJ62fBu9cLQGMHkW0eSAXrAk6TyXqv?=
 =?us-ascii?Q?Nv/7f+veOMR6XB8mkzD3qRwAvaH+NqQoKXFYP3ppbICWNPf8dNOi6GATetS1?=
 =?us-ascii?Q?Aissocpx5ILIC95f2BL9oecHQbrb5FHOM0yj/bCflj8mPwC/XxUTHMnpHEPT?=
 =?us-ascii?Q?RDwNrz/Q6ujjpxZyAYC0nUqCFpHQJGcYWAFLHTgy6tpF5PIEDoEO4Yfzf04g?=
 =?us-ascii?Q?I5OCqCHiFQUJL3kNqL/TJJ5q42BKCOK3S1UcZobPvicGDLE9LQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2845.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5VQ5/5pACCclCLcbdL16Vg0GqG7julbV3Dy+kcg5GlyQKknxGflFai6q1Vf?=
 =?us-ascii?Q?zg9tubztvIy7Ca7PnhM/pcUkCLB0L+ASDF1qxEQg8Qm598UJ7Owl+ACwUepL?=
 =?us-ascii?Q?N2VINkMKcPUP29Aay01kAn+Gyn8mWMzPGJaleHJTy3U6I+/s/6w+6JGBFPNP?=
 =?us-ascii?Q?g0iGrqU0CkYFTextiyQekH/7N61V61JX5xe8Np5BX17Bg7LBGU95f+CrpvDX?=
 =?us-ascii?Q?KT87aY0Bv3cJcW+nFn5KMSLmsQXDFAws21m7TLn4nHfzBNpIM6c6d52sM2re?=
 =?us-ascii?Q?yjalcDm32o3RBXGjKMJimbG70G2wUXag49n/6dz5P6YeNN6ugFdCrLeSdbqP?=
 =?us-ascii?Q?vpSOvVgtBgUqzUL2rKl+UrNTYMzVziq3VKL0nMOMSHTqiqlH8N7SOM8VN2+K?=
 =?us-ascii?Q?jOgthAYFd/4er3g8ADRFRdBZM7U58jnTyKCt/vjccTc/IHvhb0NlIo8ZNFu/?=
 =?us-ascii?Q?x0ukbcuAdq55oBFejHLO/H8Uc8/USXxL6jylXc+WxPXuHGmxpHNhD1FqP1pj?=
 =?us-ascii?Q?1DORnNytNbDzcYlRfX3TUa1iytGl62Cp+vTQWn20hRZKs1y7vtx8LF2L2VLI?=
 =?us-ascii?Q?9Lp8SS0jSjlJlMzTIYN3J8j9tJhNnBqyprdYSLU8V7byD+KxukmJrJGzVpjY?=
 =?us-ascii?Q?MOH9m39vhy6Yq8PBFF0k92kfHYpSi0NPgUcQ/c5M+X1Mja0tbUzpgthVEPBS?=
 =?us-ascii?Q?HLvlpO7AqdHP2iKAkHN55uDsaNkG5UyYhlIoHsnX3RJL2U7gRNZpemNanboY?=
 =?us-ascii?Q?910NEAkgmfxtz0uSmgAsoJKKBrcEmWnDGrq3/GFGZ2eRF0McGrnf7IwX0jTY?=
 =?us-ascii?Q?G7ranI8wL2NXcTCHbfbdoRkkaFARUc1YEocPWti+RsgoQTHaNdebxmWdK1v9?=
 =?us-ascii?Q?pXvw+0TjwLtuMUYsZ9ERWsHx/S3ycefemtTGvnnClOvxPMkzmZvLkb/J6Ckp?=
 =?us-ascii?Q?3UhD2xTSJelgBEUAD2Ams+Bfhjd7SGdrDW+D5w1vZEp/pcl4XFxcEnmdrw8v?=
 =?us-ascii?Q?5Vxvq3f2UqAHlgi3GSBHGjXqk8w2ZAdS/y6U5HcVWVzQXSpN07WH+pqcqi1C?=
 =?us-ascii?Q?QXAlOMjPHbFgKOa7nZQtM3hjIJvyaNE4UDCX/ItMwmm9VAdeSW82Brx1gvf3?=
 =?us-ascii?Q?6KLDmhs/mI6wnOdXwoKzXVVZwMIo2KP4gpeYIlJRm3wsFsqqEjGE3F5mtIS5?=
 =?us-ascii?Q?XiaSAzks/OAaSGF8aUPo33E8gB0eP3bB8WEY2LUhHHLUGmncVTmyMDuhXPsg?=
 =?us-ascii?Q?wMR9btWd5ao9A3C+7vHoopDBU6VwdtBiD1gzy9eomIUslulRDAPdM/HmaqzF?=
 =?us-ascii?Q?E65ntXiMjij4JQviZUem2s2LM6PcQ7F0GqGrlqgqsvKerQKnn6wDnBKqCFUu?=
 =?us-ascii?Q?vvlozgTPiB0RzoJP/qeRoDKyJJ2/FGJfo4OE+3Oqa51N0ilrwSbjDulGkjrp?=
 =?us-ascii?Q?f+qvC6nyX2Oh9L270qw1ema1yalVRw7j+IPbuVUqNIloYowJjUiXJE5QP5k8?=
 =?us-ascii?Q?wQquDoDeNITeQ/nqzq4x6h3PXieqsnA8+6XpsAI1HWPbLT0JpqllxwFwfBS5?=
 =?us-ascii?Q?qza4ZeeMsrV5nb7sBKQenxrNjuPybppvd4x75fnyyAsRthrduplEhDlmKhlW?=
 =?us-ascii?Q?j2kZxzq2aHS6Q07FKX1B0y8=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e160ea2f-7ac4-4134-3688-08dd25afb981
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 13:18:01.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhNyUpiCpHHx5B+nOXVAMYgHtjIoZV8c4hXNB4Kxm5vHLi59+ANGraTocVMkM6xhUc3EgwcVs1BY4MLE9qUHUOjs63yAvZz8xnOa0/usb8XEQ8vA1POa/PCg9lGgovyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0645

Add Support for OPT3004 Digital ambient light sensor (ALS) with
increased angular IR rejection.

The OPT3004 sensor shares the same functionality and scale range as
the OPT3001. the compatible string is added with fallback support to
ensure compatibility.

Datasheet: https://www.ti.com/lit/gpn/opt3004

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---

v1 -> v2:

- Use fallback mechanism for the OPT3004.
- Drop 2/2 patch from the patch series[1] as per feedback.

Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io/T/#t

---
 .../devicetree/bindings/iio/light/ti,opt3001.yaml      | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
index 67ca8d08256a..56844710e79a 100644
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
+          - const: ti,opt3001
+          - const: ti,opt3004
 
   reg:
     maxItems: 1
-- 
2.34.1


