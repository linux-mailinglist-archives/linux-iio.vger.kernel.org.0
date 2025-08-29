Return-Path: <linux-iio+bounces-23396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E3B3C2DE
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 21:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AC52052A0
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF1239099;
	Fri, 29 Aug 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7MzxbPK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9B230BF8;
	Fri, 29 Aug 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494697; cv=none; b=s1TOfj3l/Sx8TQ/C66YTxyZgMagD6jS/SzWWPwT/Krx7wRAKiGsYRH1u46sMgTIcaC3y+XE7f8ihUTVhlT1dHQcQ+BtlMdZm4qh553hICV8uVTgQw12gxPb+BfhEtT4c1nxGlkeGn+rigUqTqH4YBGCIGdbx64Ag68UtwNwz7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494697; c=relaxed/simple;
	bh=m19CyVA+09J41w+ehwzrXQaJ3vuX9Uo+a+GSNb7y1Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOSkYNKrKeWmmtY6BdscNirnoyxKVgyeefP420MekeOfDm3T5VFxTOng/dUokp72kLLY/JKNTsU2VXLIZJwhlefb23ZIJJCP5woTMaJr35zJfat+t9FT0iPyxZS/rZ/e+zSH+JDn9vA8+R3hqGETZ6T8ac9lRQZOVA/saBqwT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7MzxbPK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24914277174so1606405ad.2;
        Fri, 29 Aug 2025 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756494695; x=1757099495; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVGx6TDkYH55EDpIhumx3GF2YudEet8rojsYiNRrkLA=;
        b=S7MzxbPKKRVpf/xS/mYGn/gpwwmJlYNxPLBYIJt/m3fPgFaoOpxPNzL8IDHs58ovR/
         w2dV75eodRer5WARYDnWwUX95LUAvYsxlJJlgrC6lw8A5yrJvIgxw9Wxb68nEJMHm2ih
         rVspuF8aqfiK8ljP3i1iwq2jVubnPrmh0Zd5PrklpwIR8JLa4QgUpMgN8xyW4VMN4SCf
         /Zsmqe96gpkajT9f3T6jxMO4/1lTXqh0rDOFN2YDozru5Fop/8Wzz4DQGsqHcjIiXNJ2
         wIm1mlYSKM9RBfrU5bpFsZJZ5vFkm5mwCu1n2xTS0o4PyXym9p/zHQH5Sk0W+4rhiEPB
         us2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494695; x=1757099495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVGx6TDkYH55EDpIhumx3GF2YudEet8rojsYiNRrkLA=;
        b=T1Lgk+wkEb+vbqpIHQKchx6pvMAZzIjuemQ2mw70qRVsf7V6KnvTgj3amNqFysf+P4
         3CoPRW1PBIbHkjWHjbnRj5fDDUAm6v33VD3Oh51Pkv3WiAv0V/JAhkHq2XEnmq4cX3wS
         FtAsFG1rO1U2OInXs9zJY0VgbI7poRMhoCTZ1FWce7qkzx9LyxZVfBNRDhtgD3r2+6bs
         RdzkzRaxauZloTvLz+XN7SYtD2eOJLhrtKW+rg6GhUJJeLrrjYzscUOmp+WoXvmEq2Ne
         Bpp9HS6akyeZxm5GYhpqeulejTjSjXpvb7mGeQP7g1rC4Q0xdbcavrEsIkoe0f8kygIH
         fRBw==
X-Forwarded-Encrypted: i=1; AJvYcCU1OBJxz1IRaBeGJygkU6regRrX/TzBJAHZS8Zh71zm92U82uYagYwK8Z3BosBbh/bOUbjJbqXbLVPz@vger.kernel.org, AJvYcCVeIGn1cp2v6WpBqbsHtVEtfOJgJqMctefuASNCNKnRWdGryhYbQDssFff8A/pRig5vewwOU6WqZyBGINVs@vger.kernel.org, AJvYcCWPyb7YLiZKfasDDUQ/r0JIZdf5Ici6csW5I+TkXPTEm+zMwHzvcU9BvPaB0MacFSv0JkSIm3xcV2DW@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCBaETBLMoCc4gl7VcL/HqYw+88zeMRswK/BpRSdXYZGMoNOC
	Z1oeoJhasZmB80CpO0YMk5zsIpzNpRIIlFembPUn0A6QJbZbwtymsOXQ
