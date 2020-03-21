Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB26F18E578
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 00:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCUXqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 19:46:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36185 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgCUXqe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 19:46:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id z72so5138197pgz.3;
        Sat, 21 Mar 2020 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9metYm6s3YaJ3/ZpWocgeR+36BfZbh9vZcxH9YLqhQ=;
        b=RWYTwADMv+A/J38l0sD9mzA8pLC6AZPex1ResDj34HPdpL7xsBD9LFn8TNthBELoK/
         pl8jMIhcgFav4787w9aCPwbDz6k1VjWIwt+VTS8X0/vmQ5LyA3uVV8vGbScyyL6f8w/e
         kCmro/1Xcr90aQRrYjkrjKET6tLmMsR4M9dvCv01G5g2lEGAd+loYahtubNPZ5Ra5P2d
         6403CIBtIKpJ1lXyaCuwlA7CEvem2quVixBojH6/3NgXOVbkQXAWvz9zO0rQQ60Tw18Y
         JidI4EAoX0+TvEakQPcJ7cDahbNTx7H0zOTdaBSJPDxbCaowdXMidXINS+kpNJC9Xx+u
         cmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9metYm6s3YaJ3/ZpWocgeR+36BfZbh9vZcxH9YLqhQ=;
        b=iNLL9PA6Vtd/LMelIJvCUiDIlSPfEQLLnP9luit8zmY7iS9H1BWIZ06h6NR4i+ktbU
         2y0llg500ofFPSpXxM91aPNsjmh5VrRAOueidZXI6z5XJDU+8c74ld4TCO4lLfELvrkx
         rOcAvvbLPPkI1YpFjEx6ZfFSfCmP1HIpYXMPbBMi9iJTXW0IP8+HQkCIbg/bGeB42J/S
         DwjHTaiLa1hBlYB3I+8pZtlIEtK7x7Cur1WDM6irncgRBFmqvpZSTmFHMYCAgg9oZOU+
         tLKU2I335VZCciSo6jSwGjHhkb+G25kt0afor7HGNpkRt+XHBp2B/R+5hhjCDkqAzUZj
         amUw==
X-Gm-Message-State: ANhLgQ0WJsow0WUgyPh0aj+3f+2+s/z3USgXOvNIjzruo226dP4FMPvR
        +NS8GqW+2rqe4x6FfeXnrfauAJehB0F8nhesI0k=
X-Google-Smtp-Source: ADFU+vt+H219tQ2mBEOX37saN+D653nyAXnJlOi1NauFfeSanfWKl/R5MXuCfLEicw6KCg5p6lT1s0j9dJyeS8TzoPQ=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr5566713pfs.36.1584834393200;
 Sat, 21 Mar 2020 16:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200317135649.8876-1-michael.auchter@ni.com> <20200317145113.12413-1-michael.auchter@ni.com>
In-Reply-To: <20200317145113.12413-1-michael.auchter@ni.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 01:46:21 +0200
Message-ID: <CAHp75Veh3QRfqVFOpYbuuxcPqirc1_YrF-iZfRjNsYk7DWqYpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 17, 2020 at 4:53 PM Michael Auchter <michael.auchter@ni.com> wrote:
>
> There are no in-tree users of the platform data for this driver, so
> remove it and convert the driver to use device tree instead.

...

> +       chip->reg = devm_regulator_get_optional(&client->dev, "vref");
> +       if (!IS_ERR(chip->reg)) {

Why not to go with usual positive conditional?

> +               ret = regulator_enable(chip->reg);
> +               if (ret)
> +                       return ret;
> +
>                 chip->command |= AD7291_EXT_REF;
> +       } else {
> +               if (PTR_ERR(chip->reg) != -ENODEV)
> +                       return PTR_ERR(chip->reg);
> +
> +               chip->reg = NULL;
> +       }

...

> +static const struct of_device_id ad7291_of_match[] = {
> +       { .compatible = "adi,ad7291", },

> +       {},

No need for comma.

> +};

...

> +               .of_match_table = of_match_ptr(ad7291_of_match),

No need to use of_match_ptr(). Haven't you got a compiler warning in !OF case?

-- 
With Best Regards,
Andy Shevchenko
