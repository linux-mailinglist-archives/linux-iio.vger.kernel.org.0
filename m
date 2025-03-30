Return-Path: <linux-iio+bounces-17341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACBA75A50
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAE818883F3
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27121C8628;
	Sun, 30 Mar 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsC+wlN4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083D1CAA81;
	Sun, 30 Mar 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743344454; cv=none; b=UP/Spy2K1GMyojHqmY6ornfgoYc/HvUft2wF04LyXwBBaEWuryOQG82x/6a20n0e6r0mRjQ8Auo1uvnCY7QS2NcEMF2q4JrwdRBaucI6Dar8cQYI3dLVSyX6q3Y0mI9kdl+pJFj0ncpLMWqnT8a80Qv+yzy4Chd3yN/L/iT1WO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743344454; c=relaxed/simple;
	bh=OaAwWjCkWSKp7nR9/7svYOXrIrlAlqchiKGMbDjjjx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khDOwOVRCktMvZpKLlbMfx+kKCamwv+o2F4W2YIka9h3tYqKD7DxtUiZP7MYv5eGeAzlIv3C/qh+uv0i/3SgmdQ1Y2LkeInRJpEE7o336dWMg5adqW41D3M5j+hWryEsbiNJEGsjrvAfJbvTmzO88CpPN/cV6a+AOkEp/YDf/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsC+wlN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE77C4CEDD;
	Sun, 30 Mar 2025 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743344453;
	bh=OaAwWjCkWSKp7nR9/7svYOXrIrlAlqchiKGMbDjjjx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsC+wlN4Ukm2C6OvMvaVIEnCFM/3TCLYCuJP4Lr9ANNWW3rocEEYVqpjAWQeTkT94
	 0W+jzvVCwhW1kgnXi/GQbIl0ue/fgUrkMLpNNZbXdsQae7Q4SjOTNh7t9sKh6nzBAO
	 vUJ6CspG67Fpr5Zlo4g5NeSEaG2oLEG/SkwJdBdXPSaGUIu7yZmenZDdABJKBLtlAP
	 pbx1ZpYwxt9BTUhBtdYwrEt1PRLEbrXIDNeCbQ+Vrx+EZmX+F6xDycnWs3XbOmIjiy
	 v9HHug8NgAjmzSkC19uF2lwBc/PKKUR306mqCF8jNDmaGgL38Qp7RjJLsc8sljyMZO
	 WTSnaUgyh0x+Q==
Date: Sun, 30 Mar 2025 15:20:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
 Michael.Hennerich@analog.com, lars@metafoo.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <20250330152044.18cf81f6@jic23-huawei>
In-Reply-To: <20250330135402.105418-1-simeddon@gmail.com>
References: <20250330135402.105418-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 19:19:51 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> Use bitfield and bitmask macros to clearly specify AD9832 SPI
> command fields to make register write code more readable.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
Hi Siddharth,

I took a closer look at the original data layout handling
in here.  It doesn't make much sense to me, so perhaps we should
fix that up whilst making these other changes.

Jonathan

> ---
>  v1->v2:
>  - remove CMD_SHIFT and ADD_SHIFT
>  - use GENMASK
>  - store regval in an array and iterate through it
>  v2->v3:
>  - add missing header
>  - refactor code in the previously introduced loops
>  v3->v4:
>  - update commit message with a better one
>  - convert AD9832_PHASE and RES_MASK to masks
>  - cleanup a few if else blocks
>  v4->v5
>  - remove unnecessary inversion (val ? 0 : 1) used
>    with AD9832_PHASE_MASK introduced in v4
>  - use ARRAY_SIZE instead of fixed integers
>  - use reverse xmas tree order
>  - align mask macros
>  drivers/staging/iio/frequency/ad9832.c | 85 +++++++++++++-------------
>  1 file changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..e74d085fb4f2 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -16,6 +16,9 @@
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/unaligned.h>

Before this patch the includes were in alphabetical order.
That's preferred for IIO patches in general, but in this case
following local style makes that more important still.

>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -59,17 +62,18 @@
>  #define AD9832_CMD_SLEEPRESCLR	0xC
>  
>  #define AD9832_FREQ		BIT(11)
> -#define AD9832_PHASE(x)		(((x) & 3) << 9)
> +#define AD9832_PHASE_MASK	GENMASK(10, 9)
>  #define AD9832_SYNC		BIT(13)
>  #define AD9832_SELSRC		BIT(12)
>  #define AD9832_SLEEP		BIT(13)
>  #define AD9832_RESET		BIT(12)
>  #define AD9832_CLR		BIT(11)
> -#define CMD_SHIFT		12
> -#define ADD_SHIFT		8
>  #define AD9832_FREQ_BITS	32
>  #define AD9832_PHASE_BITS	12
> -#define RES_MASK(bits)		((1 << (bits)) - 1)
> +#define RES_MASK(bits)		GENMASK((bits) - 1, 0)

Silly question.  Is this used anywhere?  Given FIELD_PREP
etc tend not to work with non constant values I went looking
to check this was constant and couldn't find any where it is used.
As such just drop it instead!

