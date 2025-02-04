Return-Path: <linux-iio+bounces-14972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876C5A274A0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10520162AFC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB372139BF;
	Tue,  4 Feb 2025 14:43:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B402135BC;
	Tue,  4 Feb 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680198; cv=none; b=GN1KTxqPWifcefpGi+a/3dvNzew4/9XI/SltzpiPrPfMEhbBr+S4WJeOcK5eeqyaXiF7pqDEwkp56N9KAUyl7zBINqvjGz8MVQwZC1n1bRyWh+eTXTdG1oDi6ya0C3V/TgStDGl2NnF+E8WW5sdh0TS0rMxw9v5VFAJc0Q741cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680198; c=relaxed/simple;
	bh=DBK6s+YgOk3NpEYbVIfXExkgTDf93wrg4yVddjEVZlI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=las9+JJ7pffMQozJOEcHUi3SsOHF43/8bKfF3MchwWTbNlLvN7UM5ERLFb/se+nKmkA0Kh5f7g7SbehttmA/Vxs63tmMvGbAlbiZ1TGsCj2aBxCSoFFFK71aWX/6zoPMdN+SCtNMwkQsoMvVHrDSO+uUp22SBeE7cds6w1YWqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnR0V3CYxz6J9yR;
	Tue,  4 Feb 2025 22:42:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FDDD140B3C;
	Tue,  4 Feb 2025 22:43:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 15:43:10 +0100
Date: Tue, 4 Feb 2025 14:43:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
CC: Jonathan Cameron <jic23@kernel.org>, Tobias Sperling via B4 Relay
	<devnull+tobias.sperling.softing.com@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Message-ID: <20250204144309.000043e6@huawei.com>
In-Reply-To: <BE1P281MB24209585E1552B80272D5448EFF52@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
	<20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
	<20241124124205.02453a0c@jic23-huawei>
	<BE1P281MB24209585E1552B80272D5448EFF52@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Feb 2025 16:57:19 +0000
"Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:

