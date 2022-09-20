Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1455BF009
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 00:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiITWXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiITWXk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 18:23:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE952FFE
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1663712616; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tO+vmLeootHFQmN3/+TkPvD008MTJfgpTAz5k+oP+WY=;
        b=jwcBlLLeuEX1zfAF1yFSHkkXqCtgZbzVcB7xoH1MKG8AaxzM9v8gCYfCazL4D6Jwk6jPCc
        BAoJqfRuPKq6QUpMuBOwIrF2jedt1fECqWoWxXWoRsv/fcce7KX5699OW0jR63NXEek9eu
        Um7JtGjU6ZQ6E4KpZ4gj/H3Xcs98kzk=
Date:   Tue, 20 Sep 2022 23:23:26 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] iio: light: vcnl4000: Preserve conf bits when toggle
 power
To:     =?iso-8859-1?q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel@axis.com
Message-Id: <2V4JIR.7354DS8U39Q53@crapouillou.net>
In-Reply-To: <20220920180958.2308229-2-marten.lindahl@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
        <20220920180958.2308229-2-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi M=E5rten,

Le mar., sept. 20 2022 at 20:09:56 +0200, M=E5rten Lindahl=20
<marten.lindahl@axis.com> a =E9crit :
> As the vcnl4040 and vcnl4200 chip uses runtime power management for
> turning the ambient light and proximity sensors on/off, it overwrites
> the entire register each time. In ALS_CONF register bit fields ALS_IT,
> ALS_PERS, ALS_INT_EN are overwritten. In PS_CONF1 register bit fields
> PS_DUTY, PS_PERS, PS_IT, PS_HD, and PS_INT are overwritten.
>=20
> Add functions for preserving the affected bit fields when changing=20
> power
> state.
>=20
> Signed-off-by: M=E5rten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/iio/light/vcnl4000.c | 53=20
> ++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c=20
> b/drivers/iio/light/vcnl4000.c
> index 3db4e26731bb..0b226c684957 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -74,6 +74,9 @@
>  #define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
>  #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed=20
> measurement */
>=20
> +#define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light=20
> sensor */
> +#define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> +
>  /* Bit masks for interrupt registers. */
>  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt=20
> source */
>  #define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
> @@ -188,16 +191,62 @@ static int vcnl4000_init(struct vcnl4000_data=20
> *data)
>  	return data->chip_spec->set_power_state(data, true);
>  };
>=20
> +static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data,=20
> int val)
> +{
> +	int ret;
> +
> +	switch (data->id) {
> +	case VCNL4040:
> +	case VCNL4200:

The switch isn't needed, since vcnl4200_set_power_state() is only=20
called for compatible chips.

> +		ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val)
> +			ret &=3D ~VCNL4040_ALS_CONF_ALS_SD;
> +		else
> +			ret |=3D VCNL4040_ALS_CONF_ALS_SD;
> +
> +		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
> +						 ret);

Are you sure a race cannot happen here?

I would assume it cannot, but that's still a bit fishy.

This driver would benefit from a regmap conversion, but it's probably a=20
bit too much to ask...

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data,=20
> int val)
> +{
> +	int ret;
> +
> +	switch (data->id) {
> +	case VCNL4040:
> +	case VCNL4200:
> +		ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val)
> +			ret &=3D ~VCNL4040_PS_CONF1_PS_SD;
> +		else
> +			ret |=3D VCNL4040_PS_CONF1_PS_SD;
> +
> +		return i2c_smbus_write_word_data(data->client,
> +						 VCNL4200_PS_CONF1, ret);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool=20
> on)
>  {
>  	u16 val =3D on ? 0 /* power on */ : 1 /* shut down */;
>  	int ret;
>=20
> -	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,=20
> val);
> +	ret =3D vcnl4000_write_als_enable(data, !val);

You set "val" to 0 if "on", and to 1 if "!on", then pass "!val", this=20
is very confusing. You could just pass "on" here and below.

Cheers,
-Paul

>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,=20
> val);
> +	ret =3D vcnl4000_write_ps_enable(data, !val);
>  	if (ret < 0)
>  		return ret;
>=20
> --
> 2.30.2
>=20


