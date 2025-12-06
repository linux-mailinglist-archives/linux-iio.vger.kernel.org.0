Return-Path: <linux-iio+bounces-26827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24116CAAA0E
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD6A305D998
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628652FFDE6;
	Sat,  6 Dec 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha4teg/E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CB274B37;
	Sat,  6 Dec 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765037889; cv=none; b=Up53qXKCREycyqEHQNbTCWnf7edoTQ4A95B6SPle71inSo6iOxDfISSfz3nbzqKJ0HE0rmkumHVCOKSnq8Jbt3ICLl4F+sRvZuXCFmLpnWkpDE44oC8tOLtqo6NmtDSTfo3V7gqFaMWl3fzGpZxVGPPeio13ta36JIIIVdVVJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765037889; c=relaxed/simple;
	bh=O0FZqJE+uW1VVVSpJm7IzkbqSLM2TC1BIsj+SjPsAoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DklM34IHLhXlCvEmcoHw6Gpj0/XGfLiY/ZPLXEFY7Icbrnwl4UQKZx+hmHQ5cdTc5QpDZRfxycFnMu8yFx7ijN59/6cx8A9RgPO0LgDp5eRKpKQXq24FYyEmPvZ1kk3jSryJwJo8k5x8eosET19HlIJrHcA+C+RMK4l3EZggp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha4teg/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59516C4CEF5;
	Sat,  6 Dec 2025 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765037887;
	bh=O0FZqJE+uW1VVVSpJm7IzkbqSLM2TC1BIsj+SjPsAoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ha4teg/ElXEFid0aujVAkYp0qwxSPRsNzLFcuHEA9morf8Lzkkk2pfMxLDGXbPK4h
	 5NLAb9v2k6nvLc6C+0f5e77aFe15P5CjHkvRyKXMkaocG7s6TVr2QbAAY7SwM+n8Ko
	 5wHkLK0A3FYuSVJTkm0xTZWOQp35EmapsxyN5smkH2669mFKEXJvyJzl5BzubgoxT5
	 LGzS39n/6GQ9MiS8PivbKekYowTu+oo3KgjS9+3jhv9Dabc8CmymQEFgjwIOgAczXN
	 AU9oBuYX0XFliN1Tx8ZhTXBxl9uhIzAf09Nct4v2Cle4GrfBDEXbW1ZZGLu8vMKRif
	 v1oivQ1h5qCJg==
Date: Sat, 6 Dec 2025 16:17:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 2/3] staging: iio: ad9832: convert to iio channels
Message-ID: <20251206161757.32e4cf0d@jic23-huawei>
In-Reply-To: <20251205202743.10530-3-tomasborquez13@gmail.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
	<20251205202743.10530-3-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Dec 2025 17:27:42 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Replace the custom frequency and phase sysfs attributes with IIO channels
> using read_raw()/write_raw() callbacks, as well as removing the dds.h
> header.
> 
> Changes:
> - Add iio_chan_spec definitions for 2 frequency and 4 phase channels.
> - Implement read_raw/write_raw for IIO_CHAN_INFO_FREQUENCY/PHASE.
> - Cache frequency and phase values in driver state for readback.
> - Remove dependency on dds.h macros for sysfs.
> - Use guard(mutex) for cleaner locking.
> - Add input validation and consistent error messages.
> 
Hi Tomas,

> NOTE: This changes the userspace ABI, see cover letter.
Given I responded there on ABI, I'll just ignore that aspect for this review.

Code is pretty clean, but there are a few things that belong in other
patches rather than being mixed in here.
For kernel code we are pretty strict on one patch, one type of change.

> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 232 ++++++++++++++++++-------
>  1 file changed, 168 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index e2ad3e5a7a..79d26009d1 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -23,10 +24,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include "dds.h"
> -
>  /* Registers */
> -
Trivial but don't make unrelated white space changes in a patch
doing anything else - they add noise and hurt reviewer speed.
Put them in a patch on their own.

>  #define AD9832_FREQ0LL		0x0
>  #define AD9832_FREQ0HL		0x1
>  #define AD9832_FREQ0LM		0x2
> @@ -50,7 +48,6 @@
>  #define AD9832_OUTPUT_EN	0x13
>  
>  /* Command Control Bits */
> -

