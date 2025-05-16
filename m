Return-Path: <linux-iio+bounces-19604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64563ABA1C3
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FDB3A58EB
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852CC1FF5EC;
	Fri, 16 May 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Jtof+knb"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3BA31;
	Fri, 16 May 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415775; cv=fail; b=fwRriHlWJYmphzHAy810v9bT8clIT47fzC8y9hcnCxGdd0AdJknSK5ibg+sEDMXvyRfY79qhpxJa0cfB937BR9mpNh24zNAzvJ+lujydsT62uUBKSvO79m5lu+uOAh/EHuLUjaniCMEezNicYcLRWwkgHBIedd+J2QDqkPFojsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415775; c=relaxed/simple;
	bh=3vu1h8SB2ebEMc9ILGGu6/nhZSwc5I2YTu4VegdeTRM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rjvgiKdNg1AHupRJDKDvUqEo4dv1nNmiTUAgJJKGRYXxGKRozCLGnbMiI+I+nENc47JdaHVm7YPdNH5O85KwvHJBYUmEJTxljBV3pK9gBxkXbnv/PO4bngdi4W7LO07s5cZXkh7ks/cOEK9vorFjRIod0Kq4QpRsW85NL98ua3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Jtof+knb; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU4Ft/NNGeNul0sS9pUw/eiC8x6ZGoJ60qvV6AyPO7J+ZrXnyzM5M7DLIlyIS6nCCWsE2oTJ+CS9KVVGihgPlDnIW7bcCGpc2xNTGHUaNg4oGn2lnt/pcdU7FJqpp8/c4VhdOETUI4PH97mF6LhjuCcdwllUDJKsTIGGItNwxKA1pEu+1kPW7eEKYGso9EAP3bzkAawilqjjUBclbKD6Si5d0cme1rGt5KQl3NIxm7o/SLy4nImKdIOmh3fqfipXMEGF2PInXhCE5DY6n5hXN0EU4Qlo2OTqu3tkSy6cDyVxW+iR2duGLnre5QfEN7xtEprutjAhXsPxv0x7G9wu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKQxeYasH38zYQEqmIEvoksJoOlE1E27qSpUjdaYVOo=;
 b=Bpg0yPPV/EetvpD9u/Hdeei/mmioKjaxjr6SoWDuwCwaPJ6YSOUWi0bJ0GABbs7wUD4jgnTxK/Gkl3vGndt80bEEwFBFGbqK6k9Mq2ENwDjQfzTU4q5f5IJzOxHxZJ5uSkzWCM0gPd7Ej6YVu64+rKsA0Qw6WGJdMoIqEEIAYfuZlUvZMV+1bg62A15Ck3hOsiFN7EOgt8QT+KT92Lt41lXX8co7iRoRT2uz7HQoLj7qILkfXZbtdneS9AuI7Fv3/52w02rfkjoLb3Ir0KDKNdeoembxR+rWCiyXB2DCJxyRIo+jmGqRQcDJ5A0wG7hp7paic4BiZrADPlETnvY9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKQxeYasH38zYQEqmIEvoksJoOlE1E27qSpUjdaYVOo=;
 b=Jtof+knb7hp1/2Uk1y4Di92Ex2+QRgMBPrncX1g8Q7SM5GKZDgH9W9cPNSfETrk6QuEIioAPtbzFkp7thrukUYmstCSd74zOhIAYkevYuxP2qcTLTovtDzO6pH1kemPkSA085CIHv8d0rgZH4P6OXnG8Pea3UIJE+KsMtHuaOPU=
