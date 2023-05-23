Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060270E644
	for <lists+linux-iio@lfdr.de>; Tue, 23 May 2023 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjEWUK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 May 2023 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjEWUK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 May 2023 16:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B9119;
        Tue, 23 May 2023 13:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 012CF61EC5;
        Tue, 23 May 2023 20:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39261C433EF;
        Tue, 23 May 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684872624;
        bh=0fR2WGauhjD+tb92y4IXhmg9v6Cd3p0cmDXXNAi5rmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMd086U1fV4rjmEv7fRwfxulH8UmaFyGeZhx3JGBILAUZ/cKdwAf4c3MoDFg6OxTl
         svUjrgcE5Ief9mee/AMtdKhH9b2XRZ+XW7siJp+QVJE8Uzaahr/Gzs02wuBbmQ8wvc
         EPl3eJXkz5mN9MN0pb0z9NTERI88w/xJa6kHF0zhCXBeiydGyTrdewLrvXX8eBGYmm
         z9RumNHSxcQA2DQmwfN3hSTDvjlWrLOrXySthD6EyRDY/OAyeGiG0+W3s0BqbfyQra
         T0wsYRaQfDpaHwUnD5j0lZ3KWmNfK3l8vzJY6ScrqUqQ8NXD49rMVUtbO4EVrv3ACg
         FcbLo1fSCCfAw==
Date:   Tue, 23 May 2023 21:26:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?UTF-8?B?U8O2ZGVy?= =?UTF-8?B?bHVuZA==?= 
        <niklas.soderlund@ragnatech.se>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Kalle Valo <kvalo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Crt Mori <cmo@melexis.com>, Haowen Bai <baihaowen@meizu.com>,
        Tom Rix <trix@redhat.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, linux-media@vger.kernel.org
Subject: Re: [PATCH] staging: Switch i2c drivers back to use .probe()
Message-ID: <20230523212633.7e86f2ea@jic23-huawei>
In-Reply-To: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
References: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 May 2023 22:00:36 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

If you end up doing a v2 for some reason then please split off the
IIO ones.  I tend to pick those up directly then send them in the main
IIO pull requests to Greg.

However, I don't think we have anything else touching those drivers so
fine for Greg to pick up directly

As such,

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
for the IIO ones.

