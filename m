Return-Path: <linux-iio+bounces-20169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC070ACBA17
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 19:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D38188964D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6022541F;
	Mon,  2 Jun 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt17EzvH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADD1FDD;
	Mon,  2 Jun 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884532; cv=none; b=jsPHi7mnSS/lExzEWOdQhP+FiWDpJrgZD+KFmzzSrGSf8i9rbcW+O3AlYe0ffUNbfEK//Oj6PPQKLJ9vRjBqemMYzXENvkNOk4jbMY2dig0fvFDuBs6XGU5U6ORhW8/89JptokrSlcoC8AMYQPlpjoxROw47N3ZfhzWca1udNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884532; c=relaxed/simple;
	bh=BSPZ+8k3j7hRfUMuTmnUvpVGMIHP+qqGksybdohOw0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toO1FqEKvm2FnnLepxqw1xuSYsSVCDwOqmxhNZeojBXB5cY25mDxQBxI0KrHNMRr8D4tN2P9RNQxJ/jmT/0CpsHcZY7sg+yETZh+LyUVCO0UqTfrbj5IboETnapqexGMZdSeMdCQBhnO6OIidBFxbdZSef4/yF3MlNYjTaP5iHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt17EzvH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fad77c3ce1so1178506d6.2;
        Mon, 02 Jun 2025 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748884530; x=1749489330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPqj+hlUb15Vo0gwcmnc7OruGv7UIdZSe73EVhzlEf4=;
        b=Zt17EzvHDopbB1vda7uvsy6AXNlsY0zQ0k854GltCZyM/RsYeCGXWNowKFTSMFtg/w
         3Wy6TAe0dIElTio4stpy8Yw+1ECmRGrGQxxOsDE19AxJ2YAWt6RlEFsg8uaEylUHKX+Q
         eFANk0NMewVcm3O4SdpaIFIrXeWCE8vAgJ+IoZMZcWoHK2oakRBiX30LdCj7ucWM37Bj
         szOOS7WyiiMYM9rkhmvXv4m1Dsp0yONxbphUyCNi3cOfVvWfQ/+GAdpngZE6Mj97SO2p
         wOhclhyWvS4G1XcBdx/VCFufCSuLcymMhgbdkm4bmoYkT14YVYRaZ5+IShItFF4mFos6
         6z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748884530; x=1749489330;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPqj+hlUb15Vo0gwcmnc7OruGv7UIdZSe73EVhzlEf4=;
        b=UaAqD+ZLdgXE4lkI8OMnTaphasTZdi/Q7XV3aChKiUiXJducH7lme/K35190731xhe
         /4NYZ/OAG+iqQSGBDyu1dAUztWJEIMxaQYz8v2N1wN2XcdTIjV56EPoP9KQ2u32jtBZm
         gdzcHHMlkJuJs00Q65oZCjtoXwGBqJAxmTIQOXqbC1uMJIwm7kIDDGHCZKtOo9WMZact
         pRI+H9T86s92GZoPadENuXYwIotmioa4ckjME783xOALmQGPFCN4thJ3av2qxqwcZ/9U
         cHsdcOWyoXsHnw2zb7f5pmueSZIEA+7pEHGoH78ESK8WmpaJJHGU399V/PAJoFYnrsqW
         hRBg==
X-Forwarded-Encrypted: i=1; AJvYcCUO3YsEHvDU+5HduRSUeZ2ZlpMIC0aI+FV2OTvfANhlFtFqdJ23d18EdUTkJyVwbPc8ATaLS/MowM7Lvg==@vger.kernel.org, AJvYcCUiJXaj92fMYOtuhfNeq4hb/5AFO0H609YN2vgW5rV/0FAzNqq2weZeIPP4rJgkTincu8YlkEyW81pygcNE@vger.kernel.org, AJvYcCWUXw6B8zglvBTKrY87GMv0xD8thR3YC5ZZWBXM5mZ5SE2eiGEpkWGl1KvzGE/mFiUeLdZTcsWTBLxn@vger.kernel.org, AJvYcCWX23JNV6FnKWTff33cXxA4Sqy5XnlT5s4vj9KDfY/T5L78r+Kfpy15CyDyUWPi+oNf4AiXv/Zxg5T+fw==@vger.kernel.org, AJvYcCXfkFM5Abyc+7/paVpLJs0i08c8n+UoAM9uhvsFeYndcQEUbdvLNuh51pYx5FqvDhFbdYEgROM5uBen@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8nVbx3W1Ye7iMH19Arw//n1c6BC5TqJctZ0MMCpOlNYM7niu
	5RL1lu9KTiYhXBAEA2KQpxRcdDMd3IeHJCsWCyRSUcUP0DvQU1DAG1QF
