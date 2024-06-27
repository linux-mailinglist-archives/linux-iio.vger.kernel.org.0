Return-Path: <linux-iio+bounces-6996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8991B2D1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 01:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB5F1F2293A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E071A38C9;
	Thu, 27 Jun 2024 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNUrCQXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36631A0B1F;
	Thu, 27 Jun 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531170; cv=none; b=rM+nD+2/hHxSMSley+AUlRNCsqkBTVie1ncepzLMfWuzm8gSLyeSShlzT44fgP5fEPVmUXwCNtXDlnNuG3icwlZrG3NsTsDj0+SBPKR1kHYDsiCrS25PbTV9pVfPKATf7QxJSbKX787f3fDbxzzWToUsgszUdKpFjpq/WKvHBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531170; c=relaxed/simple;
	bh=sXezY+/7uKTXx3q/yWeaJ9K8BDVli7vQfxaBwyaNyoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghM0IH68jptbilHHWKJ37QVQUaDYUp+uA7ziDOmzKj3VFN8DYMFKX9sXZl6/EQ+pWOuIGjx0OlJLMqTILGZaVJugWyeP8BF1O42DSbejMqHc4FcZ+Gvio7mJdvBBjAs06ANyOEWQYRE2dwD+a46nxo2wvKHjDsq/P2BKTN8llz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNUrCQXq; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d566d5eda9so32719b6e.0;
        Thu, 27 Jun 2024 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719531168; x=1720135968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7Uk06ideyFTn+vYbPSwBqzjxgu55IGQgO2e4zr/Jb8=;
        b=gNUrCQXqolaZKpt1tRiIcdntXcStX/gNukMpDikkq0d8yHzN3XZUCO4HgIAcRwz3RE
         NrNUolUY2MEuU3kYOxG3iBWAQG5y+/sWvYvXnKvcV1ThAr+zuVfgkzlqd3hateqqqqCZ
         MfQZa/JwwIctWDJ+XzaqqeaJooKOQj+Vu8kw7m/wBxDjT2L+H5IasvSW0qjFUsc220sm
         w2xEw69e6l3MoXOI5EWdHQ2rklir+VT23ODG+KgY+rZiJ0Rw/dwKn+06Qm6KW487k8AE
         A2eD+R/X1jq9t5YZKhL499TQzkCCoNlbi4ndmz8PF/EPV45uV++lxwNw2HEpWX8N8OAT
         G66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719531168; x=1720135968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Uk06ideyFTn+vYbPSwBqzjxgu55IGQgO2e4zr/Jb8=;
        b=dVI5i8M38k3yUDqDnW/cL2MMbtg81wU2ssC0rWJaz0JN+vOqoLMFIo9kQ/llj4Ujat
         nMGRUwLpBoX3kjZvD+PiLr/as9maWQCYVVpRxmH+cV+W4GphCivBMfKzpP1Y0c7CYK+J
         WiURsGQdfsqpwJcNvySZ+hndG1Uj4A+fmymKEzrg58Md2hgmWxNkDfMrcOW+Rd7VeVZn
         8uKx63vfU1f4jfyPxJL8YkZTl442d3enQFHnMGB+OMVIXOll4CWMyx1aRL/9rG/nztNJ
         l6tATAs7zNxml/SQM/cI3BEKDdrZwUV00PhDP3EEyI10947zfC0e1ByzE4yS3gQ9186P
         AiEA==
X-Forwarded-Encrypted: i=1; AJvYcCXPB0VZDfWpQ7uVE1+6mYu++6v2AbUX94SjJdBeHGftPFjy5b/Ru6iyXnGvQx+8KqAhooyEhqVb4qfxZL7+x6vUznRnP7/C78m/+Xuj4y41XRuGiDmSXAPVQ6x7j81rFscQQknJE+PsgvaqowkCnJxfoIvY5b8HiMk2RRo1dYBpttWpvoBWvwJ+U2J1NXSRqkMTJkPAASLTftRcuP6p0+yI8dSJCqYzJR18ArVE804u0vc977OziNFyew==
X-Gm-Message-State: AOJu0YwSMMrVyXlcfogz2My0nkdyE7UUIW5cI0+uo301zd7ZwMpGiCRp
	OkwR7etbYKVTQHuKCvTWc+Ym83CFYH86l5h1y23Ay9mr+Gq3XoMr
X-Google-Smtp-Source: AGHT+IFh1VpIzVKP4wzEzmD/JP/8adS3wp3F1FA/pDLQW2Tt/VT6PdetdY0HHZkHyIWATDyxW4AhyQ==
X-Received: by 2002:a05:6808:169e:b0:3d5:2365:4f8c with SMTP id 5614622812f47-3d545978a8cmr17656272b6e.19.1719531167769;
        Thu, 27 Jun 2024 16:32:47 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f8csm273324b3a.202.2024.06.27.16.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:32:47 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:34:11 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
Message-ID: <Zn3281oDlhIvYrwy@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
 <1db5d054-8cce-4cbf-a02c-6ba52791548f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db5d054-8cce-4cbf-a02c-6ba52791548f@baylibre.com>

