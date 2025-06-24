Return-Path: <linux-iio+bounces-20947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91594AE6FBF
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 21:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51811885067
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB22E7F3C;
	Tue, 24 Jun 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ULMym2Xk"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7424DCFD;
	Tue, 24 Jun 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793729; cv=fail; b=nUzNQlje1k974r9VvLjYtHgLYdKpojpmW/owsUj9SSuTtfu+nG1/nGEY5RC6pZ5Hh1qTF/IdNv5pLtEQ0mDFV4DfP/YvllHzhh7eE4rlbDp4umro9a+EuS7eoA5GUrnlIrpmkpF9DIBIJgGrzdIVHCg1Rh9DQFGEh3ejMfQZ/ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793729; c=relaxed/simple;
	bh=HbyxgnWv0aLg7LYeucXSZ6k8BdsrzuvflumD5ceS3Dc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEaTlhwfIt1cJ4AA4q3tlhM5GNo+G/SoYmClwc3jcWkGj/FJnjBVwQwx+Scwxus8sDZkndtpGGpBuLt0GQCsQGXsvfaLMUb4VCaZDqhAM6isGfAIx0k3DcblKbpYfndyydC1FkoFXtJdIRYYMl8h+oz2LKzhFX6+Ik5Bwu/LhVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ULMym2Xk; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEgHgNMutgC1rOQmiv7NxPkg0Yt5kSLZMGeFzYMo9NOBgIXbK2plVxL+e3KB5vvUPfag87/gp5ZyH6h4qhdT9Q4qvj65/8fEf1Nx4JAUdlkADq+7FWLegQqBCchbYvLaJPzwr9gromK+PhC/2EMR8uN9QJqSocPcIxOsaiNo93wy2XrG12JIKRvc2HSksApxkVAaY3hJOLLG2A+1wRa17/rVFeawHZlfGVP6CwR0LKYe23hEDfz6rtxpE1M/4pizY/pxkWhXiOyOyLDstHUISwHpNlezGRx9hMM5Fkd2IkiFHiPOo43Q/z4UaxQpro5QCPWZXjAJbYWOYMDA5X77mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKT4FR1ualloZs4Fja4386WlvLnnj71MpvY1RwXs8ZY=;
 b=sbfXExMSqB7cXpxy7oTJDssTmUgbdzUphz/1Pr20Ga3VDnJ3W731/OHNPbuKzSPQ7tnwcAAKIoe3suatffDB+czCl8Z6NGpCYHeniE0kLcqnPBXCwq6W+PHAbUhHRvlMy3fgI+qjPQ2uUJZ32mUEGY67TX59D3/3hrTTWsRJUm9GSwQmCxnXDfnNSZjyTdaQyjUQ3THEaf4AIr0NYuDZfXZys85HCF/R88+TXfo++gpCYDCSCpmQmrKH94z0VEYbF3hFczMAgQyUOEIsCjzycx4uHJpbA7aixjytcDzYdwRWVxrqzU2RqH1IKB2ydxzOaD+v3SJBv3C3prDH9HKXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKT4FR1ualloZs4Fja4386WlvLnnj71MpvY1RwXs8ZY=;
 b=ULMym2XkoIE6RGpkrWsS0Z9Vq1iYEp9WY5TB8cVixDrkCa/+BG5y1Xr3pHoaz7fHDrQFnC09ltX7RDqtF7UO1bmyRzBAtTxZj4hsVI9uRNfw250csde3pi2wEpx/aGXMbfwXodvc1nbV8h/Njfwj0hToB3ScpWam5xFL+AFwtW0=
