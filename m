Return-Path: <linux-iio+bounces-9182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66D96D5ED
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF95B25ADA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24D1990B7;
	Thu,  5 Sep 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CJZedo4s"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624D1990A3;
	Thu,  5 Sep 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531731; cv=fail; b=IxXArhTi3kzFtIIpLdWOTIQWoHgHk8EYvxoOaqhva7wVl/DgVXkEpwQkFCYzCNFfVTop4+yKa+nNVtGU7y/qkA+seEaupJy1AyRO5bjrsBAoQmEwwtDeTyw201MniltXUwoj7hN0EeyE58HA5JpexaPqtK4Ax2+RAqgSxuLcPbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531731; c=relaxed/simple;
	bh=h9AGyacNViuYeSRBH4DVLVuDVPj7WZh/2IOqdCiPKe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HtKHipP/Nk74aj6wqFZVrMIucz/7IIaKtwwToEESLMZxMKR3wOhy+fYFlHeUc77UlC7qMP5wyNDNYKC2LJ8SZAVOfcRlZeJldbaOwWlgdCWuG2wCzw+w+/awzvocAiedTZws7+eagJ/6FjOmHzCbFAMk9q8/Q4gO/9/5fv+nr68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CJZedo4s; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVtEyKtTN2f/QHIaYSBWqxxNYxxSMtbEZsUTOgoVN9UMGp2vmcedkEze6hozaHBZFzGd1N4N+lg/ECdiTn78Y7qflkQRRohhLx2wCEESofYGJpxH9D7ct0dppdQ+KlfugbhW1fT2dD4b0DuSfocgfx97U+okpvGqbwF+DsvC/RsqQ2UkSWogC51lS00nXizxc81ebb/ozvhEZer46QBobAd0L9mlTAO/LZcIgTn5ODzfjzamC6lt6FUfwc4OEtNJtnTuLJM3bHfCUs5achKwDc22CV7Q8AcKgryfqbwKCGgFgCRPwdQxq0f0DL0afS88ECnUemAEjE1nYelVbm3NxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPM3B7DQxKm1DSW0hUGsbJzXm3ajFLNl9LM5KWClqzE=;
 b=s6G9Ax4WwfxAbnN1GiauOFjnZw08FAlnVSNbtCjhbWHhE0kTN2xUWGW4OvTK56cPY4yawoFvUSLk9StecPdOaeOjvWoCb/ssO54zfv6yXD8m1PdhXOCLOv3S1CeGy9behItcmEvbYMv4KXCUFnuNaRhvggSrOcMoRAkqlI0uwmuM2PRKMMBsHSPL7ecuPvPVWmIQH++U9GYFPQHnDP60qv6Z/mlYtxkB5Ox4+l6JFs1qR2nlHIiImgxUG2ewXxHFvLdni3sRerBI/wkT6fZuQ564uhqgFyYLJEqAaagW6kV+kYn2He/TzKCuxasGO5bLrkHEOUI5MMP0EQ6EC+HOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPM3B7DQxKm1DSW0hUGsbJzXm3ajFLNl9LM5KWClqzE=;
 b=CJZedo4spA896iquehrBRKSsPzyXk6bB1fskNXHe60J24/9lVnCw0hJMbqXamylVuuX0IWFfaqwU0QHxRaZT308Ttn434b7RoF9bkEL66gGAiuEG7/9xYNeibh90ktUj867mUcWpcTNlRGl0fqxDIJ6JHY/hB35DT0OJcn9W41U=