X-Gm-Gg: ASbGncvMVvNtNV5TSBMV+Pc0RnqGLmUa450B9WHTLdq8RfYR9U/KaCI4rphJPW+Nv81
	vrkq5zJE0F9FOI8Bh8dH9svoX0TvQccfsuYmv8Lbu30bj5z6JGIU2RqE3tfP7dtFRGJnPoNGlzw
	UgagZyMG8/VDadhMxj5h19fmswty3XkdJ+yF64IltZFv4TRhNOWaEgkTNx7JYx89PQ2Uw6IWztP
	v1+ZKXM/8wcyFjbMpKNbzIJl1U/+jUO+xfa7oL7ym8hMFsAlu40wFkEW9XiKPDi9IiqxKOZdyGg
	CfIYargcNxeqkionnEk/fc/E2RK0+9JUmm0cUQS2ZlHe6N5sSJxmGwoWMVuVfil8jgvHCD9xnYB
	GVMky+hU=
X-Google-Smtp-Source: AGHT+IEXoxkzXT24Ug4BWtO98apWkgU/PzoKpBIv7F4ljkTOJkULgLYOyNFTPtMiFl4pDML3ami7BQ==
X-Received: by 2002:ad4:5ca5:0:b0:6fa:be81:e18f with SMTP id 6a1803df08f44-6fad059a7f8mr86733506d6.0.1748884529431;
        Mon, 02 Jun 2025 10:15:29 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e1c800sm63659146d6.102.2025.06.02.10.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 10:15:28 -0700 (PDT)
Date: Mon, 2 Jun 2025 14:15:23 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com, rafael@kernel.org,
	djrscally@gmail.com
Subject: Re: [PATCH v9 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aD3cK5PioN7Rw3pP@JSANTO12-L01.ad.analog.com>
Reply-To: aDnuvAdkcTAP2tMt@smile.fi.intel.com
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
 <27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
 <aDnuvAdkcTAP2tMt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDnuvAdkcTAP2tMt@smile.fi.intel.com>

On 05/30, Andy Shevchenko wrote:
> On Thu, May 29, 2025 at 07:50:29PM -0300, Jonathan Santos wrote:
 
> > +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> > +					     struct fwnode_handle *dev_fwnode,
> > +					     struct ad7768_state *st)
> > +{
> > +	struct fwnode_reference_args args;
> > +
> > +	struct fwnode_handle *fwnode __free(fwnode_handle) =
> > +		fwnode_find_reference_args(dev_fwnode, "trigger-sources",
> > +					   "#trigger-source-cells", 0,
> > +					   AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
> 
> I don't see how args are being used. This puts in doubt the need of the first
> patch.
> 

If the wrapper is the issue, maybe it is better doing this instead?

static int ad7768_trigger_sources_sync_setup(struct device *dev,
					     struct fwnode_handle *dev_fwnode,
					     struct ad7768_state *st)
{
	struct fwnode_reference_args args;
	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;
	int ret;

	ret = fwnode_property_get_reference_args(dev_fwnode, "trigger-sources",
						 "#trigger-source-cells", 0,
						 AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
	if (ret)
		return ret;

	fwnode = args.fwnode;
> > +	/* First, try getting the GPIO trigger source */
> > +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> > +							       NULL,
> > +							       0,
> > +							       GPIOD_OUT_LOW,
> > +							       "sync-in");
> > +		return PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > +	}
> > +
> > +	/*
> > +	 * TODO: Support the other cases when we have a trigger subsystem
> > +	 * to reliably handle other types of devices as trigger sources.
> > +	 *
> > +	 * For now, return an error message. For self triggering, omit the
> > +	 * trigger-sources property.
> > +	 */
> > +	return dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > +}

Then we can get rid of the first patch.

Regards,
Jonathan S.

