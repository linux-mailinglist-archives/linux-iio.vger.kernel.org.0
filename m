Return-Path: <linux-iio+bounces-7105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C291E725
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 20:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B57B22239
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7916EB77;
	Mon,  1 Jul 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx+IGK5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECA14BF8F;
	Mon,  1 Jul 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857366; cv=none; b=oznVxkHHG2N0p0axIZfQhplVmJFbfZpiIhoBxovVHXGG6uoZwH9C7AIlPipqNFNhkOJT6/oD85Xynb+KQMsCNrLHVZ4ldQ1kcoaqq4jBGjH/62UEJSG2Lsn93REQLgXL2k2uc/oFFwZMf21alMvOPPv861/qpgNQQgxX1XN8D4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857366; c=relaxed/simple;
	bh=klklsmtDboy+OW955V/X6hfHZRk2vERsRPap13LB4hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cadNz9t87fIlxFK9B6cwfQE6X4Q6AqvRlaKx3m2IUjcvkqtg2qRPpC8Va4qI1/FfY3BPhagXUWrwkF2U9dyMn69gjiZpZxyxDtwccKGAaG3AJm32Wr6JZEbbIZBr+4EmBAA5+QBQBIHIVefQj2XR3702kVYvPepjOAXjXhNQ3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx+IGK5X; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706524adf91so2663768b3a.2;
        Mon, 01 Jul 2024 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719857365; x=1720462165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6qcu1nZE7KZYDUrd9vIfmSvZPyMTSfX2YwStcmyIO8=;
        b=kx+IGK5X3ddtiXRBExuebifv/lOQhQk86fUjWWg/sd8zuj5p+oxNX2LxxAg4jKEDL6
         rMBnG0ZpnkMDTKPV+N4ZmiAGxyUT1CiqLldALYRwe0qPeI28FJjEqJ8vDkNcC4w1pSbs
         OMx2gizuYcLOo5GtoYLKyu2z4wKjj+iH+FsLuaMdVpZD9l1EBTH61AEBophLlssEka5R
         JQ9Vkw0TZ6Rz9cefU96ZgPut3lC6qfTifjtRWleCikz2f8K+Ux1eZ+d4eWfb7u7ERked
         +uUez2C66sEMZfEZz6oMby8zPvz+/xyQ+38G9rkCqxPvMHVj9LQdaOEDRnkFdZkD774f
         /g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719857365; x=1720462165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6qcu1nZE7KZYDUrd9vIfmSvZPyMTSfX2YwStcmyIO8=;
        b=TlskvTrAKnefs4575Cx8Oeu0P45zjBuMiBMBdQSiiI6uYQ2OQe13UX1SoM4mAJ0cfs
         Rjwtfe/0eNnWcdFjMBu+x5JbeAWDBRsNb6ZWGyu+7li1j4sL4VOn8myTt/ENSsJbLTtn
         v6AiYZjeL1OOvyhMatVwdyv4vSKpLyu8Bs/y/3Ujb5RpgljcArChfZ5sBZsbFz4FjB6Y
         ye1CREioymX+1jQzY2LMyeoCE4WR+wqQsqp59TzUW+xrnEfiWybDKJ57K/zqWKjxhI5S
         Ku8QiOXY7uhT6HiAHsI6IEGftoDQOZQXndnjRbwBVcL2EYg1w8p0fNV9UWknxMY5FMZx
         cXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUpdbWepjjiCxeVzW3mYO8VZpomsawSkk7escfScGF7r5bAN7zlTJyliWTGHyo8C8KypWx1V14abqRQNpD5iDX8mnw1Frahoqr/oVznZL6M1RGay3JfTqZjz6z0nkyW/6IFPOPtm+sRFRl/LiMmx/3HC3ZCRqfJRjCewLI7AJxRLf1K3iC2GJMLjQ4DIOuPoZPJ8xM1IpL9dc5I/7TqnNX/ccCGXaDkjPiJ3+83OMdR9mvz8eQtw2eJ7Q==