>  	} __aligned(IIO_DMA_MINALIGN);
>  };
>  
> -static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
> +static unsigned long ad9832_calc_freqreg(unsigned long mclk, u32 fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
>  				     (u64)((u64)1L << AD9832_FREQ_BITS);
> @@ -124,12 +124,24 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  }
>  
>  static int ad9832_write_frequency(struct ad9832_state *st,
> -				  unsigned int addr, unsigned long fout)
> +				  unsigned int addr, u32 fout)
>  {
>  	unsigned long clk_freq;
>  	unsigned long regval;
>  	u8 regval_bytes[4];
>  	u16 freq_cmd;
> +	int ret, idx;
> +
> +	switch (addr) {
> +	case AD9832_FREQ0HM:
> +		idx = 0;
> +		break;
> +	case AD9832_FREQ1HM:
> +		idx = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> @@ -147,14 +159,37 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
>  	}
>  
> -	return spi_sync(st->spi, &st->freq_msg);
> +	ret = spi_sync(st->spi, &st->freq_msg);
> +	if (ret)
> +		return ret;
> +
> +	st->freq[idx] = fout;

I'd put a blank line here.  Generally slightly helps readability before
simple return statements like this.

> +	return 0;
>  }
>  
>  static int ad9832_write_phase(struct ad9832_state *st,
> -			      unsigned long addr, unsigned long phase)
> +			      unsigned long addr, u32 phase)
>  {
>  	u8 phase_bytes[2];
>  	u16 phase_cmd;
> +	int ret, idx;
> +
> +	switch (addr) {
> +	case AD9832_PHASE0H:
> +		idx = 0;
> +		break;
> +	case AD9832_PHASE1H:
> +		idx = 1;
> +		break;
> +	case AD9832_PHASE2H:
> +		idx = 2;
> +		break;
> +	case AD9832_PHASE3H:
> +		idx = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
>  	if (phase >= BIT(AD9832_PHASE_BITS))
>  		return -EINVAL;
> @@ -169,10 +204,77 @@ static int ad9832_write_phase(struct ad9832_state *st,
>  			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
>  	}
>  
> -	return spi_sync(st->spi, &st->phase_msg);
> +	ret = spi_sync(st->spi, &st->phase_msg);
> +	if (ret)
> +		return ret;
> +
> +	st->phase[idx] = phase;
> +	return 0;
>  }
>  
> -static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> +static int ad9832_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad9832_state *st = iio_priv(indio_dev);
> +
> +	if (val < 0)
> +		return -EINVAL;

Check val2 as well.  Should be zero.


> +
> +	guard(mutex)(&st->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		return ad9832_write_frequency(st, chan->address, val);
> +	case IIO_CHAN_INFO_PHASE:
> +		return ad9832_write_phase(st, chan->address, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static ssize_t ad9832_store(struct device *dev,
> +			    struct device_attribute *attr,
>  			    const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -183,20 +285,10 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  
>  	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
> -	mutex_lock(&st->lock);
> -	switch ((u32)this_attr->address) {
> -	case AD9832_FREQ0HM:
> -	case AD9832_FREQ1HM:
> -		ret = ad9832_write_frequency(st, this_attr->address, val);
> -		break;
> -	case AD9832_PHASE0H:
> -	case AD9832_PHASE1H:
> -	case AD9832_PHASE2H:
> -	case AD9832_PHASE3H:
> -		ret = ad9832_write_phase(st, this_attr->address, val);
> -		break;
> +	guard(mutex)(&st->lock);

Ideally do guard() changes in a separate patch as seems unrelated to the
other stuff going on here. I'd suggest making that change first.

> +	switch (this_attr->address) {
>  	case AD9832_PINCTRL_EN:
>  		st->ctrl_ss &= ~AD9832_SELSRC;
>  		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
> @@ -206,13 +298,13 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
>  	case AD9832_FREQ_SYM:
> -		if (val == 1 || val == 0) {
> -			st->ctrl_fp &= ~AD9832_FREQ;
> -			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
> -		} else {
> +		if (val != 1 && val != 0) {
>  			ret = -EINVAL;

With guard, should be able to directly return in error cases
simplifying the flow and helping code readability.  That's one of the
nicest things guard() enables.

>  			break;
>  		}
> +
> +		st->ctrl_fp &= ~AD9832_FREQ;
> +		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val);
>  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  						  st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
> @@ -243,47 +335,56 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&st->lock);
>  
> -error_ret:
>  	return ret ? ret : len;
>  }

>  
> @@ -309,15 +412,15 @@ static int ad9832_probe(struct spi_device *spi)
>  
>  	ret = devm_regulator_get_enable(&spi->dev, "avdd");
>  	if (ret)
> -		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
> +		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD supply\n");
>  
>  	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
> -		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
> +		return dev_err_probe(&spi->dev, ret, "failed to enable DVDD supply\n");
>  
>  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
> -		return PTR_ERR(st->mclk);
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
This is an unrelated change.  Do it in a separate patch for just the dev_err_probe()
usage.

>  


