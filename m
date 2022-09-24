Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC065E8E88
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiIXQkn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiIXQkk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 12:40:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508731EE3
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 09:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02AA9B80D8C
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 16:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447C8C433C1;
        Sat, 24 Sep 2022 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664037636;
        bh=AQ4np5g5Y55qdbJqr3htHt3mfXcUG+Hmd5T+lTWrWNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dEReH1PRb66uvU3ZL5acrmyFdjcPN76516+5mDUS0PUmx/El+w3WrQJPJXkEQu15M
         1amsgd5xR1dWbcqtJCfHtUMv2UX/XMFbCpOlXA58ek7prvLpEWDyJOlDB57fsFtcWp
         75o9VvTOxndu5NR4+4i+wmRhh64tPWzRu/yTCsjYvCos3XWzE2gelJ2u4mcCIiGwh9
         x1vVKC9bUDP87AwzPVW7Qos8krLGyocU1zCbwC+AjJrWl1IUhZtMzyz/mqaednDVVg
         cX48n72dfYYwRbLAZD8pk1TuTh2L1O1fvQerC9bgEZ1VgWrJZwMmHe/y65XCOMwa/e
         MqPoaAHgyhadA==
Date:   Sat, 24 Sep 2022 17:40:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH v2 2/2] iio: light: vcnl4000: Add ps_it attributes for
 vcnl4040
Message-ID: <20220924174044.44ecb02f@jic23-huawei>
In-Reply-To: <20220923114031.757011-3-marten.lindahl@axis.com>
References: <20220923114031.757011-1-marten.lindahl@axis.com>
        <20220923114031.757011-3-marten.lindahl@axis.com>
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

On Fri, 23 Sep 2022 13:40:31 +0200
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> Add read/write attribute for proximity integration time, and read
> attribute for available proximity integration times for the vcnl4040
> chip.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Hi M=C3=A5rten,

One minor comment inline given I've asked for changes that mean you'll
probably be doing a v3 anyway.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 129 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index b2ecf8af1aa5..056079b592c6 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -17,6 +17,7 @@
>   *   interrupts (VCNL4040, VCNL4200)
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> @@ -76,6 +77,7 @@
> =20
>  #define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light sensor */
>  #define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> +#define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration t=
ime */
> =20
>  /* Bit masks for interrupt registers. */
>  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source=
 */
> @@ -104,6 +106,17 @@ static const int vcnl4010_prox_sampling_frequency[][=
2] =3D {
>  	{250, 0},
>  };
> =20
> +static const int vcnl4040_ps_it_times[][2] =3D {
> +	{0, 100},
> +	{0, 150},
> +	{0, 200},
> +	{0, 250},
> +	{0, 300},
> +	{0, 350},
> +	{0, 400},
> +	{0, 800},
> +};
> +
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspe=
nd */
> =20
>  enum vcnl4000_device_ids {
> @@ -470,6 +483,55 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl=
4000_data *data, bool on)
>  	return ret;
>  }
> =20
> +static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int=
 *val2)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
> +
> +	if (ret >=3D ARRAY_SIZE(vcnl4040_ps_it_times))
> +		return -EINVAL;
> +
> +	*val =3D vcnl4040_ps_it_times[ret][0];
> +	*val2 =3D vcnl4040_ps_it_times[ret][1];
> +
> +	return 0;
> +}
> +
> +static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index =3D -1;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
> +		if (val =3D=3D vcnl4040_ps_it_times[i][1]) {
> +			index =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D (ret & ~VCNL4040_PS_CONF2_PS_IT) |
> +	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);

It can be confusing to read ret both as a temporary to build value ad for t=
he
return code. I would introduce a
u16 val
and build the value in that.

> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}
> +
