Return-Path: <linux-iio+bounces-6315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E239909C2D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441D91C20A06
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1317E8ED;
	Sun, 16 Jun 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r7+MTYMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2057.outbound.protection.outlook.com [40.92.40.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB117920C;
	Sun, 16 Jun 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523483; cv=fail; b=mJi5aLmm+Rvp1eOco4PGtXDjpvkjZon4AkY9LnhdVRiNU/3sK4NHZVXM/4SmNj6uoTr6Ucrtmo0db3xKnr9Q1Q5Tt0tu2+nliyW3AzvC7/1+wYsV6VB1c9dE/IaAlsPPu2Gl0HFSwDlOeqqN1oII1UaYK58YrUE8twKjFQqPP9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523483; c=relaxed/simple;
	bh=FnYOgdM7NZuDgTMpWqHWdSrtqVIFLYIUwbGJGjqJl9A=;
	h=From:Date:Subject:Content-Type:Message-ID:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A3G45vqhHyIZpJqT60haY8aNcrAM6QDLiEZh5Rcp+d92IEbuYtjkwdWlpYhbb2At4s16ir36SRLqsSJpm9owbHVHSwB0QGL2I09VGS4ga/F2mKh401W8l1S4UXUeTNwd2mBm0EMyZOP6DxlhU+Mxs39UCXYbMdw3Kgc3J6HpUiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r7+MTYMW; arc=fail smtp.client-ip=40.92.40.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxAn07VFXMG+l5OHUQ8JuSE6SpeGg5QKGcO6bzWudGsolLQScQb3gv19n+q6WMNQwQWvghJGLljcvj3s7P+6Xv8rh9d0PxRdvBaT6l9XvedFkZW96Afz0NdfW5NFdMyAu7EpVi2gcYOe03fqwt18xyt41qdGJcMJiUexS2pbeecsQMlktd5k+za8PYDck0qtA0iQHsZED/CBxt7+pf4BtcGCbW7HvCTxLe5rdnBxwRnu4G7nIWj/fKSCzSOLEj+3IVt7b64pj0/zplFa6CbU3rAPD38Bo1wux2tNeqZpyGUcHd7F4VnMq8cR5RD/mSUBWopNqMXu1wpbpWw4tQ749Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfkSwRpElD3cTkyzHjMPg4ZMMEQwTSY1qMO4w0LAfto=;
 b=k0uiVTLka+CeC1aITYRvkGx/o2iNywfI7qqZE/jf3A4t9jhK8wAAhbHtbonqw/vIGikmIMR3yjaTsKge0TP26RhuFW3eND8H8YHGSyOe7P1crI+cPBAwFEvsrtcjDAX3k2h+jG9FQYKMtSamkBw2nJ3J0b5S/M8X8YmhmCQ3BrdsEkRbqbpstpRDbgCIkQyhJ4iCMdpw8dXllCjRQnDcmSmvs82hg0lRMP+RBK9x+wRRzZf5/UaSeG/Ry4FYFbcv5ZrcXNawv5KW9maMJLne5FDyNx/QIykEE0WHccJZpwu7lgpXQAvH4OBOk986e11XJWZQ9O7zWgmAIYXUrpjbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkSwRpElD3cTkyzHjMPg4ZMMEQwTSY1qMO4w0LAfto=;
 b=r7+MTYMWcOdIGK0g4yhrgEE6MMSE/YHwYhZlZZyxML/pVfi5rYbjHhkpcASwTZRtqPNNjzJT3cO8aj8nlD1WuvEUCsyv1/eCMQY2C+En+uc6ZH9xyR8YKXvUVlE78vzg6RYhWAXTsOtS7BE9YH1JDqj3Vv+9eikoKTVu3M4DvitoMle0S7h3sse0A8NzAXo7Kwa13V37lkMFKljnGIZuRt9+Q/ie3Z67QM1kDZI3VHx1UeesTyYVeVX475UxWPEoA1Y3cI85g753DeThxLTo11+tACZxjQzOrrrmie79qd+PCo8kB9E1JVPK4BJZ2hokTyF3PDSwwDSKqlfl6g0rqg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Sun, 16 Jun
 2024 07:37:59 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Sun, 16 Jun 2024
 07:37:59 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
Date: Sun, 16 Jun 2024 15:36:47 +0800
Subject: [PATCH v5 1/3] dt-bindings:iio:proximity:new vendor prefix: tyhx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SN7PR12MB81017D645B48DABB297A62DDA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
In-Reply-To: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718523473; l=781;
 i=yasin.lee.x@outlook.com; s=20240616; h=from:subject:message-id;
 bh=yKdnXFIo7Eu+hfcr4YZCl1LtcyHgb8MtxrfBo6DCl2g=;
 b=f7kqWkix5tGDf87UD3vBT56BbMdbuhvh6GrGD3iV3i13EsjEMDIBkVgkHKVlPpTQc7xCVXV8N
 cZHZOJMxpwsB6ojRzBwp/sLFGE/ypg0qf0irOMpHFs0HnY8iyoy4HdY
X-Developer-Key: i=yasin.lee.x@outlook.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=
X-TMN:
 [NFPfu1nU9cUjK0/mSQfzc/wgbr7ImZhR3+kDO0FlSmHkT05v5pctMDeSGsHe0Lh4Yem+wd6k2K0=]
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240616-add-tyhx-hx9023s-sensor-driver-v5-1-ebaf280bbf0e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e64cc93-3096-41e4-84d7-08dc8dd73f2c
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	W4ZOnD57qzhnR9yd6QYhxL32ITn5B69kacCN+nbMO3kohTZOF3W/2Iwo/qsb7/3CzCtOg6hOrefEq1uAg7Cfo/m05QHGCfTCZgOk2CxfL4YzRLsHjOGZlX7FYrhF/LId1EpRrJN9GzocmJc/ugRtJtLeDMIBYD//uCO78pEcVUOu3srID/uIW8Jhcf0kngXBSoWbykPnuvalyB1KGku9qi1NfhxeajzkRlhyBkDWynGdq0DZILGLX9DojdVBVDnUkHG4hT40+HZH6/VcqSeeCIv4Ujp9H6y2/5n1eEY5d1CXAaAP9rTowwB4T5toFUuv4t0ATz/mxsiI/eQGMJuKPlLQeQaCEGpG2zlcAiGPHHgKQqhtxwny0SQSpe9ARabac+/dfvZr8E3Bxn14U+cWjosk/ZnCPZuPuNzJD1rWX4kjewZp8JrR9Fz2QLxJU5/y2PC7j1sLeHnLZ47tjUdH6mOSydQVJ4HErbWj2/vTJilQ826jTf3qRa/xNNOQBxFRaN4xuepjZzyiQy1lI8SQWFe8aq4eTgiLPj27au+WUYkkyazLnuQ2GBwNkXF4mlfu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0g0THBlQStJMnd3clhUWllwUzJvS1UreFltdHBYQVNxM2NtY1FSVGVGQVBW?=
 =?utf-8?B?QW1mUWhDbGNaeXBodnpEQk9JSTZYSGlYYlJFSisvV2plV2xHY3ZWOTZZK29G?=
 =?utf-8?B?ZXN0UnhiZ0g1MG5ScXJsK2JmR0NmN1diRHNVN0Q1Wnh4bHRxTlQxVGxDY1I3?=
 =?utf-8?B?OE9wRGU3SUtsZlRlcEpUcTNQN3FwUFRnSjRCYlFIWEVKNkNJVjk4N3VCbk5v?=
 =?utf-8?B?TkhJenJNTHh4SHZ2dk1RNFdkYXBVU05oS3IySWRsaXZuM21wamR5bnpsTzYx?=
 =?utf-8?B?ZEpZQ3lyNUpRN05RTHVpMzVqWTBDYW1kdVIvb3pidnk4b2lpM0poMGRLT01x?=
 =?utf-8?B?R2NrYWo4NGZKUDNxOGZ2ZnVwcW5EN2Z1S0lUVWc0NzFsdFJiSlZjblpOTEk4?=
 =?utf-8?B?emI0L1hWUURXa1VwdGltdnVvMWZlUFhjUnM4N2lrYjd1SVVROUpvYjJPcDFC?=
 =?utf-8?B?SmRNU0NuNk8rQWdONDZUcWRaUU1nV2pnR3N0LzBJR1oxemNIVnk1dGUwUUpH?=
 =?utf-8?B?OHlzR3d6YnIyQVpHakNPSVJ0MS9UcytDWEcrM3llbkNCV2pxRytaaVJCTVYy?=
 =?utf-8?B?T1hseEtDaDg1TklleGFiakF0VXQ5T1dHSHIwcUJxWGN2WTNRd2RreHJIZ0lt?=
 =?utf-8?B?VVRKQ1V0SEFLcTJwbHJPQnpxS3lKc3BnbjFBTWxCUXhKc2J0dGpzT21KOFNI?=
 =?utf-8?B?dm9sRUdldmVTYlVheld2a29GL201VDhjbFFhQTVXb1VYMlJWblhYQitLc0tm?=
 =?utf-8?B?WWpCV3hUUlpjNlk4Y0lTZmcvazI0U1hydFpPK3ZOcVJuaUJXa3BPUGtsaDND?=
 =?utf-8?B?OEQ2Q0RvMGVqSmI2NjQzbXVEdjhHMWJIOWdHYVdZc0hYL3ZPS1FSMjAzb2Fs?=
 =?utf-8?B?ZmFRK2E0clBLUFIxaUk0c2M5bDNsQW5OUnJsSmRXVDFLeTVudTlINFhVb1BB?=
 =?utf-8?B?V2FTb2lUSUNZcnIxeVB2RGl1UDEzTTNnZVA1Y3JPYjFDY0dpR292b3JVSEFH?=
 =?utf-8?B?YTJvNUo2RTQvc3pPK0E1SjFSeTJFNWpXNzhPRWFDSjlNZW9FeXNBYUJUYnZk?=
 =?utf-8?B?ckE1bkdObHJ1WDcrcytWdS9nc25jYytLR25pT2h6R2F5d3ovNWxsUVBWRkg3?=
 =?utf-8?B?ZFc2eWxxT0dDTkRlZnlKNUZvYldsNUFjaFk3T1Y1YTAvVnFFdzgxVDRTVkZS?=
 =?utf-8?B?ODBiSXp2OXVrcEYrWXBiZ3FiOFpXRTQ3ZE1MdW14eFVBVDJqTjNteGFoemhv?=
 =?utf-8?B?Z252SjhyWUxER3RBZjVWTjh5K1lVTUZJb2IrQlpoVjV0YnBSVWZTbGY3SGNo?=
 =?utf-8?B?SUlQc2pxbkNTNVI5anQvWjFPR2crZVhxSHFLN2ppbnZqN24xN042V2dDTk04?=
 =?utf-8?B?enFsLzRRZUk4UlFKS0taVVhUSHJ2ZEttK1dKcHpkMUtmb01zdWpQTGtMYUh3?=
 =?utf-8?B?emRLV1Y1bUtzNzdIczh6MTU4QXhCR2hpVlBpclR0aWV1RU1jamJ3ODNUSUxo?=
 =?utf-8?B?alFGcDlwUkw3Q2xucGtYNDc0UWdjY3RoM0x6ZmZkQUVWNXpxUzZwNGlGdXFY?=
 =?utf-8?B?ZWdCVEk5eUowYytuSjVIbndwZUl3a3FtZzQ5WVl5ZG1TMEVmR3EzU3Ixdjlx?=
 =?utf-8?B?SHdXVTJIQ0p0ZHozT1k2MlBQbyt6SmpGNXB4eU1YWW9kVUE0akI4WEg4bzdY?=
 =?utf-8?B?U3dWTkdZSVVlbGFMaFRmQ1BGeUhHeG9odU5jTzQ3dW05ckpBQjJBZFJDMVEz?=
 =?utf-8?Q?h89f046NkXEsQhOVjgiZ74bBBBWJtOeR0Uqc0Ue?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e64cc93-3096-41e4-84d7-08dc8dd73f2c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 07:37:59.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818

From: Yasin Lee <yasin.lee.x@gmail.com>

Add NanjingTianyihexin Electronics Ltd.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..989242da4f44 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1515,6 +1515,8 @@ patternProperties:
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


