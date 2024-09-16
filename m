Return-Path: <linux-iio+bounces-9619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876CE97A4A2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C19728D589
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377B15A87F;
	Mon, 16 Sep 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XLFi99dM"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EE15A85E;
	Mon, 16 Sep 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498674; cv=fail; b=PsCBSEPmZ5KV92ScCDP/qDrdsDlpvWY7EE43FORwvMSLQ7RevPYkCeNza5djBxfHPHNT4078kCr9z0TeMj8/nGMycyB46CBfmvhPaxrZrGKV0beSwIjC7WDsXSc5sM3JT7eFrsxYAUYN+CXaXwKB/GIu2l/nuDUKAPE5dofojnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498674; c=relaxed/simple;
	bh=aqY/vAVBSMH8SLZlhZ2rUTWyaKlm3LSZXGMGn4Xs3YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QF3Ohn2pNoHK5puDedf98DlImV/o8gywL0yl9fVUMw9HC/rzWbrRfzddPFWN7hyVu/aQCnhfEd8zXGzfVmnlEx3HudEmrjFVmKjcDiOvZZgZWGSzJQzFmhryxdSAr3f2iu3+54e1NhwGDmXKoCqV3ipanx7p24Shvse5ksBSrGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XLFi99dM; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5esutnq1WwaIT6CUTO8rWpCfMqND0Mb/txs/cTU4nDhBBWGEXJizO8nroJcnKH7G8CcJJPDnaQNaVgCvb+x2RDIQ2eQten3jINOd1s0jkZbHsl1DAfnOJw6aBUy/22QU9WCpx546q3y34kzXybJ6uCvrtsBz2rWKTjUzcyYPRvPf4tLR5193PZMeIehyHfPQuzvBnK58dD/mSEH1WVoWkt8/I0h6QStCJPI2mOn354TlZF3/46cjrhJWDc5fAkXvDqW9UoXdSNup0qvwDOKjQqhJbt3yMTndO7siUfI54+np/FSlbVg3ixJkBPm5npgz985DNT/DfRTGXpzTrNPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFPN0SBSr6PbHgcghlFBv+QWPvrLlELhnAj1xrXcBOo=;
 b=ntEjG6y4TghZCOTCJHnIe2HdeSum8zA4I5h/yW44VQcP8IF70DUltFaEoH02w6bvvSGouEfArLGU51Ddwv4r/TlkxedSZyA3/xQhYxi94dN6acSx4sr4SvAXe6+lTNtWbQaBE76Kfh/q/h/qIpf4TJ6DVOUpYMgJDFLzunLX+kUJBruyC3iHJdqYcw5jiuhpWq5bRGBqDeFuDs+pk6jar+CMLAuoHTBeSz0ZVrP41TNosIDKkOuYZTZXaMPRZJsZefO1DyUQti2KtStP/TrOQ0Z8LsVQE+eX0OXIN6COTD0ROx4YVeoFtczsmeicl6ggpPonh3yyKmS24IFtC+PnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFPN0SBSr6PbHgcghlFBv+QWPvrLlELhnAj1xrXcBOo=;
 b=XLFi99dM2NPxfzJ6hQVXRqZWb8nkpiUgmgGHX/nxwK03A7p+N4vLboMbmgY54I5rqY9lIsqQs/tHHXi/vz3ZXkKyDI292s2KCl7nMVU2ehsBTlbX42fWf/D+D3gkcSs0oZLozJDSg+dVr+WWoDGMxPySNvcRBH7tXq7lJdfICQI=
