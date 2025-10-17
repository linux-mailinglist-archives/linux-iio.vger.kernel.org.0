Return-Path: <linux-iio+bounces-25190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A9BE86B8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 13:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E1224F7173
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6F34DCFE;
	Fri, 17 Oct 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReV0lAbr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F112DC76D
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700876; cv=none; b=Ihi9zbVoxJuKKzSP3/FdiYnIka6KiecVQWi5yACjH7S36taiKuj8XyOUF0iKrwFOghtwit/RPKyRoiYv2t1kI9NaV+pKTixlEx5yAuuPSM7mmyj1AzrV4LA5SmpZDafrr2tBuVXdb0P0VdbAGFJoYMD8C61LgEbImoqTx7rXlng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700876; c=relaxed/simple;
	bh=xPKudPe20LVyFE+p3IxJr16x4wx/uGvtSa6tEowpGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiaetbrzXn5wYU27ZZEoEJ/RXN8svVpk+3heXGdvP2a0u3vUyFqUvBv5yVOeDHDm/iBFY6OWl4g/+V/Xhnn4VB5nA66Nnz33J1FUS2hC8AcLIgqexIv0fFbE8Zk6Y59Bm2YQM6MwT7Cm9xp7hDHQRmW9Ml1MvLF3TygMDlbl8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReV0lAbr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b4739538so1665997a91.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700874; x=1761305674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYfAPtHB/RHiXWE9XxOgOmtRX2AfdTu8oaK5y1u+j8I=;
        b=ReV0lAbrEXLoA7ZSlXmh6jSMZz275urgTCRGceEXFqCRCX0VQT54AfF3hsM8TWVFtr
         FFXpYDARFTcKsWF9Jqn2rfqav0xnJb+eIQwEKp1IKncxnIF188wMUgG5m1EX/uS7Xq4W
         hYvJsZDQUbAsm4D/IXCsoQ+K4sBPGluodtQvePY7YDwv/TD+m20/Tn4qVIzNkuEUn3WS
         dmpJZDIauzCUvz4hJYTEDIf2tvp4fL7JroMNGwYZk2+QAcIPxuw5cygFMnlJAjgNwVAY
         fbcTtt71NozCqFaxE5dyUaGqEcOI1flztoB0QmBLxxC1+xgJwi9U6UM0okiiHHsQws9P
         ZcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700874; x=1761305674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYfAPtHB/RHiXWE9XxOgOmtRX2AfdTu8oaK5y1u+j8I=;
        b=j8DnycgrnHfCeFi6SGIBIBt4xszpsH2MODzoyCEVn1S3S2weESNa443U5pkfYeikkh
         Q1hr8HPyaCvZEnXz1Kv2rawS4hrRmeKptFv5UqFkLlklrY0MkwdtdXsDh6oAN16q0spw
         0qpBPNqCg5q7eXhr8nXmt9IegFJ7uMJthuf3auQMdNoWcPa8ZhSY78YXdP7eP57rbPXh
         hqB5O4GOdiriUjSTrhtm/OvAHNpSmfau6Kxzi+UvY2fJ0a/hNWsfmFIxrNf8RJYOdc8S
         kKqilRvI31DPyrZaL5dcLYFhvGFhX3ME2A7ORW5xPLAXIJw+y5pujuHfsjEeU0NqzuGz
         JBkg==
X-Forwarded-Encrypted: i=1; AJvYcCUH+MdAL9A1WC41Ex6x+4CmxNt39pq138ppuu/y0R5fwBCW7tZg5jhwfqmLsqNRF4WotnNwzc5Zt0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmeyulgAJPXpioNcAGJNS7OZtjzh6AQQ/eXNGh3dUEixlTygM
	k711nrkVQc1oYv5Xkcebest+Gm35FkGay8vvg/UwOM6hHOk72JuehVQe
