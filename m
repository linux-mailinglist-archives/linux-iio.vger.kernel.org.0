Return-Path: <linux-iio+bounces-10612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5199E3B1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3953284603
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3411E379B;
	Tue, 15 Oct 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F0CGa9XS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8E1E1C33
	for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987684; cv=none; b=fSoNC/7DNctORJElYtO59AypLJcazFgl1e7WRkDc3HBc+1yn74yW0LIM0abD5J0zqTxq/ShiUVTnEQDdlNmIoLYS1xMltmEic9upwHlGJPJ/56D9zaKgnlIwadiE7Ilkcyuq/NRu6zRLCNupc536bKf5wPrhtSdHZ5b6kVq7Nlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987684; c=relaxed/simple;
	bh=QHzH9gX47vqZQCSrLRJNczhGJC6EsYu8VtUChrDwVBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSmt7HNzKV/0yUgz6UfaemCQoj8RF48dNVt+5g2iAxExYAALU2bzlQpglVx64dEXeuSoVHruAp3GnsLyohaj34Du5+uAL16jG6o3EigYWgVfyZbcDPtqtIo0obNGiVlDxzrjcEI0F3r6qBR0DhmfLRzl+iKF4ZDfxLkQQojbEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F0CGa9XS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-430558cddbeso35171225e9.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728987679; x=1729592479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v05gWAINOJTX3TwCq1/mdOPDGzBQZLV6r8oB7yz7mow=;
        b=F0CGa9XSEZkmrz15ZADrhGX65BVro9IvUh4CYG7iIghpO6Q6hqUf0/aIMUx7TfMTnH
         mtUCqhRHALrWqit3eWjgaCSP9sXZV4kA8Fo/9emPtiri8sSEKOMvMm6bjL9/+BApL1bZ
         KD6TS7Vs8vGBiW5Oy3NM32COxqAhI90tMi1gWDhkPh3omOgHDcJNgg1OIcLOcP8AK79V
         FrO96PFSqcmTZAVKZRKEBnjtalO6O+LXYk36hIf7Hk2eFNjLj0tEs0/RAgbASLKdNXfR
         onMg4WDdNJTEgbvtNnMA6Xc0NS/n5JjAeQVXs+5gM1mRkShYQE8RCCraypfpX03Bkiua
         nw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987679; x=1729592479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v05gWAINOJTX3TwCq1/mdOPDGzBQZLV6r8oB7yz7mow=;
        b=Z9P6skVsCcqtlLsLP0pgbMRUkwO4yZXDdl/gPJEHNxvs4kuorwOMxHIwsoFxdW5BII
         7dTzbXK/muFo0Kt1UMHGvWIioL6sAw4UPBAYxhO4Z5K0Vx6AzDbRCbUIk0wCxR+u7nB5
         B2rvCQ6vKgRqFRTNTbkB0QA5zoAM8lnYM/I2GpPQRiJXp6GW3T+rlR5PP/QsO+E2+8Jr
         JvhQyLYf6iKSx/IKWBrDZ+WQKEtfb+krjUGQbiBCPrwnV8Dt8lLLqdrLGnzl7YKX8/vQ
         X5vfVvn/yI1JJbD0PGAykTgpISDxA6wQ5pOnqgJHJTjCayZYzS6Mqq0skPBxtMvkScer
         9hpA==
X-Forwarded-Encrypted: i=1; AJvYcCUA8/Nz99+Qc0x3lllA1+KtVWSYUeNH/wovuES5zv5S3JMelxCkGxuYcAyYDJ8W41L/TkxI8Oz3+5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmdlMqVZTmjLlMukJLoKdFS6uBjLs896Zt5BUDJuCKzI3Chw4
	jwG0EDGZWesCMcxfVSiiQRzO3c1cSBWr6qSdtImWuamw2x6lkAtTuHmgqs2FTUc=
X-Google-Smtp-Source: AGHT+IHZBW2Rb0ZD+hSfjIHtvdaBVryFjjdjaPKxwoZTiEs71uPFQXpM0e6jlMPTFWbYBhslFUGggw==
X-Received: by 2002:a05:600c:4e8e:b0:430:4db2:2b88 with SMTP id 5b1f17b1804b1-4311d891c4cmr111126315e9.5.1728987679099;
        Tue, 15 Oct 2024 03:21:19 -0700 (PDT)
