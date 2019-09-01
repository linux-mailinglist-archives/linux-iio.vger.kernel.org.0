Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9056AA48DF
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2019 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfIAL3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Sep 2019 07:29:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45355 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfIAL3Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Sep 2019 07:29:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id v12so8549012oic.12;
        Sun, 01 Sep 2019 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjNYoP0TZjOYpbU4nYIgEpFHwbIKmPPLiFzVEjdvaZg=;
        b=bkdN6BO8eAl30cWYew33QHGFT9cJopCCWlD/vsFFjQaGz3Fc9EjQZ4W/ukbLppZV2P
         Zg9MvFarnFdjh9jp06N9mwJjvs7IKsXhhc7JTFb9AenAojzTgNiTBRGE0v7hXusB0Qg7
         b17iL8zwOQ2XgKagS1q4RHVeuaNhOjSajZH8WKsArRWkywx+0A69Fui74XQtKwzyvJpS
         uRM1U8i23COUJLo7/cQeuM3vRiEQrU3JytSkE/CjSid0Ol1HkKoH/pytDodkRbgFFBls
         qFgih7cva/RE8Tq6BCxXLe8jJjnrokgKTZk/Rh8NqVS8drzarN/QKLjHSPZzufu6rv1N
         RJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjNYoP0TZjOYpbU4nYIgEpFHwbIKmPPLiFzVEjdvaZg=;
        b=V7U2pmQi8uXg6y4nLU34le6GzD/ms5HMG4X8OrCSL2oudhOQhTj+NZgEEX0oKPyqy6
         B3tK1Rdyn9gcQlLPX+eCArudU7QiBWps1F6mmjk4aR/fgXvGehnXZDuMlr9S0/XQ6Z4v
         76wXCOojxJI9sKhVQupSYaeOOKKfjaMa5OADl1jeTUX8qrhg37pz9HlRYAe2GRCnWrYq
         BKPC3qDO88hQxizFZ8c7MzGQ/0oCnuJbdfO85MmEGQpCjvDXjqbUyBwtUbmuDyQexJtI
         //DtjNz3QegqN9/X+9Hu0yoT6573dD0k9brIoKpDCs638tGZNPMq5QLWqPfv7M1aNmcE
         tQcg==
X-Gm-Message-State: APjAAAUWYErSBfVxmZ2+THPDSrGdMAS9jr+7QmeJ1M6hd59IFbwLaBif
        qZ8V3Z76c4EniNDZ1M/MkWhnLRiEuxD/uk3SUgM=
X-Google-Smtp-Source: APXvYqxxXKXRUZLMHQgk0XoewqNh98k6Y0rpItgSJzPuoeBuz1EBdkqcp55bFlX0B41vfDbAAe9Icj/tVYTN6vp7Ft8=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr15778496oij.15.1567337355596;
 Sun, 01 Sep 2019 04:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190901105410.23567-1-repk@triplefau.lt>
In-Reply-To: <20190901105410.23567-1-repk@triplefau.lt>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 13:29:04 +0200
Message-ID: <CAFBinCD96nJBPnyNgWA6CgwE2kZrkXB3-cgbV9aQLB=JtbrN2w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: Fix memory allocation order
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elie Roudninski <xademax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 1, 2019 at 12:45 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
> meson_saradc's irq handler uses priv->regmap so make sure that it is
> allocated before the irq get enabled.
>
> This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
> managed resources are freed in the inverted order they had been
> allocated, priv->regmap was freed before the spurious fake irq that
> CONFIG_DEBUG_SHIRQ adds called the handler.
>

Fixes: 3af109131b7eb8 ("iio: adc: meson-saradc: switch from polling to
interrupt mode")
> Reported-by: Elie Roudninski <xademax@gmail.com>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for fixing this!


Martin
