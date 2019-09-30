Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0754DC287B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfI3VQ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 17:16:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41718 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfI3VQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2019 17:16:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id w17so12463840oiw.8;
        Mon, 30 Sep 2019 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGl26BC0P4MPPAVNiVH76qN3peTSsIs0AC8gMsuxmhs=;
        b=KZJAj1okYzXl6CRX8biKWyfxTA5Hiw5PdQNVDsGTOXm+vgzJoLkWJS9H0o4Twn7PD7
         TYwoWabeDFDlFQDF8/mYMdb6C2k8UpbM+HE5dl5xdJ8I2wyOkmaYRrv9W7BXJRe+rwCE
         xRKNIFbXqgr/2gP1EMo3+cEzuF1jSAN9YXehVh+aJeaWD3RaBH5zHb3uWi+8VJGEj8q3
         yLOry7/uLgh3D/R/t6LecDLnT7MagjPfCWJ2Wyg+plYOA8ZUMGYvUrxzRA6VGBJgEUS7
         TLbz4MoME9Xkh0UyVFFJoGD2q4Z90pAMKKMBucCA7Rs/Tid652uNdwMEO6ptzXGCOZ09
         +a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGl26BC0P4MPPAVNiVH76qN3peTSsIs0AC8gMsuxmhs=;
        b=SRsz9ZOiJt6h5c7zSPHY3E1J+pnlGqWEuOygJnLXwwlPyAvPEASSIBENMhx809ZekJ
         PPJ3Nla7uTq/rP66LIWi4A2TixMqFS0XzQwtLws7cRHzH9DgTfAyi0KIlOvFyyxjT6/i
         FLfBiOv26WvHBceAoxOtClGTGBmWBfUTWfw3S9C9nKGpvWGYeTRecS2n5Ci31rUC9vHa
         M8jjVfitgr+FIUod8KPqnmE0kzLAv2R2/jXjXJVppAyQf6Qw3ixlvoXOUjA16BhnMWHL
         JdJUHYxerCbENfSiTrE3k84XYXKcLFGWfomoMHUaUySqQR/CZ+vDS2frOhxN7436pta8
         V8gw==
X-Gm-Message-State: APjAAAVtzAj5oRtrskJYulVCghYUR7rzq3BOdGt4ZvQSNo/WSnsx7RuE
        eq/aNBCVVIsa0iy/7HlxD6/IjdnZdylKj96alQg=
X-Google-Smtp-Source: APXvYqwo3X1AmgHw4aNAK1dFU4oJnTmjOuaJANGc3Lqec/DkuNhIVQyVWSQrPvO1BIegkPzh2bHOVAF5m+nxyXG3tes=
X-Received: by 2002:aca:574c:: with SMTP id l73mr1038228oib.47.1569878186047;
 Mon, 30 Sep 2019 14:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190929164848.13930-1-yzhai003@ucr.edu>
In-Reply-To: <20190929164848.13930-1-yzhai003@ucr.edu>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 30 Sep 2019 23:16:15 +0200
Message-ID: <CAFBinCCewgHnvL+HRXR8MBOT4fdnC-nxDAw8E5rGf+NZDsbaJg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized
 if regmap_read() fails
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Yizhuo,

thank you for this patch

On Sun, Sep 29, 2019 at 6:48 PM Yizhuo <yzhai003@ucr.edu> wrote:
>
> Several functions in this file are trying to use regmap_read() to
> initialize the specific variable, however, if regmap_read() fails,
> the variable could be uninitialized but used directly, which is
> potentially unsafe. The return value of regmap_read() should be
> checked and handled.
the meson_saradc driver is using a MMIO regmap so read failures are
unlikely (unless there's a bug in the code somewhere)
did you find these issues with some static code analysis tool or did
you experience a real world problem?

> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/iio/adc/meson_saradc.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 7b28d045d271..4b6c2983ef39 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -323,6 +323,7 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
>  {
>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>         int regval, timeout = 10000;
> +       int ret;
why not add "ret" to the variables in the line above?
so this could be shortened to (which is also consistent with the
coding style in meson_saradc):
  int ret, regval, timeout = 10000;

> @@ -506,7 +514,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
>                  */
>                 do {
>                         udelay(1);
> -                       regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> +                       ret = regmap_read(priv->regmap,
> +                                               MESON_SAR_ADC_DELAY, &val);
> +                       if (ret)
> +                               return ret;
this is a big problem because we're returning with &indio_dev->mlock held
see the "timeout < 0" block below

> @@ -771,7 +782,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  {
>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>         int regval, i, ret;
> -
> +       int ret;
this removes an empty line between the variable declarations and the
first code (comment)
also "ret" is already defined in the line before
(I haven't compile-tested this myself yet but I'm surprised that this
doesn't give an error or at least a warning)

> @@ -1013,8 +1027,12 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>         unsigned int cnt, threshold;
>         u32 regval;
> +       int ret;
> +
> +       ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +       if (ret)
> +               return ret;
this function doesn't return "int" but irqreturn_t
the only allowed values are: [0]


Martin


[0] https://elixir.bootlin.com/linux/v5.3/source/include/linux/irqreturn.h#L11