Received: from dfj (host-79-50-238-21.retail.telecomitalia.it. [79.50.238.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a1c8sm1179630f8f.21.2024.10.15.03.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:21:18 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:19:50 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
Message-ID: <wfp4hao3zbmm7tfkcur6ximzsuzhp2e2jeyq4emybhaxfhtyfk@r4x26gmik6v4>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-5-eeef0c1e0e56@baylibre.com>
 <161aa7f4-299d-4486-92ad-3f3eab2f2979@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161aa7f4-299d-4486-92ad-3f3eab2f2979@baylibre.com>

On 14.10.2024 16:14, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> > is removed. Variables (arrays) that was used to call ad3552r_field_prep
> > are removed too.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> Found one likely bug. The rest are suggestions to keep the static
> analyzers happy.
> 
> 				\
> > @@ -510,8 +416,14 @@ static int ad3552r_write_raw(struct iio_dev *indio_dev,
> >  					val);
> >  		break;
> >  	case IIO_CHAN_INFO_ENABLE:
> > -		err = ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
> > -					   chan->channel, !val);
> > +		if (chan->channel == 0)
> > +			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(0), !val);
> > +		else
> > +			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(1), !val);
> 
> In the past, I've had bots (Sparse, IIRC) complain about using !val
> with FIELD_PREP. Alternative is to write it as val ? 1 : 0.
> 
> > +
> > +		err = ad3552r_update_reg_field(dac, AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> > +					       AD3552R_MASK_CH_DAC_POWERDOWN(chan->channel),
> > +					       val);
> >  		break;
> >  	default:
> >  		err = -EINVAL;
> > @@ -715,9 +627,9 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
> >  	}
> >  
> >  	return ad3552r_update_reg_field(dac,
> > -					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
> > -					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
> > -					val);
> > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > +					AD3552R_MASK_ADDR_ASCENSION,
> > +					FIELD_PREP(AD3552R_MASK_ADDR_ASCENSION, val));
> >  }
> >  
> >  static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32 *v_min,
> > @@ -812,20 +724,20 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
> >  				     "mandatory custom-output-range-config property missing\n");
> >  
> >  	dac->ch_data[ch].range_override = 1;
> > -	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
> >  
> >  	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
> >  	if (err)
> >  		return dev_err_probe(dev, err,
> >  				     "mandatory adi,gain-scaling-p property missing\n");
> > -	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, val);
> >  	dac->ch_data[ch].p = val;
> >  
> >  	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
> >  	if (err)
> >  		return dev_err_probe(dev, err,
> >  				     "mandatory adi,gain-scaling-n property missing\n");
> > -	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, val);
> >  	dac->ch_data[ch].n = val;
> >  
> >  	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> > @@ -841,9 +753,9 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
> >  	dac->ch_data[ch].gain_offset = val;
> >  
> >  	offset = abs((s32)val);
> > -	reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, (offset >> 8));
> 
> Can drop () from (offset >> 8).
> 
> >  
> > -	reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)val < 0);
> 
> Instead of (s32) cast, could write val < 0 : 1 : 0 (to be consistent with
> suggestion above for replacing !val).
> 
> >  	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
> >  	err = ad3552r_write_reg(dac, addr,
> >  				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
> > @@ -886,9 +798,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
> >  	}
> >  
> >  	err = ad3552r_update_reg_field(dac,
> > -				       addr_mask_map[AD3552R_VREF_SELECT][0],
> > -				       addr_mask_map[AD3552R_VREF_SELECT][1],
> > -				       val);
> > +				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > +				       AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> > +				       FIELD_PREP(AD3552R_MASK_REFERENCE_VOLTAGE_SEL, val));
> >  	if (err)
> >  		return err;
> >  
> > @@ -900,9 +812,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
> >  		}
> >  
> >  		err = ad3552r_update_reg_field(dac,
> > -					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
> > -					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
> > -					       val);
> > +					       AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +					       AD3552R_MASK_SDO_DRIVE_STRENGTH,
> > +					       FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, val));
> >  		if (err)
> >  			return err;
> >  	}
> > @@ -938,9 +850,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
> >  						     "Invalid adi,output-range-microvolt value\n");
> >  
> >  			val = err;
> > -			err = ad3552r_set_ch_value(dac,
> > -						   AD3552R_CH_OUTPUT_RANGE_SEL,
> > -						   ch, val);
> > +			if (ch == 0)
> > +				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), val);
> > +			else
> > +				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), val);
> > +
> > +			err = ad3552r_update_reg_field(dac,
> > +						       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> > +						       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> > +						       val);
> >  			if (err)
> >  				return err;
> >  
> > @@ -958,7 +876,14 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
> >  		ad3552r_calc_gain_and_offset(dac, ch);
> >  		dac->enabled_ch |= BIT(ch);
> >  
> > -		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> > +		if (ch == 0)
> > +			val = FIELD_PREP(AD3552R_MASK_CH(0), 1);
> > +		else
> > +			val = FIELD_PREP(AD3552R_MASK_CH(1), 1);
> > +
> > +		err = ad3552r_update_reg_field(dac,
> > +					       AD3552R_REG_ADDR_CH_SELECT_16B,
> > +					       AD3552R_MASK_CH(ch), val);
> >  		if (err < 0)
> >  			return err;
> >  
> > @@ -970,8 +895,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
> >  	/* Disable unused channels */
> >  	for_each_clear_bit(ch, &dac->enabled_ch,
> >  			   dac->model_data->num_hw_channels) {
> > -		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
> > -					   ch, 1);
> > +		if (ch == 0)
> > +			val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), 1);
> > +		else
> > +			val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), 1);
> 
> Should these be AD3552R_MASK_CH_AMPLIFIER_POWERDOWN instead of
> AD3552R_MASK_CH_OUTPUT_RANGE_SEL? (2 above and 1 below.)
>
Hi David,
thanks, probably a copy and paste issue.
Fixed.

Not changing anything else since otherwise an additional patch
for style changes should be needed.
 
> > +
> > +		err = ad3552r_update_reg_field(dac,
> > +					       AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> > +					       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> > +					       val);
> >  		if (err)
> >  			return err;
> >  	}
> > 
> 

