Return-Path: <linux-iio+bounces-20155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F93EACB7EF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F3194118D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE52C324F;
	Mon,  2 Jun 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ggbHmS57"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0583221F10;
	Mon,  2 Jun 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877005; cv=fail; b=dbOnFOfchqI41ebO+AMU67mcoyEc0vY36k9nsXdmBuM5CiiZDwZ7deQMp6b8LcDjBK2SCSlLS5BBjSkMhbQBCSrXxzDB/q1aTI8yi2L2GHxfQJTUtSbpIKZfsxQqRu5io8Qc9M3q5BdtfYnL8nM3Z2PlVVAiGVpAJn+2Xv1A7Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877005; c=relaxed/simple;
	bh=lZaRJknGNWdDWZwVXVKCeWFq+a/pkXzqxomIx3jcziI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZaUra/8E51gxXKiHLqhX/JiDSLmaCT/ff7GsZBqhCy9Cu8J3SBH5zom38bdvJWtiKGPjZuECD2vtRR11Cu3nH4j37RR36YYKn1d2QBovM0FlPfUEnuuOxkgwuH73IzImlJTqSdJ57nlXgXSqF6pJ6yu4Dj8WHJxnQWB885F/nTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ggbHmS57; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyIKJFKsMrRioRzwCxOWChhkpW/hLgvQ24Jt6pw0AAb8lW6V7lnglXj2dd6nWY8gDRcEXmkiztma0i6rq+4ssgl22UG7GMLrde/H01q8Psp4iWD8MBXPnnSShzSpvBvdcNZV2tnMxBenpJv58ncbzoN/gJbJtKoy3MqCqhVi23gXXl8kMENLLOyahCd58GLKi04Rclw/3dXLpDlAPl0OlokOJAX49JmO7iIXrmGA8P4UQaJwNc+Aj1ETRx8xjbObMmLbzp8Dtv1tQ64ijLp6FgO7VSV8Q51hvHu8P/VbVTYZsLEDTDJzFueo5KmCITXGKlEvT2xrWRYsUdExJhwXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfogDyODVylQlblQY39+5DYWGF9yw+3yoqLSD9nbfFY=;
 b=Q89HS6+HCulIOzLnCPhc8NQ8+wkiZTSIznM2LpC0W8BvEKxFqq7kJxZSaVOOSYr0YLp8aYvp0WKtb0t9gEutcGKc9yyP/nxdqQ2Kq6mrSUZq2lejgOTIGMaO1U0vpuW3LZKTuSQybWIZeF1Vh5qzQ+IlqIuHgCJB7ZMzC8M+Lk9ydGkwU7MX41nVgAd0Amf7LgMEytuMIJe9J9SNREEXCjmECd3+ocEKDhup6B8VBgfwSMxgrOahxInufTjQBxt2YWBxzkZgjZVpX+ktetnhna73ErPqnZgR49FG4JvWDU5QxP0iMwzmq6a7zbrie94M7sDMzqEjl6gME1B2CAJnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfogDyODVylQlblQY39+5DYWGF9yw+3yoqLSD9nbfFY=;
 b=ggbHmS57ZP8DnT6sLa34fT11ChqYPx0GI+xDYaLXoVHvN5h/hXUznymU/vkoyexXmyviHqXiwzSC/i2Do5WzAu6csWSDq5gDfYPvAgeGr1fdHIfPzSBUGG3uapUTBTTzlv/0zk0f1PACGzAiAMFgnIOISdeTAzwghQzn1CbGtxE=
