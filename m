Return-Path: <linux-iio+bounces-17955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2AA86204
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D87B7B8CA1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C3213230;
	Fri, 11 Apr 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzfPPM4b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BF1F76C2;
	Fri, 11 Apr 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385851; cv=none; b=ZXa/0ZRrsM48cx0X4eswlEHKIY7eltKGQWr00drxFqoENz6Q/f3Nh5jXhnTuYR755N3iefhD/time4c3/enpuDjKcx4yd+xfak1DDarVvPvuKWtiK7fy+4/m0bd/XyPHRYCn+EJFuz3SnjAC8c8G25PVpTF6rh/4q+czjpspDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385851; c=relaxed/simple;
	bh=5VxdU/rSxHU0t9EQpSyVvZexEkOwAG+5gBxXTPd8FZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4XvPqpBpTEc1ZLXgrhK+A6X9dMgNj/CZMLqbyj36YtBQhE7rCUp0AFel7qE/NSUyEpJ3sVr7mpLRtFsMSVI4FG8/4xYZQ5nCsKJ7zrTsZZ2+fN86uQWGo5mOnyK1UOUycyfwpJLM1uP8TxBWwqq1UkmL0EVXNrZfL9KhPaE7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzfPPM4b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2254e0b4b79so29964775ad.2;
        Fri, 11 Apr 2025 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744385849; x=1744990649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8oJ38+bzCClEmTkKVKJo14Ldf4qWopdR6LpZVrHlIg=;
        b=SzfPPM4b0ib5llOmYtWbzixPwvGeFVi6g5luMnARFBU6n8/+YgctPO7Yy/d4z2hgEk
         VSgaVLGe3tkVfV2q+/L9U+v9wBF86xf29taxPYbLtNz1qaK2YJYz2H+30SraNcq6OZRe
         c5cJmvdSx/PmeqOO1PcJDXnqyXJo8GNu6T61vdsGL6hhvzebYnvB6//q0r8XNXErMsgq
         IIhcoDAU78oXbPANUuhroRYXWlNBc21OQTcxMzcT1LA07dC5bK1tmJzhMGLJ4EEYSKUJ
         5bh4F+t1jC8a5wAlq9n1SNTQuu/nBD64J0apLkuqyZY9e0aDPwQypwxUi1Guuv2I+hjz
         yw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744385849; x=1744990649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8oJ38+bzCClEmTkKVKJo14Ldf4qWopdR6LpZVrHlIg=;
        b=wApUvIfnWswA16xgCRkmTAnADP1OV2Be+/ToK1S7eHgj529cdMbo1ZaFJ4vuU1A+Fj
         4EtHq7KT4hWvoclII6zO26T+HklixPdNIL6xa2Cgu1fbKx+bfefAojp5rCGQCDRefIwm
         qWgtxSa4Jmo2dJTqSDrbw9mlrXq3g4Lh5quSYOVS9E29WYV0FeSiIQnvZh8eVawsV438
         e1fpuHiUe21BqkeTRuYHGWTevZ5huyvTgcfqSU0xYIVO0mBOGsYIeIMsXd1nGg/UiTql
         Uc0XedWNx6zGtyu3jzpHmP9KOxbOnB6q0KLTeuiahEjEd+CEQJWVxfjY/19g/9Al/Nsf
         bMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUajDeCFshQELca5ktNReEH6liZi7fev3ukSst7BD6s9nxIQGV4CuNMzChwZFa+SFv5hADpoRmmv4/4@vger.kernel.org, AJvYcCVWOT6lrGSPPhQSXLDLZ27xvLUD6fOitUTyHXh7j99dajDkE5Y3ySpZnRgLan1MlnlkxKpCfBBIz85+Mq1Q@vger.kernel.org, AJvYcCW7Q3jBEFca3/xFxbugMnCJRWOzSjZBp+C1LFjDXRcKPmcuJbmT0qpN+E4DP8QzwMKle6eyEQoxR0l1@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/AQiXoicwmdfZaT2G79nAG7uhyirDTetTcahCn/35dLKKQnw
	uhsF+q4oylagVtfy7feNm6R+Dh2hqPRWsPpeau4do2nos9Ti9mch