Received: from DB8P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::39)
 by DB3PR0202MB9302.eurprd02.prod.outlook.com (2603:10a6:10:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 16 May
 2025 17:16:09 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::d1) by DB8P191CA0029.outlook.office365.com
 (2603:10a6:10:130::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Fri,
 16 May 2025 17:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:16:07 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 16 May
 2025 19:16:05 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: <jic23@kernel.org>, <kernel@axis.com>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <a0677c8f-08f6-4b0d-8393-8086972475f2@wanadoo.fr> (Christophe
	JAILLET's message of "Sun, 11 May 2025 09:57:22 +0200")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<a0677c8f-08f6-4b0d-8393-8086972475f2@wanadoo.fr>
User-Agent: a.out
Date: Fri, 16 May 2025 19:16:04 +0200
Message-ID: <pndplg8iii3.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|DB3PR0202MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6e0e2c-3bc7-40a9-d905-08dd949d5894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QjfyNP00hyarpEOKr7qMOnZ+edDM9WKaSfjlTUibm5cMDZm3IbdH0Yxrr8UT?=
 =?us-ascii?Q?ooVC77CMVOEG9DCWSJINAVrWBP6H/HVSutnBhDPRYHY/i+olrUYQo9jGmZbB?=
 =?us-ascii?Q?HLsBkR8cN4VLuVjoHKbkWpUuICDy+CNYQUjPKN+jLjfCfifrFDdGUlK+UNH5?=
 =?us-ascii?Q?nAJGrtk457xJL/lc+XDyN/YFKLDunOhBznGSHgx9ULEyenuABFu9N8pxopvO?=
 =?us-ascii?Q?Hbo1MfWSFjTsjFso/7WQ0Db09aUA/+dJk7WYSkzsg4zRH/LjRuk3sSW/yk5T?=
 =?us-ascii?Q?j9Qqxkl/jcDBhlzguR6GXwcNzRCbfnIpe0opzgbLyEdrLCZ0iLmW8eXIjsgN?=
 =?us-ascii?Q?wnLi8uYsdMlRorgzxIIuNKxQgec+Qut1eBeY1zlyp3tCH7U8R4ncNTA0z2em?=
 =?us-ascii?Q?QODYnocmABRqVPtUKLOZQJ7s8ej8fOlOxQVtetg46T17+u8N+ceh6rpL5Vz5?=
 =?us-ascii?Q?YF4c1arioe0Nxzer3CptGJMtqDZQtD5tAXsK9/p6NGx88Hdb47mrQ41rXOY4?=
 =?us-ascii?Q?3E9RYw4/3EBgU8IUHQhdRQCL3IOI/bA+2Wmyq8YsQLjssuiulXb5D4mYlVLy?=
 =?us-ascii?Q?RPeLDS2MgGocjhPmowdKa+5R6qQohrtx06OG9kavGXYswnClZrNyxTH5zPv5?=
 =?us-ascii?Q?5ILSeATULvZlZog9PTTZ7Ovt8xTNg7qGcAvcDDBd+sGtyXxJAM2XOdampckK?=
 =?us-ascii?Q?Ddk1g9LXA1LQQtBf4GG9onMF5Fq/9kPNl0ZswjG8TYYKhrcH8bD1r6ZyZ710?=
 =?us-ascii?Q?URtQ87ySy77RC7yQECMQEZMRSsxB8LHEpGyv7fBXpfm8rPYdqRnvK1bPLyXo?=
 =?us-ascii?Q?Pd6gVZ2sKuqjapACzipBPGN/zQzyMQSo6eEq6UbffAfrqQcdAAjVVBfypa6C?=
 =?us-ascii?Q?reaUUrQ+iO9w4QFDAmy0q4b2x1L/g16m/jIx23+MEDo6in8sDAuwicVKae/0?=
 =?us-ascii?Q?pEfN4nRjydSxTH7zTcRL6UROYPDzJDAFriX6OInPyjC4A9Q9PHHXm3APRQff?=
 =?us-ascii?Q?I2FLTH3hD6k03qnDmmmbLqEdW49G0tddyaAHZxBDc3owKvmD5SHMjXNYaQEb?=
 =?us-ascii?Q?x9rJq+e+m7ZUIRqqWgxU8PkroGc4ZCNhoGG1g5CCTvGUk+Mpi2Ti47z5E1f9?=
 =?us-ascii?Q?Ij+/b9Wgt7CJ/Y0FNwlsJ05yjTKYVyvXCVMc4HBU4owBTaHQl82QkxlFETMz?=
 =?us-ascii?Q?rToGEsx7pCd16UiXo0qtVInn13rm+A9SW22qFXacRWXPJD9Q4POgUkfty4nX?=
 =?us-ascii?Q?vQ183PhOaqZIHk4Zgk8M4sYV+Z3TMC1kK0NH6vZapNAxAO5T/KpCu9EyGMX9?=
 =?us-ascii?Q?KhIl5VmQg9uGTyxvC4XWd6IJ27KQ6T11x7MIeg0MpyiceWuvQiOxY6oV2Lux?=
 =?us-ascii?Q?gZGhexoU/iZRlF1ObZpeZySUy7o4xVJPija4BnqdMkym86/a9EUJc3qBjOPL?=
 =?us-ascii?Q?JhNfVzpQrhXP411iQmJFMUJq7sDAibcO8Jb3IVcWgeAcbEj0vO7uUdy+Smda?=
 =?us-ascii?Q?RKwI89zfGpzgjBP25fkShCV1MJKU67/vXPK9?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:16:07.2889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6e0e2c-3bc7-40a9-d905-08dd949d5894
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9302

On Sun, May 11, 2025 at 09:57 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

[...]

> Hi,

Hi Christophe! Thank you for your review!

>
> ...
>
>> +static int d3323aa_set_lp_filter_freq(unsigned long *regmap, const int val,
>> +				      int val2)
>> +{
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
>
> Missing newline.

Sure, I'll add one.

>
>> +		if (val == integer && val2 == fract)
>> +			break;
>> +	}
>> +
>> +	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
>> +		return -ERANGE;
>> +
>> +	bitmap_write(regmap, d3323aa_lp_filter_regval[idx],
>> +		     D3323AA_REG_BIT_FILSEL0, D3323AA_FILTER_TYPE_NR_BITS);
>> +
>> +	return 0;
>> +}
>
> ...
>
>> +static int d3323aa_probe(struct platform_device *pdev)
>> +{
>> +	DECLARE_BITMAP(default_regmap, D3323AA_REG_NR_BITS);
>> +	struct d3323aa_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>> +				     "Could not allocate iio device\n");
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>> +	init_completion(&data->reset_completion);
>> +
>> +	ret = devm_mutex_init(data->dev, &data->regmap_lock);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Could not initialize mutex (%d)\n", ret);
>
> No need to repeat the error code in the message, when using dev_err_probe().
>
> Same for all calls below.

Ah, of course! I'll remove it. (There is actually another driver that is
doing this, I'll update that one as well...)

>
>> +
>> +	/* Request GPIOs. */
>> +	data->gpiod_vdd = devm_gpiod_get(data->dev, "vdd", GPIOD_OUT_LOW);
>> +	if (IS_ERR(data->gpiod_vdd))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_vdd),
>> +				     "Could not get GPIO vdd (%ld)\n",
>> +				     PTR_ERR(data->gpiod_vdd));
>> +
>> +	data->gpiod_clk_vout =
>> +		devm_gpiod_get(data->dev, "clk-vout", GPIOD_OUT_LOW);
>> +	if (IS_ERR(data->gpiod_clk_vout))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_clk_vout),
>> +				     "Could not get GPIO clk-vout (%ld)\n",
>> +				     PTR_ERR(data->gpiod_clk_vout));
>> +
>> +	data->gpiod_data = devm_gpiod_get(data->dev, "data", GPIOD_OUT_LOW);
>> +	if (IS_ERR(data->gpiod_data))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_data),
>> +				     "Could not get GPIO data (%ld)\n",
>> +				     PTR_ERR(data->gpiod_data));
>> +
>> +	ret = gpiod_to_irq(data->gpiod_clk_vout);
>> +	if (ret < 0)
>> +		return dev_err_probe(data->dev, ret, "Could not get IRQ (%d)\n",
>> +				     ret);
>> +
>> +	data->irq = ret;
>> +
>> +	/* Do one setup with the default values. */
>> +	bitmap_zero(default_regmap, D3323AA_REG_NR_BITS);
>> +	d3323aa_set_threshold(default_regmap, D3323AA_THRESH_DEFAULT_VAL);
>> +	d3323aa_set_filter_gain(default_regmap,
>> +				D3323AA_FILTER_GAIN_DEFAULT_VAL);
>> +	ret = d3323aa_setup(indio_dev, default_regmap);
>> +	if (ret)
>> +		return ret;
>> +
>> +	indio_dev->info = &d3323aa_info;
>> +	indio_dev->name = D3323AA_DRV_NAME;
>> +	indio_dev->channels = d3323aa_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(d3323aa_channels);
>> +
>> +	ret = devm_iio_device_register(data->dev, indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Could not register iio device (%d)\n",
>> +				     ret);
>> +
>> +	return 0;
>> +}
>
> ...
>
> CJ

