Return-Path: <linux-iio+bounces-19733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D0ABD6C6
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2171D3B6D4B
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C327AC5C;
	Tue, 20 May 2025 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fXMPdOGN"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373927A12E;
	Tue, 20 May 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740485; cv=fail; b=ElKN0kl/7oWjl/ZXDAWtT9fKXBhOAyuy1HELb7Il01bt1PDxRf9/k+JlQqrr/cbpSI5jWydLOx1EBx/F1sm8tBnOkp8m1C/mjmrlnqS2QsULv1ww4s/vyOMJ4jfvr2SDbZDSBCsMu6ydcRqfteIEbguOZMkuEItVInkfJfdWXw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740485; c=relaxed/simple;
	bh=//ZAQowYZhvYerrDO2Pwoysidqo02Uv+yzw8C6oE9R4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwJRlhlqExLU+cftq/ahCfq8kK9n+UA6AqxRqrAlccxsMNQj5Z3cLWe5Pks7yPwojtHxgEtv0OFGHuPznRjblKXgRUjjWwLIRWFU1g4zpMS2RsnoJRfFhJ2a3XI9gjAU/BmJLPjZGM+7tOQLv/dF2z9EyNefHpBf3C+g8tPyohg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fXMPdOGN; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmJByPsWRLcs/bgWNrTwFLzgeLn5K/157emMXE1cvnHkc0a4mq4Hh4bcCUyHnXmoB0sHYr9pWIhsIoE6otVKjBZSlLm3Chhf6PF66MVUDQUPppnKTUoe4uc4r3YPFI2TfkbqKkbTfgWNY4coxkk7sk09lKMdMFrs0XOqnD32+8RKesPQe+HywVFHcDHX9uPm4KUvZi2fWc6NPFengYvLyGYg24NbHSwFvMgieDficTXHjjpvlAi4v1jXndZwQMaf2+moCnDTQmhedrBNEw6yI+3tOW/3908ZtSzQmz92DJ8V3yti9TMlmJDJX/5QDG9CYmWrUdCsJIq7HNuRDozeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPVmAYjU0MAGhpKIP4B4+e6qnrCetamM+biMMWXgxNk=;
 b=R5bs9sJXNzcYHRKnyN+IlwJe+JWqIhFekxjKMITqQlaU4Pdtwzu3qdQa+m6JHsPIx/UNanWt5vtpGUl4qAEVaVjx5Xl7qs6onZpoGefAky8I9sSr/pXhOIB3CTQeqMW5a6HDIWRXTOD0ujLdmQClvsoFQeOXxRT4LuG9zKcl4NFBCQkNDCQvGYKVYqbGbh54FWpEcom9ljaPi9Bcxxw4VApYeCu+Oh7/u70PFJtDN8Rdvj6xq7UoFiJ5qcehMsPPVFnjEFqpcPJX1/vsXph9rNmnLm8Kb6eJsLXII9lI9oBBzgFolMdGBYhIVIA/LC82GhkOuFYRyHVEVKb7fx6etA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPVmAYjU0MAGhpKIP4B4+e6qnrCetamM+biMMWXgxNk=;
 b=fXMPdOGNONZkieh+3osfnrFqAhaoBVLMBxf91hq8zhu/nFX6pt65BLNrc2csS+MtFqI0CwViAYoQE4Lmf9cXTdYXzwvbJX8WZ41DP7Z03JLHEUD4qVNWZtV4Lrqov81ePfbGakIhYVgH0eUz40Rh1vPVcdXtD5IbWo7VanugsVY=