Received: from DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) by AS8PR02MB6504.eurprd02.prod.outlook.com
 (2603:10a6:20b:25e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 19:35:22 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::d1) by DUZPR01CA0010.outlook.office365.com
 (2603:10a6:10:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 19:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 19:35:22 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 24 Jun
 2025 21:35:20 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250622120756.3865fc4b@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 22 Jun 2025 12:07:56 +0100")
References: <cover.1749938844.git.waqar.hameed@axis.com>
	<5d12fcd6faae86f7280e753f887ea60513b22ea9.1749938844.git.waqar.hameed@axis.com>
	<20250622120756.3865fc4b@jic23-huawei>
User-Agent: a.out
Date: Tue, 24 Jun 2025 21:35:13 +0200
Message-ID: <pndtt45aq6m.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AS8PR02MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd9b84c-eb69-4234-6151-08ddb35642a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6+OYbem4SmAI/0R5+UYuun9KCm6y3diyencVAYZrYhZHFR//6KN0qWf+Ooq?=
 =?us-ascii?Q?BB7n11AzxQ6pB451a4WPgu/Y+0KVRatx755aFXKv1JNVHVqkHPQCKRLzCCAZ?=
 =?us-ascii?Q?uWVrfiuVnEolzWL0rgplUsUD+6rHHZSBzckHr6UCcJJ9F5Uwfnzz2ig2z23J?=
 =?us-ascii?Q?aLW9EI1+xYf6bfBgyOtqBIKYJWLx6NilNA3QDFZkvuIuxfu2zi5SXlF/WOjn?=
 =?us-ascii?Q?TmJJEIZC8Y6GtmNM/BVYzkbN8oZrbkDMFBz19RyC+9P/6YRG5EcbKKDO/3WP?=
 =?us-ascii?Q?THE5FekhcyMWwOm248FjEgGtaTV9thrrYtUHFpkv/SVHen5iy5Ga1t4qUgWc?=
 =?us-ascii?Q?eNIo4vQyayT7DiA3+MCy3ezNZeRG/G834aBCw7oVAfk5hqbgRTwe1DwjFfBu?=
 =?us-ascii?Q?D9Y8jmprwqUj0ftFlsMnR2E/4KFropTj5SqOs7DU3VbEuWNFLnwcxxVwaRAM?=
 =?us-ascii?Q?vT9pv8x5ZNSCfg8A2FMN36cJBsiVMQNrXfSIkn6QHKE/XXLfJGtujNYp7dos?=
 =?us-ascii?Q?AN+pDPNppT+1hybgNBr5vsUV3KpAGoKF9ZBchFXIjROWJKSlayPv5Hwd2dQx?=
 =?us-ascii?Q?PoR9ubMnYaZRRQ0kyhw7bAuwhS/ATLCFZPfJoQ0uhiaFN+FMKBNVc7SjzzWG?=
 =?us-ascii?Q?7/1228OtYVA8BzWgWBCwlkTGPLmILnrJ4v7KU7mMVmHKhPovU9B8Dn998uNz?=
 =?us-ascii?Q?mSIPrPDXQGjm3BxHjZW7Qz3oHuqKe3eQhccBNR0ixTMiORgaMweojEMy70Sx?=
 =?us-ascii?Q?juEywqpgMU+kKPbTBMYk5h5SioWpIN1DTW4dicpyKhobJLzhMtCV/Sl1RT8m?=
 =?us-ascii?Q?ro1JqzLfYSJyvbIaRRkhfLlXKf+n2kPtfZgzfWVNd8HBtH7YNdOp8Vvr0X+g?=
 =?us-ascii?Q?Vr3odgT21T1RqzlQEJWhTQMGCo3wdNkgVk9QIpWx32y38iuGMhydqS4RJjBi?=
 =?us-ascii?Q?E/6bHu2dCvnPbT8x8pFzTFjPItyx4DPebHqwNkyR+lBTKFtEUCRn2ANtsJ87?=
 =?us-ascii?Q?0XIfgu42CHaIuiSVYj3QufU/5MJfpvC3CpHlRZa92wmuF0UozEwIyvsRbt2m?=
 =?us-ascii?Q?BZcDmYOhVYFMs2NTt6sR5gj0psW5gkLizwsFeLG78uJNcytIpsvyKERCwf48?=
 =?us-ascii?Q?Fn2a6G7AvJLk8fbZq6J/fioAlVbItRXQrKAzkPJvbVCT0cc1G4V+GRqy+1H4?=
 =?us-ascii?Q?znmdEIyY4crtxt9w9IQ6Jw2nfwoxXizmJBZQXrSvQk/8C5KkCWAIVUgjD3+E?=
 =?us-ascii?Q?hj4prRqWg9yfa9X/wXRc7JFROUJkiiZgGimf+GpKWYAaJ6bwgnWN+Q159RUr?=
 =?us-ascii?Q?V0eCdzJn31C0OuSGWN9UQ5rA+kbHK26e9UCyUD+xARsGWeKoTqtzgMTthF2M?=
 =?us-ascii?Q?dnrqx5J+SXW9HcSy7rtMRoX2u9rnxoQuW5rf9QpeiJ78q1eyBb5f86JUe0ta?=
 =?us-ascii?Q?gmrA1odWL7t2ra6aj1s2uiqHlxS/rhGoI/HnzPjHIdeRn+trBN9wffdfcM7P?=
 =?us-ascii?Q?yt4Dz8RtmlIDXkalusdyRkjlnYFdZ2eHrBef?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 19:35:22.2642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd9b84c-eb69-4234-6151-08ddb35642a5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6504

On Sun, Jun 22, 2025 at 12:07 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 15 Jun 2025 00:14:05 +0200
> Waqar Hameed <waqar.hameed@axis.com> wrote:

[...]

>> +static irqreturn_t d3323aa_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct iio_dev *indio_dev = dev_id;
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	enum iio_event_direction dir;
>> +	int val;
>> +
>> +	val = gpiod_get_value(data->gpiod_clkin_detectout);
>> +	if (val < 0) {
>> +		dev_err_ratelimited(data->dev,
>> +				    "Could not read from GPIO vout-clk (%d)\n",
>> +				    val);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (!data->detecting) {
>> +		/* Reset interrupt counting falling edges. */
>> +		if (!val && atomic_inc_return(&data->irq_reset_count) ==
>> +				    D3323AA_IRQ_RESET_COUNT)
> Odd line break
> 		if (!val &&
> 		    atomic_inc_return(&data->irq_reset_count) == D3323AA_IRQ_RESET_COUNT)
>
> Is a bit better though rather long line.  I'm not completely clear on why it needs
> to be an atomic counter though as the comment in reset() to to imply this
> can't race with the zeroing and no one else touches it.

Hm, now when we have unified the IRQ handlers, there is actually no need
for it to be atomic anymore. Since it is now "guarded" with an
if-statement on `data->detecting` and can't race. Good catch! Let's
convert `irq_reset_count` to an `u8`. This will also fix the formatting
when removing `atomic_inc_return()`.

>> +static int d3323aa_reset(struct iio_dev *indio_dev)
>> +{
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	long time;
>> +	int ret;
>> +
>> +	if (regulator_is_enabled(data->regulator_vdd)) {
>
> Add a comment to say this check is only for the use in probe() where
> the power may not be on yet.  In other paths I think it will always
> be on.

Yeah, that might not be immediately obvious. Will add one.

>> +		ret = regulator_disable(data->regulator_vdd);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/*
>> +	 * Datasheet says VDD needs to be low at least for 30 ms. Let's add a
>> +	 * couple more to allow VDD to completely discharge as well.
>> +	 */
>> +	msleep(30 + 5);
>
> Use fsleep here as well with the parameter value in usecs.  It will use msleep
> under the hood but we don't need to enforce that in the driver.  On some particular
> platform some other sleep call may be more suited.

I agree, that's a better approach. 

>> +
>> +	/*
>> +	 * After setting VDD to high, the device signals with
>
> This is a little odd.  vdd, as the regulator is currently low as you powered it down.
> This is referring I think to what happens later.  Edit the comment to make that
> clearer.  Someting like * When VDD is later enabled...

I can see how one can get a little confused by that. I'll rephrase it!

>> +static int d3323aa_setup(struct iio_dev *indio_dev, size_t lp_filter_freq_idx,
>> +			 size_t filter_gain_idx, u8 detect_thresh)
>> +{
>> +	DECLARE_BITMAP(write_regbitmap, D3323AA_REG_NR_BITS);
>> +	DECLARE_BITMAP(read_regbitmap, D3323AA_REG_NR_BITS);
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	unsigned long start_time;
>> +	int ret;
>> +
>> +	ret = d3323aa_reset(indio_dev);
>> +	if (ret) {
>> +		if (ret != -ERESTARTSYS)
>> +			dev_err(data->dev, "Could not reset device (%d)\n",
>> +				ret);
>> +
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Datasheet says to wait 10 us before setting the configuration.
>> +	 * Moreover, the total configuration should be done within
>> +	 * D3323AA_CONFIG_TIMEOUT ms. Clock it.
>> +	 */
>> +	usleep_range(10, 20);
>
> fsleep() preferred as that generalizes the tolerances fed to usleep_range()
> so we don't have to think if they are appropriate in each call.

As above, I agree.

>> +static int d3323aa_set_lp_filter_freq(struct iio_dev *indio_dev, const int val,
>> +				      int val2)
>> +{
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	size_t idx;
>> +
>> +	/* Truncate fractional part to one digit. */
>> +	val2 /= 100000;
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_freq); ++idx) {
>> +		int integer = d3323aa_lp_filter_freq[idx][0] /
>> +			      d3323aa_lp_filter_freq[idx][1];
>> +		int fract = d3323aa_lp_filter_freq[idx][0] %
>> +			    d3323aa_lp_filter_freq[idx][1];
>> +
>> +		if (val == integer && val2 == fract)
>> +			break;
>> +	}
>> +
>> +	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
>> +		return -ERANGE;
>
> It's a patch not a range check, so -EINVAL may make more sense as
> a return value.

Hm, `ERANGE`s message does say "*Numerical result* out of range...",
which I can see is not really applicable here (strictly speaking, we are
really not "calculating" anything...). However, isn't `EDOM` actually
the better alternative here? Consider the following

  echo a > in_proximity_hardwaregain
  sh: write error: Invalid argument

  echo 1234 > in_proximity_hardwaregain
  sh: write error: Numerical argument out of domain

>> +static void d3323aa_disable_regulator(void *indata)
>> +{
>> +	struct d3323aa_data *data = indata;
>> +	int ret;
>> +
>> +	if (!regulator_is_enabled(data->regulator_vdd))
>> +		return;
>> +
>
> This is unusual and I think an artefact of where you are registering
> the devm callback and the use of reset later.  Needs a comments
> at the very least to explain why the check is needed.

Correct! I'll add a comment clarifying this.

>
>> +	ret = regulator_disable(data->regulator_vdd);
>> +	if (ret)
>> +		dev_err(data->dev, "Could not disable regulator (%d)\n", ret);
>> +}
>> +
>> +static int d3323aa_probe(struct platform_device *pdev)
>> +{
>> +	struct d3323aa_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>
> Given there is a lot of use of either pdev->dev or data->dev which is
> the same thing, I'd suggest a local declaration at the top and use that
> throughout.
>
> 	struct device *dev = &pdev->dev;

Alright, we can do that.

>> +				     "Could not allocate iio device\n");
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->dev = &pdev->dev;
>> +
>> +	init_completion(&data->reset_completion);
>> +
>> +	ret = devm_mutex_init(data->dev, &data->statevar_lock);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Could not initialize mutex\n");
>> +
>> +	data->regulator_vdd = devm_regulator_get_exclusive(data->dev, "vdd");
>> +	if (IS_ERR(data->regulator_vdd))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->regulator_vdd),
>> +				     "Could not get regulator\n");
>> +
>> +	ret = devm_add_action_or_reset(data->dev, d3323aa_disable_regulator,
>
> This is in a slightly odd place as you haven't turned it on yet. 
> At very least add a comment. 

Will do!

>> +				       data);
>> +	if (ret)
>> +		return dev_err_probe(
>> +			data->dev, ret,
>> +			"Could not add disable regulator action\n");
> Odd formatting.
>
> 		return dev_err_probe(dev, ret,
> 				     "Could not add disable regulator action\n");
>
> It's fine to go a little over 80 chars if it helps readability and here I think
> it does. However it is vanishingly unlikely this would fail (as it basically means
> memory allocation is failing in which case not much is going to work) so
> common practice is not to bother with prints for failed devm_add_action_or_reset().
> Those prints do make sense for devm calls that are doing something more complex
> though so keep the rest.
>
> 	if (ret)
> 		return ret;
>
> is fine here.

`clang-format` trying its best here. Let's just remove the print then.

There are a bunch drivers in iio that are printing in this
devm_add_action_or_reset()-error-path (though it looks like the majority
are not doing that). Probably not really worth changing those; in case
someone would really "miss" the (very unlikely) prints.

