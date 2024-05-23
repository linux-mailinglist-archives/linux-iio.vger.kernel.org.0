Return-Path: <linux-iio+bounces-5230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919B28CD8D5
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3287DB21331
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786486E615;
	Thu, 23 May 2024 17:02:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A5AD2C;
	Thu, 23 May 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483737; cv=none; b=Fl0mhgIHNKapFib2fUoBZQ3hIKrcenw0hpKmzle9ED3HnNA357CTeyhFMbXe6C/SlgmgAdv273pHdH8NI8TuwRDDKRqpyrpMsf2E7FCyrAP13IIPkRJIbthB9TDBaO7YaR3y52Jv5sheD/rqmM45bAGsv0DaULUaIKPMnItHT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483737; c=relaxed/simple;
	bh=MFnAFu0mDTr79Tz6WSnTZIzc69nJXw23osl4KOgVlzM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWlVzmrI6Eb49VSJ+2pHeDn0oMYUD9TM7dDbLabBs5Ayv/OS9d67k/5VxO89FCvLXSNEwsEbQbmJMds+rOBdWKoLDcwwg0n+EgS4h2jES24M4dvNT2vCYRJ+1XioFUsIl+jNUNaOpI0JdC5qI4tG/60pmw0oIYoFPe1g7+Cu0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlZB03mhHz6J6X0;
	Fri, 24 May 2024 00:58:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CAF96140B2F;
	Fri, 24 May 2024 01:02:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 18:02:11 +0100
Date: Thu, 23 May 2024 18:02:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Dimitri
 Fedrau" <dima.fedrau@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S?=
 =?ISO-8859-1?Q?=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <20240523180210.00006b84@Huawei.com>
In-Reply-To: <20240523031909.19427-6-kimseer.paller@analog.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
	<20240523031909.19427-6-kimseer.paller@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 23 May 2024 11:19:09 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 16 bit Current Output Softspan DAC
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi Kim,

A few minor things inline,

Jonathan

> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> new file mode 100644
> index 000000000000..488b841e6c66
> --- /dev/null
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -0,0 +1,802 @@


> +static int ltc2664_set_span(const struct ltc2664_state *st, int min, int max,
> +			    int chan)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	const int (*span_helper)[2] = chip_info->span_helper;
> +	int span, ret;
> +
> +	st->iio_channels[chan].type = chip_info->measurement_type;
> +
> +	for (span = 0; span < chip_info->num_span; span++) {
> +		if (min == span_helper[span][0] && max == span_helper[span][1])
> +			break;
> +	}

Sanity check for no match?

> +
> +	ret = regmap_write(st->regmap, LTC2664_CMD_SPAN_N(chan),
> +			   (chip_info->id == LTC2672) ? span + 1 : span);
> +	if (ret)
> +		return ret;
> +
> +	return span;
> +}
> +
> +static int ltc2664_channel_config(struct ltc2664_state *st)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	struct device *dev = &st->spi->dev;
> +	u32 reg, tmp[2], mspan;
> +	int ret, span;
> +
> +	mspan = LTC2664_MSPAN_SOFTSPAN;
> +	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> +				       &mspan);
> +	if (!ret) {
> +		if (!chip_info->manual_span_support)
> +			return dev_err_probe(dev, -EINVAL,
> +			       "adi,manual-span-operation-config not supported\n");
> +
> +		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> +			return dev_err_probe(dev, -EINVAL,
> +			       "adi,manual-span-operation-config not in range\n");
> +	}
> +
> +	st->rfsadj = 20000;
> +	ret = device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj);
> +	if (!ret) {
> +		if (!chip_info->rfsadj_support)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,rfsadj-ohms not supported\n");
> +
> +		if (st->rfsadj < 19000 || st->rfsadj > 41000)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,rfsadj-ohms not in range\n");
> +	}
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		struct ltc2664_chan *chan;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +
> +		if (reg >= chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg bigger than: %d\n",
> +					     chip_info->num_channels);
> +
> +		chan = &st->channels[reg];
> +
> +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan = true;
> +			/* assume sw toggle ABI */
> +			st->iio_channels[reg].ext_info = ltc2664_toggle_sym_ext_info;

chan->ext_info = ...

> +			/*
> +			 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
> +			 * out_voltage/current_raw{0|1} files.
> +			 */
> +			__clear_bit(IIO_CHAN_INFO_RAW,
> +				    &st->iio_channels[reg].info_mask_separate);
> +		}
> +
> +		chan->raw[0] = ltc2664_mspan_lut[mspan][1];
> +		chan->raw[1] = ltc2664_mspan_lut[mspan][1];
> +
> +		chan->span = ltc2664_mspan_lut[mspan][0];
> +
> +		ret = fwnode_property_read_u32_array(child, "adi,output-range-microvolt",
> +						     tmp, ARRAY_SIZE(tmp));
> +		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
> +			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
> +						      tmp[1] / 1000, reg);
> +			if (span < 0)
> +				return dev_err_probe(dev, span,
> +						     "Failed to set span\n");
> +
> +		}
> +
> +		ret = fwnode_property_read_u32(child,
> +					       "adi,output-range-microamp",
> +					       &tmp[0]);
> +		if (!ret) {
> +			chan->span = ltc2664_set_span(st, 0, tmp[0] / 1000, reg);
> +			if (span < 0)
> +				return dev_err_probe(dev, span,
> +						     "Failed to set span\n");
> +		}
> +	}
> +
> +	return 0;
> +}





