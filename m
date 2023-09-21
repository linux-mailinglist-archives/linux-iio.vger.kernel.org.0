Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678B7A9A4F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjIUSiK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjIUSh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 14:37:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FC5808E
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:28:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31ff985e292so1136081f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317281; x=1695922081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtfnLMS48uOMTYFLHrC4VI+xPTOGEubCm+FExSzwlTk=;
        b=OoEsZxI348/ZAv/jyh8CU3HHVAwqSDLUKLbeeqtZqwlqTZ0KC9N9xP1EJykz2Prbbg
         xeO3D4wfw3a/CedwQpvMC5rwotSepTbCfsb/2TRd2L3dCM6MSwvek9sfbUSuauSeGtUW
         1M8OS5vDxr1aw8EMcyKoXA1ti7FfusBnkAINVz6lyTiHgB2vFgoahfGjjV6tBH3ctupv
         VV8WJtm/J1DWluhgp4+oLrL2wXHP5W9oWuT+2hGv86hs4LDBPnaNWcOGLYbNp7H1w2no
         rliMM7zKhf6X89JAgDSHAcFrb+vX72Etm50kgFx35aKKIy80byaadR09eWNHE/SVIuwC
         m3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317281; x=1695922081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtfnLMS48uOMTYFLHrC4VI+xPTOGEubCm+FExSzwlTk=;
        b=Wlm4oT0Tm1SYGzzCPcZkQ6qjWw1FBhARJr8Hw87pqDtnC56lutvn3ZTXEomUSnfMrU
         Bj8X3SiE7LB7LHxcRwZNQpIrQzlDGeTzxfM/a1sUMD9lApSh4vDYXji/gCczye+8nLCv
         DFs3EOkQNiebIjXWLDswe+d7nAPxrV2v61LGcWc91gd3qJ/2f3wS5ZTmFtQ/n6BnA6Zr
         +Dw0V7eTVDC115/x/3D55BJ0iWKTWzysc+eiqYJiVzzKp8FdaJzaE2HFXh1UN65QFE3o
         akjQXANLEXXJOWohBUNqujjDap9f7NmfOYXg5RbBIzi5W+rb3dh4MRzR7sAAxyCLRgSl
         WWVQ==
X-Gm-Message-State: AOJu0YzlWff33CT5mT+BTXn/Y7R0AeYv5Dr9obY03pMzygud1l01+/zg
        VX3HaH9gQ6ua7OCwBPZwzgkJwv6wx8NZFteVJ4W6L9PCF0LbxzmX5okQibkb
X-Google-Smtp-Source: AGHT+IHDdCW8l8v6OhDqZiyja7I2+F2x5WsRgSux5VP1tVFRRWSTYBCB9TdkqRkvd27HKrJXY3PRK7lDy+BsjgySXvg=
X-Received: by 2002:a17:906:d044:b0:9a2:474:4aa0 with SMTP id
 bo4-20020a170906d04400b009a204744aa0mr4171303ejb.48.1695306427980; Thu, 21
 Sep 2023 07:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230921141947.57784-1-dlechner@baylibre.com> <20230921141947.57784-21-dlechner@baylibre.com>
In-Reply-To: <20230921141947.57784-21-dlechner@baylibre.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 21 Sep 2023 16:26:57 +0200
Message-ID: <CAMknhBFrQivxmE=3voeYgHAtQBf0FSTep7oHfWOAnBTwBogXGw@mail.gmail.com>
Subject: Re: [v2 18/19] staging: iio: resolver: ad2s1210: add phase_lock_range attributes
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looks like I got some wrong patches in the get-send-email. These two patche=
s
are included in the series "[v2 00/19] iio: resolver: move ad2s1210
out of staging"
so please disregard this copy of the two patches.

On Thu, Sep 21, 2023 at 4:22=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> This adds new phase_lock_range and phase_lock_range_available attributes
> to the ad2s1210 resolver driver. These attributes allow the user to set
> the phase lock range bit in the control register to modify the behavior
> of the resolver to digital converter.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 58 +++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/ii=
o/resolver/ad2s1210.c
> index 71f0913b7e2e..f5b8b290e860 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -259,6 +259,60 @@ static ssize_t excitation_frequency_store(struct dev=
ice *dev,
>         return ret;
>  }
>
> +static ssize_t phase_lock_range_show(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct ad2s1210_state *st =3D iio_priv(dev_to_iio_dev(dev));
> +       int ret;
> +
> +       mutex_lock(&st->lock);
> +       ret =3D regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +                              AD2S1210_PHASE_LOCK_RANGE_44);
> +       if (ret < 0)
> +               goto error_ret;
> +
> +       ret =3D sprintf(buf, "%d\n", ret ? 44 : 360);
> +
> +error_ret:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}
> +
> +static ssize_t phase_lock_range_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t len)
> +{
> +       struct ad2s1210_state *st =3D iio_priv(dev_to_iio_dev(dev));
> +       u16 udata;
> +       int ret;
> +
> +       ret =3D kstrtou16(buf, 10, &udata);
> +       if (ret < 0 || (udata !=3D 44 && udata !=3D 360))
> +               return -EINVAL;
> +
> +       mutex_lock(&st->lock);
> +
> +       ret =3D regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +                                AD2S1210_PHASE_LOCK_RANGE_44,
> +                                udata =3D=3D 44 ? AD2S1210_PHASE_LOCK_RA=
NGE_44 : 0);
> +       if (ret < 0)
> +               goto error_ret;
> +
> +       ret =3D len;
> +
> +error_ret:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}
> +
> +static ssize_t phase_lock_range_available_show(struct device *dev,
> +                                              struct device_attribute *a=
ttr,
> +                                              char *buf)
> +{
> +       return sprintf(buf, "44 360\n");
> +}
> +
>  /* read the fault register since last sample */
>  static ssize_t ad2s1210_show_fault(struct device *dev,
>                                    struct device_attribute *attr, char *b=
uf)
> @@ -506,6 +560,8 @@ static int ad2s1210_write_raw(struct iio_dev *indio_d=
ev,
>  }
>
>  static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
> +static IIO_DEVICE_ATTR_RW(phase_lock_range, 0);
> +static IIO_DEVICE_ATTR_RO(phase_lock_range_available, 0);
>  static IIO_DEVICE_ATTR(fault, 0644,
>                        ad2s1210_show_fault, ad2s1210_clear_fault, 0);
>
> @@ -552,6 +608,8 @@ static const struct iio_chan_spec ad2s1210_channels[]=
 =3D {
>
>  static struct attribute *ad2s1210_attributes[] =3D {
>         &iio_dev_attr_excitation_frequency.dev_attr.attr,
> +       &iio_dev_attr_phase_lock_range.dev_attr.attr,
> +       &iio_dev_attr_phase_lock_range_available.dev_attr.attr,
>         &iio_dev_attr_fault.dev_attr.attr,
>         &iio_dev_attr_los_thrd.dev_attr.attr,
>         &iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
> --
> 2.34.1
>
