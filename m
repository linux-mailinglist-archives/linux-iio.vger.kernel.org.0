Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8CA6B22
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfICOTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 10:19:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37308 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICOTT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 10:19:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so16253524lji.4
        for <linux-iio@vger.kernel.org>; Tue, 03 Sep 2019 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIDS3i5V8/hLhvP5KnwHpdHDL8TaBaqhJaWdCST5U40=;
        b=gj4xaeodJFFHT5hgdBez3W1LIzH9PM8ASeRUmKMnWB8EDglrbEfrUIUdB1f1o4D35k
         m9ZOQ6yjp4PGS8VSFX+RCPSsEJ8REk6CQy/FUaLyaise2Fxu6c+1UFnzzH+Un6jyx5N/
         nAacpkkKrd4zc7Bjv2X36dZY2+O/dQeRavQuCjl8zrl2JqN0ccioAuMFX5QECrK/jxmG
         P+3xzC2cegcHWQ7W2GMdm3EsC5oYd/s61TUVcbpj0jIFZXF3T/BY+dzxXBsiYDXN/02v
         ABUd39ZHptpgTI8aJy0ZZ8kJq0a5ZtBGh1utlSgxXM5itBcxPoi0xc5J/R9jtwaOJJNf
         Emew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIDS3i5V8/hLhvP5KnwHpdHDL8TaBaqhJaWdCST5U40=;
        b=fDakvGlM/PbUMwNY3GNNzEHCQ8Mg28TLRZaCsIk7OzctJwftItDgP5MYsvfrBMpKr3
         GrhVPTwsuY+Tcc1afp9f7dtuItpdJOaB/wg/IdS4bo+9sOrA3Ca2x1Y3ptXPf4on9IOy
         DZbEhmUH8jqYTyICMYBolj9Sqv57J8XAba/dt8XxcG5y5NeeV+wc95tLiqimjOfh8Jg/
         FHAvNZbkxroQuDYUBzTewcc4TigA3FA7+3FqB33cLkCWPeu2dGlm15FU31NuZf8oJoJ8
         gnZyTAYM55RYzHlD6U2epIRyCvte61lKqvRVCOPdkaDPdVX8GT6l+88M3+DOszAhJnH6
         veSQ==
X-Gm-Message-State: APjAAAXPiw3GopU7MULt7ESi5sDvhtUnEMY6aZbq+Dzmr1yiU325Tsdm
        eZmrHrU/yFiWoaBVMoKMWteN5gfGOSJGp0atZvrP8w==
X-Google-Smtp-Source: APXvYqybe8aYWIe6XGhy9BUyVfKha69BNmPn6GKwI1uifQK+hDdX35H82E3XQCJzoToEeEnmSA4PTOViYPXeM+Kvv/U=
X-Received: by 2002:a2e:9903:: with SMTP id v3mr20033602lji.37.1567520357192;
 Tue, 03 Sep 2019 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190822145233.18222-1-linus.walleij@linaro.org>
 <20190822145233.18222-6-linus.walleij@linaro.org> <20190902093024.GH32232@dell>
In-Reply-To: <20190902093024.GH32232@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Sep 2019 16:19:05 +0200
Message-ID: <CACRpkdZfzdFrheihacHUreiSAfC3KLtLr0+o+rHYymaXc-EmvQ@mail.gmail.com>
Subject: Re: [PATCH 5/8 v2] mfd: ab8500: augment DT bindings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 2, 2019 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 22 Aug 2019, Linus Walleij wrote:

> > +  ab8500_btemp                : io-channels "btemp_ball" and "bat_ctrl" for measuring the
> > +                        battery voltage
>
> Voltage?  Not temperature?

No it is just named like that, super confusing but is in the datasheet and
the register description.

In drivers/hwmon/ab8500.c, function ab8500_voltage_to_temp() you
can see how it is converted into an actual temperature.

> > +  ab8500_charger      : io-channels "main_charger_v", "main_charger_c", "vbus_v",
> > +                        "usb_charger_c" for measuring voltage and current of the
> > +                        different charging supplies
>
> Are you not a fan of full stops? :)

Added some!

> Besides this, looks okay in general:
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Should I record that as just Acked-by: when I resend or do you want
me to record the infix when resending for clarity?

Yours,
Linus Walleij
