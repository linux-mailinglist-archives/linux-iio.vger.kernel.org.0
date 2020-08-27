Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F4254F9B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH0UAV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UAV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 16:00:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74731C061264;
        Thu, 27 Aug 2020 13:00:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so4321448pfc.12;
        Thu, 27 Aug 2020 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7FsTR8MREGabBVt8LZ1j+20Xw6tV3sc64t+TrTmz1s=;
        b=H9Avjr9TBzYfwPOkz9EdvQOD/Hp2R/foNgj3n1RhDeUBaZ+T5lK3N+jmOVnF21fOPt
         cveijGliKTaLjmDGdxLWA8yVPczBusBiXh8fEduLfVMgyZ0AxHteuhJDmjK+uvJjLgPq
         hM8m0PARzvkixd1ZpgNhwBjSF1Ql6JaTzlrCF6hmmq+YjKNxQIvus1kjO8clKsH8C/t2
         Nr82ezEM0MgwJqZL7nrR3nrQCfjaqM4GPuz/FwXoB+2fw+2pY2HJ58nma+QCs85J+WsJ
         mBjjdnKmcvQsh0zyRUoV3RFVkHHilb03CsDzzWN0tKOzpTSWidOkEcJRc4N+Npaqr7Eh
         iyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7FsTR8MREGabBVt8LZ1j+20Xw6tV3sc64t+TrTmz1s=;
        b=fbeD/6r7Vl27Y2IqIeZ6zvwNxmU23eLlH3MsoN/g240zWVGH/HGJIdL8f/BZ8WCEQt
         Yre5rFnP7qrynbF9l+8PxTN7t3r4wbX72Yr838hFTdf0xYzd9Mq269xUf54aQ/fT4VAv
         HFDEKIspaFNBhYTl53aFTT0qH6jnz/T+9a+02MsZyyTDUbEan0fvy5PMTu9R3YseKS22
         7b0VCiOfXpwO3A9pn0Cf7Li+zsWUIVl/6g2zPhGAq9O8ARlShglQsKw2+JdZXACN00R9
         LNUxHB33T4oNXukKMNK9iGU3ZeDgYEV7d7IOyKoVNNNtTImmb+fdBXOrPYZHqV/LcG9J
         Dx3A==
X-Gm-Message-State: AOAM533NYVqpbWLiet/0R4FzWAJ3lUoatolrG/z6JjaHSN2ShDsdbXMs
        hTM3wEERTS+v849sJu4X8rLU4+wBnkai9vPLmDQ=
X-Google-Smtp-Source: ABdhPJzMVgucetaUrBARc94LCHK9ltEz39VRjcWxPvDTspL6QeAi4Dc29DqGVOxpjkKfh4YtQxfRbS/CdGszBd3FklY=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr15673608pgk.4.1598558421035;
 Thu, 27 Aug 2020 13:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-14-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-14-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 23:00:05 +0300
Message-ID: <CAHp75VdQYzuiXBXYBrwaLKzZDZWtyT1_kLAWVU0G7fXTi8fAGQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] iio: light: isl29018: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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

On Thu, Aug 27, 2020 at 10:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/light/isl29018.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index ac8ad0f32689..2689867467a8 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -746,12 +746,9 @@ static int isl29018_probe(struct i2c_client *client,
>         chip->suspended = false;
>
>         chip->vcc_reg = devm_regulator_get(&client->dev, "vcc");
> -       if (IS_ERR(chip->vcc_reg)) {
> -               err = PTR_ERR(chip->vcc_reg);
> -               if (err != -EPROBE_DEFER)
> -                       dev_err(&client->dev, "failed to get VCC regulator!\n");
> -               return err;
> -       }
> +       if (IS_ERR(chip->vcc_reg))
> +               return dev_err_probe(&client->dev, PTR_ERR(chip->vcc_reg),
> +                                    "failed to get VCC regulator!\n");
>
>         err = regulator_enable(chip->vcc_reg);
>         if (err) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