Received: from DUZPR01CA0250.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::6) by DBAPR02MB6407.eurprd02.prod.outlook.com
 (2603:10a6:10:191::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Mon, 2 Jun
 2025 15:10:00 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::e7) by DUZPR01CA0250.outlook.office365.com
 (2603:10a6:10:4b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 2 Jun 2025 15:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 15:10:00 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 2 Jun
 2025 17:10:00 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250531161029.4010a3d6@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 31 May 2025 16:10:29 +0100")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei> <pndldqwiihi.fsf@axis.com>
	<20250518183852.7e9afdac@jic23-huawei> <pndo6vnfrnp.fsf@axis.com>
	<20250525103019.3773be94@jic23-huawei> <pndecwa85z5.fsf@axis.com>
	<20250531161029.4010a3d6@jic23-huawei>
User-Agent: a.out
Date: Mon, 2 Jun 2025 17:09:59 +0200
Message-ID: <pndr0026uyg.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|DBAPR02MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fd4eab-a857-4b9b-a33d-08dda1e78b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+pI1GjxvN6pTwXGbCiH3WzQKmeWbAhOb0J+Mp0aJzmhtVVxSeoE/HQVqhyq?=
 =?us-ascii?Q?bt8qxnfvX1kS2+1uRr7pAhDczOtY4ElB1GJt25YZXOIMRHb0PSi2APVW5dZw?=
 =?us-ascii?Q?CKx0keep6Y5Y+VE80Q7XPg6dUWCpXxhmK/UllLsKHfo/98NgjJ0c1ATNkADo?=
 =?us-ascii?Q?h2B0zGNTGP+6ueroKrlpxqoSCp9WwX89RwDX8vSB0eqneW9tU87OoqUdh7uH?=
 =?us-ascii?Q?JjQTdBFxpuOrP4m098TDoYf9SN4p5Rzu7CCbVOi+UBL9w0tGTIWNO0BbXizq?=
 =?us-ascii?Q?c3qiEGVlyHyDUYzx5gC2MGL2SnQg/0s1HXpYnLVQiDesLSVbIocZMHGRX4mg?=
 =?us-ascii?Q?4z8yNaEZ5L/kGQzg6WNj8NkpMf99N5Czco/YgqsilqzHJBF1YMbP0asE+MjX?=
 =?us-ascii?Q?O5rStXqQPttFB6btvXGIzhmqGTjfKTx6kdkFp3Et5XCTtro8icFSOUyY9pv+?=
 =?us-ascii?Q?/rgnPQbtIhatbfuSmDTrAWQC5J2VGTVN+T7ezhGtm2GVFRZvXDXRJkd/KaMG?=
 =?us-ascii?Q?mWQfF282eVov+BDArEM4g9fsiO2FR5KX0WfM8NG0mlf7xz7/oSF7nOOa17VM?=
 =?us-ascii?Q?mzQsMdSR4m9HjkDocLhRYXIk3BDBqTvxtffHMh6HBIHaZlKIEhKaNAPQpFlP?=
 =?us-ascii?Q?2N71kudppNC+S8tGY8Gw4XABaPpK9zfaVgkzNtz7tsWgn/h1ngAQYHwD/Hg1?=
 =?us-ascii?Q?L6ikAcuv3+gq1SrXFhxVGEhSYqN9lA0rkiNgxK+mmzfXJ2Th6t31swLnugf5?=
 =?us-ascii?Q?od7TYkcr9dhEmeKjxb0/hlXcF2zLjx1MDkd3qilguI6YZZdPDBIM5bmVPYAO?=
 =?us-ascii?Q?8OifND8Jp0izPAa1dOl68xswuUlBoF3BS8V+3651X3vU74GrJtZO1XactwKG?=
 =?us-ascii?Q?nmLuOnOdm0hFBDJZF91LK2GjJuwqhrI4UJB70wDUNRjqXL+zS3xr5LJ8JpwH?=
 =?us-ascii?Q?Z3SebLtrEPNVfegdjiAFsesCunqVsKN6GwagedoXtewHkNOsNYx2fSTdGS5o?=
 =?us-ascii?Q?02GXWi8HkbL+5blY3ZT1mbnnGZNK2ZysBGp/uzxdkVKtfC8frOrXcqrnlCgH?=
 =?us-ascii?Q?VuCsq/PONdM/eWHSUYypnBH4B34FGgWKXhr/YVBtZulKtr0E8z8Ucv4sTmxR?=
 =?us-ascii?Q?e+WJP96va9MB2MLGmUD++J94OTRGb7vAzmSc7DzeBGgPFkJtfxv1L6fhMBOn?=
 =?us-ascii?Q?HNWdROHr2PxScDGdQSqJjPvOcjiu2HX2bI/kB9g9pi45SBLVfeV85O6IdOtX?=
 =?us-ascii?Q?AisgFHtulikw/lbtFOBSZZG3gCVkAdLsIOrSMEJgc/ujWLFITevKyfLsbaow?=
 =?us-ascii?Q?4jfc0MOqemnEzzy2LJ16SwetfuKSMcTM88P//hddJdtFHbGx1r0bQh+0fuBY?=
 =?us-ascii?Q?UlbReoj7dOHr7ORosnWrhrAH1xpPcS9xLjq+NCEgIDNeo7DMEmE8bgII1QlM?=
 =?us-ascii?Q?Acm2bz4Br4Hdw1/sN4Q+EztJ41JLUQo06xqHktWawsr4lBejLWma0nvzNpJC?=
 =?us-ascii?Q?+lzG7G8n8XDIvbN+XoeA8ZdF1V+yw3W+wqnD?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:10:00.6914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fd4eab-a857-4b9b-a33d-08dda1e78b8f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6407

On Sat, May 31, 2025 at 16:10 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

>> I think if you use it in multiple places, it should definitively be a
>> macro definition. I just sent some patches for those that only used it
>> once (I didn't include those with `KBUILD_MODNAME`. We can discuss if we
>> should also address those in that thread).
>
> I would disagree slightly.  If it is used in multiple places because there
> is some inherent reason they should have same string then I absolutely agree.
> If it's just because it's a convenient string that is used twice in places
> that could have had different string then not so much.

Absolutely! If two places can end up with different strings, then they
shouldn't share the same variable in the first place. I was not as clear
as you with my one-sentence :)

>> However, there are a bunch of drivers that _only_ use a macro definition
>> in `.name` and `indio_dev->name`, including this one. That _is_ more
>> than one place, so we should actually leave it? Or do you still think we
>> should have the same string literal in both places, as you originally
>> commented above?
>
> I'd prefer that for new code, but it is a less clear cut case than the ones
> you have tidied up, so not worth the churn of tidying up unless people
> are otherwise working on the relevant drivers.

Sure, let's use string literals in this driver then.