On 06/26, David Lechner wrote:
> On 6/25/24 4:55 PM, Marcelo Schmitt wrote:
> 
> > +
> > +enum ad4000_sdi {
> > +	/* datasheet calls this "4-wire mode" (controller CS goes to ADC SDI!) */
> 
> It looks like this comment was meant for AD4000_SDI_CS.
> 

Yes, but I'm thinking maybe this is not the best place to have a comment about
that at all. I'm removing this comment for v6. Maybe better to have it well
documented in dt and close to the transfer functions than having partial
explanation here.

> > +	AD4000_SDI_MOSI,
> > +	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
removing this comment too
> > +	AD4000_SDI_VIO,
> > +	AD4000_SDI_CS,
> > +};
> > +
> > +/* maps adi,sdi-pin property value to enum */
> > +static const char * const ad4000_sdi_pin[] = {
> > +	[AD4000_SDI_MOSI] = "",
> > +	[AD4000_SDI_VIO] = "high",
> > +	[AD4000_SDI_CS] = "cs",
> > +};
> 
> Should we go ahead and add "low" here too even though it isn't supported
> yet? We could give a different error message in this case. (not supported
> mode vs. invalid value).
> 
Okay.
I have added for v6:
	case AD4000_SDI_GND:
		return dev_err_probe(dev, -EPROTONOSUPPORT,
				     "Unsupported connection mode\n");

> > +/*
> > + * This executes a data sample transfer for when the device connections are
> > + * in "3-wire" mode, selected when the adi,sdi-pin device tree property is
> > + * absent or set to "high". In this connection mode, the ADC SDI pin is
> > + * connected to MOSI or to VIO and ADC CNV pin is connected either to a SPI
> > + * controller CS or to a GPIO.
> > + * AD4000 series of devices initiate conversions on the rising edge of CNV pin.
> > + *
> > + * If the CNV pin is connected to an SPI controller CS line (which is by default
> > + * active low), the ADC readings would have a latency (delay) of one read.
> > + * Moreover, since we also do ADC sampling for filling the buffer on triggered
> > + * buffer mode, the timestamps of buffer readings would be disarranged.
> > + * To prevent the read latency and reduce the time discrepancy between the
> > + * sample read request and the time of actual sampling by the ADC, do a
> > + * preparatory transfer to pulse the CS/CNV line.
> 
> This description doesn't sound quite correct. When st->turbo_mode is true
> the shorter delay will cause a read during conversion, so we would be 
> reading the sample from the previous conversion trigger, not the current one.

If I'm correctly understanding the datasheet diagrams for 3-wire mode,
we should be reading the conversion triggered by the rising CS edge of the
preparatory/dummy transfer (that should happen when the dummy transfer finishes). 
So this is actually doing two samples. One sample gets triggered when the
dummy transfer ends and the other one is triggered when xfers[1] completes (this
second data sample is wasted because we are doing the extra dummy transfer to
avoid having data that might have been sampled long ago and to keep timestamps
close to the actual sampling time). 

> 
> The description sounds like this function always does a read during
> aquisition. So if that is the actual intent (and I agree it should be),
> maybe the best thing to do would be to just remove st->turbo_mode for
> now? Then we can add it back when we do SPI offload support that actually
> needs it to achieve max sample rate. Then the function will match the
> description as-is.
> 
> st->turbo_mode is never set to true currently anyway. So removing it
> for now seems best.

I always thought we should not add to the kernel code that does nothing, even if
it might do something in the future. For example, when adding new drivers, I
think it is preferred only to add defines for registers that are used, in
contrast to adding defines for all registers a chip has. So, yeah, removed
turbo_mode for v6 and also some reg defines I noticed were unused too.

> 
> > + */
> > +static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> > +					     const struct iio_chan_spec *chan)
> > +{
> > +	unsigned int cnv_pulse_time = st->turbo_mode ? AD4000_TQUIET1_NS
> > +						     : AD4000_TCONV_NS;
> > +	struct spi_transfer *xfers = st->xfers;
> > +
> > +	xfers[0].cs_change = 1;
> > +	xfers[0].cs_change_delay.value = cnv_pulse_time;
> > +	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> > +
> > +	xfers[1].rx_buf = &st->scan.data;
> > +	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> > +	xfers[1].delay.value = AD4000_TQUIET2_NS;
> > +	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> > +
> > +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> > +
> > +	return devm_spi_optimize_message(st->spi, &st->msg);
> 
> In the cover letter or after --- in this patch we should mention the
> dependency since this is a new API and depends on the tag from Mark.

I got
d4a0055fdc22381fa256e345095e88d134e354c5 "spi: add devm_spi_optimize_message() helper"
7e74a45c7afdd8a9f82d14fd79ae0383bbaaed1e "spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)"
6ecdb0aa4dca62d236a659426e11e6cf302e8f18 "spi: axi-spi-engine: Add SPI_CS_HIGH support"
from https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-6.11
to apply and test the changes for v6.
Will mention those in the cover letter.

Thanks,
Marcelo

