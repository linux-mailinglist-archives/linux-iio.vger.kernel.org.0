Return-Path: <linux-iio+bounces-7415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40F9298D6
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ABE1F221C5
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306CA35894;
	Sun,  7 Jul 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdjHQ7nx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D8EDC;
	Sun,  7 Jul 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720369911; cv=none; b=jD0d/h+fTQYdIkisou65uBaq3A8E8VyfxfzVzjEMe/kdMgEAGzD4mSrx6XFIxzwVk64ni+3VqPu8ufHhhEUK3ko2CLL+fV/eFbp0eB+S7q1VRgsEOYIpaYj+LPvUx1yNeYH/2eABRX8s/UKnrY++uq8W3pqacjCclFP4CmFPFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720369911; c=relaxed/simple;
	bh=R0A8F9MaBNMJYyePyat187xoFF611t/6TqupStas/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/i5lbP4l9QqS54rKxmzEscUxzCQZaTgkE3kE9MEvNVKnC6O9UaO0wVscXr1H5qC2AwNj4a/jZPsecI9Jro/St5HP+TYV8HEpy3cfdelUIiz8vxupJeEV5d4RFpmPI1FP66vGsrcUT27sg0JR1QnZBzbn8FQeOBRzE116xTdfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdjHQ7nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC75C3277B;
	Sun,  7 Jul 2024 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720369910;
	bh=R0A8F9MaBNMJYyePyat187xoFF611t/6TqupStas/DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AdjHQ7nxuc9SF9Mc7Xnbh/YjrR4uOUBAXMgA7WatgTwmq1m8vlrQZ/eG+T6cLFAVS
	 lnMAffo4jUvWd+mYeiLj9395rKyHQ552QhJMAgN1+LUWi6QbllnL/UIA3qGjpCG0ZK
	 OsaSaWMNxVpuRMtU6mkg2OtlPARdqPU4G84m2xE7xnivHNVUzN8IAtc+3uMxJb516b
	 qKVcLUfRRgBWZGFpN7XY9B4ZEXi2J77AIb0U72yjjpuLG4fppyPsmzOoLqiYLMtDAW
	 Y5UmGHOuls/fa+/aHraHP+o7U+zJ7WOiuSOZsmjn73YGfONYEOM5e8EIq98iob0Rkn
	 gPHpWpdzVh2eQ==
Date: Sun, 7 Jul 2024 17:31:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jun Yan
 <jerrysteve1101@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: accel: add ADXL380 driver
Message-ID: <20240707173139.349d4749@jic23-huawei>
In-Reply-To: <CA+GgBR89nOCwrGgU=fsS_+woj9mDeqR_hizZMjNgLtxoZ+pY=Q@mail.gmail.com>
References: <20240701083138.15891-1-antoniu.miclaus@analog.com>
	<20240701083138.15891-2-antoniu.miclaus@analog.com>
	<CA+GgBR89nOCwrGgU=fsS_+woj9mDeqR_hizZMjNgLtxoZ+pY=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


*grumpy*
Alexandru, crop out the irrelevant parts!
I initially only spotted the comma one due to too much scrolling.

Good to have your review though.

Jonathan



> > +#define ADXL380_FIFO_SAMPLES                   315UL
> > +
> > +enum adxl380_channels {
> > +       ADXL380_ACCEL_X,
> > +       ADXL380_ACCEL_Y,
> > +       ADXL380_ACCEL_Z,
> > +       ADXL380_TEMP,
> > +       ADXL380_CH_NUM,  
> 
> nitpick:  If ADXL380_CH_NUM is the number of channels, then a trailing
> comma is not needed.
> Fine to also leave it.
> > +static int adxl380_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +       struct adxl380_state *st = iio_priv(indio_dev);
> > +       int i;
> > +       int ret;
> > +
> > +       guard(mutex)(&st->lock);
> > +
> > +       ret = adxl380_set_measure_en(st, false);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = regmap_update_bits(st->regmap,
> > +                                st->int_map[0],
> > +                                ADXL380_INT_MAP0_FIFO_WM_INT0_MSK,
> > +                                FIELD_PREP(ADXL380_INT_MAP0_FIFO_WM_INT0_MSK, 1));
> > +       if (ret)
> > +               return ret;
> > +
> > +       for_each_clear_bit(i, indio_dev->active_scan_mask, ADXL380_CH_NUM) {  
> 
> Would this need to be?:
> for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength)
> 
> Or, is the logic intended to go over the cleared bits here?
> 
> Depending on what's needed here, this could make use of
> "iio_for_each_active_channel()" later.
> 
> 
> > +               ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN_REG,
> > +                                        ADXL380_CHAN_EN_MSK(i),
> > +                                        0 << (4 + i));
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
> > +                                         indio_dev->masklength);  
> 
> Depending on Nuno's series (and if that gets accepted first), this
> might need to use the new iio_get_masklength() wrapper.
> That's not a reason against this going in first though.

