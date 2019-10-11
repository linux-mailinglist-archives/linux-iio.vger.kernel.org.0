Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27005D39D5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfJKHHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:07:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37852 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfJKHHp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:07:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so8743177lje.4
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMRAqG5BzH34QtcOckq2OAXBNCAwG74oouEQA4P4k5k=;
        b=m82JXHQoMVAx2eaF4EZXaxc/l0OAJ2Gx3DIHP925pL2EWhdXTjfHjOlcDZ6NmD41NH
         rnE3FGwv226fgYKudXxyByX9AYafguW6y2/VjcjYr4o6CxqeH7slzdkCvs0ZyWD1hAQh
         5UPoqgrF71EuqavQaw2aWGWMOwg/oPLvgRy/l3wiaGEWmJn1moFhlhD18/2y0IiE6iNb
         4LnpXBtgbsAbzxKf5eop/ijUdIWg46UAJtkC4ObcDGGRLwftlvuUnx24jNRV06JiL3MY
         RMNrJjhwAFdFLhczdpuh8JQCluARffb9GdMSr1MbHPLMcpY1n70nVH0oLwHo/h0OWxUS
         A52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMRAqG5BzH34QtcOckq2OAXBNCAwG74oouEQA4P4k5k=;
        b=FCOG20RWhYF8XWcoemksBtwtCtndjbwRqbdapxNhvtP6cw7k+rLNDoKE4qOqCTCUbC
         rBbt9gHtUHB1I4VkiIytaazAnz0jy0ys9Y+fugN7pS0ntrVIXXi/05lDBlGKOz0kJOXU
         RvGPNmvlGbJfXj8iNz5nzuE5o5nes2Ib88GlCSPQRJ8t+QWBWdReJJaBHJbSG5jGW2xR
         X4zuZTgU353Hu2GkTIrbPpMcRjLhBb9pKpjrtKKOI4rIUXQNvUFi/zOmzAbZgcft5QFj
         381LShl5iFnfpu6EqJ+57dah585Afj7r7ww2FGjME1OmjenFqDug/9OMd96nYFTU8VqM
         F9Nw==
X-Gm-Message-State: APjAAAUWdRoP+ZdCUBsDja+nFJkLiwtQpbnAQRJXZ5wBeh/0/sbCqW/9
        hgtRhU5R0y9BtAVJFsJjmYemV4bFoaruT442dcY/kw==
X-Google-Smtp-Source: APXvYqwKX431J+PMA2u2tXXF96O/zALY0bVxm7M6HozsrL+W3kvBvywF1bZix14nfbqpwAlTiZNB8AkMZjlwIpW0Cwk=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr8332395ljk.152.1570777662155;
 Fri, 11 Oct 2019 00:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191001221356.19317-1-linus.walleij@linaro.org>
 <20191001221356.19317-6-linus.walleij@linaro.org> <20191010183902.GA4633@bogus>
In-Reply-To: <20191010183902.GA4633@bogus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Oct 2019 09:07:30 +0200
Message-ID: <CACRpkdZZK9kQuEBHjNBG37EqeugFiVmJ3GLFf19L70OiYwy14Q@mail.gmail.com>
Subject: Re: [PATCH 5/7 v3] mfd: ab8500: augment DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 10, 2019 at 8:39 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Oct 02, 2019 at 12:13:54AM +0200, Linus Walleij wrote:
> > As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> > the bindings to account for defining the ADC channels in the device
> > tree.
> >
> > Cc: devicetree@vger.kernel.org
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v2->v3:
> > - Change "adc-channel@" to "channel@" as per preferred notation.
> > - Add some full stops to the end of sentences.
> > - Reference the new ADC-specific documentation for channel specifier
> >   etc.
> > - Collect Lee's ACK.
> > - Rebased on v5.4-rc1
>
> Humm, this is the 2nd v3. Can you address my comments in the 1st v3 you
> sent[1].

Sorry for the sloppiness. I blame it on the weather and some
organizational stress. I'll fix it up and send a proper v4.

Yours,
Linus Walleij
