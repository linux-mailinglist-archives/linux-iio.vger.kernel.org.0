Return-Path: <linux-iio+bounces-22333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE2B1C78B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E792D4E3537
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677328CF74;
	Wed,  6 Aug 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nnbpHnao"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8E23CB;
	Wed,  6 Aug 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489982; cv=fail; b=TvnEc4/jZA86PE2aGp/vN/OFiHSa3GDH1i9YxKzsRNqfL4poD2FsQMQhM2SfZt4S3wBxHq3r1TIodnz4qcgM8eFkuU0K4fgaodp9owYs5+nhHJaNCLNvi1IbkQw7ykEI33GOk1yb7vievMvV1bc3jEKiDj6TmhQ8B0K00XgFy6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489982; c=relaxed/simple;
	bh=m8NQJd/UBebd2gHXrFaKUZe1SAAo+9IzfaUrNb9JcPE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHdkxiWDElP8Am9woaLQeRTIz45TvGF9olC2bow2HHjrNA4cvWyFpw0NDXibNVP9Bq5rhA+7jJpS5ibHobN+raIZ1HJdYIaifniNv61He+OsTSq6qDC6q50r4VCNEiu49Iuibu4NYKAdw4CMRTfVvcXUEDKVSh+TiPHXcCbNa5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nnbpHnao; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPzdCQ9nhKGLTMVhXncCBcIiIsjCOVLVg6mtbk/em0/IR22/73LQ6FXyPr+f0eC060xrdtoueF8k5bXa8DZjukxod33A8k6Tar376KgFidrte1jQSQQwIdodp6gNtFFpp7t6KrXnlXzUC7WA9LROj8SrN03kXV7E0Hd8+d83W6HO/OGzKxQlYscPpXCu3at0VI6GOOrDzrfG9DMzL3HKxYlhUs8ba0dxxSC5sGNJ7fZ/x+w8ZKE0aIo8yt9qfTCcHF07d3ck76jdTGGDjDXzf5EMfy/nrc1cT6Dq9idcWbCRaQWae+k5bOmZbMvmLyk2vt4NkHWtBJWD2D2fx/Lx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97EQIsBX2ywPhopjt/ixeEJVRHsWxgssSO3AStKwdes=;
 b=X6J/lLMufTI/OsV4vTABu9+7Koc1XHgskwoT57FYXXCevB+u02BhUFIlRwzQu5/GEcGGnOqtUzCku53olKQxA5ozPckAegy4WsQI57ydH0LUjvNUdbOC9vlgJmFPI+8zkdloAQLPBrQkdlofNZGHccabIABoHUoeJnPGuytSOZ7/z54wNc2OlxJWv2omEogov3ZqHR9BbWZaLtS/5EfyljS5qi91jpiHP12YGgKs/kRA9UaCe3cqQKeVxoV7rAoAK2lC0k0O+CxGHya0uT/+Yh7FhFPKNW3mZhYMdUBmpMLwofyAIRzwlZVBMDGeT5d5auzcRB9uhAWcDXgThehxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97EQIsBX2ywPhopjt/ixeEJVRHsWxgssSO3AStKwdes=;
 b=nnbpHnaotPwGAOv8kMvPWJRmxYyIzy1RUp2Io4Gns+o+eAEwItiEwXOeQwXQts9p0jwoySFBUIiNWZ5eGs0Re1Kewcsyaggj5aFNErU65rOUStDul+1ozqgPr7EjnBmTY3jVd8D5sCso13H6OSOAFQY4nJtAecKIRE4Mr52dcBs=
Received: from DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) by DBAPR02MB6182.eurprd02.prod.outlook.com
 (2603:10a6:10:18e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 14:19:35 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::60) by DUZPR01CA0060.outlook.office365.com
 (2603:10a6:10:469::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 14:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 14:19:35 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 6 Aug
 2025 16:19:32 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>,
	William Breathitt Gray <wbg@kernel.org>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] counter: ti-ecap-capture: Remove error print for
 devm_add_action_or_reset()
In-Reply-To: <e0670467-65cb-441b-b14d-9775609ced8b@ti.com> (Andrew Davis's
	message of "Tue, 5 Aug 2025 13:10:11 -0500")
References: <pndms8em7tf.a.out@axis.com>
	<e0670467-65cb-441b-b14d-9775609ced8b@ti.com>
