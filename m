Return-Path: <linux-iio+bounces-19602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DBFABA1BB
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45115021CE
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17681272E69;
	Fri, 16 May 2025 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fakFOUFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21961200B9F;
	Fri, 16 May 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415695; cv=fail; b=BpZa6CksVEFuiXe4Ht6qGsxHQSzWSGtcPFpn9hrkaORFUYul3hPnrpvY48klPnlfz5ToJqjH5wcl7W6Hs2Q5S0bg1a65jscFt7FRUpa93iy/o+0SE1KRISl33m8mz4hFSttCeEOxa5aTZ8XAHjkvZq0sgEMBWpkcCJJOtKNRfqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415695; c=relaxed/simple;
	bh=WUxfJaDt2qXcrIy9GEy7rYm3renJppwdcsu7JgC9ABo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXj5cJSjsrEijV/vlP6KUaeP2YqXvLeZM9QgQJpKkknNjKFq9DwWS0KDLv1oiSvQfVg8Q2ethjYazHMTSGtqms93Ou9skdICNL96tqApPAp8aB84ZkgiH3bYlWKs8+3JpqQP4shTpF2va0WChTDJcNx2CcECi8dYxgt8cNDg+BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fakFOUFx; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afzQfpmh/2ZjgxojIwrkRzxHw83IB4NBssv7LIWXkVN1qOHmlAVHAk44BnkFK8TxfouPDdMGVXH1RDJbQo9duNN0HSyCBFIszppZetXbgxa885Zl4naktLEf0R19m+R/QDnq8GSTEil3lpGoMPBOSoZsCuccVC4JvFJjOjyq+BEkYYljxV9OPy+e3hTul/vzyBW+8eommIntH/F06i19CIUXPkLqmeBUO6XrqMywlz8YNfUqlw8SmFCTiqk8GoZiGuUwiL0MCvJzZP5grFdYy4CnT3pZokcB0/NSqx063E/WktdSerIF7KNDh7Zh/0M7YwV56GhrOUamPZmevMOMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIKruRSl+R5BwzEiGwq09qr1+SzBBonX+Q0RT4nwH1w=;
 b=Vibe7Ci9wj3Vx42QxesUzrcJtFfivqBx/3BicldrrTEYYVepv/6U8ohsJMWtweKXe5U7ToEaZkMnTxK4dCBUuPiSTg/bH4xDz++uXubVlEyuzRBd43JT0a3zwkaOfRfZnF1W1aSu9WDkNece3pxKHrM4OnJ5k90VF575AcPkh1vWm05njRfZQ78n8Kiz01WM5uwpnqs/790/X7/ykNcpNeE0tFC4G5mKrLDONDGdV6fg6HWu4GFTQ8YVmtkaO9YprL90hjyrWiLN5PrZnB3QSmMncFyG4Yqus4dcEoeK4oflpLZV4MirP+BrYpFUnskHQyU2eipqDmPIF9qSencP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIKruRSl+R5BwzEiGwq09qr1+SzBBonX+Q0RT4nwH1w=;
 b=fakFOUFxRXsq7QC14avcN2gvlvua/YmExW0L0Y8WCPBUA3hBo3i88VAhtnMYCZZB4dkd5SZFhY8SgXWnZVqe9nP/BMnfgT9WYZaVckJy6Sd+589VEr3FmpeHyDtI6YjrgS4TnFjFoy/AAo9K+6l3AdqmTSRP1dRp2LcE0Xv71FU=
