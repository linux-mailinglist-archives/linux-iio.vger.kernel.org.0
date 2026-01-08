Return-Path: <linux-iio+bounces-27550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D835D02DF9
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93B313008C56
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774394AD691;
	Thu,  8 Jan 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC5YmvjQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BC4AB668
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876287; cv=none; b=JqKXGtKhnpihb20//TCZiwbbEvclKy4+BlO2czuRnamDMp5iNqqz9Gy8vkOzVScjrPwcEwmYzbnRqd6Ilo9ZVvO4SfVePJLBh0mT8/RFFoCOyl2tOVjaOI55iU9VqmpWR2nKvbS3jgv0VaPWXKwRKl1Mklz5R27kmE6nevqUOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876287; c=relaxed/simple;
	bh=AwhGImIvcBaR3vyUVl2KbbFcTijy2PNb0a3UiV69YTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZoyA/3XShRKakkwzdZtwzVgoxZogFbh+l3OcsoBxBSAM5FznmsUAImu5rsbXxfGQTx6KCWAEsj3F2ueDWi/IUJos3EunkN2WyvYJ8I63LkEOx2WOkZsAHYl7Mw4lV6JeSp9Ux9kgoNh5dyRkZ4uw7/+e0BXfMOElp5WVqmTYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC5YmvjQ; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121b14efeb8so5849937c88.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876285; x=1768481085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whT378guI+ZEoS3nkN8PXSvu/iXsM/AnSpQS/H8en2M=;
        b=MC5YmvjQm+UmRiWaXlQkEU+AAORWiPyM3qfksFFMnYBs1NoPMEUkUYAxuSpw3NJWot
         iUD5qv/lx89VVetTIsjEcTyOVRBEiG+PvmJBcoRSla6xxvf4z9KbSywF2DiPA+kg7oPV
         OEXqHDtLj8m9sy7AMOTnnh5RtMrRE2XiltNhHzPpuIyJCY4CiwVs7MmewPUQ10jjTb4e
         ZMUO3ShnU6YGg5qp2+sETIwMQ5WjdRcBtCH7Zbtjl5zFpmiBD5FFhlr+CyySO/J/nec5
         L0LH89vQ3lXbPIzncXliJdLbC1DclYLgstw+XYJvl2tXH+vAzyl2viG0NuRnOXZIW0EP
         63Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876285; x=1768481085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whT378guI+ZEoS3nkN8PXSvu/iXsM/AnSpQS/H8en2M=;
        b=Draw6TKQbdWbbZBMEnz9ScNHHDfAl3GKZ5AZGm6kB0Ow6MzrnX2zG83yfxSQgBtPGb
         fqYfjRqyEDPlMuhdtkDcUzgjDuoVN4tbA96awbofkdMxC+sB9SmzUbhGT+9sxsdQmSLf
         6AmSgQt4oQjWx9YhIXa8OpN2lrtOVYSxQ0jqP9+Vnn5Up9UKOfZF2gibbqTMtsdU3vhf
         sXGh8E3JjWMkcFB7IZTTvAxiBc+zND6h9IMkxrMJprYxtGGo2l2xKvoNgXtw1o6mNmWu
         H9A0jheXSv2bRguwciu+DDhZtXxuAMLW19/i9kAnBqSaFHH+nxwF8iKvSBibT8VWBuMS
         6+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBIDdnijIFrkBvZaZv6PyNkYzkT9aN22/HFKLDEfdO+ZVkfQ0nI+8dnpwzFAxP26B5mBAVz52qWk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVa1S6Qxg6DyfUJOVXRc5RQde6Y9jzVNTIe3w2BDcsvXqYbtjs
	pE5ODj3YpG2ykVp3ARQgawcyQmkKpeYRrgiI6YE0HXD7io+Oa8XdQCi8
X-Gm-Gg: AY/fxX4zg910BOa2XNFu6mWxN/UFPMLXQvGbjjeYzKZtlKpuf5HmMnGoxiPpWGi73WB
	/1zYjS6iF7zaQFCGmRVMBlti3M6KasW9QNB8fI0Peebm3M5eZlagSfcqtVn1Q9YgTaCZ9KNnqwI
	H/vqyxOgH5jmcOoknzKGmfnFA/5Z4HX9NIuFxcFWF8TBChwH8pTJP1Q7VoMfyGF7kfXDTz1PABm
	plmB3/LBRl3K562Ch9BnqPZcCB9rO9gdk2e1tqzIfZsPdWLB9b1YwbaChGEs3kgiGdhrf+SHq02
	FOtQawQ4VrUXe4Co8r2O1FBuSsahnVyWEoAQgCwGGP0eHXXnbyHwNhSvwDf+aQldU9cdl4JPRbC
	lnzfxrKhBPC2tZYlgQ6HcXUh4EJu6iBj27euyYTPsDr2IYUIurKfv4cJGE+DIFpSihLPBaBxsva
	jUqknuc5aovF3Zf84fc0J1qGwyYL22ug==
X-Google-Smtp-Source: AGHT+IGUmQ23SV+7CSSWfVlEULrNabCZpw88V1MXglBdAIwNayHbWakVzrJclbrbPZNyKd8leH4uRw==
X-Received: by 2002:a05:7022:6728:b0:119:e56b:9592 with SMTP id a92af1059eb24-121f8b4dbc9mr4671745c88.23.1767876284619;
        Thu, 08 Jan 2026 04:44:44 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm13361817c88.12.2026.01.08.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:44:43 -0800 (PST)
Date: Thu, 8 Jan 2026 09:46:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 9/9] iio: adc: ad7380: add support for multiple SPI
 lanes
Message-ID: <aV-nJtPKWbmDSlah@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-9-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-9-145dc5204cd8@baylibre.com>

On 12/19, David Lechner wrote:
> Add support for multiple SPI lanes to increase throughput. The AD7380
> family of ADCs have multiple SDO lines on the chip that can be used to
> read each channel on a separate SPI lane. If wired up to a SPI
> controller that supports it, the driver will now take advantage of this
> feature. This allows reaching the maximum sample rate advertised in the
> datasheet when combined with SPI offloading.
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
...
>  	st->sample_freq_range[0] = 1; /* min */
>  	st->sample_freq_range[1] = 1; /* step */
> @@ -1887,6 +1899,11 @@ static int ad7380_probe(struct spi_device *spi)
>  	if (!st->chip_info)
>  		return dev_err_probe(dev, -EINVAL, "missing match data\n");
>  
> +	st->num_sdo_lines = spi->num_rx_lanes;
> +
> +	if (st->num_sdo_lines < 1 || st->num_sdo_lines > st->chip_info->num_simult_channels)
> +		return dev_err_probe(dev, -EINVAL, "invalid number of SDO lines\n");
> +
Maybe also print st->num_sdo_lines here?

Nevertheless,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

>  	ret = devm_regulator_bulk_get_enable(dev, st->chip_info->num_supplies,
>  					     st->chip_info->supplies);
>  

