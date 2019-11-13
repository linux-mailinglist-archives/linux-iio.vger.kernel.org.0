Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62600FB7A4
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 19:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfKMScj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 13:32:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36651 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfKMSci (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 13:32:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id j7so2722651oib.3;
        Wed, 13 Nov 2019 10:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cduUxY81dK6FATxcJPl9Q1qZAjOQW4lgU+z9WUW0USM=;
        b=V28/Dvqd/t/5511PdZYlQWWIiuYiegIRu6bH5vRtngsafZMWeFCpwvEclcbx0w/5D7
         iy0BOpaF1wzB2CeubqNV/+WNqBnWogFCnwR0ZAVgISxIpDFLo83Bza/M8UARjrk8ddJA
         +N0gBKJhopfyLNpJ5hWONrlsIf3aZ1Oh8tIRxYBAK/epxC3QuyU/bVuksOqsAdflHw1n
         QjGbpftqVxSxm0/UGHswt6y8Xu4i6kKm5P6VcRU/dNMIMs98y/56PxOUPBj/ScUxzqv0
         G0OCC1qBdkGu8IkoMusP7euMx8TU7wQ/5ZceWK3bVM1vYCtP1nw/OYyPAXihk8ESxWY8
         Wz6g==
X-Gm-Message-State: APjAAAWgoiBnYhkegxS+imICWNl7ZYU5BrBkUlvuwceB9NwU+yqZlP1Z
        EhqQjrPkimgz41YtIlc1+3TnA1yFYXg/BdsnqX4=
X-Google-Smtp-Source: APXvYqwq+I1WKqcpRoDsqQgesT61g+HwzdCel1J9cdIofKyiHiYzNfMWLLPrDFN6wFG36xUA9RaaoKf/U5T2nnXhhuk=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr9636oia.148.1573669956588;
 Wed, 13 Nov 2019 10:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20191113092133.23723-1-geert+renesas@glider.be> <20191113180057.GA2764@ninjato>
In-Reply-To: <20191113180057.GA2764@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Nov 2019 19:32:24 +0100
Message-ID: <CAMuHMdWp8Sjkz7oOa6cHOQcHP5cwHMQcp_4aNA=HssBjrtGZQQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max9611: Fix too short conversion time delay
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Wolfram,

On Wed, Nov 13, 2019 at 7:01 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > According to the datasheet, the typical ADC conversion time is 2 ms, but
> > no minimum or maximum values are provided.
>
> That sentence makes me want to increase the delay to 4ms.

That sounds a bit excessive to me.
According to my measurements, it's 1.8 ms.

=> 3 ms?

> Maybe we can ask someone at Analog in parallel? I recently found this
> patch from an Analog developer in my inbox "[RESEND PATCH] drm: bridge:
> adv7511: Fix low refresh rate register for ADV7533/5" Or do you guys
> know a better contact?

s/Analog/Maxim/?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