X-Gm-Message-State: AOJu0YyCnG8zmTfgIMEHQniVB08zRXZA2mvCuY8n+wP/4t/zWx9+MdA8
	hWrIosNlF6Gsk4ozOCMSzAqoMmkH7YC8NnbgkSLPm8SsuEj8seVV
X-Google-Smtp-Source: AGHT+IFh2feUeG/ELVwtKgQhpLtRHdSCRscIJK5gnG+BmVmyoeoN4Men1/9vx42lil4cyddQBeE8kw==
X-Received: by 2002:a05:6a21:32a5:b0:1bd:2ba1:983b with SMTP id adf61e73a8af0-1bef6216d0bmr10499470637.51.1719857362875;
        Mon, 01 Jul 2024 11:09:22 -0700 (PDT)
Received: from localhost ([2804:30c:165e:de00:82ea:ff72:ead3:4367])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f67sm67538595ad.43.2024.07.01.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:09:22 -0700 (PDT)
Date: Mon, 1 Jul 2024 15:10:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: adc: Add support for AD4000
Message-ID: <ZoLxLgpy44S38nSe@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
 <20240630121726.5d75578e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630121726.5d75578e@jic23-huawei>

On 06/30, Jonathan Cameron wrote:
> On Sat, 29 Jun 2024 16:06:59 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Add support for AD4000 series of low noise, low power, high speed,
> > successive approximation register (SAR) ADCs.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Hi Marcelo
> 
> A few comments inline. However, the spi_w8r8 etc can easily be a follow up
> optimization patch (if you agree it's a good improvement) and the
> other changes are so trivial I could tweak whilst applying.
> 
...
> > +	/*
> > +	 * The gain is stored as a fraction of 1000 and, as we need to
> > +	 * divide vref_mv by the gain, we invert the gain/1000 fraction.
> > +	 * Also multiply by an extra MILLI to preserve precision.
> > +	 * Thus, we have MILLI * MILLI equals MICRO as fraction numerator.
> > +	 */
> > +	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);
> 
> If you are rolling a v7 for other reasons, stick some line breaks in here!
> It's a bit of a mass of text that is hard for my eyes to parse!
> 
Ack

...

> 
> > +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> > +{
> > +	struct spi_transfer t = {
> > +		.tx_buf = st->tx_buf,
> > +		.rx_buf = st->rx_buf,
> > +		.len = 2,
> > +	};
> > +	int ret;
> > +
> > +	st->tx_buf[0] = AD4000_READ_COMMAND;
> > +	ret = spi_sync_transfer(st->spi, &t, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = st->rx_buf[1];
> > +	return ret;
> 
> I'd be tempted to do
> 
> 	ssize_t ret;
> 
> 	ret = spi_w8r8(AD4000_READ_COMMAND);
> 	if (ret < 0)
> 		return ret;
> 	*val = ret;
> 	
> 	return 0;
> 
I tried this when working on v6. Only difference was I had declared ret as int.
Then reg values were not read correctly with spi_w8r8().
I'm either missing something or reg access must be 16-bit transfer.
Datasheet sais:
"The AD4000/AD4004/AD4008 configuration register is read from and written to
with a 16-bit SPI instruction."
Yet, besides possible delay between first and last 8 SCLK pulses, I don't see
any transfer level differences between current and spi_w8r8() versions.

> 
> 
...
> > +			ret = ad4000_write_reg(st, reg_val);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			st->span_comp = span_comp_en;
> > +			return ret;
> 
> If you are spinning for another reason, make it clear this is always good.
> The spi_write() never returns positive so current code is correct but I had
> to go check which this would have avoided.
> 
> 			return 0;

Ack
> 
> If nothing else comes up, I'll probably tweak whilst applying.
> 
> J
> 
> > +		}
> > +		unreachable();
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 

