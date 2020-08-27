Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D765254EE1
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Tlf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:41:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0Tle (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:41:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id g29so3074047pgl.2;
        Thu, 27 Aug 2020 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZm/oywi3r1tbCCgZePyobFM2PGZReJQn7CQ3uKc+Ao=;
        b=f8n5VPrpuTtwANe91fL3ceCKerjs9R1uZiyAXmwVy/cZqu3I8o92h7iWKeUrZbvTHI
         xv3f2KNykWxz9M4p+YEx/8qCMXuZ9zkFFj9z+dffQXJOEZsPQBZzrKqn6Xfw2iQuP5Af
         eIOEmUek3WrgS3fxMZwWJXrEDNbdzLAOraAWLfkDXyFr6h00Z7O9KvIpFIS9xEGr+3aX
         9zXFJ0A9XeZY0Ce0KWz63fWV7wQ7VVhbTgUiEEsxac+lfKyxCqS913SAPiQ6itoN4Kdu
         Hp/smrljQR+JJGKvlfG5Wqu+EBGIUVqGeslwuBUsIrpvL2dILvRlZuex9jG0lt4PEcd9
         UTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZm/oywi3r1tbCCgZePyobFM2PGZReJQn7CQ3uKc+Ao=;
        b=N+m23nxEuiXnMWvsECXxcBqXwrrt0Yez7OVPBlhddlFvrPBuTNr/ktkBKKer2NS0gd
         FWWC/gJQig/5p9eVIE844mWTgiRq0+dg6bey9bPzDDN6SdCMh+WpwFpwtGYzCvIkVI/6
         GfW8U9KLmAPEL3WdFAqLjEh8023K02++4VO3N4umWQcYQijC0c1LB0qejkjwBYGdVy2V
         3uX9EDP0phaILBjT9zQdo2GfdmQ7a0rerxIEd5uZO13kE1mzzd0bo83wNZrrS1mOx37X
         IvS4ab+G/9zHlSqBjw2pxDl8IUu9ML/1sU+T3vpp+3t0dqDtfN0KzwKx4DQU6kwTme7h
         z0DQ==
X-Gm-Message-State: AOAM533Lav3OTTU/FAzSpj4Cb58uLGD3MJcu4f2gU7/nSwzNJ/CKMK/Z
        izAjwILIaR+H/CJNu0daSVplkl0ku1R9MWW7+B8=
X-Google-Smtp-Source: ABdhPJzf24/mTVbylFzj0huXtaxnG7j22bCzla2pU3gLISj7msJajR9gj4ZkRMNtbU33SxLbtqsrpdn12ipaw+rhX4g=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr15210554pgh.74.1598557143681;
 Thu, 27 Aug 2020 12:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-1-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:38:46 +0300
Message-ID: <CAHp75VeOWTuB1SqsajLZE9WB+VzgMuL9gnA-ohf58_hfJ=gn5w@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] iio: accel: bma180: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 10:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/accel/bma180.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 5b7a467c7b27..448faed001fd 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1000,19 +1000,15 @@ static int bma180_probe(struct i2c_client *client,
>                 return ret;
>
>         data->vdd_supply = devm_regulator_get(dev, "vdd");
> -       if (IS_ERR(data->vdd_supply)) {
> -               if (PTR_ERR(data->vdd_supply) != -EPROBE_DEFER)
> -                       dev_err(dev, "Failed to get vdd regulator %d\n",
> -                               (int)PTR_ERR(data->vdd_supply));
> -               return PTR_ERR(data->vdd_supply);
> -       }
> +       if (IS_ERR(data->vdd_supply))
> +               return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +                                    "Failed to get vdd regulator\n");
> +
>         data->vddio_supply = devm_regulator_get(dev, "vddio");
> -       if (IS_ERR(data->vddio_supply)) {
> -               if (PTR_ERR(data->vddio_supply) != -EPROBE_DEFER)
> -                       dev_err(dev, "Failed to get vddio regulator %d\n",
> -                               (int)PTR_ERR(data->vddio_supply));
> -               return PTR_ERR(data->vddio_supply);
> -       }
> +       if (IS_ERR(data->vddio_supply))
> +               return dev_err_probe(dev, PTR_ERR(data->vddio_supply),
> +                                    "Failed to get vddio regulator\n");
> +
>         /* Typical voltage 2.4V these are min and max */
>         ret = regulator_set_voltage(data->vdd_supply, 1620000, 3600000);
>         if (ret)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
