Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC265524C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 16:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiLWPlI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiLWPkv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 10:40:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FF4DE47
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 07:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D2FEB820E5
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C3EC433EF;
        Fri, 23 Dec 2022 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671810003;
        bh=U718eykJ43OjSiecxgzEEd2QIvz80VNFU4/iN2fKRYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTLQKvbU3yD/7h0qZXTixn75QGRdtHJ1slq1+9eBDtvzRlgTvdNawl5HLBV+AWVG0
         tVFRn/GVEeTR9irUJSu36IX0WqiHvGSo0gGWeufCEzAgbby/M2727j1P19fkO0nr0N
         S++XEnXZz4S19UgG1TwWlUnoip3dGsgARM67zL7gYS2qzMmBUeH9HrmegfbXqlORaH
         io6adI4siZwc1QfuiqKIe7RSTY7oqCFQG00cHixMkCuiPAME41xaSTYo5e+S5Lc2tL
         mqQcKCh40ZQFIPwH55UZUKxZbAkwEZuLCwGq3lePHy2I823qgzyuzlqV0wDfhw/Qfi
         i6Rpu4TgoeakQ==
Date:   Fri, 23 Dec 2022 15:53:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: Make irq handling more
 generic
Message-ID: <20221223155313.00a89322@jic23-huawei>
In-Reply-To: <20221220214959.2289330-2-marten.lindahl@axis.com>
References: <20221220214959.2289330-1-marten.lindahl@axis.com>
        <20221220214959.2289330-2-marten.lindahl@axis.com>
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

On Tue, 20 Dec 2022 22:49:58 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> This driver supports 4 chips, by which only one (vcnl4010) handles
> interrupts and has support for triggered buffer. The setup of these
> functions is hardcoded for vcnl4010 inside the generic vcnl4000_probe,
> and thus ignores the chip specific configuration structure where all
> other chip specific functions are specified.
>=20
> This complicates adding interrupt handler and triggered buffer support
> to chips which may have support for it.
>=20
> Add members for irq threads and iio_buffer_setup_ops to the generic
> vcnl4000_chip_spec struct, so that instead of checking a chip specific
> boolean irq support, we check for a chip specific triggered buffer
> handler, and/or a chip specific irq thread handler.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Hi M=C3=A5rten,

A few comments inline.

Jonathan


> ---
>  drivers/iio/light/vcnl4000.c | 66 +++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index cc1a2062e76d..142d1760f65d 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -150,11 +150,13 @@ struct vcnl4000_chip_spec {
>  	struct iio_chan_spec const *channels;
>  	const int num_channels;
>  	const struct iio_info *info;
> -	bool irq_support;
> +	const struct iio_buffer_setup_ops *buffer_setup_ops;
>  	int (*init)(struct vcnl4000_data *data);
>  	int (*measure_light)(struct vcnl4000_data *data, int *val);
>  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
>  	int (*set_power_state)(struct vcnl4000_data *data, bool on);
> +	irqreturn_t (*irq_thread)(int irq, void *priv);
> +	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
>  };
> =20
>  static const struct i2c_device_id vcnl4000_id[] =3D {
> @@ -167,6 +169,11 @@ static const struct i2c_device_id vcnl4000_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> =20
> +static irqreturn_t vcnl4010_irq_thread(int irq, void *p);
> +static irqreturn_t vcnl4010_trigger_handler(int irq, void *p);
> +static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev);
> +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev);

Does it makes sense to just move the chip_spec array later in the driver
to avoid this set of forwards definitions?  If you do, make that move
a precursor to this patch as otherwise things are going to get very
hard to read!

