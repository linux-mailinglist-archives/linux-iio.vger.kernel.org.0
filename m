Return-Path: <linux-iio+bounces-12072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8509C2D90
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5163A281D09
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9401925A2;
	Sat,  9 Nov 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADeTmWjw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749E13CA9C;
	Sat,  9 Nov 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159535; cv=none; b=I1q0j1TCKj6liRYZlNY7W3xuOeEFoql78R+OaOC0vXSI+aGEtuz3m+iBKNp1D0Db3k0owNT5xniZoP4UJ0Iz/LGJtsd7gtoSY/IG5X5zrXq9sIF27rCvmoGKNFWCKLXbEFSGew8yBz5v47haYDv9r2VYCb5PkglHlZfLnfig1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159535; c=relaxed/simple;
	bh=xK1EstYJfmUBR3r7y6GFUc08EvB9qxw1bqmlRdrQcF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANJTVl1YNrz2PoT6YM8w1Rjfwfiku84Y5CD2+uSDkVJ1/ZWE6QXk2EInqz1H9+qYEs6eowUq3FvrAtZv5/kOdNzpJwu6niLZif92d01Oi6U3rsNee3cdRYRndwzbg17eUhg1YwCXAL/IOuJhTQk82g9SE18PvtB7TD668njceD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADeTmWjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A25C4CECE;
	Sat,  9 Nov 2024 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731159534;
	bh=xK1EstYJfmUBR3r7y6GFUc08EvB9qxw1bqmlRdrQcF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ADeTmWjwb3WD427+fGGhLNAluQKlEQ2wdBBtW0j+yy9VeySlBj1L9qsNqx/UIA/R1
	 9eZfcOswmFCsgukKcl4ouBL5YZi49BlXlXygckbhYWV4JxHZ/3FFlJoYRB7Ctu/T1R
	 DfT2L045tlyctq1Y350RXrTQJHSWLWt6vJPcmWea/e1a9McHAj0aeq6uCiW13rHi6I
	 DBH4eyucf1I+R53eTWVE6A0KxS78RYW69HiZAWj33wxHUurnjM8y4VIcBdDQulDshI
	 YB4FdLmSBYIig1+vuu2JHxQok6o8KT/51vGjkli65JI9MyFmCpYRZFU/LvSQPcm2RK
	 61uieIB7cpVYQ==
Date: Sat, 9 Nov 2024 13:38:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com,
 benjamin.gaignard@linaro.org, lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
Message-ID: <20241109133846.53d7ef06@jic23-huawei>
In-Reply-To: <20241108200900.44727-1-jiashengjiangcool@gmail.com>
References: <20241108200900.44727-1-jiashengjiangcool@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 20:09:00 +0000
Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:

> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Hi,

In principle this is fine, but I'd rather we made use of guard()
/ scoped_guard() rather than adding the explicit unlocks.

If you do that as a precursor patch in appropriate places
in the driver then this will be a little cleaner.

Note I'll not be taking this until next cycle now anyway.

Jonathan

> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Remove unsuitable dev_err_probe().
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 32 ++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 0684329956d9..e1e077122f73 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -119,7 +119,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  			     unsigned int frequency)
>  {
>  	unsigned long long prd, div;
> -	int prescaler = 0;
> +	int prescaler = 0, ret;
>  	u32 ccer;
>  
>  	/* Period and prescaler values depends of clock rate */
> @@ -153,7 +153,11 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  	mutex_lock(&priv->lock);
>  	if (!priv->enabled) {
>  		priv->enabled = true;
> -		clk_enable(priv->clk);
> +		ret = clk_enable(priv->clk);
> +		if (ret) {
> +			mutex_unlock(&priv->lock);

as below guard() for when the mutex is locked is cleaner.

> +			return ret;
> +		}
>  	}
>  
>  	regmap_write(priv->regmap, TIM_PSC, prescaler);
> @@ -307,7 +311,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	u32 mask, shift, master_mode_max;
> -	int i;
> +	int i, ret;
>  
>  	if (stm32_timer_is_trgo2_name(trig->name)) {
>  		mask = TIM_CR2_MMS2;
> @@ -326,7 +330,11 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  			if (!priv->enabled) {
>  				/* Clock should be enabled first */
>  				priv->enabled = true;
> -				clk_enable(priv->clk);
> +				ret = clk_enable(priv->clk);
> +				if (ret) {
> +					mutex_unlock(&priv->lock);
As below. Prefer use of guard() so we don't have to handle the unlock manually.
> +					return ret;
> +				}
>  			}
>  			regmap_update_bits(priv->regmap, TIM_CR2, mask,
>  					   i << shift);
> @@ -482,6 +490,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  				   int val, int val2, long mask)
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -496,7 +505,11 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  		if (val) {
>  			if (!priv->enabled) {
>  				priv->enabled = true;
> -				clk_enable(priv->clk);
> +				ret = clk_enable(priv->clk);
> +				if (ret) {
> +					mutex_unlock(&priv->lock);
Add include of cleanup.h and swithch the place where the mutex is locked to
guard(mutex)(&priv->lock);
then remember to drop the explicit unlocks.


> +					return ret;
> +				}
>  			}
>  			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>  		} else {
> @@ -601,7 +614,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  				 unsigned int mode)
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> -	int sms = stm32_enable_mode2sms(mode);
> +	int sms = stm32_enable_mode2sms(mode), ret;
>  
>  	if (sms < 0)
>  		return sms;
> @@ -611,7 +624,12 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  	 */
>  	mutex_lock(&priv->lock);

Perhaps scoped_guard() is  appropriate here.

>  	if (sms == 6 && !priv->enabled) {
> -		clk_enable(priv->clk);
> +		ret = clk_enable(priv->clk);
> +		if (ret) {
> +			mutex_unlock(&priv->lock);
> +			return ret;
> +		}
> +
>  		priv->enabled = true;
>  	}
>  	mutex_unlock(&priv->lock);