Received: from DB9PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:10:1db::19)
 by DBBPR02MB10602.eurprd02.prod.outlook.com (2603:10a6:10:52f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.17; Tue, 20 May
 2025 11:27:57 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::cb) by DB9PR06CA0014.outlook.office365.com
 (2603:10a6:10:1db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Tue,
 20 May 2025 11:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 11:27:57 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 20 May
 2025 13:27:54 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250518183852.7e9afdac@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 18 May 2025 18:38:52 +0100")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei> <pndldqwiihi.fsf@axis.com>
	<20250518183852.7e9afdac@jic23-huawei>
User-Agent: a.out
Date: Tue, 20 May 2025 13:27:54 +0200
Message-ID: <pndo6vnfrnp.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|DBBPR02MB10602:EE_
X-MS-Office365-Filtering-Correlation-Id: 964b522b-e135-453d-1835-08dd97915eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3FvM9TfCTxOChJTqm3gyS9R44A9V2HgTOufS3vZlfXhzX5ztB2qRx3LWyHSO?=
 =?us-ascii?Q?xTyM7fWBY6JeVaghkJDbKZ+xxTfqi2OnUJMdReB6SkLlh8I1MEd5zGhY8mfR?=
 =?us-ascii?Q?ru4FP1OsEoa08/w/J3KvjepLmYlFZLn71Q5uit7VCmhRP319/aMGQWk8SBrh?=
 =?us-ascii?Q?daSy177ybxQT+HmqdlsHp3IuFZ7JmpNfxbDW3KHZ4swn19Wdex9MYAN1DBM5?=
 =?us-ascii?Q?5G7tkF1mrOwN8xmHW+8aLdV7p8G6YCjOD9omVcXa4iLI4XTQERO+Cv7E55uI?=
 =?us-ascii?Q?Yy1iEbPUwx/U1NUQDUvqmjuaWaHRgFo3dlUhE1vXkDEdUDBbZYIWPv0k193/?=
 =?us-ascii?Q?w2Yc5HMo9+Dy2G1c0ZiKHmkJyzTR2tvl7kOe2ncuLxPTUUwTV0SIrOgjMHgt?=
 =?us-ascii?Q?NfdwhAYFmNZnz0pAjhkkKQ5uqPS9ML2p3B6cK/vbLdZNR416DBzO3Cg9u1KK?=
 =?us-ascii?Q?Yhm5iTIai/P06HYuo7ocPevy+A4JqDS8kYem9MLvNFQ6EhcFUHtBcYvc3fS0?=
 =?us-ascii?Q?L6yjK+nQLWMU58FgjJDUOweOeX//f/n2W7JzGSjOH3c1Wkti1s5SEm5k1Lvf?=
 =?us-ascii?Q?Kle3eIy7QAogYlxRA2+aPuzWEp31hvc1xU7Cg9/9U4x1mprrKrUdUb+Ny7gL?=
 =?us-ascii?Q?zF7q2k4xFi8JdmbJviMzigds7iGF6T8zOAk8Bug+ptAnVQwsP942qsBMH/ps?=
 =?us-ascii?Q?kWR13Oocyyw92TJn0VSgw1czzvOPw7c6M4zoajM0eePcj2Ngz8u5lGNeOWiD?=
 =?us-ascii?Q?PNdF9fnLOEfNS7zxdUm3oBnXcSiKdWjQMfUdCzqXVRYxPH5zkgJ2KHRu1lOM?=
 =?us-ascii?Q?/vbGxrWlSGuzKLlSuI5R26+nhgHKLKqmRU1d4UPFIKLhsOnAHCnonis11B58?=
 =?us-ascii?Q?jCW06MiKh51sTJxCQxh1c3oPlGl1jyGtzEmVQjfo4XmGjojuR1egYZiqHTvL?=
 =?us-ascii?Q?EHXtN/0Fb19WGFfaXY8SJJJHF2vSBMzyp+TmMgljcvvsFno32v+OrLhTG3iq?=
 =?us-ascii?Q?lLi9g45ppQHcCaSdfv36RqLV1/vRBAX3fBAbp9ErAVbhudcDqdv8ybu3pXi7?=
 =?us-ascii?Q?YoSByBKBpN3fLkdkK8Uc9g4nmp8Yr05MGuMQ2DzunTmyRJN+trZpyTkweoGq?=
 =?us-ascii?Q?TglNmgfjffjZf4ffsDU/OAL5jxQX2jcK03NyvyYs8fjttTkv5ncj4S4h8z/h?=
 =?us-ascii?Q?CdqbkqdB74MSU0kNIyWjrybagp5+CiJMX2GuZk74RCI7C/4wTi5lKpX5lOLk?=
 =?us-ascii?Q?KSxkL2XidHyI9PMBNHbRWC7/PTpDfNnObHksIm6XhDD/QagQgbJkHo4XcsC9?=
 =?us-ascii?Q?pq/dtJwqvPm87AVgyqDuUF4Yo+1PjmGAtpreaoNei1VybiGhw72tixi8rzE5?=
 =?us-ascii?Q?cCUAXhAGd02/5/29bNhVixOBfWt1AXrEapIp8nh1zKFQEXSJ9+mqveWnkag5?=
 =?us-ascii?Q?ndUDM2eoG3xLw3tyk7W4bXX4BFu5vf+FDqJHLx4ak/4sSjDFrnuR+gjRHHz/?=
 =?us-ascii?Q?SUufCBD4X8Z32T2d7Z6+t5LEoxCuwhdrUel6?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:27:57.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b522b-e135-453d-1835-08dd97915eac
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10602

On Sun, May 18, 2025 at 18:38 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

>> >> +#define D3323AA_DRV_NAME "d3323aa"  
>> >
>> > Put that inline where used.  A define like this both implies that various values
>> > must be the same when they need not be and means that we have to go find the
>> > define to fine out what they are set to.  Just setting the strings directly
>> > tends to end up more readable.  
>> 
>> Sure, we can do that. (There are a bunch of IIO-drivers doing this, so I
>> just thought that was the "convention".)
>
> I'm sometimes in less fussy mood.  One day I might just clean those up
> so there is nothing to copy into new drivers!

A quick search tells that there are (at least) 105 of those:

  rgrep -A 30 "\.driver" drivers/iio/ | grep "\.name" | grep -v '"'
  
I was just about to write a small Python script to fix those, but just
wanted to confirm with you before spending more time on this. So if you
don't want to do this yourself, I can help your here :)

>>
>> >> +	/* Input clock or output detection signal (Vout). */  
>> >
>> > I'd rename. Vout kind of suggests a variable voltage. This seems to just
>> > be a level signal.  
>> 
>> >> +	struct gpio_desc *gpiod_clk_vout;  
>> 
>> Yeah, it's a weird pin with multiple use-cases... I just named it
>> according to what the datasheet calls it. What about
>> `gpiod_clk_detection`?
>
> That sounds like it's detecting a clock.  Hmm.  
> gpiod_clkin_detectout maybe?

No objections.

[...]


