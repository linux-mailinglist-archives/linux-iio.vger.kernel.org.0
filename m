Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10058C2F11
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJAIoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 04:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfJAIoG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Oct 2019 04:44:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5B9215EA;
        Tue,  1 Oct 2019 08:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569919444;
        bh=r0+WZu1njzJ4yUatFF10Sz7m/V9UmgsgaTaMt2erY38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WejM8JGefkfqN3gtu1vBd3fLTozGlI+60X2pcoEvKMETilAgXKV9atO+lPSotM2Pd
         pWwWU+zDKkqkl1QU2KbPQUBjdkrVBY/uycruOc2eGN4jukazfy7L0gu+B/4l0Mn8/8
         4mVR56b0ntkWAKftbhcRDH/kRD0Q2smXcpLDxe8w=
Date:   Tue, 1 Oct 2019 09:43:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: stm32-timer: fix the usage of
 uninitialized variables
Message-ID: <20191001094355.65d873a3@archlinux>
In-Reply-To: <20190930204451.28614-1-yzhai003@ucr.edu>
References: <20190930204451.28614-1-yzhai003@ucr.edu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Sep 2019 13:44:49 -0700
Yizhuo <yzhai003@ucr.edu> wrote:

> Several functions in this file are trying to use regmap_read() to
> initialize the specific variable, however, if regmap_read() fails,
> the variable could be uninitialized but used directly, which is
> potentially unsafe. The return value of regmap_read() should be
> checked and handled. This patch fixes most of the uninitialized
> variables, but those in function stm32_tt_read_frequency() are
> hard to handle and need extra effot.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

Hi Yizhuo,

This is a slightly interesting case.

=46rom an 'obviously' correct point of view, it makes sense to
always handle the errors and avoid the potentially uninitialised
cases.

=46rom the point of view of a 'fix' we need to show if these can
actually happen.  These calls are regmap-mmio so the error
path is in clock enable / disable if there is a clock provided.
Looking at mfd/stm-timers.c there is a clock called "int" provided.
Now it's possible that clock enable can never fail, but that is
getting too hard to chase down.

As such, I think this fix is worthwhile, but I'm not going to
mark it for stable without a report of it actually being
possible to trigger it.

