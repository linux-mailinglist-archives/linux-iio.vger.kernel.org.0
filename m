Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9B565D55
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiGDSHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGDSHw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 14:07:52 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFBF5A5;
        Mon,  4 Jul 2022 11:07:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 76so2453033ybd.0;
        Mon, 04 Jul 2022 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9y+OytD7xOGm1KNwwCKXCYZwJoK7r4QVWYYYwSDLSW8=;
        b=NNvKQxzLB24ZF++XLEQ6f8amj8k2zBkFJSpExbFrPEB8u+cobXQGMrzu7C4jGoJeam
         W31WiGaGs7/BkmsWFu4sB4E3+JNTIOF3xThLL9CZKRDxLMCMFVKW/UGQ1OfYvyTPiyZn
         eDXPDw2i7hECNrdAAOisFIetFxmRw5jO5cubdSz3HsWjGk7TwAKhHDXBQdrG9vbBn7/F
         TGFwoxWid3ENKq6OGoKWapzxeMqqNe2i0wASEgFJP9DMYIdL6iMEzUuTT7uOVswnGZqR
         fDFINK4oitmn7PK8kwlk5X47zY//DjBQSV5gaTXh3N/DyInf5GyXYPu6eRRSO9drqQwN
         9e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9y+OytD7xOGm1KNwwCKXCYZwJoK7r4QVWYYYwSDLSW8=;
        b=r4hI0Dmqo4F5d7nNzN8wBg6N+pZyPSm2mMva49tFDHCqI1Fxg2Q8LmgMzqQ2Pcs2s3
         YSU0Alc+FZn8rvPbffOvYwTzOD7utgHE7CvVsa/ODROb0HJDKwzXh2Qo7RUHVM3J/mUS
         emAYNy2te+Yt/8TGPN+ydDi+SDtt8ZwFhiPKwTX4JilFieotU1qhr0QFu+cPLnaTc11A
         gQpnMMz7VVbmFTF74C3DXhTRhdZDXVGhAnBWyVT9FTS6rjfQvzOgyP4wdTNJe+MmLTQG
         JAnRLtKFHImywYMFNomJ4YjVY2Kd57HwNPJkffVyXZ8PIMWmObimJCkQGUh3uyWlAjNm
         y+kA==
X-Gm-Message-State: AJIora9EchaZ3KtDfq3Qdm1GZQBoJCi/sH5gU2dkWFbfprYI+OFECmRe
        +qTdEIBQe2dsbamhhtgyEw5TPafSv4wuNMl6hG0=
X-Google-Smtp-Source: AGRyM1sNMKzyykPpig1ssm1tDe8CkrJ72BqA+1LY/UcjYCTbL+pIuhCnssCoN1Xgr/oWpOY+Xbe8HEQsKxaYVAhZZso=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr2670266ybt.385.1656958066348; Mon, 04
 Jul 2022 11:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <8a1fb0faedc25aa2fbf9852cf4e1d9d085675ad6.1656883851.git.jahau@rocketmail.com>
In-Reply-To: <8a1fb0faedc25aa2fbf9852cf4e1d9d085675ad6.1656883851.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 20:07:08 +0200
Message-ID: <CAHp75Vdb03oop0L_+52KbsGh2BHTwKyCW+8Uy=eD1phToE+5Qw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] iio: magnetometer: yas530: Apply documentation
 and style fixes
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 4, 2022 at 12:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This commit gathers several minor changes.
>
> In the device examples, "Xiaomi" is too generic, specific devices should =
be
> listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully =
clear
> if this applies to all its variants. Samsung Galaxy S7 is often quoted in
> conjunction with YAS537.
>
> Removed defines for device IDs of YAS537 and YAS539, they are not needed =
so far.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index 8358d4b3d1e2..4e2f460a4efd 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -10,7 +10,7 @@
>   * (YAS534 is a magnetic switch, not handled)
>   * YAS535 MS-6C
>   * YAS536 MS-3W
> - * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Xiaomi)
> + * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Galaxy S7)
>   * YAS539 MS-3S (2018 Samsung Galaxy A7 SM-A750FN)
>   *
>   * Code functions found in the MPU3050 YAS530 and YAS532 drivers
> @@ -93,10 +93,6 @@
>  #define YAS532_DATA_OVERFLOW           (BIT(YAS532_DATA_BITS) - 1)
>  #define YAS532_20DEGREES               390 /* Counts starting at -50 =C2=
=B0C */
>
> -/* These variant IDs are known from code dumps */
> -#define YAS537_DEVICE_ID               0x07 /* YAS537 (MS-3T) */
> -#define YAS539_DEVICE_ID               0x08 /* YAS539 (MS-3S) */
> -
>  /* Turn off device regulators etc after 5 seconds of inactivity */
>  #define YAS5XX_AUTOSUSPEND_DELAY_MS    5000
>
> @@ -323,7 +319,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, =
s32 *to, s32 *xo, s32 *yo,
>  {
>         struct yas5xx_calibration *c =3D &yas5xx->calibration;
>         u16 t_ref, t, x, y1, y2;
> -       /* These are "signed x, signed y1 etc */
> +       /* These are signed x, signed y1 etc */
>         s32 sx, sy1, sy2, sy, sz;
>         int ret;
>
> @@ -663,7 +659,10 @@ static int yas530_get_calibration_data(struct yas5xx=
 *yas5xx)
>                 return ret;
>         dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
>
> +       /* Contribute calibration data to the input pool for kernel entro=
py */
>         add_device_randomness(data, sizeof(data));
> +
> +       /* Extract version */
>         yas5xx->version =3D data[15] & GENMASK(1, 0);
>
>         /* Extract the calibration from the bitfield */
> @@ -690,6 +689,7 @@ static int yas530_get_calibration_data(struct yas5xx =
*yas5xx)
>         c->r[0] =3D sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
>         c->r[1] =3D sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
>         c->r[2] =3D sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
> +
>         return 0;
>  }
>
> @@ -711,12 +711,12 @@ static int yas532_get_calibration_data(struct yas5x=
x *yas5xx)
>         dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
>
>         /* Sanity check, is this all zeroes? */
> -       if (memchr_inv(data, 0x00, 13) =3D=3D NULL) {
> -               if (!(data[13] & BIT(7)))
> -                       dev_warn(yas5xx->dev, "calibration is blank!\n");
> -       }
> +       if (!memchr_inv(data, 0x00, 13) && !(data[13] & BIT(7)))
> +               dev_warn(yas5xx->dev, "calibration is blank!\n");
>
> +       /* Contribute calibration data to the input pool for kernel entro=
py */
>         add_device_randomness(data, sizeof(data));
> +
>         /* Only one bit of version info reserved here as far as we know *=
/
>         yas5xx->version =3D data[13] & BIT(0);
>
> @@ -725,6 +725,7 @@ static int yas532_get_calibration_data(struct yas5xx =
*yas5xx)
>         c->Cy1 =3D data[1] * 10 - 1280;
>         c->Cy2 =3D data[2] * 10 - 1280;
>         yas530_extract_calibration(&data[3], c);
> +
>         /*
>          * Extract linearization:
>          * Linearization layout in the 32 bits at byte 10:
> --
> 2.35.1
>


--=20
With Best Regards,
Andy Shevchenko
