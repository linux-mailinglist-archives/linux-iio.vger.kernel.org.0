Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7281A7642
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436955AbgDNIiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 04:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436826AbgDNIiI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 04:38:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092EC008748
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 01:38:07 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i75so11177714ild.13
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jo/o9ww/4cJSnmnkD3CjyH8WMNoX0+k4o9KsdfhD1SU=;
        b=y8PtE+gTsDZZwWFwSeHHeCFQ33Ojb2y6ulbiOVndaSWifuuU1qY5CJhInz8wkvASVH
         yVPA5Cg4kidytaGezrBCLdW4Ot8vgNCUOjK1xXp0gMXNgy8sAT71WrdTTw6cF9Lg/9aR
         0j5+CLbOZOKInlCz7qORieFxv7d/WB/5Ft+UWYOoOcqt45CjWh0vGWn+jiDIsbJub6Zx
         6RTgxEu9otv8/DDGf2UCmwNYUDW1jtxjvh3oN5hh+yh8eGHq0OO3mKBpvqGx7mJBFtFt
         FPlMkosertwNnlsQqcXiYpSZpteWM6yEM5v1cMAMZi4xQ9cYoOikip2laVHl5Mv5niBy
         b5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jo/o9ww/4cJSnmnkD3CjyH8WMNoX0+k4o9KsdfhD1SU=;
        b=pSGFZ7uU9Y81gHLqaIUje2UIJvM0S47wZRQ/IoUnZyyManWzxM8Qvm6cby6XgC2NM7
         kZ210dez5ogv9laD2hPjQ5SbJl/evf/177QR4Hs6zn64/j6OowGP9aW0X3QqLKNzZo0k
         c5KqISLjEqEU04XWI0m0uOQ80ntdfAGe+WJNiB/yFDoOvEVPiU1lWfoXLfjvJYJDkqzJ
         ESueOtP3vh0ysu47XRLcRGkU22CMwLCMEptFSOnihwhhFPW6+Ch165dpScnnqxZs+9KI
         XUiKQ5PliwHzCDjsC+A4g9dpFNWw7gE3p58ueiVkF1ueJIY9DGU5St7OwV9gT+nEKkYg
         pOmQ==
X-Gm-Message-State: AGi0PubvmcDrBsHD+iQLGtcY7fIq7Rd/f8fNKNPXxcQS9XIFu3KlPNqb
        nRjJ55nyLutFfAUfxk8qVvOkm4yEqKTrxnILld/RZbRd
X-Google-Smtp-Source: APiQypJLEx+4wdr30LFxsnO4FePdVk1/hUYO2QfJBCM4GEMyVVTdfS1Zgqb6bqkEsd+A63s85UfcT0IaUyDRqecuwjY=
X-Received: by 2002:a92:dac8:: with SMTP id o8mr12258552ilq.189.1586853487047;
 Tue, 14 Apr 2020 01:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200211131240.15853-1-brgl@bgdev.pl> <CAMRc=Mc=gTrpQsMdOTBJaYT6JLg=o17Mm78ijAGUJYE2pXcCQQ@mail.gmail.com>
 <20200413180728.0714da3d@archlinux>
In-Reply-To: <20200413180728.0714da3d@archlinux>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 14 Apr 2020 10:37:55 +0200
Message-ID: <CAMRc=MenWERT6VegvdRkwJ5xKwa01QRK+BbE2GhEk-+Jw36GvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] irq/irq_sim: try to improve the API
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

pon., 13 kwi 2020 o 19:07 Jonathan Cameron <jic23@kernel.org> napisa=C5=82(=
a):
>
> > Hi,
> >
> > it's been three weeks, so gentle ping on that.
> >
> > Or should I resend the entire series with a more elaborate commit
> > message for patch 1/6?
>
> I'd resend it now if nothing has happened that I missed.  Merge window
> having just closed, it's the perfect time for a rebase on rc1.
>

Yeah, I'll resend the first two patches which are less controversial
and then see with the rest of them.

Bart
