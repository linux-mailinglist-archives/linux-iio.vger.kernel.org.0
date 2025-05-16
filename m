Return-Path: <linux-iio+bounces-19605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D04EABA1C5
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF8A7A62CF
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E726D4EF;
	Fri, 16 May 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FcUMhVo1"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD92512F3;
	Fri, 16 May 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415792; cv=fail; b=BwGAYxhhKmEq+xJYpYGNSswnsrwIzTmsCuyR4oBtZbHMvPg7GfY9wx7diaQLUdKti/fFHG5bIQ24gn1R/TN9fNW3TyG92vK/TouFTkXYH9R39NGf5opzH8Hy1kFYdM8Y/avxTJjTrSBby2JqR/rucv5SVeoVACg6qRGkcT+D1V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415792; c=relaxed/simple;
	bh=4ElQwiWETiUW33QLEu0d3YGcoEiqdZ0L6Vg90I8TwR0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vGEU+2cIOo7afH50u67PGJSjMIxQ6EiG5NbKgWuWuAm7aUK2J7E7sXjCRScaJr32SiacNYBbWNg/uFNTcY3gDgIioj1sdE65u1lBGkz9FCev5gvWlXNzgxOejtqc+5GZvs8OAHHyKk9Ref7hivFTxjq3RhlGY2w2naGbGl6kny4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FcUMhVo1; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVppdUFMt0jqLP+kZiK+IjYZbXv9uufhE0XH6vzDi0SNsQmTCYpM4ESNc3VwoleVsaajnch49BF1dGab9U53nv8utML4WmW8oUaW658IPJCIWcYL/esUTxHiUCtdadYyNF9j91wNGREYGIlCEz2k2G0cl7iqIX51JnWuzzCFt1qzyCpAVP5kRiYl6Dn3vCFCQMGqiPVqaHJxOO6sFcjAYQADC8sy0X9iqFWiC36OchSmJAC+CKX6EAkrfOID4OnbckNJ5FyV8upPn5tb+K4fZPUUXoBH/AVwc858hOypXDG4B6V3k37GdJgoKJkqCpbFe4mOkijYd44bbLBFtQx9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDZ4BjBRF0DPWv+aKHzhXxvS7M11ik1emqRQH4VTWT8=;
 b=ysgZHTrEG2nrSqRdAfMtMCxFCyTQ6KTT8hQ4UTOK9fs2FCh/oi1n8UkRdG+Ala5hnpGeVMbTffqZwpCSekbK7+w3n1qRSvwCKWPcwjWRsT8HtqtAf30aV/15zKqK3mg0mRk5lMBY+lGZVYTmGk+K3LVgN5jgAmEo98adE5vlPGYZ3exWyds5aDjz/Ys9It5cwUo5MO+8jcFjAd5tSIrovLt0IpudRQUlh7/YXL7m26R4CvVJBmOGaqwNPZhAhT2BJIGpz6/FylrEmksBMlX3prTtZNFPtAdvoLEsExJo6TTJ5xJ05yV0/fqBWsoGwbLkR3YpOKwfhTKWcsL+Y6IrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDZ4BjBRF0DPWv+aKHzhXxvS7M11ik1emqRQH4VTWT8=;
 b=FcUMhVo1V9eRtoQSA+pb+HwiLmzCZRpDPput6kif8AmMHkxFjwxPrIhTDZTPZ0LLaezqAVOowCjrwEaQ4tugi3W57gB4jHfzl3qomFFpIBpf0erk5VWqDfQ8CrG1WjIwxeaD9AbFfzIb0yH/0RjynuK2XpZseblhla7k6ZkdF1s=