X-Gm-Gg: ASbGncviiqUMgZtgMnnqYMv5t/5u+msMmicaqQeCF9qvPFNwcyNh5itwgJW6s7Nswkg
	jXMzNYMN8nbo/G5C8BjKzXYZT16d3tOpKHr7RDf8NmhXOmJZ8N9dpnsgtu3KZwj9VE5puRQjISg
	4J72QtpG9zfFYiUppcT64CWg1EpfT2GhFmel3hTx9zoOPY4Wwm9Ru8HbmS6HcJ2BjG4ippQ6k5S
	WcNNlWPqIOhHunjRKTji8JVOnGn9q2Sp+UJ+sXQsBv6+AmAr9xsHmyNID0Gis+Qya/gbRsgGxvC
	/xRQe4nLv9SBoprUvcmuxaTaz2hXDdsUNGg4tRyKSJix/mmz0g==
X-Google-Smtp-Source: AGHT+IH2PTxTwVpsgdmDoRgm8ZDIR6GhIwUrKLCgS77GF45jETvsyEGJf7eYtId4Sp/Kl5ikZjehOw==
X-Received: by 2002:a17:902:ebc1:b0:224:13a4:d61e with SMTP id d9443c01a7336-22bea4fea1emr47841635ad.51.1744385849108;
        Fri, 11 Apr 2025 08:37:29 -0700 (PDT)
Received: from localhost ([2804:30c:979:8400:d3a1:d5f7:94ea:b576])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd22f10f4sm1667010b3a.113.2025.04.11.08.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:37:28 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:38:35 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
Message-ID: <Z_k3e1DfxmcJgQeu@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
 <9c115086bd574b6c778a093143ebf54e14d7202b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c115086bd574b6c778a093143ebf54e14d7202b.camel@gmail.com>

Hi Nuno, thank you for your review.
I've already applied most of your suggestions.
Also providing answers to some questions inline.

Thanks

On 04/10, Nuno Sá wrote:
> Hi Marecelo,
> 
> First, superficial look...
> 
> On Wed, 2025-04-09 at 09:24 -0300, Marcelo Schmitt wrote:
> > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > 
> > Add support for the AD4170 ADC with the following features:
> > - Single-shot read.
> > - Analog front end PGA configuration.
> > - Digital filter and sampling frequency configuration.
> > - Calibration gain and offset configuration.
> > - Differential and pseudo-differential input configuration.
> > 
> > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
...
> > +	ret = ad4170_set_channel_enable(st, chan->address, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	reinit_completion(&st->completion);
> 
> I would do the above right before wait_for_completion_timeout()...

Ack. Changed accordingly.

...
> > +
> > +	setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
> > +	setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
> > 
> 
> ditto...

Ack.

...
> > +static int ad4170_set_channel_freq(struct ad4170_state *st,
> > +				   struct iio_chan_spec const *chan, int val,
> > +				   int val2)
> > +{
...
> > +
> > +	old_filter_fs = setup->filter_fs;
> > +	if (f_type == AD4170_SINC5)
> > +		setup->filter_fs = ad4170_sinc5_filt_fs_tbl[i];
> > +	else
> > +		setup->filter_fs = ad4170_sinc3_filt_fs_tbl[i];
> > +
> > +	guard(mutex)(&st->lock);
> 
> Shouldn't the lock also protect the 'setup' struct?

Good catch. Changed to acquire the lock before reading and updating the setup in
all places.

...
> > +static int ad4170_parse_reference(struct ad4170_state *st,
> > +				  struct fwnode_handle *child,
> > +				  struct ad4170_setup *setup)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	int ret;
> > +	u8 aux;
> > +
> > +	/* Positive reference buffer setup */
> > +	aux = AD4170_REF_BUF_PRE; /* Default to have precharge buffer enabled. */
> > +	ret = fwnode_property_read_u8(child, "adi,buffered-positive", &aux);
> > +	if (ret) {
> 
> Shouldn't this be if (!ret)?
> 
Yes, fixed for all off adi,buffered-positive/negative, adi,reference-select.
Thanks.

> > +		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Invalid adi,buffered-positive:
> > %u\n",
> > +					     aux);
> > +	}
> > +	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);
> > +
> > +	/* Negative reference buffer setup */
> > +	aux = AD4170_REF_BUF_PRE; /* Default to have precharge buffer enabled. */
> > +	ret = fwnode_property_read_u8(child, "adi,buffered-negative", &aux);
> > +	if (ret) {
> 
> ditto
Ack

> 
> > +		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Invalid adi,buffered-negative:
> > %u\n",
> > +					     aux);
> > +	}
> > +	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_M_MSK, aux);
> > +
...
> > +
> > +static int ad4170_parse_adc_channel_type(struct device *dev,
> > +					 struct fwnode_handle *child,
> > +					 struct iio_chan_spec *chan)
> > +{
> > +	u32 pins[2];
> > +	int ret;
> > +
> > +	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> > +					     ARRAY_SIZE(pins));
> > +	if (!ret) {
> > +		chan->differential = true;
> > +		chan->channel = pins[0];
> > +		chan->channel2 = pins[1];
> > +		return 0;
> > +	}
> > +	ret = fwnode_property_read_u32(child, "single-channel", &pins[0]);
> > +	if (!ret) {
> > +		chan->differential = false;
> > +		chan->channel = pins[0];
> > +
> > +		ret = fwnode_property_read_u32(child, "common-mode-channel",
> > +					       &pins[1]);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +				"single-ended channels must define common-mode-
> > channel\n");
> > +
> > +		chan->channel2 = pins[1];
> > +		return 0;
> > +	}
> 
> Kind of a nitpick but for the above I would flip the logic. First check for errors in
> the single-channel case and then you can have one less of level of indentation...