There will be a bunch of races with that, so I'm not worried if drivers
use it yet.  We'll fix them all up along with the existing cases before
taking the masklength private.

I have applied Nuno's initial series and some drivers that will need
converting today :)

...

> > +static int adxl380_write_raw(struct iio_dev *indio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            int val, int val2, long info)
> > +{
> > +       struct adxl380_state *st = iio_priv(indio_dev);
> > +       int odr_index, lpf_index, hpf_index, range_index;
> > +
> > +       switch (info) {
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               odr_index = adxl380_find_match_1d_tbl(st->chip_info->samp_freq_tbl,
> > +                                                     ARRAY_SIZE(st->chip_info->samp_freq_tbl),
> > +                                                     val);
> > +               return adxl380_set_odr(st, odr_index);
> > +       case IIO_CHAN_INFO_CALIBBIAS:
> > +               return adxl380_write_calibbias_value(st, chan->scan_index, val);
> > +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +               lpf_index = adxl380_find_match_1d_tbl(st->lpf_tbl,
> > +                                                     ARRAY_SIZE(st->lpf_tbl),
> > +                                                     val);
> > +               if (lpf_index < 0)
> > +                       return lpf_index;  
> 
> The way I see adxl380_find_match_1d_tbl(), it will never return negative.
> 
> > +               return adxl380_set_lpf(st, lpf_index);
> > +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > +               hpf_index = adxl380_find_match_2d_tbl(st->hpf_tbl,
> > +                                                     ARRAY_SIZE(st->hpf_tbl),
> > +                                                     val, val2);
> > +               if (hpf_index < 0)
> > +                       return hpf_index;
> > +               return adxl380_set_hpf(st, hpf_index);
> > +       case IIO_CHAN_INFO_SCALE:
> > +               range_index = adxl380_find_match_2d_tbl(st->chip_info->scale_tbl,
> > +                                                       ARRAY_SIZE(st->chip_info->scale_tbl),
> > +                                                       val, val2);
> > +               if (range_index < 0)
> > +                       return range_index;
> > +               return adxl380_set_range(st, range_index);
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
>

> > +int adxl380_probe(struct device *dev, struct regmap *regmap,
> > +                 const struct adxl380_chip_info *chip_info)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct adxl380_state *st;
> > +       int ret;
> > +
> > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st = iio_priv(indio_dev);
> > +
> > +       st->dev = dev;
> > +       st->regmap = regmap;
> > +       st->chip_info = chip_info;
> > +
> > +       mutex_init(&st->lock);
> > +
> > +       indio_dev->channels = adxl380_channels;
> > +       indio_dev->num_channels = ARRAY_SIZE(adxl380_channels);
> > +       indio_dev->name = chip_info->name;
> > +       indio_dev->info = &adxl380_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +       ret = devm_regulator_get_enable(dev, "vddio");
> > +       if (ret)
> > +               return dev_err_probe(st->dev, ret,
> > +                                    "Failed to get vddio regulator\n");
> > +
> > +       ret = devm_regulator_get_enable(st->dev, "vsupply");
> > +       if (ret)
> > +               return dev_err_probe(st->dev, ret,
> > +                                    "Failed to get vsupply regulator\n");
> > +
> > +       st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT0");
> > +       if (st->irq > 0) {
> > +               st->int_map[0] = ADXL380_INT0_MAP0_REG;
> > +               st->int_map[1] = ADXL380_INT0_MAP1_REG;
> > +       } else {
> > +               st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> > +               if (st->irq > 0)
> > +                       return dev_err_probe(dev, -ENODEV,
> > +                                            "no interrupt name specified");
> > +               st->int_map[0] = ADXL380_INT1_MAP0_REG;
> > +               st->int_map[1] = ADXL380_INT1_MAP1_REG;
> > +       }  
> 
> Would it make sense fo this interrupt-register setup to go into
> "adxl380_config_irq()"?
> 
> > +
> > +       ret = adxl380_setup(indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
> > +                                             &adxl380_buffer_ops,
> > +                                             adxl380_fifo_attributes);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}

