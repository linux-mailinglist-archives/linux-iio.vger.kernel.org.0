Return-Path: <linux-iio+bounces-9487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF27977CA7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77D91F27350
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BE61D7996;
	Fri, 13 Sep 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hdZEyzdg"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C11B654F;
	Fri, 13 Sep 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221450; cv=fail; b=d7BVSitvMLrhbCfkhFhOfnMQliedxtcnUlaBGWOwPoihdUwhYGRYw8DhQOaeb5MgWtQD2BicQVdgcWR4ixK1SX2i+UU7mZQ8nkzVqWt9n19FYCd9Vn1hc4zHyMEP6N0I43uQVF9UxupGrpKSZPPfB+hVrAJ1rDFAX/HdmeJoZfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221450; c=relaxed/simple;
	bh=aqY/vAVBSMH8SLZlhZ2rUTWyaKlm3LSZXGMGn4Xs3YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FyAFtj5J4HCmQWB1g48hISs82eMul9BuOoasYkPA8+s0byZUjqg8Oc7zuN6abUACQcJInhHdQ/rkYqJAVhe59LZmXpbgzg8Fq4vJmAhFTmLgY7pzOWrD/bDqMn6AJEhXxE3eVc8OG46+HLItm9gH5HPri3jg3R3OylqiSdxwYQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hdZEyzdg; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFOCh9Iztdlg1cuYIdGXYb4lnLqGYcZTeH1GegxnE9VE4YPmaJhmt6IcYvNdI9QICWpRYV5BIKZ2dool84IWb6U8xjsfNSzTYoAqvhOhXF/mzqgCh2ABD1Obee8QvyHp9qbILEWUgg+c0zxSZhJwPLLxiYckmEupBTDrmkB0yYqy4RWmQS3vegqmPz/HOIhZhezv2FGqzbjHsNsSVBZkR3dlDw6KtZtLMKccBiWnXEtbZZyKt2ejca0pGlOlMmu9VCi55DUbmZedfonc6hHCoUMicRbmMK63vbyJLNl91YUGpj7GGvBMAoGUwd9+sntXsuqBGj8wt5lazUugUGf+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFPN0SBSr6PbHgcghlFBv+QWPvrLlELhnAj1xrXcBOo=;
 b=lFOsKjRY0meGO/v5tqjfDQ8EXSm1DaturDsjr3t4USBELN0+Sios/W3RS9f78g48OcJDMB1jT80HrD+Jwxps9yM9CbnnjuMEz0hgMHBQLuVsL97ZkREjr07Zm3nlkCgKpjyJAI5QgXYD3MjA3n8xovcXXwM+LTzRFr8qMcZGH87jHmjmKX/eycie2Fg9Gzc3JVvgRgQHr6RvLrmfhmeYkzbrKaJTdzuQ3gdUCkLxyaULhQ0bjlF1E3FUwvwYX86IO7/IiNSYKP5w0Ab9EflDKTXWX1cuEHBfzz5flVcYwnSP7m1jNxgMXZ9mflRryGJB2xRxSVx6aKBmxi8PpEOaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFPN0SBSr6PbHgcghlFBv+QWPvrLlELhnAj1xrXcBOo=;
 b=hdZEyzdgLB0aSSgpd/ALdlu/gybGhyIpGzNySE2jbBD+hXvyIj37ktS+3jMx2/y7DPrISsK65GVm2C8P4Im75V23nKSiDIz9TcETkJgY3c8Rzf2dfpjTPTB9xbecz1C7Gmj11C6+qfMrP6hvL+Rlw84mhJPZYNUhElouWwCJDuw=