Okay, will do it.
> 
> > +	return dev_err_probe(dev, ret,
> > +		"Channel must define one of diff-channels or single-channel.\n");
> > +}
> > +
...
> > +
> > +	ret = fwnode_property_read_u32(child, "reg", &ch_reg);
> > +	if (ret)
> > +		return ret;
> > +
> 
> Could also deserve a log message?

Sure, added.

> 
> > +	if (ch_reg >= AD4170_MAX_CHANNELS)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Channel idx greater than no of channels\n");
> > 
> 
> ...
...
> > +
> > +	return request_irq(st->spi->irq, &ad4170_irq_handler, IRQF_ONESHOT,
> > +			   indio_dev->name, indio_dev);
> 
> devm_request_irq()...
> 
Done.

> > +}
> > +
> > +static int ad4170_regulator_setup(struct ad4170_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	int ret;
> > +
> > +	/* Required regulators */
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to get AVDD voltage.\n");
> > +
> > +	st->vrefs_uv[AD4170_AVDD_SUP] = ret;
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "iovdd");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to get IOVDD voltage.\n");
> > +
> > +	st->vrefs_uv[AD4170_IOVDD_SUP] = ret;
> > +
> > +	/* Optional regulators */
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "avss");
> > +	if (ret < 0 && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "Failed to get AVSS voltage.\n");
> > +
> > +	/* Assume AVSS at GND (0V) if not provided */
> > +	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin1p");
> > +	if (ret < 0 && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "Failed to get REFIN+ voltage.\n");
> > +
> > +	st->vrefs_uv[AD4170_REFIN1P_SUP] = ret;
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin1n");
> > +	if (ret < 0 && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "Failed to get REFIN- voltage.\n");
> > +
> > +	/* Negative supplies are assumed to provide negative voltage */
> > +	st->vrefs_uv[AD4170_REFIN1N_SUP] = ret == -ENODEV ? -ENODEV : -ret;
> 
> Maybe to early for me but the comment does not make it clear to me why the negation?
> Won't the regulator return a negative voltage?

devm_regulator_get_enable_read_voltage(), regulator_get_voltage(), and anything
about reading the regulator voltage returns either a positive voltage value or
a negative error code. I couldn't find out how to read a negative voltage with
regulator API. So, for now, this is making the simplifying assumption that
the negative end of external reference supplies is always below GND level (even
though they could be positive).

...
> > +
> > +	st = iio_priv(indio_dev);
> > +	devm_mutex_init(dev, &st->lock);
> 
> check for errors...
> 
Ack, done.

> > +
...
> > +	st->regmap24 = devm_regmap_init_spi(spi, &ad4170_regmap24_config);
> > +	if (IS_ERR(st->regmap24))
> > +		return dev_err_probe(dev, PTR_ERR(st->regmap24),
> > +				     "Failed to initialize regmap24\n");
> > +
> 
> Hmm, interesting idea... but I would expect an explanation on why can't we have bulk
> reads for the 16 and 24 bit cases? Without it, I have to ask why not?

Not sure how regmap_bulk_read() handles it from a quick look but CS can't be
taken high between multibyte register access. Anyway, will check out if that
can be used here.

>  
...
> > +
> > +	if (spi->irq) {
> > +		ret = ad4170_trigger_setup(indio_dev);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to setup
> > trigger\n");
> 
> Typically it's better to log the errors inside ad4170_trigger_setup() unless you use
> it outside probe.

Ack.

> 
> - Nuno Sá
> > 

Thanks,
Marcelo