X-Gm-Gg: ASbGncurn+HcR8aW98HJXqUA2goPpnnra2S0veZpZG5lD4ih/VJnlQv+2GTofJWMX7W
	XIJx9ycrQQWuDsipKlJtHIpyk5ISO+RTbFxw/1pAlWkUUPez9ZAldUoOEYUTlOLSEyuNAqWRuuF
	g49FXhBOOu9cbNB+yxN+HmXd4fP1FH4bDrFhbANP58UJf4Z5BIWxHkd4Ej2vKCMUH5pWmlDBX47
	sEl6YN/3PvsrHQ3Xwyme+ZziR88BaFjtIt+fPcNsYifUl/bqYELr2kpvf07dhxDuuqwZe2zYs75
	nGvTzhYZUVJ3NMeUH1NMqFjCPmYH7vrknz0s0onmqmQCzd9avigvkuCj+cTVUyVLlJn3aBRWSLE
	xEM1Da+PZ+iEcOd0athep8EU3+SXZr7jrdZlXQftFBCc5E61jr+eJYmlKVq3w1ahmPh6l50BOim
	iM1Ru64f/vbA==
X-Google-Smtp-Source: AGHT+IFWkL4x7nbwb+9Uvguh+3df9cfdWGeCUM99KzCsQewGs4kLcYRtKcEcc6/or/fk3QS39PWIIA==
X-Received: by 2002:a17:90b:2f8e:b0:33b:c5f6:40ec with SMTP id 98e67ed59e1d1-33bcf914840mr3603295a91.30.1760700874068;
        Fri, 17 Oct 2025 04:34:34 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992bc13543sm25483583b3a.35.2025.10.17.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:34:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 08:35:38 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
Message-ID: <aPIqCrvaPQZg7Lo8@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
 <e677f27a-787a-433c-8516-99ff1d33f2c6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e677f27a-787a-433c-8516-99ff1d33f2c6@baylibre.com>

On 10/16, David Lechner wrote:
> On 10/14/25 5:22 PM, Marcelo Schmitt wrote:
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve such
> > high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates. Add SPI offload support for AD4030
> > and similar ADCs to enable data capture at maximum sample rates.
> > 
> > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v4 -> v5
> > - Made Kconfig entry depend on PWM and select other features.
> > - Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenable().
> > - Dropped common-mode voltage support on SPI offload setup.
> 
> Curious why you chose this. I guess it will be fine to add it later
> if anyone ever actually needs it.
> 
I had coded that in a way I think would work for the dual channel devices, but
it didn't really work for single-channel adaq4216. And yes, if anyone asks
for offload with common-mode data, we shall probably be able to it that later.


> > - Adjusted offload trigger period calculation.
> > - No longer setting data frame mode from ad4030_set_avg_frame_len().
> > - Rearranged code to reduce patch diff.
> > 
> >  drivers/iio/adc/Kconfig  |   5 +
> >  drivers/iio/adc/ad4030.c | 425 +++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 416 insertions(+), 14 deletions(-)
> > 
> 
> ...
> 
> > @@ -512,11 +643,30 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
> >  	struct ad4030_state *st = iio_priv(dev);
> >  	unsigned int avg_log2 = ilog2(avg_val);
> >  	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> > +	int freq_hz;
> >  	int ret;
> >  
> >  	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> >  		return -EINVAL;
> >  
> > +	if (st->offload_trigger) {
> > +		/*
> > +		 * The sample averaging and sampling frequency configurations
> > +		 * are mutually dependent one from another. That's because the
> 
> s/one from another/on each other/
> 
> "one from another" makes it sound like they are independent rather than
> dependent.

Ack.
> 
> > +		 * effective data sample rate is fCNV / 2^N, where N is the
> > +		 * number of samples being averaged.
> > +		 *
> > +		 * When SPI offload is supported and we have control over the
> > +		 * sample rate, the conversion start signal (CNV) and the SPI
> > +		 * offload trigger frequencies must be re-evaluated so data is
> > +		 * fetched only after 'avg_val' conversions.
> > +		 */
> > +		ad4030_get_sampling_freq(st, &freq_hz);
> > +		ret = ad4030_update_conversion_rate(st, freq_hz, avg_log2);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> LGTM.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Thanks,
Marcelo