Received: from DU2PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:10:234::6)
 by AM9PR02MB7298.eurprd02.prod.outlook.com (2603:10a6:20b:3ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 10:22:04 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::80) by DU2PR04CA0031.outlook.office365.com
 (2603:10a6:10:234::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 10:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 10:22:04 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 12:22:00 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 12:22:00 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 12:22:00 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 58E053F0;
	Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 55D82230ECAA; Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Thu, 5 Sep 2024 12:20:45 +0200
Subject: [PATCH 1/3] iio: light: opt3001: add missing full-scale range
 value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-add_opt3002-v1-1-a5ae21b924fb@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
In-Reply-To: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AM9PR02MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8e448b-e326-4b1e-7743-08dccd9496be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0V0bDVRVnN1MFJrU280NzBZVE0xVDdvaVB4MjFxZ0o0VDNzUUoyQzlXdmJn?=
 =?utf-8?B?LzEzcUVDWGQ5eWM5S3k0OCsvekNnYTNxajllUFh0SEtFRUxiQkFraFFZYkF0?=
 =?utf-8?B?ZzU1RjBxR216QUFMc0h6WFpzQkVuSWM1RzE3K2FObHZFdjRpbSs3Q0RiNkRH?=
 =?utf-8?B?WGI2aXNmeGs3RWpSZGRUd2ZCUGlmbjE4aWprVkYzazluSmN6TWxWVHN0RHJC?=
 =?utf-8?B?c1ZLQkhNa2p4VTJOU2tEVFhnMThiTmxCN2RWWVZiUFVnSDIrcmZodlFsWkVM?=
 =?utf-8?B?R2huZmhPbHE5UlRnWURJMmVGTlE5cFlZNUtDbDlPM0cvKzIvS2s1S1RYUDRE?=
 =?utf-8?B?clhFMUxRSTNqZWc0ak5CTVlqTmlwKzFob0NyRGloc1NBMEloNlhHcllwUk5i?=
 =?utf-8?B?MnRETGtFM21oRkNkQ2pJSk5DMHNpek5nTnJITDI1L2J5V0c1bG9IajFEVW5U?=
 =?utf-8?B?VDdidkVTWllYSWVnT20xbHpBQlhSWG9wWmZWdlQzZ01TVkN3dzJCVDJJMUdW?=
 =?utf-8?B?Y3pjdVdIMU9SUXk2N3BQNTFNSUEwTG9XTkZFbjBaUHlxRnJhRWVZUlZHa0tN?=
 =?utf-8?B?a0hxK1BXc0I5dm56ODczUlBnNk5SVnIxdms0QjJiSFZDWWM1R21SbEhYdHFr?=
 =?utf-8?B?NDFxU3BFVWRGbStjb3FUWFRpa3p6a2NKS2F4OCtCdlVEdnRUemk5dnU1ZkR2?=
 =?utf-8?B?bWFVQ3pOdTFqNHU1dzZZN0tWQUdJQ0ZLeTBaaGFCcWZmRURzQXZiMWMrMHNt?=
 =?utf-8?B?MmpkeGl3Y2tSTmFXenpyNmI0NXIzdFdVY1N5OFF4RksvKzkxTTYxQjE1VVRK?=
 =?utf-8?B?L0dWYUFCeXg1bnlYVFdNMWVzVzhJakRzRENzL1lHaExjWWluL3NVZDFxTU56?=
 =?utf-8?B?MVFOTGl3ZEw3NmJXU2Q5VjlheGZYNGlST3VIeGpFNzNtWUF4WTJGUUZvYmdq?=
 =?utf-8?B?K2ZINDBZZWY3MHBUbFArVGREOGlLU25sY3FEcXdrTTNiUnBTa2xadXNXc2hL?=
 =?utf-8?B?UytXb0RmOXZwYzhyd3VORmoyeklSRXpJMnZPUHVTLzdRV3N5SUdsUDljOW1k?=
 =?utf-8?B?Mm5LdnZPQ1E5emdzREs5MkRBaXNFcFVybnVGVXhYekZPUzlWWHczcXBZTXpi?=
 =?utf-8?B?TWZhRjlCR0dSVGczd01XdE00MUJNTk4vMlFIMlE2L3JVb2dkOVM3OUxpdkVJ?=
 =?utf-8?B?MXdLQkNTSkpmUUdkMWF0MGN5cC9tcm5YdUx5b25VbHhLTnVnWTgrelcvQU1M?=
 =?utf-8?B?VTZVYVJ4QXpucHpWT0tXUTEzOFpDUkg3Z3ZMek9UWGlJeVRqTzgzQmYrN2dk?=
 =?utf-8?B?WUxaODQybDM1QStQWTNoUURFREh6b2xnRXpTajhuRHJwaE5oSy80RzJDNnlh?=
 =?utf-8?B?OFBBWVd4c1V6UTV4TVVjQTVjNDlscTVqVzV3RUU4bDNvK3I3MlBhQ2Rib0wv?=
 =?utf-8?B?NlNKZVVUL2tZNkIzYjFtWmZoMmEzc1ZXVldWa21zRUk1WUFFdHZXZzdTUGd4?=
 =?utf-8?B?S1dSZENIaVExaWtnREhyc3h5SVNZSnBadlM0L2FmZ2VIUWVLZCtYZFpZNDNX?=
 =?utf-8?B?TnhpajBNL0tHVWUwYWhOZlZaYWpnSnNhTDlEY3IrNUNlN0tHWjlGb0Z5M01j?=
 =?utf-8?B?cmNlRnM0UFlnWVNIVkNBdUpKd2R0aHRsck1SWURaaGoxL3ZGNzJoUE9zQmcy?=
 =?utf-8?B?RnUrTEw2d2RzVzFNOVl3cVc0NlczS3BaM3hUamF0ZkF4KzlHZkE0RjJ3MFVt?=
 =?utf-8?B?SEJ4WEpRSENwRDJwK0tNQXNkcGFnR0VqejB3RDNYOFRhbnZHVHczai91ZS83?=
 =?utf-8?B?SGpiVlBLWHErWi9NMWl4MTBXNVpvQ2oxNUxkeDhBdy9heEV2dy9pQThybnhp?=
 =?utf-8?B?YjNVQ3VFQklvRy9mN01IMFFmdE9oa0p1VTA3WkFUSElpNkhmSzMyR1FORm84?=
 =?utf-8?Q?Ohe0qI7WtnasdIimr9iZYGgW1hVVIJZ5?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:22:04.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8e448b-e326-4b1e-7743-08dccd9496be
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7298

The opt3001 driver uses predetermined full-scale range values to
determine what exponent to use for event trigger threshold values.
The problem is that one of the values specified in the datasheet is
missing from the implementation, causing a big gap in settable values.

Add missing full-scale range array value.

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