X-Gm-Gg: ASbGncvQGPX/92feL/l4TkLwY29RD3VKX59rhg0xau+Pv0c45MGMcl284GC8UmHQ07c
	R3d7Bkujsx1mFjwnR5ArYvkIVCaGDwxBoNDWVeXhjaYkS6B8XUHUW3RLPMXAT9NPphCdcRt+Ukj
	pE5j6LwLR25MAAF7F6LMMJyFQ8WjUL4pE9AdgfhVSTIGWNUC52SfM5C6NHjV5GznFtUuKVDRRMZ
	VZu59OtFbmRvKq8uH0Gn+AfMKzbqt7yaE3fEyXN1M0VzuqBsnvoHilaaAJWPuR28JB5ZzIFSPu4
	gF43Ro0T/Z1a/qM3+NyljN3QQ1eFdcid/EVKkvXuoUo11A/NANMX0+Ctbr7t+l4D2L/ZXt8lwx3
	xYJCYK1K53BOis9EK1DfXmhw039WeXlox0izl7SgEdJXK35zDJU23KA==
X-Google-Smtp-Source: AGHT+IHWqc+I8uAx3S96UwMbBHH1P00t+luv1SUl0QJsFSxjOnqx1lb5UFbcsPn4bnOrEAkFLU4ovg==
X-Received: by 2002:a17:902:f687:b0:246:b3cc:f854 with SMTP id d9443c01a7336-2490f6bd83dmr25833635ad.2.1756494694972;
        Fri, 29 Aug 2025 12:11:34 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b91sm32467915ad.12.2025.08.29.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:11:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:11:24 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <aLH7XNuaZ2CkQVWo@JSANTO12-L01.ad.analog.com>
Reply-To: CAHp75VcGG_h+wpo7hHL=ERYqbrvvAaufwPAYBsEbRn3dB8-dfA@mail.gmail.com
References: <20250824041013.9872-1-Jonathan.Santos@analog.com>
 <CAHp75VcGG_h+wpo7hHL=ERYqbrvvAaufwPAYBsEbRn3dB8-dfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcGG_h+wpo7hHL=ERYqbrvvAaufwPAYBsEbRn3dB8-dfA@mail.gmail.com>

On 08/24, Andy Shevchenko wrote:
> On Sun, Aug 24, 2025 at 7:10 AM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> >
> > Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> > Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> > provide a VCM regulator interface.
> >
> > The PGA gain is configured in run-time through the scale attribute,
> > if supported by the device. PGA is enabled and controlled by the GPIO
> > controller (GPIOs 0, 1 and 2) provided by the device with the SPI
> > interface.
> >
> > The AAF gain is defined by hardware connections and should be specified
> > in device tree.
> 
> the device
> 
> ...
> 

...

> >         struct completion completion;
> >         struct iio_trigger *trig;
> >         struct gpio_desc *gpio_sync_in;
> 
> >         struct gpio_chip gpiochip;
> >         const struct ad7768_chip_info *chip;
> >         bool en_spi_sync;
> > +       struct mutex pga_lock; /* protect PGA value access */
> 
> >  }
> 
> Have you run `pahole`? Does it suggest a better layout?
> 
> ...
> 
yes, I have run with the reorganaize option, tried a few combinations, but couldn't found a better arrengement.

> > +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> > +{
> > +       struct ad7768_state *st = iio_priv(dev);
> > +       const struct iio_scan_type *scan_type;
> > +       int val, val2, tmp0, tmp1, i;
> 
> > +       unsigned long denominator, numerator;
> 
> struct u32_fract fract;
> 

Problem is that rational_best_approximation requires a unsigned long. I
could do:

rational_best_approximation(fract.numerator, fract.denominator,
					    INT_MAX, INT_MAX,
					    (unsigned long *)&fract.numerator,
					    (unsigned long *)&fract.denominator);

But I don't know if this is the best practice.

One way around this would be to represent the gains in fractions instead
of 1000x, example:

static const int ad7768_gains_frac[][2] = {
...
	[AD7768_PGA_GAIN_3] = { 13, 5 }, /* 2.600 */
...
};

then we could drop the rational approximation.

> > +       u64 tmp2;
> > +
> > +       scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
> > +       if (scan_type->sign == 's')
> > +               val2 = scan_type->realbits - 1;
> > +       else
> > +               val2 = scan_type->realbits;
> > +
> > +       for (i = 0; i < st->chip->num_pga_modes; i++) {
> > +               /* Convert gain to a fraction format */
> > +               numerator = st->chip->pga_gains[i];
> > +               denominator = MILLI;
> > +               if (st->chip->has_variable_aaf) {
> > +                       numerator *= ad7768_aaf_gains[st->aaf_gain];
> > +                       denominator *= MILLI;
> > +               }
> > +
> > +               rational_best_approximation(numerator, denominator, INT_MAX, INT_MAX,
> > +                                           &numerator, &denominator);
> > +
> > +               val = mult_frac(st->vref_uv, denominator, numerator);
> > +               /* Would multiply by NANO here, but value is already in milli */
> > +               tmp2 = shift_right((u64)val * MICRO, val2);
...
> >         init_completion(&st->completion);
> > +       mutex_init(&st->pga_lock);
> 
> Perhaps devm_mutex_init()?
> 

sure!

> -- 
> With Best Regards,
> Andy Shevchenko

