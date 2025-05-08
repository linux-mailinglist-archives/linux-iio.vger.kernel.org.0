Return-Path: <linux-iio+bounces-19277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28AAAF697
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759FB5000CD
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5200263C68;
	Thu,  8 May 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ROgpOU2S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B72F43
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695860; cv=none; b=cjXm0/aRgEcKZh3j2pNyJU2cfpbrFyNtVFbLy6eYFG9Lh6npvIaqsJEJQ0qhwYq3W2n0mg7n97wM2wBlKEZkTELVUMrj6ahe7wa9e2sy9nKsAngp+EvgJrYcq+vNqBRXbmmvDMnGQ03XBVv6mzB0Y+DiAyNROPBnUsTkM/a45tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695860; c=relaxed/simple;
	bh=hASGQaxXpiY5FHVtp3EgMQ6Y/NJAsNGG/hzPVZj9HMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL8gyRm0erHdL0xh/oTmwv23oScMye0jvftGz5ob8TllmFdiPwKHo27z/wMybYHQQbNhKrU4H3P+mxzAGl3L6xcWxGbjGDZ484iMIMZzMX2OxVHHRU+QuRaxinqjNaHOFY8UsmoTru+sSH8i+Xkk9/Gw7cjYZcNpLknDKXSqw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ROgpOU2S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so623518f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746695854; x=1747300654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BF1WFSYzy6unIRUXzEpd/eRhMY+e6oBnTujYR6+ffP4=;
        b=ROgpOU2Sz+LbA9BpU+SgekuRNd/eYVVJwu5n/efwodhpbp1GFyYe+nP+OAxA5rnLdJ
         iQ2TN9Yu5bHelFqd0PWtv3KRU3Cy0HaqPWtL+hTk1DVEr3zF5mVBJKzy1l6nz7yY7/VQ
         82LUpCI617nOLl/ER1K/LdZBEdJ8o2e/Y28zUttWahi5hkAXG0nndlFEZgMQRm4EXjvy
         E68U4rQgvwwSSWmfoXE7RaYvojmKPmkIqI0Knnpbf9XMohoOQJhJzfw8Ki4cm3ApAw00
         qfKdVEIpJLN4RI9k38/xYeZ1hVMR58q9yZbeaHgsKU1gZFh5IqOiKl7P+e+LutXhDxpJ
         j54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746695854; x=1747300654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BF1WFSYzy6unIRUXzEpd/eRhMY+e6oBnTujYR6+ffP4=;
        b=TdSWSbk6/4B6/f7GuGO3Xa1lwhkYmPIrXE4NjrsUzFNg3nJNBQ5x+MVnExhMIrcOeM
         5doJr1CKcgtKdVI+kmHtTCpX6/IFYkQFv3zT8F1TO7FvvIOdMjt++4EuC73bGlBIARrW
         k2T6oMFSLznPNyDSbLRD8kaPDGFZGa8CTwXIlYXSMnRbiKEh8ElMGx3nwjtUHguLYLt4
         CM89LIRmMAvHPjQ6ZdgCDC/PrgGoExf1kodORo5bRJT3jD9N7ISutBpzavHgb7f/b7+p
         dRyOq/+OWGhCsC6eYBIdZkyrAJFNkL/ClJzgeBOdyySXQsDPEZb7AS1TDpIN1UkwcakU
         HQBA==
X-Forwarded-Encrypted: i=1; AJvYcCWssuT85q5rxhR9fH+Gb1Fp5ZqbZgc65rJt/WdB24L6pUoI0H16/qDqEv37nkOZngYoLO+uxSFc56E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAaqWTnHz0SFGRJrj1LsfPRqf67Pu7AEHaz3s2BXjt3CDhNGn
	XdqnQhhrxAItVvlMMBlE7g9SLKby/1SGx5zHCAmJKP2h3el1+YICXsxqxrG+Ovs=
X-Gm-Gg: ASbGncuph1i4vCXRbrO3/OrfHmEpbjqTCKJU1VEtKnl4vOY1wPkow6mjs8SyUDIZP4s
	MNOMK5pRi/N5jGwjroPQZZEYwhOxe7irgKNj9siU/pZbqIO6x5UDws53xyE8pVlywiElO1ktrnJ
	J4EskY191iBc5SHjtF3jtjPAn0yiWusfRySw1f+X3KPYzNNjUp+UMb+08KPrfpokVSEA8SHXoKp
	av3ihluYditAVy+B8QEy4FnX2bHg69lcYAUJqP1cwCX4LmgKmImn/K7Q/SFJqC6iDAC9Q4edqDZ
	w1hg3/J9b7/1ib61xjfl+jsZSVemS2v2q7w/csGsx0Y3DK1A2z2Kw97FgVNUrfJ26bephYaY/FZ
	zWElS84ZhkK3shtIEVQ==
X-Google-Smtp-Source: AGHT+IHmUlWs7sWnu8sNqCM7w1Ovbo7chcDANaOLySE8KJF9TX6KqKSbMi5HVBx/UBaB7+ICOj4c0Q==
X-Received: by 2002:a05:6000:178c:b0:39e:cbc7:ad38 with SMTP id ffacd0b85a97d-3a0b49bc923mr5220023f8f.32.1746695853692;
        Thu, 08 May 2025 02:17:33 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0ebf11bffsm495167f8f.20.2025.05.08.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 02:17:33 -0700 (PDT)
Date: Thu, 8 May 2025 11:16:19 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <qaiqdak4pieewavl2ff4mpr2ywhw2bvnoob55buiinkisacar5@q6jhlb5klcf6>
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
 <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
 <c999800bb5f6c1f2687ff9b257079dcf719dd084.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c999800bb5f6c1f2687ff9b257079dcf719dd084.camel@gmail.com>