Received: from DU7P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::14)
 by DB9PR02MB7260.eurprd02.prod.outlook.com (2603:10a6:10:25c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 09:57:24 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::3f) by DU7P250CA0025.outlook.office365.com
 (2603:10a6:10:54f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Fri, 13 Sep 2024 09:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:57:23 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:57:22 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 11:57:22 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id F34892D9;
	Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id F04B522FC7E6; Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Fri, 13 Sep 2024 11:57:02 +0200
Subject: [PATCH v2 1/3] iio: light: opt3001: add missing full-scale range
 value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240913-add_opt3002-v2-1-69e04f840360@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
In-Reply-To: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|DB9PR02MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0347f9-80f7-4acf-3d19-08dcd3da776c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3BTREhXTlJaSEFpMExzeDVuRW5BUDFzSTA5M3JUZE5QendEUTZvVjhLTHJU?=
 =?utf-8?B?SnNqTXlVZ2J1c1I1WkI4cWlhRUZSamIvUlRTUGMxT1hCUzFHK2pNN3QxSW9k?=
 =?utf-8?B?QUtwVml2Qms4ZmIxV21Ba0M4RVRYM0dBNW43UjFWUlhpbWJteXk3aFNrbXh3?=
 =?utf-8?B?ci8wRFZ3cmN3azB4U1VDVFpXTU9xbU15eTg1UCtHd3RaYVNyWUJpOUJuaUY5?=
 =?utf-8?B?Zzh0RDRHZEZWWGhuZk1iYVlYUng1WmFOb0lCbkltRWhFOUdmNm5kWG84NkZ0?=
 =?utf-8?B?cTR0aTk0Q0FWZTJLTkwrUEF3NFVjRkw4MHAvOGNiQjRFZFhrYlJpYTFNSmVI?=
 =?utf-8?B?TnJnN3lCQkRORHJFQUVXclU3b09ENWlnRWpFTnJEMmpaaHFMUEthT2FsME8y?=
 =?utf-8?B?bDJUN0NMMHZCekxUMEUxNGFRQ3g3Sk1kZ0FoTGluMFBNWjhhcGRHY3ZzNkgx?=
 =?utf-8?B?SjVQU3pYUGVXbm1jQkNzai9XSVZieUZLTTF0Y2ZBY1NqRUNsRUw0TnUvYXQv?=
 =?utf-8?B?RjNNaHorMkcrSkk4UFNnOUtnQzlaaStIM0pjbTFiK0Q0aEJIaFBNSUwvQi9V?=
 =?utf-8?B?Tnl0RzJXaENMVk11TVJ6UTIzbVJGZUpMMDMxWFZmRG5iS080aXVBL2tpS3hw?=
 =?utf-8?B?SFBHellSbW9oNDVDLysyOHFmYlRnL1BQbEFXTjBmNG1PRkNmMjlLTXZmdGJv?=
 =?utf-8?B?NHFvYzFFbjBmRGpkSzRqMUlXeFVDU1QzdUIvSGVRVEpxbE0ycnl1WTIwZnhH?=
 =?utf-8?B?MGRKbWozeEF6R2pHZGdmc3JseVFaS3kwZFQyU2QveXRSL1BybVB5WDUweXQ2?=
 =?utf-8?B?Uk00Nmx1K0lxYzg3UG9WenNHbXdSZUtkWmRYR1YzQ0lrTWNlVVBESWxCdFJJ?=
 =?utf-8?B?Y082cGNiZzZseWVCdUZSNWgxSEs0SHpHU1hBdDZpc3ZZUnQrOHBMSnhkMkxq?=
 =?utf-8?B?dEZxajRvZXowMGlhY3RVR29ZQnVFYTZidS9mQ3dIWFZMKzRCV0FRbFhqSmJF?=
 =?utf-8?B?SmtlS2ZkbnFmZzhEMHlFdUE2UXFCelZla2Z1ZE01WHVDVzlXTk1xZGhlcXBT?=
 =?utf-8?B?ald0Ym5CL3lSRE8yRnErclRKT0RUU3ZOWXFFMnpvQktwNi9CV3lwZi83dUZI?=
 =?utf-8?B?eDI2dFdOU3lGcktDbkptd0xHL1YwV04za3d1TkNaVktuQjkzQ2dDSS9CbEZv?=
 =?utf-8?B?UnpjQUtYbGVpcUtKTGZPdEJqYTR3eUliRWsvbUlLVWY4emI1Q1I4azVKMERZ?=
 =?utf-8?B?aHdMTnRDL0RrcFI4WlBWeTg3ckFVK0gvOXgwOGtxNW0yeTNpZ3NwSE5HYlJU?=
 =?utf-8?B?UTJmdnlxNk1rOHVDTjk0Y1VSS1VQMHpva1FiOGNubVlrMjlMUjVpU2VCNGdl?=
 =?utf-8?B?RXVIUW01S3ZRdTFQZ09GaVFOaTVwZ2s3alMwKzFwYjAwMEN5SHRZRVNySGRr?=
 =?utf-8?B?ZUFYb0NPQWVxUXFyQStTRGtGdk4vbTJIUjAyYkFJN1hsR2xoRVlHTEUrbkJG?=
 =?utf-8?B?R0U2dXlHVzR1aGxObFk5eTBoSzNPMWxqZUc5eEJHQStPK3ZHY3VRai9hbzlR?=
 =?utf-8?B?S1JiM0NNc01iTytZZ0U1WFBreVY4a2VvcFpPMDhaSkZ4bkRJb1JzZWhKYTht?=
 =?utf-8?B?NlVhcTEydVV6ZEFRdzRGaTRmTVhtK2FVdUI2TU13bUUvYjVDanAxdGp2SEtU?=
 =?utf-8?B?dnNVd05rcnNnVS9JOU1RaEpzMkZvZVJXakRaYWZyWkZjdlRqOEVkNUtaWk9R?=
 =?utf-8?B?a1AvaitPUDhZWG5ycVBDcmNUNDBGbXViWTFaSDJJYmdqcFY1Z3lKVm5MQVV5?=
 =?utf-8?B?TGJQUHdrVXAwNUpxTmtwSVV2bzVNcmNacnJGWWJIaVA5TVlFbGZWQjdSQ2ZT?=
 =?utf-8?B?NkRFNW5TL1o0b0tBWlhFclhnRWtVajVacktEMi94aGhyWXpHekxZTFZWMkxx?=
 =?utf-8?Q?XSuI8Em6J4FCPShoW/En8XsBzLIK5G51?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:57:23.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0347f9-80f7-4acf-3d19-08dcd3da776c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7260

The opt3001 driver uses predetermined full-scale range values to
determine what exponent to use for event trigger threshold values.
The problem is that one of the values specified in the datasheet is
missing from the implementation. This causes larger values to be
scaled down to an incorrect exponent, effectively reducing the
maximum settable threshold value by a factor of 2.

Add missing full-scale range array value.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 drivers/iio/light/opt3001.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 887c4b776a86..176e54bb48c3 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -138,6 +138,10 @@ static const struct opt3001_scale opt3001_scales[] = {
 		.val = 20966,
 		.val2 = 400000,
 	},
+	{
+		.val = 41932,
+		.val2 = 800000,
+	},
 	{
 		.val = 83865,
 		.val2 = 600000,

-- 
2.39.2