> +#define AD9832_CMD_MSK		GENMASK(15, 12)
> +#define AD9832_ADD_MSK		GENMASK(11, 8)
> +#define AD9832_DAT_MSK		GENMASK(7, 0)
>  
>  /**
>   * struct ad9832_state - driver instance specific data
> @@ -131,6 +135,8 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  {
>  	unsigned long clk_freq;
>  	unsigned long regval;
> +	u8 regval_bytes[4];
> +	u16 freq_cmd;
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> @@ -138,19 +144,15 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  		return -EINVAL;
>  
>  	regval = ad9832_calc_freqreg(clk_freq, fout);
> +	put_unaligned_be32(regval, regval_bytes);
>  
> -	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					(addr << ADD_SHIFT) |
> -					((regval >> 24) & 0xFF));
> -	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 1) << ADD_SHIFT) |
> -					((regval >> 16) & 0xFF));
> -	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					((addr - 2) << ADD_SHIFT) |
> -					((regval >> 8) & 0xFF));
> -	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 3) << ADD_SHIFT) |
> -					((regval >> 0) & 0xFF));
> +	for (int i = 0; i < ARRAY_SIZE(regval_bytes); i++) {
> +		freq_cmd = (i % 2 == 0) ? AD9832_CMD_FRE8BITSW : AD9832_CMD_FRE16BITSW;
> +
> +		st->freq_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, freq_cmd) |
> +			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
> +			FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
Looking at the data layout here, this seems like an interesting dance to fill two unrelated
u8 values - it's not a be16 at all.

I'd be tempted to split the freq_data into u8s and then you will just have 
		st->freq_data[i][0] = FIELD_PREP(AD9832_CMD_MSK, freq_cmd) |
				      FIELD_PREP(AD9832_ADD_SMK, addr - i);
//with masks adjusted appropriately.
		st->freq_data[i][1] = regval_bytes[i];

> +	}
>  
>  	return spi_sync(st->spi, &st->freq_msg);
>  }
> @@ -158,15 +160,21 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  static int ad9832_write_phase(struct ad9832_state *st,
>  			      unsigned long addr, unsigned long phase)
>  {
> +	u8 phase_bytes[2];
> +	u16 phase_cmd;
> +
>  	if (phase >= BIT(AD9832_PHASE_BITS))
>  		return -EINVAL;
>  
> -	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
> -					(addr << ADD_SHIFT) |
> -					((phase >> 8) & 0xFF));
> -	st->phase_data[1] = cpu_to_be16((AD9832_CMD_PHA16BITSW << CMD_SHIFT) |
> -					((addr - 1) << ADD_SHIFT) |
> -					(phase & 0xFF));
> +	put_unaligned_be16(phase, phase_bytes);
> +
> +	for (int i = 0; i < ARRAY_SIZE(phase_bytes); i++) {
> +		phase_cmd = (i % 2 == 0) ? AD9832_CMD_PHA8BITSW : AD9832_CMD_PHA16BITSW;
> +
> +		st->phase_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, phase_cmd) |
> +			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
> +			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));
Similarly.

> +	}
>  
>  	return spi_sync(st->spi, &st->phase_msg);
>  }
> @@ -197,24 +205,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  		ret = ad9832_write_phase(st, this_attr->address, val);
>  		break;
>  	case AD9832_PINCTRL_EN:
> -		if (val)
> -			st->ctrl_ss &= ~AD9832_SELSRC;
> -		else
> -			st->ctrl_ss |= AD9832_SELSRC;
> -		st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
> +		st->ctrl_ss &= ~AD9832_SELSRC;
> +		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
> +
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
>  					st->ctrl_ss);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
>  	case AD9832_FREQ_SYM:
> -		if (val == 1) {
> -			st->ctrl_fp |= AD9832_FREQ;
> -		} else if (val == 0) {
> +		if (val == 1 || val == 0) {
>  			st->ctrl_fp &= ~AD9832_FREQ;
> +			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 0 : 1);
>  		} else {
>  			ret = -EINVAL;
>  			break;
>  		}
> -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  					st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
> @@ -224,21 +230,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  			break;
>  		}
>  
> -		st->ctrl_fp &= ~AD9832_PHASE(3);
> -		st->ctrl_fp |= AD9832_PHASE(val);
> +		st->ctrl_fp &= ~FIELD_PREP(AD9832_PHASE_MASK, 3);
> +		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);
>  
> -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  					st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
>  	case AD9832_OUTPUT_EN:
> -		if (val)
> -			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
> -					AD9832_CLR);
> -		else
> -			st->ctrl_src |= AD9832_RESET;
> +		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
> +		st->ctrl_src |= FIELD_PREP(AD9832_RESET, val ? 0 : 1);
>  
> -		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
>  					st->ctrl_src);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
> @@ -396,7 +399,7 @@ static int ad9832_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
>  
>  	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
> -	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> +	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
>  					st->ctrl_src);
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret) {