> +
>  static int vcnl4000_set_power_state(struct vcnl4000_data *data, bool on)
>  {
>  	/* no suspend op */
> @@ -983,6 +990,11 @@ static const struct iio_info vcnl4040_info =3D {
>  	.read_avail =3D vcnl4040_read_avail,
>  };
> =20
> +static const struct iio_buffer_setup_ops vcnl4010_buffer_ops =3D {
> +	.postenable =3D &vcnl4010_buffer_postenable,
> +	.predisable =3D &vcnl4010_buffer_predisable,
> +};
> +
>  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] =3D {
>  	[VCNL4000] =3D {
>  		.prod =3D "VCNL4000",
> @@ -993,7 +1005,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chip=
_spec_cfg[] =3D {
>  		.channels =3D vcnl4000_channels,
>  		.num_channels =3D ARRAY_SIZE(vcnl4000_channels),
>  		.info =3D &vcnl4000_info,
> -		.irq_support =3D false,
>  	},
>  	[VCNL4010] =3D {
>  		.prod =3D "VCNL4010/4020",
> @@ -1004,7 +1015,9 @@ static const struct vcnl4000_chip_spec vcnl4000_chi=
p_spec_cfg[] =3D {
>  		.channels =3D vcnl4010_channels,
>  		.num_channels =3D ARRAY_SIZE(vcnl4010_channels),
>  		.info =3D &vcnl4010_info,
> -		.irq_support =3D true,
> +		.irq_thread =3D vcnl4010_irq_thread,
> +		.trig_buffer_func =3D vcnl4010_trigger_handler,
> +		.buffer_setup_ops =3D &vcnl4010_buffer_ops,
>  	},
>  	[VCNL4040] =3D {
>  		.prod =3D "VCNL4040",
> @@ -1015,7 +1028,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chi=
p_spec_cfg[] =3D {
>  		.channels =3D vcnl4040_channels,
>  		.num_channels =3D ARRAY_SIZE(vcnl4040_channels),
>  		.info =3D &vcnl4040_info,
> -		.irq_support =3D false,
>  	},
>  	[VCNL4200] =3D {
>  		.prod =3D "VCNL4200",
> @@ -1026,7 +1038,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chi=
p_spec_cfg[] =3D {
>  		.channels =3D vcnl4000_channels,
>  		.num_channels =3D ARRAY_SIZE(vcnl4000_channels),
>  		.info =3D &vcnl4000_info,
> -		.irq_support =3D false,
>  	},
>  };
> =20
> @@ -1153,11 +1164,6 @@ static int vcnl4010_buffer_predisable(struct iio_d=
ev *indio_dev)
>  	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
>  }
> =20
> -static const struct iio_buffer_setup_ops vcnl4010_buffer_ops =3D {
> -	.postenable =3D &vcnl4010_buffer_postenable,
> -	.predisable =3D &vcnl4010_buffer_predisable,
> -};
> -
>  static const struct iio_trigger_ops vcnl4010_trigger_ops =3D {
>  	.validate_device =3D iio_trigger_validate_own_device,
>  };
> @@ -1214,26 +1220,30 @@ static int vcnl4000_probe(struct i2c_client *clie=
nt)
>  	indio_dev->name =3D VCNL4000_DRV_NAME;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> -	if (client->irq && data->chip_spec->irq_support) {
> -		ret =3D devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> -						      NULL,
> -						      vcnl4010_trigger_handler,
> -						      &vcnl4010_buffer_ops);
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"unable to setup iio triggered buffer\n");
> -			return ret;
> +	if (client->irq) {
> +		if (data->chip_spec->trig_buffer_func) {

Whilst they may always go together, perhaps also check the buffer_setup_ops=
 is
present.

> +			ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> +							      indio_dev, NULL,
> +							      data->chip_spec->trig_buffer_func,
> +							      data->chip_spec->buffer_setup_ops);

As a general rule, the buffer ideally wouldn't be directly coupled to their=
 being an
irq available. The driver only allows the trigger to be used with this devi=
ce, but doesn't
prevent another trigger being used with the device (only one of the two val=
idate functions
is there).  So I'd kind of expect this block outside of the if (client->irq)


> +			if (ret < 0) {
> +				dev_err(&client->dev,
> +					"unable to setup iio triggered buffer\n");
> +				return ret;
> +			}
>  		}
> =20
> -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> -						NULL, vcnl4010_irq_thread,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> -						"vcnl4010_irq",
> -						indio_dev);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "irq request failed\n");
> -			return ret;
> +		if (data->chip_spec->irq_thread) {
> +			ret =3D devm_request_threaded_irq(&client->dev,
> +							client->irq, NULL,
> +							data->chip_spec->irq_thread,
> +							IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +							"vcnl4000_irq",
> +							indio_dev);
> +			if (ret < 0) {
> +				dev_err(&client->dev, "irq request failed\n");
> +				return ret;
> +			}
>  		}
> =20
>  		ret =3D vcnl4010_probe_trigger(indio_dev);
Does it make sense to add the trigger even if we have no irq_thread?