Received: from AM0PR08CA0010.eurprd08.prod.outlook.com (2603:10a6:208:d2::23)
 by DBBPR02MB10481.eurprd02.prod.outlook.com (2603:10a6:10:538::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:57:38 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::d) by AM0PR08CA0010.outlook.office365.com
 (2603:10a6:208:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 14:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:57:38 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 16:57:37 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 16:57:37 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 4FB92264;
	Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 4CA0E22FBD57; Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Mon, 16 Sep 2024 16:56:37 +0200
Subject: [PATCH v3 1/3] iio: light: opt3001: add missing full-scale range
 value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-add_opt3002-v3-1-984b190cd68c@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
In-Reply-To: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|DBBPR02MB10481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1918d5b9-1416-4ddb-c9ad-08dcd65fe825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXhpdDZicXJhQ2hPbEQ4cUc0M0dXSjdDTWRFL21xNjdJVTA0UXRxS08wb04v?=
 =?utf-8?B?eTZZaFUxcmltdE1hTWZRcVhxSzFBdnRYaGlJTzVFTjBILy9MQTdyTnUybUE1?=
 =?utf-8?B?ZGhRK2s1dFVjWEs3UGF0ZzJyRlgyZHI0RU5aSEUvWjI5MlovZE43VUtiakRn?=
 =?utf-8?B?eVZjVmgrbEZLSkdCaTVnUTloaXFuTXJpSnBmc3Mwb05ZL1dpelFKRjA5b0hi?=
 =?utf-8?B?TUpTeGZOYjIvbXpYWVhxUVI0UTFXZjVpNFZJbVYzeGJreEV5eW5Nd216cEFH?=
 =?utf-8?B?eVJWUkJDd3lSMC9OV2xIS0oxM0hNeS9mZ2pDNUdNK3BHdXl6U1cvYWlSZTV4?=
 =?utf-8?B?cXpuSGRiNXM0WG9WT2dhV1ZHUjZwaEJIbGgvZFJvRXRPZUN6bGFyY0JMMzVF?=
 =?utf-8?B?VjEySjVFNCtnMSt0M0xjYU1pckxVZnhCUWR1VTlNTGtyWjBaN1NLNWVkMG5o?=
 =?utf-8?B?ZVl3cCtpNkJVWXkyM0V3NkxIa2FkbHhQTUpNUEIwdWplV0pyYUJBRkltUU16?=
 =?utf-8?B?SWFLb28wUTc0c3gxK0FRQWJ5Y2dQNFg0dnJRWkZvdU1DQUFzVGszN1FPUjlN?=
 =?utf-8?B?dnJ2dEFlaUNPTEJieGNLd2s2YmNlNTBzQlF1dnlpUnFMOWE1d3ZjbFM1ckpj?=
 =?utf-8?B?SnQxTGxBKzdNNWRrNlliVHJ3SUNWZXloaVpDd0FPM2k5S3lLQ0k4VFhOdzFw?=
 =?utf-8?B?ejYvbkFILy8vSGVxamJvMzZzSS9XdXdQSTdsSGFHc1VWM0tGNWthUkFsU1Ix?=
 =?utf-8?B?VXNldjVZdzYyUDRvMy8zUDhTd2V0N3U2cWlvSEhENVVGTnNhczZTTlNjL2NY?=
 =?utf-8?B?dGJreHZ6UE9MTWZCajM2MnlabWxYZWdqRTlXRDZNTldjZlZSMVBoNkhMeVB3?=
 =?utf-8?B?VEtWbjVhekxpS1dTRi9xWWIwWkRPTUdZV1dXMUxRd3NwMVdIL0htSHMyWnBW?=
 =?utf-8?B?WWY3WEJkTWFhZzUrRFZYVkJvbURwMFJhc0kwWVRLSDRQRkRMN3dJaU95bFBD?=
 =?utf-8?B?RWI3Y2k3blN2aWVmNWxqbm94RGdiMUNscGVnQWh3dGp2aVhiTzZwcFRuQ1VU?=
 =?utf-8?B?TGs2SlJYc3NtNU5oVXlKOWlSU0VnZ2tlWm5IaWZaWEZpdWoxbW5qZEg3L1Nq?=
 =?utf-8?B?aVFIazBnQzh5NUVMZ3YxN1ZSTllzNm9VNVlmM1JYdUJTRi9mSUpoNU5UaEw0?=
 =?utf-8?B?cTFCMWJTV2JkTTlsb2xkcEpDMGtHd1lhR3d5NVNlVEVhOTZRUE54Mk9aZk10?=
 =?utf-8?B?U25aLzIxNEhXZ056QytmMEZKa0Zod2JDbUErbDV0U1RQZFAwdEZLY3BPOFVV?=
 =?utf-8?B?WU9xZ2JQV3lhZEpKTldRblNpVklidzZQbTRKTTEzMXlYWlEzbEdVYlk1d2Iy?=
 =?utf-8?B?OXRIQ08zOXFwNUdLVlJQcmtaY2ErOVk1ZHY4azZqZWZuNk9BdHlCdVlJc2o1?=
 =?utf-8?B?T0ZYMnR2ZzRXZTVuU2hraE5URGN2VzhPLytqVG5SQlNkRXV4UVp5KzBac1FJ?=
 =?utf-8?B?TE84TW5pMzJWcnZDNFc4a3lUNk1OYXZPOGVuTElGMXg0YkcxM3JCdXlVdnhC?=
 =?utf-8?B?ZVRiYVp0dE91cmFETUhHSTF0d2xPcnVtSFdqVXhOQzFIcmxhUXlYQWJQTnps?=
 =?utf-8?B?c0tvcks4cGdWYlBpditqdUhGKzVnbHo2eFU1V1JUbHJJNXl4L2hLVFgycG9Z?=
 =?utf-8?B?NmJoaXlMa2ZJaUtlQjZtUFJualVEeE5mcmJvQUpqSzlhV3A5dTRFM0pkenVr?=
 =?utf-8?B?OC9zVTZGb1pDR0hxZGNMYXVWUGl0aUVkTncvNnorQnV1Tm41ZDBpdXJ4Wldn?=
 =?utf-8?B?RGZ5ZTZYVWE3QTUrMm9DQWIvSEhxWUtSY2VWZk1IcSs1dzE0c1YvaWZMOENU?=
 =?utf-8?B?NjJ3RTlCdFpNQ3poYndFK1lsSEdERFAxQ1VJKzlqR2ZoLzlraTBxVksyNEI3?=
 =?utf-8?Q?rm072vMZffHABzchRg2GV/YR3osOALsZ?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:57:38.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1918d5b9-1416-4ddb-c9ad-08dcd65fe825
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10481

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