Received: from DUZPR01CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::14) by AM9PR02MB7139.eurprd02.prod.outlook.com
 (2603:10a6:20b:262::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 16 May
 2025 17:16:27 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::a9) by DUZPR01CA0106.outlook.office365.com
 (2603:10a6:10:4bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.21 via Frontend Transport; Fri,
 16 May 2025 17:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:16:27 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 16 May
 2025 19:16:25 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250511131432.1c6e381c@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 11 May 2025 13:14:32 +0100")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei>
User-Agent: a.out
Date: Fri, 16 May 2025 19:16:25 +0200
Message-ID: <pndldqwiihi.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AM9PR02MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d573a7-f490-48c0-b733-08dd949d6479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCbr4tW+TcLojfD7GPx4awg6dD447dhjzj5US6KRU0rpXio9twj+tHZ5+Wtz?=
 =?us-ascii?Q?mibpFtEAlo6/h6bY0WiLgpumUTRJiTSvweo23BLnTf/76W++pN6g2nLk25nv?=
 =?us-ascii?Q?RkvBdWli9pdDCs6K7cpwxUtZjH+T4jMvxyOElcMqMmI1ILXML0oh1FSPpBbY?=
 =?us-ascii?Q?uBfH72i1fTBErt4YrqabEFcBLi5hxKyqOp63aEGr0tWQ771ctcfBjehA+U0T?=
 =?us-ascii?Q?W1ureFpy4L7dhFjuvVTnKh3vKCbkkIbx58jQEjOovoFH5yw8KluHt6HAshQd?=
 =?us-ascii?Q?lVCt7W24ZvNAWo8Hj1W+e+gBg8CYcBHRlnH6GPRwkjzhw5GNu1Y1Kggki97N?=
 =?us-ascii?Q?rUOc/p2SmJF6G3frs+sbVJzS4A1yVn+3Yh6PCC66LL09qcWnOBFyP9x/WAal?=
 =?us-ascii?Q?ymfXyRMyECj/G8K83Gz/ytrqHh/ljStMyI0I9pG1nQ7h4zRUon+oQ3dzijRU?=
 =?us-ascii?Q?ujlM9qOKBamtjxXl3p56FKIWO64z0FeSGkHJJqdnaUN0/RJJJotkUPxJT9Bz?=
 =?us-ascii?Q?Xgxlukw1s8zPQPmNam7VzfwP5lKaZW4mq4sHpm47/Q2aztMZoab0sq2oQB9l?=
 =?us-ascii?Q?bM+dibpOFTdvUtupvjuwBITVpVknSRkBQXYxY/oAYhBstYf6vHx3yEQb6Jkz?=
 =?us-ascii?Q?xv7g8DrIiXSOtk0it+P4NtQ7SytapOJY+ugHe2AeQY2i3e8LUCDpHwDv89+T?=
 =?us-ascii?Q?vb9XMg6aerSqOAEOpVH6GCxnynZTMFiyIsPQcq+WujAFu1STwFGL1G06pu0d?=
 =?us-ascii?Q?bqeSpinOmD25X1KxD0+Sem6/Rh0s3O/6qUYACdk/bPbZ904sdDKp4i6pFAbG?=
 =?us-ascii?Q?gyLWx5+Blmmgr7uxxr8nExnn0D8Ogt9bil7j8NdKqJ9YwasUlypAWK7a/NzH?=
 =?us-ascii?Q?pUEE8vSungw79eBQLU0f8IWkeeQ98TwRyuIA11W94rb+Bs0ZwyOHR+yVgh/m?=
 =?us-ascii?Q?G4kXlP9RqrZOHdXf/Y+XVy8E1LCgcAv2PMdGAQcEefiAzY6SLxph4SkYOpRm?=
 =?us-ascii?Q?vAwiftDmJAnnWWAEZsbpI06lJcG6gCw0Oeo7ZbXAVNCvqjOeuA2LMxnRBhlS?=
 =?us-ascii?Q?6rwcZkMOYsxfikR5fQ4waY1HK85uDtpfrO9UGYkEeHuduCmqJoY8JOq/Woyx?=
 =?us-ascii?Q?VlOIqgLLYqU12bKxio4G8awoWe1bYwNFDtNQhhodH6yPW9CMu00CyO/bF75P?=
 =?us-ascii?Q?Bflwc7Ro7suOmoMOd1smRYoVkopv9JoLvbdyAyKQ+EtduR9Q0AcGczGv1T39?=
 =?us-ascii?Q?k6G7eknJut7QuLayrqktBqAppYoM19zrNFQeAnSFpO+IyvO8sNX8DwaiRG4V?=
 =?us-ascii?Q?EpKKQ8hxLKjC0roZNgaJ+XKV7u1K6QYtxN3M5WMvL0EBz0yLjL0D3XXQagfG?=
 =?us-ascii?Q?DOPk/A2+l1mHhTH2BpGzmw1dL4/Yi9EqIDM42hG8399Lch5RywbBe1YgbXCG?=
 =?us-ascii?Q?R6bIU2b63fTtotqcjwrW+cwjnikBxBHt2IvPtLUfOMlJ6ovHGIn5pv0wXdTk?=
 =?us-ascii?Q?3nEpwTjrK8mm9JqpuXi3VwAIVdaQTVkoVUZn?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:16:27.2393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d573a7-f490-48c0-b733-08dd949d6479
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7139

On Sun, May 11, 2025 at 13:14 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

> Hi Waqar,
>
> Biggest suggestion in here is hide those bitmaps. They are of interest
> only at point of reading and writing. I wouldn't use them for device state
> elsewhere as they make for much less readable code than using simple
> fields in iio_priv() for the state elements and building up the bitmaps
> only where needed.

Hi Jonathan!

Thank you for thorough (as usual) review!

[...]

>> +#define D3323AA_DRV_NAME "d3323aa"
>
> Put that inline where used.  A define like this both implies that various values
> must be the same when they need not be and means that we have to go find the
> define to fine out what they are set to.  Just setting the strings directly
> tends to end up more readable.

Sure, we can do that. (There are a bunch of IIO-drivers doing this, so I
just thought that was the "convention".)

>> +
>> +/*
>> + * Register bitmap.
>> + * For some reason the first bit is denoted as F37 in the datasheet, the second
>> + * as F38 and so on. Note the gap between F60 and F64.
>> + */
>> +#define D3323AA_REG_BIT_SLAVEA1		0	/* F37. */
>> +#define D3323AA_REG_BIT_SLAVEA2		1	/* F38. */
>> +#define D3323AA_REG_BIT_SLAVEA3		2	/* F39. */
>> +#define D3323AA_REG_BIT_SLAVEA4		3	/* F40. */
>> +#define D3323AA_REG_BIT_SLAVEA5		4	/* F41. */
>> +#define D3323AA_REG_BIT_SLAVEA6		5	/* F42. */
>> +#define D3323AA_REG_BIT_SLAVEA7		6	/* F43. */
>> +#define D3323AA_REG_BIT_SLAVEA8		7	/* F44. */
>> +#define D3323AA_REG_BIT_SLAVEA9		8	/* F45. */
> Perhaps these can be represented as masks using GENMASK() rather than
> bits.  A lot of this will be hidden away if you follow suggesting to
> only expose that you are using a bitmap to bitbang in the read/write
> functions.

Yes, that would be the natural thing to do when moving the bitmap stuff
to the read/write functions (as answered below).

[...]

>> +/*
>> + * This is denoted as "step" in datasheet and corresponds to the gain at peak
>> + * for the band-pass filter. The index in this array is the corresponding index
>> + * in d3323aa_filter_gain_regval for the register bitmap value.
>> + */
>> +static const int d3323aa_filter_gain[] = {
>> +	1,
>> +	2,
>> +	3,
>> +};
> 	1, 2, 3,
> is fine for such a short list.

Sure, I'll change the corresponding array below as well then.

>> +
>> +/*
>> + * Register bitmap values for the filter gain. The index in this array is the
>> + * corresponding index in d3323aa_filter_gain for the gain value.
>> + */
>> +static const u8 d3323aa_filter_gain_regval[] = {
>> +	1,
>> +	3,
>> +	0,
>> +};
>> +
>> +struct d3323aa_data {
>> +	struct completion reset_completion;
>> +	/*
>> +	 *  Since the setup process always requires a complete write of the
>> +	 *  _whole_ register bitmap, we need to synchronize it with a lock.
>> +	 */
>> +	struct mutex regmap_lock;
>> +	atomic_t irq_reset_count;
>> +	unsigned int irq;
>> +
>> +	struct device *dev;
>> +
>> +	/* Supply voltage. */
>> +	struct gpio_desc *gpiod_vdd;
>> +	/* Input clock or output detection signal (Vout). */
>
> I'd rename. Vout kind of suggests a variable voltage. This seems to just
> be a level signal.

>> +	struct gpio_desc *gpiod_clk_vout;

Yeah, it's a weird pin with multiple use-cases... I just named it
according to what the datasheet calls it. What about
`gpiod_clk_detection`?

>> +	/* Input (setting) or output data. */
>> +	struct gpio_desc *gpiod_data;
>> +
>> +	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
>> +
>> +	/*
>> +	 * Indicator for operational mode (configuring or detecting), i.e.
>> +	 * d3323aa_irq_detection() registered or not.
>> +	 */
>> +	bool detecting;
>> +};
>> +
>> +static int d3323aa_read_settings(struct iio_dev *indio_dev,
>> +				 unsigned long *regmap)
>> +{
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	size_t i;
>> +	int ret;
>> +
>> +	/* Bit bang the clock and data pins. */
>> +	ret = gpiod_direction_output(data->gpiod_clk_vout, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = gpiod_direction_input(data->gpiod_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(data->dev, "Reading settings...\n");
>> +
>> +	for (i = 0; i < D3323AA_REG_NR_BITS; ++i) {
>> +		/* Clock frequency needs to be 1 kHz. */
>> +		gpiod_set_value(data->gpiod_clk_vout, 1);
>> +		udelay(500);
>> +
>> +		/* The data seems to change when clock signal is high. */
>> +		if (gpiod_get_value(data->gpiod_data))
>> +			set_bit(i, regmap);
>> +
>> +		gpiod_set_value(data->gpiod_clk_vout, 0);
>> +		udelay(500);
>> +	}
>> +
>> +	/* The first bit (F37) is just dummy data. Discard it. */
>> +	clear_bit(0, regmap);
>> +
>> +	/* Datasheet says to wait 30 ms after reading the settings. */
>> +	msleep(30);
>> +
>> +	return 0;
>> +}
>> +
>> +static int d3323aa_write_settings(struct iio_dev *indio_dev,
>> +				  const unsigned long *regmap)
>
> Rename regmap. regmap means some specific stuff in the kernel register_bm or something
> like that avoids that potential confusion.
>
> However, it would be much easier to read this driver if only this
> function and the read one knew about the bitmap stuff.  Inside the reset
> of the driver just store and pass around a structure with the various fields.
> Then in here use that to build up the bitmap locally and write to the device.
> The opposite in read which decodes the bitmap into those fields.
>
> That will make for a more standard and easier to review driver.

Hm, maybe it would be easier to understand it if we remove the bitmap
from `struct d3323aa_data` and instead only store the relevant state
variables. We still would need to have the `regmap_lock` but to instead
protect all of the variables.

Let's go for that then! I actually don't have any strong arguments (or
opinions) against it.

>> +{
>> +	DECLARE_BITMAP(end_pattern, D3323AA_SETTING_END_PATTERN_NR_BITS);
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	size_t i;
>> +	int ret;
>> +
>> +	/* Bit bang the clock and data pins. */
>> +	ret = gpiod_direction_output(data->gpiod_clk_vout, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = gpiod_direction_output(data->gpiod_data, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(data->dev, "Writing settings...\n");
>> +
>> +	/* First bit (F37) is not used when writing the register map. */
>> +	for (i = 1; i < D3323AA_REG_NR_BITS; ++i) {
>> +		gpiod_set_value(data->gpiod_data, test_bit(i, regmap));
>> +
>> +		/* Clock frequency needs to be 1 kHz. */
>> +		gpiod_set_value(data->gpiod_clk_vout, 1);
>> +		udelay(500);
>> +		gpiod_set_value(data->gpiod_clk_vout, 0);
>> +		udelay(500);
>> +	}
>> +
>> +	/* Compulsory end pattern. */
>> +	bitmap_write(end_pattern, D3323AA_SETTING_END_PATTERN, 0,
>> +		     D3323AA_SETTING_END_PATTERN_NR_BITS);
>  
> Why not use a larger bitmap with padding for this end pattern
> and just write this into that?  At which point this can all be one loop.

Will do! It will be natural to do that after moving the bitmap stuff and
only scope it here.

>> +	for (i = 0; i < D3323AA_SETTING_END_PATTERN_NR_BITS; ++i) {
>> +		gpiod_set_value(data->gpiod_data, test_bit(i, end_pattern));
>> +
>> +		gpiod_set_value(data->gpiod_clk_vout, 1);
>> +		udelay(500);
>> +		gpiod_set_value(data->gpiod_clk_vout, 0);
>> +		udelay(500);
>> +	}
>> +
>> +	/* Datasheet says to wait 30 ms after writing the settings. */
>> +	msleep(30);
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t d3323aa_irq_detection(int irq, void *dev_id)
>> +{
>> +	struct iio_dev *indio_dev = dev_id;
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	enum iio_event_direction dir;
>> +	int val;
>> +
>> +	val = gpiod_get_value(data->gpiod_clk_vout);
>
> Ideally I'd like a setup where we can wire the interrupt side of this
> to one pin and the gpio needed for writing to another.  In practice
> they may well be the same pin but that does introduced a bunch of races
> and dependency on what the interrupt controller does when an irq
> is disabled.
>
> Using one pin as an irq and as a data line is prone to some nasty
> corner cases though it works on some SoCs.

Hm, that's an interesting idea. However, as you say there might then be
other issues to take care of.

On the other hand, the scope of the clock bit bang is quite small (only in
`*read/write_settings()`). So I guess we just leave it then?

>
>
>> +	if (val < 0) {
>> +		dev_err_ratelimited(data->dev,
>> +				    "Could not read from GPIO clk-vout (%d)\n",
>> +				    val);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	dir = val ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
>> +	iio_push_event(indio_dev,
>> +		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>> +					    IIO_EV_TYPE_THRESH, dir),
>> +		       iio_get_time_ns(indio_dev));
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t d3323aa_irq_reset(int irq, void *dev_id)
>> +{
>> +	struct iio_dev *indio_dev = dev_id;
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	int count = atomic_inc_return(&data->irq_reset_count);
>> +
>
> As below. It should be easy enough to have a unified handler and avoid
> the need to unregister / reregister the irq.

Alright (see longer response below).

>> +	if (count == D3323AA_IRQ_RESET_COUNT)
>> +		complete(&data->reset_completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int d3323aa_reset(struct iio_dev *indio_dev)
>> +{
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	long time;
>> +	int ret;
>> +
>> +	/*
>> +	 * Datasheet says VDD needs to be low at least for 30 ms. Let's add a
>> +	 * couple more to allow VDD to completely discharge as well.
>> +	 */
>> +	gpiod_set_value(data->gpiod_vdd, 0);
>> +	msleep(30 + 5);
>> +
>> +	/*
>> +	 * After setting VDD to high, the device signals with
>> +	 * D3323AA_IRQ_RESET_COUNT falling edges on CLK/Vout that it is now
>> +	 * ready for configuration. Datasheet says that this should happen
>> +	 * within D3323AA_RESET_TIMEOUT ms. Count these two edges within that
>> +	 * timeout.
>> +	 */
>> +	atomic_set(&data->irq_reset_count, 0);
>> +	reinit_completion(&data->reset_completion);
>> +
>> +	ret = gpiod_direction_input(data->gpiod_clk_vout);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(data->dev, "Resetting...\n");
>> +
>> +	gpiod_set_value(data->gpiod_vdd, 1);
>> +
>> +	/*
>> +	 * Datasheet doesn't mention this but measurements have shown that
>> +	 * CLK/Vout signal slowly ramps up during the first 1.5 ms after reset.
>> +	 * This means that the digital signal will have bogus values during this
>> +	 * period. Let's wait for this ramp-up before counting the "real"
>> +	 * falling edges.
>> +	 */
>> +	usleep_range(2000, 5000);
>> +
>> +	if (data->detecting) {
>> +		/*
>> +		 * Device had previously been set up and was in operational
>> +		 * mode. Thus, free that detection IRQ handler before requesting
>> +		 * the reset IRQ handler.
>> +		 */
>> +		free_irq(data->irq, indio_dev);
>> +		data->detecting = false;
>> +	}
>> +
>> +	ret = request_irq(data->irq, d3323aa_irq_reset, IRQF_TRIGGER_FALLING,
>> +			  dev_name(data->dev), indio_dev);
>
> Can you keep to a single handler with a check on device state?  This
> dance with releasing and requesting irqs is rather complex when all you need
> to know is what the irq means and that is state the driver knows.

We can do that. Ironically, I opted for separating them just for the
sake of simplicity, and thought it would be easier to understand this
way :)

>> +	if (ret)
>> +		return ret;
>> +
>> +	time = wait_for_completion_killable_timeout(
>> +		&data->reset_completion,
>> +		msecs_to_jiffies(D3323AA_RESET_TIMEOUT));
>> +	free_irq(data->irq, indio_dev);
>> +	if (time == 0) {
>> +		return -ETIMEDOUT;
>> +	} else if (time < 0) {
>> +		/* Got interrupted. */
>> +		return time;
>> +	}
>> +
>> +	dev_dbg(data->dev, "Reset completed\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int d3323aa_setup(struct iio_dev *indio_dev, const unsigned long *regmap)
>> +{
>> +	DECLARE_BITMAP(read_regmap, D3323AA_REG_NR_BITS);
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
>> +	start_time = jiffies;
>> +
>> +	ret = d3323aa_write_settings(indio_dev, regmap);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not write settings (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = d3323aa_read_settings(indio_dev, read_regmap);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not read settings (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (time_is_before_jiffies(start_time +
>> +				   msecs_to_jiffies(D3323AA_CONFIG_TIMEOUT))) {
>> +		dev_err(data->dev, "Could not set up configuration in time\n");
>> +		return -EAGAIN;
>> +	}
>> +
>> +	/* Check if settings were set successfully. */
>> +	if (!bitmap_equal(regmap, read_regmap, D3323AA_REG_NR_BITS)) {
>> +		dev_err(data->dev, "Settings data mismatch\n");
>> +		return -EIO;
>> +	}
>> +
>> +	/* Now in operational mode. */
>> +	ret = gpiod_direction_input(data->gpiod_clk_vout);
>> +	if (ret) {
>> +		dev_err(data->dev,
>> +			"Could not set GPIO clk-vout as input (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = gpiod_direction_input(data->gpiod_data);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not set GPIO data as input (%d)\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = request_irq(data->irq, d3323aa_irq_detection,
>> +			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>
> Why both ways?  Add a comment.

Good point! I'll add a comment.

>
>> +			  dev_name(data->dev), indio_dev);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not request IRQ for detection (%d)\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	bitmap_copy(data->regmap, regmap, D3323AA_REG_NR_BITS);
>> +	data->detecting = true;
>> +
>> +	dev_dbg(data->dev, "Setup done\n");
>> +
>> +	return 0;
>> +}
>
>> +
>> +static int d3323aa_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int val,
>> +			     int val2, long mask)
>> +{
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
>> +	int ret;
>> +
>> +	guard(mutex)(&data->regmap_lock);
>> +
>> +	bitmap_copy(regmap, data->regmap, D3323AA_REG_NR_BITS);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>> +		/*
>> +		 * We only allow to set the low-pass cutoff frequency, since
>> +		 * that is the only way to unambigously choose the type of
>> +		 * band-pass filter. For example, both filter type B and C have
>> +		 * 0.3 Hz as high-pass cutoff frequency (see
>> +		 * d3323aa_hp_filter_freq).
>
> This is somewhat unintiutive userspace inteface.  I'd try and do the best
> possible in response to a userspace request.  So if the lp frequency is
> already set to one of the values that matches requested hp then use that.
> If it's not then pick the one that has best match lp (so nearest) on
> assumption userspace is probably about to update the lp side anyway.
>
> Slight fiddlier code than you have here, but a better attempt to figure
> out what the users is after than rejecting writes.

To be honest, I wasn't super keen on doing this either and figured you
would have some suggestions on it. It was the easiest way to just set a
policy instead :)

Your suggestion is reasonable. Let's do that!

>> +		 */
>> +		return -EINVAL;
>> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>> +		ret = d3323aa_set_lp_filter_freq(regmap, val, val2);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		ret = d3323aa_set_filter_gain(regmap, val);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return d3323aa_setup(indio_dev, regmap);
>
> I'd bury this call in set_lp_filter() and set_fillter_gain() so they
> actually do the setting.

Alright, let's do that then.

>
>> +}
>
>> +
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
>
> Should be unnecessary with the suggested change below.

Yup, will be removed.

>
>> +
>> +	init_completion(&data->reset_completion);
>> +
>> +	ret = devm_mutex_init(data->dev, &data->regmap_lock);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Could not initialize mutex (%d)\n", ret);
>
> As already pointed out in other review - look at what dev_err_probe()
> does.

Yeah, will fix!

>
>> +
>> +	/* Request GPIOs. */
>
> This sort of code structure comment adds nothing useful. We can see
> you are requesting gpios from the code.  As such, all it can do is
> become wrong in future if code is reorganised.  Hence drop the comment.

Sure, let's drop it.

>> +	data->gpiod_vdd = devm_gpiod_get(data->dev, "vdd", GPIOD_OUT_LOW);
>
> This seems to be a supply, not a gpio.  Use the regulator framework.
> Make sure to request exclusive use though so you can turn it on and off.
> _get_exclusive() etc should ensure no one else is using it.

Alright, will do!

>> +	if (IS_ERR(data->gpiod_vdd))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_vdd),
>> +				     "Could not get GPIO vdd (%ld)\n",
>> +				     PTR_ERR(data->gpiod_vdd));
>> +

[...]

>> +static void d3323aa_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> +
>> +	if (data->detecting)
>> +		free_irq(data->irq, indio_dev);
>
> So this is an ordering mess.  You should never mix devm handling and
> non devm handling - once something happens in probe that is non devm
> you stop using devm_* from that point on.
>
> The irq handling in here is complex, but not on fast paths. As such I'd
> do devm_irq_request() and if you need to free it do so with devm_free_irq()
> in the places where you immediately re request it.  However see above.
> That should allow you to to drop this remove callabck.

Yes, we'll merge the IRQ handlers into one and thus we'll drop this
altogether.

>> +}
>> +
>> +static const struct of_device_id d3323aa_of_match[] = {
>> +	{
>> +		.compatible = "nicera,d3323aa",
>> +	},
>> +	{}
> 	{ }
>
> Is now standard format for these in IIO.
>
>> +};
>> +MODULE_DEVICE_TABLE(of, d3323aa_of_match);

Oh ok. I'll change it to:

static const struct of_device_id d3323aa_of_match[] = {
	{ .compatible = "nicera,d3323aa", },
	{ }
};

If that's more according to the style (I was relying on `clang-format`
here).

[...]


