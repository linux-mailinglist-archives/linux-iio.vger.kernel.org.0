Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCDE5795C9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 11:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiGSJJW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGSJJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 05:09:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7D923BC6
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 02:09:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tk8so14587340ejc.7
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QD52p4PiqKxfKjzOyhjB/shP3g/67KbOLb4Y7mriyQ4=;
        b=gF/m7K/kOslZ0D+mwaBNp/jIWIXKEI094aAGk4m6h36POvcHb+T2Byy4rs3A6Frk6Z
         vSWq9o5uTXc2Pid5z0J3Z/P4m+mkvErCNL4+d7D7tfKwr/eOnOPhMlKyD7/s4HfCPdFr
         Ta9LpQlZuRQj/jUUSsUT6bupzSRNNA6WR3dPOecrTkqn33/wfSE3SiMhPzOuT+giMmhS
         V728CrTWg7TNZKFYdr4W0uOlMlEl3WNnQnos5l81LCdIZlJ0VDnMY/6zI6WLDtjp2kMQ
         bWCAnuNPAQnHQ6U5fIdjkM+2xwqfFT+LNU3Kw7Q2EiPdmbXIzwFONcnidgb9Clk4bSck
         x25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QD52p4PiqKxfKjzOyhjB/shP3g/67KbOLb4Y7mriyQ4=;
        b=76G/LGEkHXMK6cIcvgHefOU0bmNxy/ePTIb7p3dV3wKvmU+/F2llAhsLT54RokkfDV
         ANcmsC8KlSJyjHHCWTYpVfHVAXMOZ4Y7Ij45IYOAuHwCKfsEetPFc3x59u9Qqa3BwmsL
         kAWEZhq0WZWX/Z1tWCdHWgn37YgUYv8xpvLnbLU1HOQNvFyhAZ/99XEK7PDHb8wlqKEd
         AWC8o8cL2C6uiJ2YDI5aFVyp55CdVctuZkuus2UZUmL4l4BvQc+2ifI0meZdKMXgBtZ9
         4eNThXNkZ24i6DeaXf4rbG6eTdMGRj/KqyScYeiLhrd2RT6aaN5i2NLN3XW9r16LInZZ
         HScA==
X-Gm-Message-State: AJIora+0cyLhuimjBYGHbzqR/vmYLeRJjFBMeAeMmSBmKCCC4KA3V+gN
        nLbonNDWANqTXYCnNfHnq5pgGn6blzfaVszRLkEaM4d12GKOZg==
X-Google-Smtp-Source: AGRyM1tXIsAKmOpGfb1z9RSEiT5gl7fBoxixl+txi8dBh++hRB+42loTwb1Yn0fVaEgfDOIN1y8sMDjK+H3BcW/rN84=
X-Received: by 2002:a17:907:75da:b0:72b:3ce0:2524 with SMTP id
 jl26-20020a17090775da00b0072b3ce02524mr29600918ejc.394.1658221759003; Tue, 19
 Jul 2022 02:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220718194258.181738-1-ukleinek@debian.org> <20220718194258.181738-2-ukleinek@debian.org>
In-Reply-To: <20220718194258.181738-2-ukleinek@debian.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jul 2022 11:08:41 +0200
Message-ID: <CAHp75Vf4S=txRbqS-=KtP8W3AVdfDNyS4a+ujANr1Ov+9LXe-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: humidity: dht11: Emit error messages for
 probe failures
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 18, 2022 at 9:50 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>=
 wrote:
>
> There are two exit points in the driver's probe function that fail
> silently. From a user perspective this is unsatisfactory because the
> device is unusable but there is no hint in the kernel log about the
> actual problem which makes it unnecessarily hard to fix the problem.
>
> Make use of dev_err_probe() to emit a problem indication which also does
> the right thing if requesting the gpio return -EPROBE_DEFER.

After addressing the comment,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>
> ---
> Changes since (implicit) v1:
>
>  - Make it actually compile. (It helps quite a lot to have the driver to
>    be tested enabled in the config when doing compile tests *sigh*)
>  - Fix a typo I added when manually splitting the original patch
>
>  drivers/iio/humidity/dht11.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 891b6bf0b4ca..0db4f7471319 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -293,6 +293,7 @@ static int dht11_probe(struct platform_device *pdev)
>         struct device *dev =3D &pdev->dev;
>         struct dht11 *dht11;
>         struct iio_dev *iio;
> +       int ret;
>
>         iio =3D devm_iio_device_alloc(dev, sizeof(*dht11));
>         if (!iio)
> @@ -302,7 +303,8 @@ static int dht11_probe(struct platform_device *pdev)
>         dht11->dev =3D dev;
>         dht11->gpiod =3D devm_gpiod_get(dev, NULL, GPIOD_IN);
>         if (IS_ERR(dht11->gpiod))
> -               return PTR_ERR(dht11->gpiod);
> +               return dev_err_probe(dev, PTR_ERR(dht11->gpiod),
> +                                    "Failed to acquire GPIO\n");
>
>         dht11->irq =3D gpiod_to_irq(dht11->gpiod);
>         if (dht11->irq < 0) {
> @@ -323,7 +325,11 @@ static int dht11_probe(struct platform_device *pdev)
>         iio->channels =3D dht11_chan_spec;
>         iio->num_channels =3D ARRAY_SIZE(dht11_chan_spec);
>
> -       return devm_iio_device_register(dev, iio);
> +       ret =3D devm_iio_device_register(dev, iio);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to register iio de=
vice\n");
> +
> +       return 0;
>  }
>
>  static struct platform_driver dht11_driver =3D {
> --
> 2.36.1
>


--=20
With Best Regards,
Andy Shevchenko
