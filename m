Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764CD255656
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgH1IZb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 04:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1IZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 04:25:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72FC061264;
        Fri, 28 Aug 2020 01:25:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nv17so190976pjb.3;
        Fri, 28 Aug 2020 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgp9U9Y/G0zo5rd2YjDP3ShdcPx6s9r42iPuJEDI0jc=;
        b=ECtC8Qr2QpWVT5Ln1YYdt0d41D8iu4+1QljOFImcKWuMAAwp02hB9Z/uL8VN2ey2J+
         p3GD3wlvEExKnV3Z319A58NvE45esf1chM+0V/fjhkBUwXersN3vaLphhdr1J4difc+p
         0CAUiHbAVl9ixDZFHnIBUOaHukXywdJoUMvTFy3YA0YF9c3y5XU82ueUeX/Egnq+CmRC
         9hNwIbKnSRxOMPUVO8etY6uZgLfo6aqikvMDuvVT9IqO2gK9kJBCJF/qz+RdRz2245Vy
         DFaJDmcxFVDbDqen+wlr2csyHQ1eWpt/RK7KSuNhW3eyhUvIV3DI9LK5Mo5H9XXISrU7
         E5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgp9U9Y/G0zo5rd2YjDP3ShdcPx6s9r42iPuJEDI0jc=;
        b=pctQx0EBEnxpYdTF8BTf/T8OmcYKWNG+l71XLGbNh4QWNPrKoPDqFrhe8NWAtpl0jd
         NtwgLkYIvS0C/IUdRpCyLGd2Wpcu7M9i59xEi9YyCDeeS6b3Gw8pDrQfhyocDxydNhFz
         Jo5ZMckd8nquGjRM+caow/WxlT54OZqMCSOBMuBUX4Xh78s2wBEqARBW9zkjK6AIl8h5
         twpROwDA0LeYzmInsp1iaoRsyed4HZeYSPAuJ7bJjkLDfkhViV8nmVPoDyB5ul6i5LlT
         XpLe5KfjwiVX88anWzUZoerUuJxiufLhkReJ+fCPwibw1WLcpL35YlU49+cgg0dguVJ+
         I00g==
X-Gm-Message-State: AOAM532arx/TYS8Jx1jO+bgzgdWVixMm7e+LzER+rpPI/sNpsmJUJX3R
        W7m9U+x/DebwJHlHCbNdndv4QHn3KP5GF9LJ44E=
X-Google-Smtp-Source: ABdhPJwsbuw20O2OB1p5m5faNM+P4s8DD8aLK8TuvYw3gq+cYE8m/WMyHxDzBvhpeh/QCh5ExRey2Xy2BFReiumdd/0=
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr408970plr.321.1598603123368;
 Fri, 28 Aug 2020 01:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-9-krzk@kernel.org>
 <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
In-Reply-To: <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Aug 2020 11:25:06 +0300
Message-ID: <CAHp75VdWDtoGxm3uxxeXveZQ3Y_ofShdYPSXHL0Vxsz5d0miuQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with dev_err_probe()
To:     Peter Rosin <peda@axentia.se>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
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

On Fri, Aug 28, 2020 at 12:46 AM Peter Rosin <peda@axentia.se> wrote:
> On 2020-08-27 21:26, Krzysztof Kozlowski wrote:

...

> I'm not a huge fan of adding *one* odd line breaking the 80 column
> recommendation to any file. I like to be able to fit multiple
> windows side by side in a meaningful way. Also, I don't like having
> a shitload of emptiness on my screen, which is what happens when some
> lines are longer and you want to see it all. I strongly believe that
> the 80 column rule/recommendation is still as valid as it ever was.
> It's just hard to read longish lines; there's a reason newspapers
> columns are quite narrow...

Why not to introduce 66 (or so, like TeX recommends)? Or even less?
I consider any comparison to news or natural language text is silly.
Programming language is different in many aspects, including helpful
scripts and utilities to browse the source code.

-- 
With Best Regards,
Andy Shevchenko
