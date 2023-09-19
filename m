Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E07A6A53
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjISR67 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjISR6z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:58:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2795
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:58:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so177535a12.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146327; x=1695751127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1NRUeCHZVcU7vFnB9mFf3Vt372PLclrw8mQfXYBE3E=;
        b=Wc6oQ3mYZMPocdqE1ZMtXSZ8ugWGsxKvY1wTHRSHANjsdbpi3H+GMdIxFXWgYp3wqc
         jACn3gIVxan9cTJ1u0EeQ+R7pDy+60TTXsV3hyDJ5KJyBCnwBdzd0EfehG/kvlzaSb8w
         UVFL0oY1E6LrxZCQ/NN35muJUHyp1wyLNDwATnYPIVgVopBnuZInDKmJZ9VC2Zr8XorH
         17T/TWnxuOO+rxt7KnxtyS9XKd9Ba/nB7eBUbQnTcmgtSogpRL8w+qad4TxEMxXWVXWn
         wUP99Otcr3hpdftz/YAZ+0dDxnBRkU19R14vJsKhz2T1cvCexlaJ7DkP642EaP2qbszm
         Qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146327; x=1695751127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1NRUeCHZVcU7vFnB9mFf3Vt372PLclrw8mQfXYBE3E=;
        b=lZt6P+GmjjkfHLWXwH5G0p2lEc1QdESkd3sR/bnBXrdI5jz8xPBAGS0/UecXMfcvQz
         OojHb0eCbfl/JAIAZ1rt+mC3aQ43IyEi+/iO0BBbUOQQyoM7BZVeMHbjX8T4mUfO1RCl
         wzKtykM6b5zw58BAiUMnmPocFGnoc5fRRGEI3EuBpPLXV/mxeZEUOxUrfdvjvZr9vSMm
         snCNEqZYymZjcmxMTmjbisHEv7l1OF7yout8FXpXAc3USg2PBeb1R1LvMfpNWzWR/8uV
         7FhenU1YCFKkvO6JPqkTJCtov0Nzk5i56SfzXsedbYN9NnCQ7iJNeF/L4ySHzvuBp+Dy
         C/uQ==
X-Gm-Message-State: AOJu0YypBbPAqMmIxrR/Yw7tA9+kja/Tygm2aMvaZFYxGiRrGoZOPDM6
        xR/UkxVIfeDVbgC6DKPPljk=
X-Google-Smtp-Source: AGHT+IEiBbBQwup9WppiUmb+sqxSKYGgUrzhNxvYEKeXarSza67dv9jMX7VWYr8RD6NZ6k7/WFS3xA==
X-Received: by 2002:a17:907:25cd:b0:9ad:e62c:4517 with SMTP id ae13-20020a17090725cd00b009ade62c4517mr4196555ejc.34.1695146326452;
        Tue, 19 Sep 2023 10:58:46 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d5d9000000b005288f0e547esm7697627eds.55.2023.09.19.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:58:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mark Brown <broonie@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@pengutronix.de
Subject: Re: [PATCH 24/49] iio: adc: sun4i-gpadc-iio: Convert to platform remove
 callback returning void
Date:   Tue, 19 Sep 2023 19:58:44 +0200
Message-ID: <2243607.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20230919174931.1417681-25-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
 <20230919174931.1417681-25-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dne torek, 19. september 2023 ob 19:49:06 CEST je Uwe Kleine-K=F6nig napisa=
l(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c
> b/drivers/iio/adc/sun4i-gpadc-iio.c index 25bba96367a8..100ecced5fc1 1006=
44
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -669,7 +669,7 @@ static int sun4i_gpadc_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> -static int sun4i_gpadc_remove(struct platform_device *pdev)
> +static void sun4i_gpadc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> @@ -678,12 +678,10 @@ static int sun4i_gpadc_remove(struct platform_device
> *pdev) pm_runtime_disable(&pdev->dev);
>=20
>  	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> -		return 0;
> +		return;
>=20
>  	if (!info->no_irq)
>  		iio_map_array_unregister(indio_dev);
> -
> -	return 0;
>  }
>=20
>  static const struct platform_device_id sun4i_gpadc_id[] =3D {
> @@ -702,7 +700,7 @@ static struct platform_driver sun4i_gpadc_driver =3D {
>  	},
>  	.id_table =3D sun4i_gpadc_id,
>  	.probe =3D sun4i_gpadc_probe,
> -	.remove =3D sun4i_gpadc_remove,
> +	.remove_new =3D sun4i_gpadc_remove,
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_id);