> ---
> Hello,
>=20
> this patch was generated using coccinelle.
>=20
> I chose to convert all drivers below drivers/staging in a single
> patch, but if you prefer I can split by driver.
>=20
> If conflicts arise until this is applied, feel free to just drop the
> files with conflicts from this patch. I'll care about the fallout later
> then.
>=20
> Also note there is no coordination necessary with the i2c tree. Dropping
> .probe_new() will happen only when all (or most) drivers are converted,
> which will happen after v6.5-rc1 for sure.
>=20
> Best regards
> Uwe
>  drivers/staging/iio/addac/adt7316-i2c.c                   | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c           | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-gc0310.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-lm3554.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 +-
>  drivers/staging/media/max96712/max96712.c                 | 2 +-
>  drivers/staging/most/i2c/i2c.c                            | 2 +-
>  drivers/staging/olpc_dcon/olpc_dcon.c                     | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/ii=
o/addac/adt7316-i2c.c
> index 7e3d1a6f30ba..6c1f91c859ca 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -138,7 +138,7 @@ static struct i2c_driver adt7316_driver =3D {
>  		.of_match_table =3D adt7316_of_match,
>  		.pm =3D ADT7316_PM_OPS,
>  	},
> -	.probe_new =3D adt7316_i2c_probe,
> +	.probe =3D adt7316_i2c_probe,
>  	.id_table =3D adt7316_i2c_id,
>  };
>  module_i2c_driver(adt7316_driver);
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/st=
aging/iio/impedance-analyzer/ad5933.c
> index b3152f7153fb..46db6d91542a 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -781,7 +781,7 @@ static struct i2c_driver ad5933_driver =3D {
>  		.name =3D "ad5933",
>  		.of_match_table =3D ad5933_of_match,
>  	},
> -	.probe_new =3D ad5933_probe,
> +	.probe =3D ad5933_probe,
>  	.id_table =3D ad5933_id,
>  };
>  module_i2c_driver(ad5933_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c b/drivers=
/staging/media/atomisp/i2c/atomisp-gc0310.c
> index 273155308fe3..21eb4234a081 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
> @@ -483,7 +483,7 @@ static struct i2c_driver gc0310_driver =3D {
>  		.pm =3D pm_sleep_ptr(&gc0310_pm_ops),
>  		.acpi_match_table =3D gc0310_acpi_match,
>  	},
> -	.probe_new =3D gc0310_probe,
> +	.probe =3D gc0310_probe,
>  	.remove =3D gc0310_remove,
>  };
>  module_i2c_driver(gc0310_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers=
/staging/media/atomisp/i2c/atomisp-gc2235.c
> index cb4c79b483ca..9fa390fbc5f3 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> @@ -864,7 +864,7 @@ static struct i2c_driver gc2235_driver =3D {
>  		.name =3D "gc2235",
>  		.acpi_match_table =3D gc2235_acpi_match,
>  	},
> -	.probe_new =3D gc2235_probe,
> +	.probe =3D gc2235_probe,
>  	.remove =3D gc2235_remove,
>  };
>  module_i2c_driver(gc2235_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers=
/staging/media/atomisp/i2c/atomisp-lm3554.c
> index c4ce4cd445d7..cf5d9317b11a 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> @@ -945,7 +945,7 @@ static struct i2c_driver lm3554_driver =3D {
>  		.pm   =3D &lm3554_pm_ops,
>  		.acpi_match_table =3D lm3554_acpi_match,
>  	},
> -	.probe_new =3D lm3554_probe,
> +	.probe =3D lm3554_probe,
>  	.remove =3D lm3554_remove,
>  };
>  module_i2c_driver(lm3554_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/driver=
s/staging/media/atomisp/i2c/atomisp-mt9m114.c
> index 0e5a981dd331..1c6643c442ef 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> @@ -1600,7 +1600,7 @@ static struct i2c_driver mt9m114_driver =3D {
>  		.name =3D "mt9m114",
>  		.acpi_match_table =3D mt9m114_acpi_match,
>  	},
> -	.probe_new =3D mt9m114_probe,
> +	.probe =3D mt9m114_probe,
>  	.remove =3D mt9m114_remove,
>  };
>  module_i2c_driver(mt9m114_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers=
/staging/media/atomisp/i2c/atomisp-ov2680.c
> index 63de214916f5..b5d93a96d588 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> @@ -719,7 +719,7 @@ static struct i2c_driver ov2680_driver =3D {
>  		.pm =3D pm_sleep_ptr(&ov2680_pm_ops),
>  		.acpi_match_table =3D ov2680_acpi_match,
>  	},
> -	.probe_new =3D ov2680_probe,
> +	.probe =3D ov2680_probe,
>  	.remove =3D ov2680_remove,
>  };
>  module_i2c_driver(ov2680_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers=
/staging/media/atomisp/i2c/atomisp-ov2722.c
> index 5d2e6e2e72f0..6a72691ed5b7 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> @@ -1019,7 +1019,7 @@ static struct i2c_driver ov2722_driver =3D {
>  		.name =3D "ov2722",
>  		.acpi_match_table =3D ov2722_acpi_match,
>  	},
> -	.probe_new =3D ov2722_probe,
> +	.probe =3D ov2722_probe,
>  	.remove =3D ov2722_remove,
>  };
>  module_i2c_driver(ov2722_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c b/=
drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
> index da8c3b1d3bcd..c94fe8e861a5 100644
> --- a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
> +++ b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
> @@ -1794,7 +1794,7 @@ static struct i2c_driver ov5693_driver =3D {
>  		.name =3D "ov5693",
>  		.acpi_match_table =3D ov5693_acpi_match,
>  	},
> -	.probe_new =3D ov5693_probe,
> +	.probe =3D ov5693_probe,
>  	.remove =3D ov5693_remove,
>  };
>  module_i2c_driver(ov5693_driver);
> diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/=
media/max96712/max96712.c
> index 99b333b68198..77943bdf3fb9 100644
> --- a/drivers/staging/media/max96712/max96712.c
> +++ b/drivers/staging/media/max96712/max96712.c
> @@ -427,7 +427,7 @@ static struct i2c_driver max96712_i2c_driver =3D {
>  		.name =3D "max96712",
>  		.of_match_table	=3D of_match_ptr(max96712_of_table),
>  	},
> -	.probe_new =3D max96712_probe,
> +	.probe =3D max96712_probe,
>  	.remove =3D max96712_remove,
>  };
> =20
> diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2=
c.c
> index 4e85e681922f..ce869280a056 100644
> --- a/drivers/staging/most/i2c/i2c.c
> +++ b/drivers/staging/most/i2c/i2c.c
> @@ -362,7 +362,7 @@ static struct i2c_driver i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "hdm_i2c",
>  	},
> -	.probe_new =3D i2c_probe,
> +	.probe =3D i2c_probe,
>  	.remove =3D i2c_remove,
>  	.id_table =3D i2c_id,
>  };
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc=
_dcon/olpc_dcon.c
> index 2fba52e0bd7b..d5271eac14f6 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -779,7 +779,7 @@ static struct i2c_driver dcon_driver =3D {
>  	},
>  	.class =3D I2C_CLASS_DDC | I2C_CLASS_HWMON,
>  	.id_table =3D dcon_idtable,
> -	.probe_new =3D dcon_probe,
> +	.probe =3D dcon_probe,
>  	.remove =3D dcon_remove,
>  	.detect =3D dcon_detect,
>  	.address_list =3D normal_i2c,
>=20
> base-commit: 1f3413dc8eb0de023c5ec5994aef8225262d0f19

