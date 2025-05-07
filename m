Return-Path: <linux-iio+bounces-19225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7C1AAD7E2
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F039A3BDC04
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE7214A7F;
	Wed,  7 May 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="N7WjbRQV"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F855215068;
	Wed,  7 May 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602530; cv=fail; b=bYHhyH6kd/DsZZeA9+U5R47Mwi9d0RCQDjsJsdHzcdwnm4s6TFJidLSmRRYpmCVkOwWb7GYeHO8bkgJQWch5eoN7w03uHUyXRWZKvHGBBd9Y0KsNaQrOY0LOfMGghLRuSXERo1DPXW+YUdiArZ4CXven0ym5HUtn+b19oXq67E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602530; c=relaxed/simple;
	bh=BFYYGeixh6bs+vpXsxjFirfmzS9eupgLkX2yV8F59PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CggkUa8FzL6pTR5sh1R0iaTpasbEbpCSDWLYDQpRIWutgtoXahJgYLM0vW1235k6rnAo4oBsS8ECFsae+pGF6pU6sVDR73GgTi2SC2OE8HByMM6GUcEPpxekMPTHVUOTS6znznyUhT7t3O5mZlPSxWA5QbNFIAyD+xTdwvAPWRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=N7WjbRQV; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzCCfHpQF4JwY3+R06Kwe+dAdx18QnfKYsT15JBUvImYKdMZnh5UUkpz5I6xuRjXKs30OhSMt873wB+RlXe1m95+zfxI8oL28IHQCgJxHPxYwfM+YXyaeTuDfRQE9VbNS0KPs2LqHHAkHn+MtEGWT5OHfUZveENgTT5QrgDVOvWpjdRAZKLw5sQkGh0890HGw4ld8ZBfCbrz9nX2f9JADnvAiY0NlNNzRP1hxy6JU5huGpopCNS2iQ5uoINNqHFqFGa/q6PChYWdZEyXStsHAA9ORtURAkImIrSO9RMqSxVepm8wIb4TsQjfZruOs75114k3MBh8D9mbNnjtKo8s/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ln9jnelzDLclIELAH2wiCq17cPIRIM+6rHTzhhPvAM=;
 b=ewD8rdbSo27mCcZT09mbzE77QSy2iLdCKcEZER5NcwOnFcALnFacVr2uhuFXS4AEBSNbVdV2WOc+3Jcbb4RA3U3T29iz/d56rMvi+Yd5X6gc+GvEFjASj1cpn1yiR7ilgymkw0CP1OEBbJxnNqzRBDqp1kn4RDQsLvoZP4LX3CmjfGOL5C+ZIYKODhynphxwNUJ8LDZPvgVCpF2IRlP+xjJaYT66jHs9ncCLTGpx3ZvDdeJ6p41oX+Ph9ZQw8AQS/dFeDAlaMt/kwmRwbY60u7dZ9MHPkqz7koni+1BcveyemU65REU+4h77XIDxhec2OvhJ+eI8u66uYn9WX0Dzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ln9jnelzDLclIELAH2wiCq17cPIRIM+6rHTzhhPvAM=;
 b=N7WjbRQVxYBvl5xxk1zDhUevz8y43lPPdGx5GMpx+lxMUC6Oa5n4MFwXI8rgO0tTdDSxKScwo/BdPZknWL+jeQHgoSx5iRVd49Io87TxFK3Rr8jV2g/CNnU/XF0Fe589HPkAyIzeoLKgGRTW1dxGs/69Wtd1qp/9h8TOjDi5cAHf//pFDcjYTNt68G4vvHPiR9m+OmbZ3wV4KNKI2RJ57Jz9ar0bQL77AFKBFaf7KKuGCj0t7uzKQBxMDf1w1goPJPY0bABWDRPnNmznjvAgJQqaiLdyNhXVx6+Tku4EiigrPDy4Z5PRyhGP1jB/3ae2x9Uizcr8AN+LVpiKlNon/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB6PR03MB3062.eurprd03.prod.outlook.com (2603:10a6:6:36::19) by
 AS8PR03MB7986.eurprd03.prod.outlook.com (2603:10a6:20b:429::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Wed, 7 May 2025 07:22:06 +0000
Received: from DB6PR03MB3062.eurprd03.prod.outlook.com
 ([fe80::b201:e423:f29:53b]) by DB6PR03MB3062.eurprd03.prod.outlook.com
 ([fe80::b201:e423:f29:53b%4]) with mapi id 15.20.8678.033; Wed, 7 May 2025
 07:22:06 +0000
Date: Wed, 7 May 2025 09:21:56 +0200
From: Markus Burri <markus.burri@mt.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: Re: EXTERNAL - [PATCH v3] iio: backend: fix out-of-bound write
Message-ID: <aBsKFNiNA-BHP5b2@Debian-VM-Markus.debian>
References: <20250505203830.5117-1-markus.burri@mt.com>
 <aa7f18ce-9330-4a30-93e5-85489f507a42@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7f18ce-9330-4a30-93e5-85489f507a42@baylibre.com>
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To DB6PR03MB3062.eurprd03.prod.outlook.com
 (2603:10a6:6:36::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR03MB3062:EE_|AS8PR03MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dcd82a-ca37-4eeb-1b26-08dd8d37decb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KCTWfCY6SDV8L2n3eQHE2flA/0nKAiHCswN1llZL1UOLxPNMknIioQY6N3X?=
 =?us-ascii?Q?e6tfzMgVS46JcnmnfYwuv1TloGdT9NlDds2JGwA3SH9fnKxUMn1nnt0m6LVl?=
 =?us-ascii?Q?sHNpTpBJjU9+fpHfVHj1PCl3GDo2Xypl1LTstK9u7QLIW9q8w+nEv9fuRmGK?=
 =?us-ascii?Q?Zhd3XfSeR0TBvm+TYVSEwoXfrE/qP/wsYE98jLfWUFC50oFvRUH6BvY1zQG1?=
 =?us-ascii?Q?kvHtgCT2zsfrEnVmUSrI83WJoXFeKXIWPdLhiZnWU2ksViXKv6vQxS/AiVIJ?=
 =?us-ascii?Q?xTxDUI3PegMTY2P1gwqFCzIV8QMpkI+tkHoTTbZn6TGse8tsmzpCGu9qphtC?=
 =?us-ascii?Q?RDhbasuoPqpi3k5Cz5cGVyRomXghpUNeAEzv7zGcCY4Vk6Jpvprni6wDflhX?=
 =?us-ascii?Q?M0UGET7f1c+QVy+LMSj+y77H3jEaoRS5WWb9zVXqMct1ffRGQpepH8wfz/oV?=
 =?us-ascii?Q?2UJGz996Zv5Sm6wZkStvVVr4aJgbVZWpiW54/mo2f8crw2QENHGBauz2VUQU?=
 =?us-ascii?Q?6YUmZ5DBJ75FvOXsLv7RqJpxsrOX58963SmmCtbSfxUalZKaiXF2XZbrigBr?=
 =?us-ascii?Q?BWh3Q7U38acUm7X0HjSg08Ig2qzV/bu6+AGSXwxk5TsmlRktzlOEKa4OuSYb?=
 =?us-ascii?Q?MQF3Dvu3h9W2bnhdiyIdCtRfwLmCgFfVkI+7OUwFzeI2D9gLP2HkR4g0Vipb?=
 =?us-ascii?Q?YeYtWcmofvBy9ePqZJLhSAbgJab022Ip5E7ccNlIyrX+GcceTE7w9LnQHAZb?=
 =?us-ascii?Q?2MFEz8FBVs0tBAPobTbjxto4F4RZ2E7NFoEafB0uWoHEBKv+BS7QbVn3FYX+?=
 =?us-ascii?Q?L+2yI6c5Rb7QFkhfLx/Olh56yOE/NRLR5BzBSxgVYGe4+AEHGNmpt3GG9rwO?=
 =?us-ascii?Q?yDLqPZfUINiMITuGJHR+CRpa/EzIDYVUzLi1nIqptLqBj0SJcQ8fb2a0mEef?=
 =?us-ascii?Q?uqMhl2XMBmXdAP0jEuy2lKSsN52R0CkKiJ8EA+RDPzHjPeDxqm5HmvQ7Zku6?=
 =?us-ascii?Q?YBwgkPNBUAfJTYb8ITA5hJ2bcRHGKmFJqs1W0JABKB2T7rWWpN0Su8Yf396d?=
 =?us-ascii?Q?yAU/BgOJmqzWB9Zkhf7/CwLMYzxiBgrrwg9yxEJU+abYocczNVUxzd7r2FI9?=
 =?us-ascii?Q?FDtqbF63iN3iukeZID+yKkRVoCi3wzOkXXcrT/4SzkIgV4ABY2gnYHyPZDC1?=
 =?us-ascii?Q?D229cHGcBbVkmf7jVHMe1aTg8ys2nOXXpW8jN37zeoNUukcPavcM+mJETnrz?=
 =?us-ascii?Q?4pNotWBsvkvb2UDpiwMsaPn749To0WJ5hB/KA8Plh4gy1aEMHIfKxQvkCxC9?=
 =?us-ascii?Q?v3VoEcJxqGG8B2DYVTPkuzTLV9NUfgY5UczFEyc+PXmSbbiicrWLy46UCOZm?=
 =?us-ascii?Q?fX6tFAFZKosVoX/vWRIL9Rv1kibhZxt55FdXg5V3luhHW59M7Twvmcng3q6C?=
 =?us-ascii?Q?Re0hINm7JiShXrvpvXsuefr5bDLryS7DX7Pe6dnM6zFPzI+t40tYSY6dUq6B?=
 =?us-ascii?Q?byyxkJ/mZ95Frlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3062.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZKIMS9eiR8ROQR3vXsDjxAsx404EeEosNp7Mzxm9ea5Itf6TzFH4wVSnD2e?=
 =?us-ascii?Q?cwbHQscGtOcR85w+HRTjf2tNyDIlV0cReT94T4rG3UM21XasagiIR/v/sVbw?=
 =?us-ascii?Q?+A6bTCM69xxVfBIWu2BFYpAcfeZBfVfteQYKKD2BMOWPpYRcxa6JnQ9n4VS2?=
 =?us-ascii?Q?RecdLx1ZzdZV1ElxZFY/DR2TaSJhVh7wFq3cXT/KIYGMO8hb9DVKUvVZXfkQ?=
 =?us-ascii?Q?8qVvpB6id84Zb+/lCqSeAxZOE3S8IawjqbWwyz4XTMbt4fGng40D91cHUoAH?=
 =?us-ascii?Q?6Xvi6lBQRf+kRK4OaP80LutRso+7lXxMfyHLRw8axaVvJe37wEMud+86a5cb?=
 =?us-ascii?Q?8O+QL1iagBQtrukVuqX+MGNEEsU3mkSEY8Wqr5P6lsgmrGQ9jE+kl/q3QLVP?=
 =?us-ascii?Q?momtYVVjHPafoj9uhldXcv+lTx1G5n32rttQKlBm7cdLWX2ZRGJQSjE8Zno7?=
 =?us-ascii?Q?OHHZY0HeO1fKuuLSFzYAKCBWvPSHPPT/ueIqRW86V1kH6P9nudocgbfblsOu?=
 =?us-ascii?Q?tHg0iszhW0sXNOwN43B/2rpgQBXGNQVQd0zsW0HU5fGR3WYvAM1qAB7EIOEk?=
 =?us-ascii?Q?j9EpvEDKy6FW8eWDcKLl0w8eQbR5HTWqHPNU7j6sNyeYiFYQvcE+XAt9bfLe?=
 =?us-ascii?Q?5DYHpCu56N8iOwUfqzSQf/igNWryTa3NvV9IbCWEJy43R/OwrnBiy2xoEBIi?=
 =?us-ascii?Q?JgVrPLEwuV85pmwuovVaZXgvIVRNv0JK/C3zv3/vedFmVD9dcS0GwSx71AP9?=
 =?us-ascii?Q?GGVjBv6tFQDDk1Bomq0tqpKAtV0rveGZVC0gMs57JYVyGGFn9ULau7OgnqDh?=
 =?us-ascii?Q?RT+HvrIY4D3f6mAxTx+KPk8AcMx+pXsDvC7Er+gi9jwluTELNZ2RiXoWv7PP?=
 =?us-ascii?Q?O3LmuMEDxDlRp6alssXjKEey7efLmBHYuNi30rZhN3IoKApqiKYUuIFgEfZF?=
 =?us-ascii?Q?pmNtreo5FydmksnL5YOH6ndrQ94RPcdXlIujeROf9b7iHxhLnQYqxf5gs7o8?=
 =?us-ascii?Q?VEF+loNASev7oYuqV3IC2ETLVH0MC0+7k8IGlUqQ8+iVp+KwXuSdNo6XwreC?=
 =?us-ascii?Q?GuZ9OHI8MCRahNfwLpVTlbxRPUgWr+8cPP8IGwsJQ0MipIHVEtWDG9BjvSVf?=
 =?us-ascii?Q?SQdWzW0Hnp49XrLaCR/bgdwyglkuZAaeQwqcQtBSLHunBXl4DVb2ObJzapjD?=
 =?us-ascii?Q?VyrfdWrIeQj0OI006Nr+bHslY7MEuRCbQ8z9TjTervHDbb30sNiExvgnuT3N?=
 =?us-ascii?Q?HlPSj23d7AnHe19Hpd8E6VGEGaOvFCFjHHUZGVAgHYKe+q6QslzjP4h6pDpI?=
 =?us-ascii?Q?YU0+rLmC12Lojsx7Bocl3ZlUigccyoyJRE5DqEslrdE34FhHVbvJgvb38Lnd?=
 =?us-ascii?Q?JIZijdC7knVJy4sowVSufevqFX3/hXCDKEC79wH9BLcf2oOE3hQTNjpqRoxk?=
 =?us-ascii?Q?qh5opvYW97jz0BFUtAooqi567sZi4rdQ1A9L+19df6Yzr0sn/1LO9jlDoCpd?=
 =?us-ascii?Q?4MZmbqyLhR2Q5jeXkv6HrLW6U/UWOOOuJccsl1ZureKRgX9hhP6opbB3GH8j?=
 =?us-ascii?Q?TNUVK8okIek0y8TFs1v19ShmQV7G1B3Y56Y3Ul1c?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dcd82a-ca37-4eeb-1b26-08dd8d37decb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3062.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:22:05.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOLJsqhuTmdjhtxjzkmTWUMt0ArU5wQeEvWWxMNZAEVjU4YQeRCO5GwrjIl3TOacZ16s48SgfditjPx7Fx+gCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7986

On Tue, May 06, 2025 at 12:00:19PM -0500, David Lechner wrote:
> On 5/5/25 3:38 PM, Markus Burri wrote:
> > The buffer is set to 80 character. If a caller write more characters,
> > count is truncated to the max available space in "simple_write_to_buffer".
> > But afterwards a string terminator is written to the buffer at offset count
> > without boundary check. The zero termination is written OUT-OF-BOUND.
> > 
> > Add a check that the given buffer is smaller then the buffer to prevent.
> > 
> > Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
> > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > ---
> >  drivers/iio/industrialio-backend.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> > index a43c8d1bb3d0..4a364e038449 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
> >  	ssize_t rc;
> >  	int ret;
> >  
> > +	if (count >= sizeof(buf) - 1)
> 
> Isn't it OK if count == sizeof(buf) - 1? In other words, should be:
> 
> 	if (count >= sizeof(buf))
>
This was my original patch and I think it is OK.
In a situation we have 79 characters and the last one ('\n'), the '\n' will be
replaces by a '\0', therefore it is OK.
Since the given text should anyway be < buffer size and it is a little more
correct to have the -1, I would keep it.

> > +		return -ENOSPC;
> > +
> >  	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	buf[count] = '\0';
> > +	buf[rc] = '\0';
> >  
> >  	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> >  
> > 
> > base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
> 
> It looks like we have the same or similar bugs in:
> 
> drivers/accel/ivpu/ivpu_debugfs.c
> drivers/gpio/gpio-virtuser.c
> drivers/iio/industrialio-core.c
> drivers/iio/dac/ad3552r-hs.c
> 
> Do you plan to fix these as well? 
True there are some more. I will check them later.