Received: from DUZPR01CA0345.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::28) by DU0PR02MB10016.eurprd02.prod.outlook.com
 (2603:10a6:10:444::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Fri, 16 May
 2025 17:14:47 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::5d) by DUZPR01CA0345.outlook.office365.com
 (2603:10a6:10:4b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.24 via Frontend Transport; Fri,
 16 May 2025 17:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:14:47 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 16 May
 2025 19:14:45 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <d746c1b4-4794-498d-9a6c-a1ac1c58357c@kernel.org> (Krzysztof
	Kozlowski's message of "Fri, 9 May 2025 17:09:17 +0200")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<d746c1b4-4794-498d-9a6c-a1ac1c58357c@kernel.org>
User-Agent: a.out
Date: Fri, 16 May 2025 19:14:45 +0200
Message-ID: <pndy0uwiika.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DU0PR02MB10016:EE_
X-MS-Office365-Filtering-Correlation-Id: c369234e-5e0c-48d1-6aac-08dd949d2936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VR+5EHRhQkOlWiaXzHbmqF2RzepOIzKqGosHglBd1t02e2B104cSiN597SX?=
 =?us-ascii?Q?9tlm3j+TH+nmkQO/b4WjZ37Ck4o1wJGla/zXyyrd9yF+/Bbj/gmA5hOIb3gD?=
 =?us-ascii?Q?uOkodSTPVgyiAdP3MJDcvowRJ6VzcS/uY2iiL+bLdMlKFEslGEMDgM1Ajdvw?=
 =?us-ascii?Q?AWDH3xwtXNkQwH6HnIBlkkEh1U5ShnNfkfwatKofM0Ider0VMSKDx0p55dEM?=
 =?us-ascii?Q?ekXjJYstdjpIJxVoNJMaCJeCDiHE0IUrc4hAY7G2516W7uIZ4ogsdILr4s7F?=
 =?us-ascii?Q?O5vaTReZRg7GhqcKIT+GUXJ2+ucuBR2rliw9q/AOW0OoQYUxlofm8IEO6WTq?=
 =?us-ascii?Q?OSKIInIU9RnLe227QNIsFfNUR6eN0jhPNnd9X2amj0cBI/623y+9bGg1uqmB?=
 =?us-ascii?Q?9MpEt6hiHg1MMZZ7AMwWdhaCnXwexIzKYOuSvV8c0tLesprMv+Woue/KkFAJ?=
 =?us-ascii?Q?YMoCcAl54fEtGf6MpmMbCoVg/ewbCwLIqxY2N6s+tEBU1G4r09yo8tcC4+sH?=
 =?us-ascii?Q?qB2n6EvidORCeBPXSFE7j/fj1ggnBkaapXV1H3le2gRGIypYATzUXJFKCD7n?=
 =?us-ascii?Q?iuIVfBAXTVLB3gD3gDmqFweMw54BG//V3bt8FXpbxa0+h/nz39/Uh/yeoC/G?=
 =?us-ascii?Q?hFQk+9yMF0dSJPlik5VTHLms0SYNsSNq3aKnILKDINaTYPgc5/d2RhMLOrsJ?=
 =?us-ascii?Q?e9GdlX+FfWvirgotW/wSHV+bo5SShPFihahB8YLduRrmesMla4Eu2eRTR6q/?=
 =?us-ascii?Q?4B81IqvlzSr3IRSPNKYY12kYkOU9EBWzZ76C5xM6760MPlSSWJ8hzKXEYvts?=
 =?us-ascii?Q?Zi85pg210GFzwjw0HEN4F35+klKmt7y2gKSXTok1x+lxABoeMIPmLVARsHoO?=
 =?us-ascii?Q?MiScE01/7KwKtx58+eqO3YKQlE/0Jlo7Sd9EI+Y/CrCXEl9/aHIHhSZVpOCs?=
 =?us-ascii?Q?oeP1/GzFvpa3XJ58Tjgv80Tq+h5+Gf5bLDcKhZ4Qahx7YtcR6UGStXJmhTjU?=
 =?us-ascii?Q?Yg56XxOEtKomO/GvFO78/56QhmdfG/6PVueU0x/9m2kQ202wZSi4WF/wAxQ4?=
 =?us-ascii?Q?6lPhYsdY0Lh2SpidMsxF+pROd05e4DmTrgG5gQwUddyoGLqjEWR48/m4LPEF?=
 =?us-ascii?Q?RYMbtufp0zHpXLZw+E45h96kBaSAU4kqghovAbtS3GRVSK+N7V/2HencyVjv?=
 =?us-ascii?Q?2KP8hiijix9eK/N3KEdwMky3AnDHtujeg2/hYPQIrtYqy2WSB7ujbd1R1CxN?=
 =?us-ascii?Q?pMRsDALgfev/i26MBcJkfd2eF0aLefPTEV5c8ft0KT+ZL19CmAwwTBhwzP4g?=
 =?us-ascii?Q?AEto5WRKiwPgB8czMnKxSvofAmBgX3h1+JT0DzhyemChr0Wx43pEMgyCf1WT?=
 =?us-ascii?Q?Irt/ZUMcG1+xuledZ33W6TMcD7BFlWJfLfdBCTez6q91+OdWlOiXr22JZLIz?=
 =?us-ascii?Q?dxl98SzH/ifBUBGel9SiTOf/BuY+1cruvLDTB7dIzyjjTrAM5HmU9iTWYeyz?=
 =?us-ascii?Q?nCcjriXwRd3kP95EaL4c73VsuPyCBCKt59hq?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:14:47.8156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c369234e-5e0c-48d1-6aac-08dd949d2936
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10016

On Fri, May 09, 2025 at 17:09 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 09/05/2025 17:03, Waqar Hameed wrote:
>> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
>> raw data measurements and detection notification. The communication
>> protocol is custom made and therefore needs to be GPIO bit banged.
>> 
>> Previously, there has been an attempt to add a driver for this device
>> [1]. However, that driver was written for the wrong sub-system. `hwmon`
>
> So that's a v2. Mark your patches correctly.

I figured that since it was a complete rewrite (and from another
author), I'd start a new series. But I also understand your point.

To not confuse others, I'll mark the next one as V2 instead (if that's
fine with you).

>
>> is clearly not a suitable framework for a proximity device.
>> 
>> In this series, we add a driver for support for event notification for
>> detections through IIO (the more appropriate sub-system!). The various
>> settings have been mapped to existing `sysfs` ABIs in the IIO framework.
>> 
>> The public datasheet [2] is quite sparse. A more detailed version can be
>> obtained through the company.
>> 
>> [1] https://lore.kernel.org/lkml/20241212042412.702044-2-Hermes.Zhang@axis.com/
> Read the comments given in that review:
> https://lore.kernel.org/lkml/wy7nyg3cztixe5y5rg4kbsbbly32h547hwumwwvrfme4fdgsj5@znfpypleebrb/
>
> You repeated same mistakes, which means I did same review second time
> which is waste of my time.

I'm really sorry! I actually completely missed your response there. 

Thank you again for reviewing! I know it's a lot of work sometimes...