I'll leave this on the list for a little longer though as I'd definitely
like an ack from Benjamin or someone else more familiar with the driver
than I am.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 98 ++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trig=
ger/stm32-timer-trigger.c
> index a5dfe65cd9b9..f8ea7bcbb739 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -107,6 +107,7 @@ static int stm32_timer_start(struct stm32_timer_trigg=
er *priv,
>  	unsigned long long prd, div;
>  	int prescaler =3D 0;
>  	u32 ccer, cr1;
> +	int ret;
> =20
>  	/* Period and prescaler values depends of clock rate */
>  	div =3D (unsigned long long)clk_get_rate(priv->clk);
> @@ -132,11 +133,21 @@ static int stm32_timer_start(struct stm32_timer_tri=
gger *priv,
>  	}
> =20
>  	/* Check if nobody else use the timer */
> -	regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	ret =3D regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	if (ret) {
> +		dev_err(priv->dev, "fail to read TIM_CCER.\n");
> +		return ret;
> +	}
> +
>  	if (ccer & TIM_CCER_CCXE)
>  		return -EBUSY;
> =20
> -	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	ret =3D regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	if (ret) {
> +		dev_err(priv->dev, "fail to read TIM_CR1.\n");
> +		return ret;
> +	}
> +
>  	if (!(cr1 & TIM_CR1_CEN))
>  		clk_enable(priv->clk);
> =20
> @@ -164,12 +175,23 @@ static int stm32_timer_start(struct stm32_timer_tri=
gger *priv,
>  static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  {
>  	u32 ccer, cr1;
> +	int ret;
> +
> +	ret =3D regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	if (ret) {
> +		dev_err(priv->dev, "Fail to read TIM_CCER.\n");
> +		return;
> +	}
> =20
> -	regmap_read(priv->regmap, TIM_CCER, &ccer);
>  	if (ccer & TIM_CCER_CCXE)
>  		return;
> =20
> -	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	ret =3D regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	if (ret) {
> +		dev_err(priv->dev, "Fail to read TIM_CR1.\n");
> +		return;
> +	}
> +
>  	if (cr1 & TIM_CR1_CEN)
>  		clk_disable(priv->clk);
> =20
> @@ -403,20 +425,36 @@ static int stm32_counter_read_raw(struct iio_dev *i=
ndio_dev,
>  {
>  	struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>  	u32 dat;
> +	int ret;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		regmap_read(priv->regmap, TIM_CNT, &dat);
> +		ret =3D regmap_read(priv->regmap, TIM_CNT, &dat);
> +		if (ret) {
> +			dev_err(priv->dev, "fail to read TIM_CNT.\n");
> +			return ret;
> +		}
> +
>  		*val =3D dat;
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_ENABLE:
> -		regmap_read(priv->regmap, TIM_CR1, &dat);
> +		ret =3D regmap_read(priv->regmap, TIM_CR1, &dat);
> +		if (ret) {
> +			dev_err(priv->dev, "fail to read TIM_CR1.\n");
> +			return ret;
> +		}
> +
>  		*val =3D (dat & TIM_CR1_CEN) ? 1 : 0;
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_SCALE:
> -		regmap_read(priv->regmap, TIM_SMCR, &dat);
> +		ret =3D regmap_read(priv->regmap, TIM_SMCR, &dat);
> +		if (ret) {
> +			dev_err(priv->dev, "fail to read TIM_SMCR.\n");
> +			return ret;
> +		}
> +
>  		dat &=3D TIM_SMCR_SMS;
> =20
>  		*val =3D 1;
> @@ -438,6 +476,7 @@ static int stm32_counter_write_raw(struct iio_dev *in=
dio_dev,
>  {
>  	struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>  	u32 dat;
> +	int ret;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -449,13 +488,23 @@ static int stm32_counter_write_raw(struct iio_dev *=
indio_dev,
> =20
>  	case IIO_CHAN_INFO_ENABLE:
>  		if (val) {
> -			regmap_read(priv->regmap, TIM_CR1, &dat);
> +			ret =3D regmap_read(priv->regmap, TIM_CR1, &dat);
> +			if (ret) {
> +				dev_err(priv->dev, "fail to read TIM_CR1.\n");
> +				return ret;
> +			}
> +
>  			if (!(dat & TIM_CR1_CEN))
>  				clk_enable(priv->clk);
>  			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  					   TIM_CR1_CEN);
>  		} else {
> -			regmap_read(priv->regmap, TIM_CR1, &dat);
> +			ret =3D regmap_read(priv->regmap, TIM_CR1, &dat);
> +			if (ret) {
> +				dev_err(priv->dev, "fail to read TIM_CR1.\n");
> +				return ret;
> +			}
> +
>  			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  					   0);
>  			if (dat & TIM_CR1_CEN)
> @@ -517,8 +566,13 @@ static int stm32_get_trigger_mode(struct iio_dev *in=
dio_dev,
>  {
>  	struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>  	u32 smcr;
> +	int ret;
> =20
> -	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +	ret =3D regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +	if (ret) {
> +		dev_err(priv->dev, "fail to read TIM_SMCR.\n");
> +		return ret;
> +	}
> =20
>  	return (smcr & TIM_SMCR_SMS) =3D=3D TIM_SMCR_SMS ? 0 : -EINVAL;
>  }
> @@ -557,6 +611,7 @@ static int stm32_set_enable_mode(struct iio_dev *indi=
o_dev,
>  	struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>  	int sms =3D stm32_enable_mode2sms(mode);
>  	u32 val;
> +	int ret;
> =20
>  	if (sms < 0)
>  		return sms;
> @@ -565,7 +620,12 @@ static int stm32_set_enable_mode(struct iio_dev *ind=
io_dev,
>  	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
>  	 */
>  	if (sms =3D=3D 6) {
> -		regmap_read(priv->regmap, TIM_CR1, &val);
> +		ret =3D regmap_read(priv->regmap, TIM_CR1, &val);
> +		if (ret) {
> +			dev_err(priv->dev, "fail to read TIM_CR1.\n");
> +			return ret;
> +		}
> +
>  		if (!(val & TIM_CR1_CEN))
>  			clk_enable(priv->clk);
>  	}
> @@ -594,8 +654,14 @@ static int stm32_get_enable_mode(struct iio_dev *ind=
io_dev,
>  {
>  	struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>  	u32 smcr;
> +	int ret;
> +
> +	ret =3D regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +	if (ret) {
> +		dev_err(priv->dev, "fail to read TIM_SMCR.\n");
> +		return ret;
> +	}
> =20
> -	regmap_read(priv->regmap, TIM_SMCR, &smcr);
>  	smcr &=3D TIM_SMCR_SMS;
> =20
>  	return stm32_sms2enable_mode(smcr);
> @@ -706,13 +772,19 @@ EXPORT_SYMBOL(is_stm32_timer_trigger);
>  static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
>  {
>  	u32 val;
> +	int ret;
> =20
>  	/*
>  	 * Master mode selection 2 bits can only be written and read back when
>  	 * timer supports it.
>  	 */
>  	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
> -	regmap_read(priv->regmap, TIM_CR2, &val);
> +	ret =3D regmap_read(priv->regmap, TIM_CR2, &val);
> +	if (ret) {
> +		dev_err(priv->dev, "fail to read TIM_CR2.\n");
> +		return;
> +	}
> +
>  	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
>  	priv->has_trgo2 =3D !!val;
>  }