User-Agent: a.out
Date: Wed, 6 Aug 2025 16:19:32 +0200
Message-ID: <pnd7bzgleh7.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|DBAPR02MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cdccf5-6746-46f7-72d6-08ddd4f4454c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHDAJpV6I1j/9XTP6aByIXws+3oXdU69VNTJOLjXawZJbfFxloIxCLEgJou0?=
 =?us-ascii?Q?haD436zStoTn8UNlK9lA9t8ObRMbmjo4wV+EDnLFGpdZ6KPa3l4HAKKW9lvM?=
 =?us-ascii?Q?P6rX9iAIuV2acUpzvkK7QuowDAjyw835BEXoeBmrShLcYIrwhAcw+krJCkKR?=
 =?us-ascii?Q?PUBlgoSaCdAD4UHGBwVfsKntDzSbvteuZX38tZOvHv0h6PCPeloav2jZmlqQ?=
 =?us-ascii?Q?XnbwzYW2VN2QREPWM/DClLFkUZNg7TB2a9gETr/Vxk9k4dp9oHQ8euOKxPRc?=
 =?us-ascii?Q?QoPn64u6x6QMvUcZsZAifIL2aLJDjBT1T0Fn74DpdrjNoylYBkxdQJJ6/zaU?=
 =?us-ascii?Q?rTrHy9gQUuLC6TwpoTTL4pjvxn5NeaAtDw10fLkHLpEH5a1q49d4QtHw3mwy?=
 =?us-ascii?Q?ukKMB988nMFhADbqI6vNAmtJ6qvn6sXAMTpXx4c8HfJI9sj157ErofCrqXYa?=
 =?us-ascii?Q?2nk22d7z4a9zcET75K3KvBUtAZPS3PTXSa1bUzfAykJXa0OStGprNv9fyQVQ?=
 =?us-ascii?Q?SQaxdCjgSB5cqfgxjxNogNPEViNBU+2X9tJMY4UBnWoLcXC5rl0bUtWckVu2?=
 =?us-ascii?Q?UOAKGKcbQQcpVcsVubem4HGMt5QxCx0xVR74Ujk9j71wW18d8CXNvNPsMAFo?=
 =?us-ascii?Q?ARsSisRQPlPp3pZbYmcgzic5mjjf8AvHK7pso9dgTBnT1hH3dLXieyJnIWiw?=
 =?us-ascii?Q?9EPMG5NzVx6KE5Zg74ImQGE7+7FilS8QatN54MSZtLCrTTPZcb8lZKaKRLzi?=
 =?us-ascii?Q?ii1DSYNg/pRCCDuw7Mr+7+Xm8Cy6EjedB1krd7TjPfrZ7IEOIJ0GBCn1TOl3?=
 =?us-ascii?Q?PHIGKMynQqDO/jfwmvCveX3nqEHURs4tENmCk7QRCvMRR43Tjs7a8C5/vhJg?=
 =?us-ascii?Q?yz7nDteH/Wq2terPV9iT2WCxPt1uF3Poaevz9G6tWNkex8SNAZVSWv8eHyP4?=
 =?us-ascii?Q?Y/grN3fwZyyfaCaTBpKk1ztvGfaZBABBQMrEZOOgtrg/LgVQEzgVOqHnCtM8?=
 =?us-ascii?Q?7jVXGVT7o+nqN/wGm8hqqkExax8gb35yiWAiFVNWImuJOxf65+GysOPGNduA?=
 =?us-ascii?Q?qmMRicdnWaj0DnTBv0iDkUSW8kejO8wxhBm5V1IL2Gn2GBPUC9WZswqoKZk7?=
 =?us-ascii?Q?3ZqawYrSufby923vq3/PzVQ1Io4yRVmulPkpVmKmceM6A+gz5hvvVm6aZvQt?=
 =?us-ascii?Q?JHwCz54CoSc6Ifv0REGlsYY+5KMVvMfqYWkmhdu3Xe8Lj+PAFJikTlcHwpIV?=
 =?us-ascii?Q?GHK+G91dphfgZoYmla+sj2744zdRNdZMiJuyvYRlhEKf0hzXQCdyUP9DWYYs?=
 =?us-ascii?Q?PEb8MJtwTNgzQNzqm5owimna96aF+RqIM+3eS81NOdoZzqr7NxW44Huk9/n1?=
 =?us-ascii?Q?8aJGo9HKc8ZJuVDE6+UtNcNi+WpiR0u6ChViFdqP+rYsvtdvzXVdGSBL78CR?=
 =?us-ascii?Q?28kIV2KmxxX11ugJ5UdRoUbltyaZ04T9tCLdxxfTRcxtuPUwMme79mA09xX8?=
 =?us-ascii?Q?dyz94SRzX1UiynFCb6raj1xJ8mg/G4tfo3CQuSKWW43wl7lITqK/R+x4Cg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:19:35.5686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cdccf5-6746-46f7-72d6-08ddd4f4454c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6182

On Tue, Aug 05, 2025 at 13:10 -0500 Andrew Davis <afd@ti.com> wrote:

> On 8/5/25 4:33 AM, Waqar Hameed wrote:
>> When `devm_add_action_or_reset()` fails, it is due to a failed memory
>> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
>> anything when error is `-ENOMEM`. Therefore, remove the useless call to
>> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
>> return the value instead.
>>
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>> Changes in v2:
>>
>> * Split the patch to one seperate patch for each sub-system.
>>
>> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
>>
>>   drivers/counter/ti-ecap-capture.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
>> index 3faaf7f60539..114f2d33f193 100644
>> --- a/drivers/counter/ti-ecap-capture.c
>> +++ b/drivers/counter/ti-ecap-capture.c
>> @@ -528,7 +528,7 @@ static int ecap_cnt_probe(struct platform_device *pdev)
>>       /* Register a cleanup callback to care for disabling PM */
>>       ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
>
> Now that we have devm_pm_runtime_enable(), you can just turn the pm_enable()
> call 3 lines above this into that, and not need this manual devm action at all.

That's true! However, `devm_pm_runtime_enable` also runs
`pm_runtime_dont_use_autosuspend()` on exit. I'm guessing we are fine
with that extra side-effect so I'll change to that instead.

>
>>       if (ret)
>> -             return dev_err_probe(dev, ret, "failed to add pm disable action\n");
>> +             return ret;
>>
>>       ret = devm_counter_add(dev, counter_dev);
>>       if (ret)
>>
>> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2