> Hi Jonathan,
> thanks for the great feedback, I tried to improve all the mentioned things, just
> some comments/questions inline.
> 
> Regards,
> Tobi
> 
> > > +static const struct ads71x8_freq_bits ads71x8_samp_freq[] = {
> > > +	{163, 0x1F}, {244, 0x1E}, {326, 0x1D}, {488, 0x1C}, {651, 0x1B},
> > > +	{977, 0x1A}, {1302, 0x19}, {1953, 0x18}, {2604, 0x17}, {3906, 0x16},
> > > +	{5208, 0x15}, {7813, 0x14}, {10417, 0x13}, {15625, 0x12}, {20833, 0x11},
> > > +	{31250, 0x10}, {41667, 0x09}, {62500, 0x08}, {83333, 0x07},
> > > +	{125000, 0x06}, {166667, 0x05}, {250000, 0x04}, {333333, 0x03},
> > > +	{500000, 0x02}, {666667, 0x01}, {1000000, 0x0}  
> > Format this as something like.
> > 	{ 163, 0x1F }, { 244, 0x1E }, { 326, 0x1D }, { 488, 0x1C },
> > 	{ 651, 0x1B }, { 977, 0x1A }, { 1302, 0x19 }, { 1953, 0x18 },
> > 
> > So with more spaces and with a power of 2 entries on each line to make it easy
> > for people to work out the matching.
> > 
> > Once you use read_avail as requested below, you may well just want to use
> > the index of the array for the second field and have a simple array of value
> > assuming no holes that I'm missing.  
> 
> There would have been some holes, as some register values lead to the same frequency.
> I just changed this to repeat these values then in the list. Should be fine now and the
> array's index can be used now.

Ok.  Generally when that happens we don't export repeats in read_avail.

So may be back to this approach :(

> 
> > > +static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintptr_t priv,
> > > +	const struct iio_chan_spec *chan, char *buf)
> > > +{
> > > +	struct ads71x8_data *data = iio_priv(indio_dev);
> > > +	int ret;
> > > +	u8 values[2];
> > > +
> > > +	switch (priv) {
> > > +	case ADS71x8_STATS_MIN:
> > > +		ret = ads71x8_i2c_read_block(data->client,
> > > +			ADS71x8_REG_MIN_LSB_CH(chan->channel), values,
> > > +			ARRAY_SIZE(values));
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		break;
> > > +	case ADS71x8_STATS_MAX:
> > > +		ret = ads71x8_i2c_read_block(data->client,
> > > +			ADS71x8_REG_MAX_LSB_CH(chan->channel), values,
> > > +			ARRAY_SIZE(values));
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return sprintf(buf, "%d\n", ((values[1] << 8) | values[0]));  
> > 
> > I've no ideas what this is, so needs docs.  
> 
> See comment below regarding custom ABI.
> 
> > That last bit is a get_unaligned_le16() though so use that to make it
> > explicit what is going on.  
> 
> > > +};
> > > +
> > > +static const struct attribute_group ads71x8_attribute_group = {
> > > +	.attrs = ads71x8_attributes,
> > > +};
> > > +
> > > +static const struct iio_info ti_ads71x8_info = {
> > > +	.attrs = &ads71x8_attribute_group,
> > > +	.read_raw = &ads71x8_read_raw,
> > > +	.write_raw = &ads71x8_write_raw,
> > > +	.read_event_value = &ads71x8_read_event,
> > > +	.write_event_value = &ads71x8_write_event,
> > > +	.read_event_config = &ads71x8_read_event_config,
> > > +	.write_event_config = &ads71x8_write_event_config,  
> > Definitely worth thinking about whether the device can be used to
> > some degree at least without interrupts.  It is annoyingly common
> > for board designers to not wire them.
> > 
> > If it is easy to support (without events) from the start that
> > is a nice to have. If more complex we can leave it until we know
> > of actual hardware.  
> 
> In general, this driver could be used without interrupts. What remains
> is the reading of the ADC values, which probably is sufficient most of
> the time.
> Is this what you had in mind?

Yes.

> 
> > > +static const struct iio_chan_spec_ext_info ads71x8_ext_info[] = {
> > > +	{"stats_min", IIO_SEPARATE, ads71x8_read_stats, NULL,  
> > ADS71x8_STATS_MIN},  
> > > +	{"stats_max", IIO_SEPARATE, ads71x8_read_stats, NULL,  
> > ADS71x8_STATS_MAX},  
> > > +	{},  
> > 	{ "stats_min", ...
> > 	{ }
> > 
> > No comma for terminating entries as we don't want it to be easy to add more
> > after them.
> > 
> > However, the fields in this structure are non obvious, so
> > 	{
> > 		.name = "stats_min",
> > etc
> > preferred.
> > 
> > This is custom ABI, so I'd expect to see a file under
> > Documentation/ABI/testing/sysfs-bus-iio-*
> > that explains what these are.
> > 
> > Adding custom ABI however is a hard thing, so provide plenty of information
> > to see if these are justified or not.
> > Superficially they sound like debugfs things rather than suitable for sysfs.  
> 
> In the current configuration the IC is automatically making some statistics about
> the minimal and maximum value that were seen on each channel, which can be
> read back by this ABI.
> This as quick info, do you think it makes sense to add this as custom ABI?
  
For max we do have existing ABI peak and trough (only one user of that)
https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/ABI/testing/sysfs-bus-iio#L363
Would those work for you?

> 
> Otherwise, making this part of the debugfs, I guess you are talking about
> granting access via debugfs_reg_access of the iio_info, don't you?
> And this then also needs docu in "Documentation/ABI/testing/debugfs-bus-iio-*",
> doesn't it?

This doesn't really feel like a feature intended for debug, so better to
use main ABI. If we need to add something we can.


Jonathan



