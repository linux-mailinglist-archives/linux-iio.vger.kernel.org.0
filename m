Return-Path: <linux-iio+bounces-20825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5DAE2AD8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFDA18872E6
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521A1D63CD;
	Sat, 21 Jun 2025 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5OdYf6I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF1221DAC;
	Sat, 21 Jun 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527531; cv=none; b=SsSqTYN9kvvQoizn5jOVsZHk7Wd28/3IKGAUpRkGzkFaa9+3sYzpqO1B14uqsBhyBPKlVIZ12KhY1/UCMvrvP3bmqS+UlvlOL3Q6lXo8StvZr4z4Y9EJILBnwPR7eC1PFKQsxFgtnUgTBR9zChLVWonD2aJsl5IaO4Ynq4h9TW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527531; c=relaxed/simple;
	bh=VZrKRyCSUhrPDO+F+biiKTBzzgQ/qPMTR1uyl+Vn/L0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K310SkyFaGd7wLw+MgawKmlSp79WO2za155PEr9uGsg2kbsKLDT+DGI8X9Q8REvPeJ+kf3BVrWbP4aAV6ofTX8oluylWckWnlzCkWC8cgbyEhIB6pesw45rbFaQaDKwWI+V/8i83Qkzj14j2pX0+6sSJxgx2hjpUK1l/tV2Ovgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5OdYf6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123DDC4CEE7;
	Sat, 21 Jun 2025 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527530;
	bh=VZrKRyCSUhrPDO+F+biiKTBzzgQ/qPMTR1uyl+Vn/L0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5OdYf6IaxnvzlokeKkPAldatztDh7YCTPjsjM3IAfdurJcuWp0iAUyBHKfA8lylx
	 RZrRm4e7qv4ydCVHgqFC7Sp7pOvt7NN19Ee7Et5+Fc11q/inEN4yzUImuMaHuBV7Ia
	 cmfadX3b964+cqxZ3l4omOlmratuobWgDrES4IsFBI1LMFwSBElgDeFd+TdejTqta5
	 CgZHA/Iyth1r0wIEFPwlQMZ8GXAVLNHIXks30yk6Kj7pGkRdUg7kFaItpO15y4SP8T
	 53vSk7TQI2qTxAV5QiKhNnBmkl7xoZwaBtjCWxb9ZYAC/0jKefklBPYemse9m2kEBD
	 LRuzgBIjYYNBg==
Date: Sat, 21 Jun 2025 18:38:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
Message-ID: <20250621183843.2f8bcb48@jic23-huawei>
In-Reply-To: <20250618031638.26477-2-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
	<20250618031638.26477-2-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 00:12:16 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Remove sca3000_read_data_short() function, replacing it by spi_w8r8()
> and spi_w8r16be() helpers.
> 
> This is an old driver that was not making full use of the newer
> infrastructure.
> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Hi. I made two related tweaks.  A few comments inline for further possible cleanup.

Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to take a look at it.

Thanks,

Jonathan


diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index c85a06cbea37..eb0cad22474e 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -589,8 +589,7 @@ static int sca3000_read_raw_samp_freq(struct sca3000_state *st, int *val)
                return ret;
 
        if (*val > 0) {
-               ret &= SCA3000_REG_OUT_CTRL_BUF_DIV_MASK;
-               switch (ret) {
+               switch (ret & SCA3000_REG_OUT_CTRL_BUF_DIV_MASK) {
                case SCA3000_REG_OUT_CTRL_BUF_DIV_2:
                        *val /= 2;
                        break;
@@ -644,8 +643,7 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
                return ret;
 
        /* mask bottom 2 bits - only ones that are relevant */
-       ret &= SCA3000_REG_MODE_MODE_MASK;
-       switch (ret) {
+       switch (ret & SCA3000_REG_MODE_MODE_MASK) {
        case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
                *val = st->info->measurement_mode_3db_freq;
                return IIO_VAL_INT;



>  /**
> @@ -427,13 +406,13 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> -	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR));
>  	if (ret < 0)
>  		goto error_ret;
>  	dev_info(&indio_dev->dev,
>  		 "sca3000 revision major=%lu, minor=%lu\n",
> -		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
> -		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
> +		 ret & SCA3000_REG_REVID_MAJOR_MASK,
> +		 ret & SCA3000_REG_REVID_MINOR_MASK);
Hmm. doesn't belong in this patch but it is rather odd to not see
a shift on one of these.

Hmm. Time to miss quote whoever it was who said:

"kernel development is like a murder mystery where you try to solve
 the crime only to realize you were the murderer."

Below I mention using FIELD_GET() in appropriate places as a possible additional
cleanup.  Fix this up when you do that (and note it in the patch description for
that patch).

>  error_ret:
>  	mutex_unlock(&st->lock);
>  
> @@ -570,7 +549,7 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
>  {
>  	int ret;
>  
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
>  	if (ret)
>  		return ret;
>  
> @@ -660,13 +639,13 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
>  {
>  	int ret;
>  
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
>  	if (ret)
>  		return ret;
>  
>  	/* mask bottom 2 bits - only ones that are relevant */
> -	st->rx[0] &= SCA3000_REG_MODE_MODE_MASK;
> -	switch (st->rx[0]) {
> +	ret &= SCA3000_REG_MODE_MODE_MASK;
> +	switch (ret) {
See discussion below.  This can be simplified as
	switch (reg & SCA3000_REG_MODE_MASK)
avoiding the modified 'ret' value in place comment.

This one I'll tweak as it is easy to avoid the ugly pattern.

>  	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
>  		*val = st->info->measurement_mode_3db_freq;
>  		return IIO_VAL_INT;
> @@ -698,14 +677,14 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
>  		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
>  	else
>  		return -EINVAL;
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
>  	if (ret)
>  		return ret;
>  
> -	st->rx[0] &= ~SCA3000_REG_MODE_MODE_MASK;
> -	st->rx[0] |= (mode & SCA3000_REG_MODE_MODE_MASK);
> +	ret &= ~SCA3000_REG_MODE_MODE_MASK;

For a further potential cleanup it would be good to use FIELD_GET() and FIELD_PREP()
in appropriate places in this driver. Do that into a separate local variable
as using ret for all this is a little confusing as quite a bit of the time
it's not a variable we are ever going to return.

As a rule of thumb if we are modifying the ret only a little in a single reuse
(i.e. masking out a bit in a parameter being passed to something else) then
a local variable is probably overkill. If we are building up a new register
value it is not really appropriate to do it into ret.

I'm not asking for changes in this patch though as what you have here
is the simplest and easiest to review change.  If you add those extra
local variables as part of using FIELD_GET/ FIELD_PREP though that would
be great.



> +	ret |= mode & SCA3000_REG_MODE_MODE_MASK;
>  
> -	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
> +	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, ret);
>  }


