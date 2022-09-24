Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AC5E8E83
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIXQhT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIXQhS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 12:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0137CA9E
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 09:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3785861480
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 16:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D933C433D6;
        Sat, 24 Sep 2022 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664037436;
        bh=cjynVjVmJ+nzLV+qxnUA1K6wGgEfnigced/SZFmyJWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6bMaN2p74KCZaNZCEFsehqDTwLXHi+o+4O8FSkjeMV3F5ukM8cTerFZFHnOyPa/1
         2YY1ZDVCav9A1o7a7YK4hYHePXrK69VUOAhVxrxx8Jmhj9U6pLcAUQAqwep57Yks/I
         DmHg33cBw7URKOJQYuf7+hEZVkiwHtJofdf5b5WY2pjvZB4xNXFPpP1bMKRvhplnsT
         y6Yp7eMqh3bdszJ9ag2TzaUCIwsQ+/lCbYs/NbHz2euGDtyiAONfW4tVqojEx3O6Ak
         OokMikZdnHzFofDJAeEn9X5STp8aZO0uqjL5U2d4xZefhj5/wqVo1LDtHdLCCRm2i7
         5+DPw9epxpUdw==
Date:   Sat, 24 Sep 2022 17:37:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH v2 1/2] iio: light: vcnl4000: Preserve conf bits when
 toggle power
Message-ID: <20220924173724.374305c9@jic23-huawei>
In-Reply-To: <20220923114031.757011-2-marten.lindahl@axis.com>
References: <20220923114031.757011-1-marten.lindahl@axis.com>
        <20220923114031.757011-2-marten.lindahl@axis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Sep 2022 13:40:30 +0200
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> As the vcnl4040 and vcnl4200 chip uses runtime power management for
> turning the ambient light and proximity sensors on/off, it overwrites
> the entire register each time. In ALS_CONF register bit fields ALS_IT,
> ALS_PERS, ALS_INT_EN are overwritten. In PS_CONF1 register bit fields
> PS_DUTY, PS_PERS, PS_IT, PS_HD, and PS_INT are overwritten.
>=20
> Add functions for preserving the affected bit fields when changing power
> state.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
See inline.
Otherwise looks good to me.

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 54 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 3db4e26731bb..b2ecf8af1aa5 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -74,6 +74,9 @@
>  #define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
>  #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
> =20
> +#define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light sensor */

Comment seems inverted. Bit being set is 'shut down'  I would expand the
name to
VCNL4040_ALS_CONF_ALS_SHUTDOWN=20
then drop the comment as the name is self explanatory

> +#define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> +
>  /* Bit masks for interrupt registers. */
>  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source=
 */
>  #define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
> @@ -188,16 +191,61 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  	return data->chip_spec->set_power_state(data, true);
>  };
> =20
> +static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, boo=
l en)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (en)
> +		ret &=3D ~VCNL4040_ALS_CONF_ALS_SD;
> +	else
> +		ret |=3D VCNL4040_ALS_CONF_ALS_SD;
> +
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool=
 en)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (en)
> +		ret &=3D ~VCNL4040_PS_CONF1_PS_SD;
> +	else
> +		ret |=3D VCNL4040_PS_CONF1_PS_SD;
> +
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
>  static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
>  {
> -	u16 val =3D on ? 0 /* power on */ : 1 /* shut down */;
>  	int ret;
> =20
> -	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
> +	ret =3D vcnl4000_write_als_enable(data, on);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> +	ret =3D vcnl4000_write_ps_enable(data, on);
>  	if (ret < 0)
>  		return ret;
> =20