Hi all,
On 07.05.2025 07:14, Nuno Sá wrote:
> On Tue, 2025-05-06 at 23:03 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add gain calibration support, using resistor values set on devicetree,
> > values to be set accordingly with ADC external RFilter, as explained in
> > the ad7606c-16 datasheet, rev0, page 37.
> > 
> > Usage example in the fdt yaml documentation.
> > 
> > Tested-by: David Lechner <dlechner@baylibre.com>
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7606.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iio/adc/ad7606.h |  4 ++++
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index
> > a986eb1284106da4980ac36cb0b5990e4e3bd948..049fd8616769d32778aa238b348b2fb82fa83745
> > 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -33,6 +33,10 @@
> >  
> >  #include "ad7606.h"
> >  
> > +#define AD7606_CALIB_GAIN_MIN	0
> > +#define AD7606_CALIB_GAIN_STEP	1024
> > +#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
> > +
> >  /*
> >   * Scales are computed as 5000/32768 and 10000/32768 respectively,
> >   * so that when applied to the raw values they provide mV values.
> > @@ -125,6 +129,8 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
> >  				   struct iio_chan_spec *chan);
> >  static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
> >  static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
> > +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> > +					struct iio_chan_spec *chan);
> >  
> >  const struct ad7606_chip_info ad7605_4_info = {
> >  	.max_samplerate = 300 * KILO,
> > @@ -180,6 +186,7 @@ const struct ad7606_chip_info ad7606b_info = {
> >  	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
> >  	.sw_setup_cb = ad7606b_sw_mode_setup,
> >  	.offload_storagebits = 32,
> > +	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
> >  	.calib_offset_avail = ad7606_calib_offset_avail,
> >  	.calib_phase_avail = ad7606b_calib_phase_avail,
> >  };
> > @@ -195,6 +202,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
> >  	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
> >  	.sw_setup_cb = ad7606b_sw_mode_setup,
> >  	.offload_storagebits = 32,
> > +	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
> >  	.calib_offset_avail = ad7606_calib_offset_avail,
> >  	.calib_phase_avail = ad7606c_calib_phase_avail,
> >  };
> > @@ -246,6 +254,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
> >  	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
> >  	.sw_setup_cb = ad7606b_sw_mode_setup,
> >  	.offload_storagebits = 32,
> > +	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
> >  	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
> >  	.calib_phase_avail = ad7606c_calib_phase_avail,
> >  };
> > @@ -357,6 +366,49 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev,
> > int ch,
> >  	return 0;
> >  }
> >  
> > +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> > +					struct iio_chan_spec *chan)
> > +{
> > +	struct ad7606_state *st = iio_priv(indio_dev);
> > +	unsigned int num_channels = st->chip_info->num_adc_channels;
> > +	struct device *dev = st->dev;
> > +	int ret;
> > +
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		u32 reg, r_gain;
> > +

working on further features, i noticed this function is called
for each channel, that is not correct, so need to fix this,
will send a v4.

Regards,
angelo

> > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* channel number (here) is from 1 to num_channels */
> > +		if (reg < 1 || reg > num_channels) {
> > +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> > +			continue;
> > +		}
> > +
> 
> Sorry Angelo, just realized this now. Any reason for not treating the above as a real
> invalid argument? It's minor and not a big deal but odd enough...
> 
> - Nuno Sá
> 
> > +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> > +					       &r_gain);
> > +		if (ret == -EINVAL)
> > +			/* Keep the default register value. */
> > +			continue;
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (r_gain > AD7606_CALIB_GAIN_MAX)
> > +			return dev_err_probe(st->dev, -EINVAL,
> > +					     "wrong gain calibration value.");
> > +
> > +		/* Chan reg is 1-based index. */
> > +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> > +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
> >  					  struct iio_chan_spec *chan)
> >  {
> > @@ -1410,6 +1462,10 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
> >  				chan->info_mask_separate_available |=
> >  					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> >  					BIT(IIO_CHAN_INFO_CONVDELAY);
> > +				ret = st->chip_info->calib_gain_setup_cb(
> > +					indio_dev, chan);
> > +				if (ret)
> > +					return ret;
> >  			}
> >  
> >  			/*
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index
> > f613583a7fa4095115b0b28e3f8e51cd32b93524..94165d217b69d54cbce9109b8c0f9dc0237cf304
> > 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -50,6 +50,8 @@ struct ad7606_state;
> >  typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> >  				       struct iio_chan_spec *chan);
> >  typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
> > +typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev,
> > +					    struct iio_chan_spec *chan);
> >  
> >  /**
> >   * struct ad7606_chip_info - chip specific information
> > @@ -66,6 +68,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
> >   * @init_delay_ms:	required delay in milliseconds for initialization
> >   *			after a restart
> >   * @offload_storagebits: storage bits used by the offload hw implementation
> > + * @calib_gain_setup_cb: callback to setup of gain calibration for each channel
> >   * @calib_offset_avail: pointer to offset calibration range/limits array
> >   * @calib_phase_avail:  pointer to phase calibration range/limits array
> >   */
> > @@ -81,6 +84,7 @@ struct ad7606_chip_info {
> >  	bool				os_req_reset;
> >  	unsigned long			init_delay_ms;
> >  	u8				offload_storagebits;
> > +	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
> >  	const int			*calib_offset_avail;
> >  	const int			(*calib_phase_avail)[2];
> >  };
> > 
> 

