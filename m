Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340A655268
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiLWPrt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 10:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiLWPrs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 10:47:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9AD28E14
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 07:47:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34DB9B81FEF
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 15:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C3C433EF;
        Fri, 23 Dec 2022 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671810464;
        bh=p1NhYbmIRnsdPGHapDpLQNESVQbHt9ZkLEhRtqOOoZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKdOD52H/y2UNt9b38Ow/7+IOUBS71gxySYtpAIK+WJtSFyHqzrBqHplH9kOtcPjq
         RXi1oH4P6ltqtRvW9G2dPRJfAW/dKDG0Yvh8xrYyU3AGI+NfeQ5L0CJSJrQArAHNtk
         CBFGoTWtCtk3cfbC9oTnyifGsoT9GMhhkNunF9c1hZpiHEiOJISY6qT5ZUtCbJlpDq
         3WlkiUGxBzXRUdRdPPQIOqwHqJ06lRLgwpe3GqLtJA8o+O867lfLlcizA3FkgUE4Jy
         +KRGRuFHOnIx0nCiX+ZeKKxpMNcxaB42mcW6rPtk2dVz9hTsX18PRa9jA44PCkXf1B
         6zLIOlmQtm9CA==
Date:   Fri, 23 Dec 2022 16:00:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Message-ID: <20221223160054.316c473f@jic23-huawei>
In-Reply-To: <20221220214959.2289330-3-marten.lindahl@axis.com>
References: <20221220214959.2289330-1-marten.lindahl@axis.com>
        <20221220214959.2289330-3-marten.lindahl@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Tue, 20 Dec 2022 22:49:59 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> Add support to configure proximity sensor interrupts and threshold
> limits for vcnl4040. If an interrupt is detected an event will be
> pushed to the event interface.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Hi,

Code looks good in general. A few readability related suggestions inline.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 163 +++++++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 142d1760f65d..61d18c404ea6 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -60,8 +60,11 @@

...

>  /* Bit masks for interrupt registers. */
>  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source=
 */
> @@ -138,6 +144,7 @@ struct vcnl4000_data {
>  	enum vcnl4000_device_ids id;
>  	int rev;
>  	int al_scale;
> +	int ps_int;

Bit big for 2 bits ;)  Maybe size it same as register size.

Also, probably benefit from a comment as ps_int isn't a particularly obviou=
sly name.

>  	const struct vcnl4000_chip_spec *chip_spec;
>  	struct mutex vcnl4000_lock;
>  	struct vcnl4200_channel vcnl4200_al;


...

> =20
> +static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> +
> +	return (dir =3D=3D IIO_EV_DIR_RISING) ?
> +	    (data->ps_int & 0x01) : (data->ps_int & 0x02) >> 1;

Add some field definitions and FIELD_GET() to extract them.

> +}
> +
> +static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir, int state)
> +{
> +	int ret;
> +	u16 val;
> +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		goto out;
> +
> +	val =3D FIELD_GET(VCNL4040_PS_CONF2_PS_INT, ret);
> +
> +	if (dir =3D=3D IIO_EV_DIR_RISING)
> +		val =3D state ? (val | 0x1) : (val & 0x2);

Whilst I'm sure this is correct, it's not easy to follow. Perhaps
		val =3D state ? (val | 0x1) : (val & ~0x1);
to make it clear you are turning on an off one bit?
Also as above, some field definitions may make this easier to follow.

> +	else
> +		val =3D state ? (val | 0x2) : (val & 0x1);
> +
> +	data->ps_int =3D val;
> +	val =3D (ret & ~VCNL4040_PS_CONF2_PS_INT) |

It's been quite a few lines. Probably better to put that ret into
a reg_val or similarly named field to make it slightly easier to see it
is retained from above.

> +	    FIELD_PREP(VCNL4040_PS_CONF2_PS_INT, val);
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	data->chip_spec->set_power_state(data, (bool)data->ps_int);
the bool cast is a little nasty.  Perhaps !=3D 0 is clearer?

> +
> +	return ret;
> +}
> +


