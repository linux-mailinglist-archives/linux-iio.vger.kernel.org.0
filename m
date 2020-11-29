Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8942C7B33
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 21:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgK2UnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 15:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2UnO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2020 15:43:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160CAC0613D2
        for <linux-iio@vger.kernel.org>; Sun, 29 Nov 2020 12:42:28 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so16751234lfg.0
        for <linux-iio@vger.kernel.org>; Sun, 29 Nov 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uBLY7Ua4rfHubKZI/G+6QMI6J0iMgJ9HGZNIZryQbY=;
        b=ltAUV8xcjgqKSy62ciPxDWEgXuyJ1B2kI6+cb44w6G19toyVP0D6HZddlG1zwZCpva
         h6ieZY5Ieh6NkyaYxLt9nWFxGZwboGuSe/k5zeOV70Ls4tl0EN7blQUHu8fbFcOrAQlG
         7b9yXAJ9nH0Z0LWOU09A81+U3gO6LRGTE65dfgXaOzWQpSCo0CpaUIJircI680ZNI4LW
         8wM40VohlpKEDOCs2bSSCt2kf0kgc3MAliO1g+rqyuQMdjl9KE03oIEYg8dcIBtki7ql
         ks0WaeFPO63yC6XAP/LdRFPFgQVIFsXrCfODbTPM9KQOdrpzcWJgGAaRLckjVpmhwf+G
         KCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uBLY7Ua4rfHubKZI/G+6QMI6J0iMgJ9HGZNIZryQbY=;
        b=LzbvIpJ70XApAJRBZyRDqNhAz/NlimQGB9dSDNItdhxFTrtlPlSuIe47iyoKVwdhML
         tX+TGiKLUlOEqnDORwZP4aHD+7hDn9LBBi8XYMeSqBUAzNah4lv7nTlKAMeRKQtv3IGN
         T2UPuoYtDA4jPzkaV7w2OwHEot9KH9B7JJhrN9CbUn918pw/RyGFZhqeF3NwJecnj3uF
         SBkP2IUOd37fJQjVgPj88k+WeQdVl3556NYtK4ECc8Tu62h5Ed5fSIcwQ8Jg4SWxyOsi
         Hh/VsOFNsLNZUbDdssQFkvu7yYHMz+wkOorbtT5A0pFJlzGULIW/jhw695t5tmzuIGzm
         +DTw==
X-Gm-Message-State: AOAM530JVmSYCTWXvMkd6BwbG8Wn+DP6nMC8N8EtfGPVu8U2Pbi9vLve
        4ZWPkiOjjAB0XVtVWjB2oSlsaldNZJdgro0+V7Z3F0CwiTeouA==
X-Google-Smtp-Source: ABdhPJzY1JviYd7H5LSLECyBaOqpwEM2KhxmJ+AniJVEswZixjGqXiHBl5M93+TInnvMzvW81pJoUhC2J6S082yRyCY=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr7417427lfb.572.1606682546304;
 Sun, 29 Nov 2020 12:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20201128004038.883289-1-linus.walleij@linaro.org>
 <20201128004038.883289-2-linus.walleij@linaro.org> <20201128122153.44c1052c@archlinux>
 <CACRpkdYvkV0Xrw9fseQneHwhJ-EkcX+RQKVcCF8hhidE479AmQ@mail.gmail.com> <20201129112603.1644e5a5@archlinux>
In-Reply-To: <20201129112603.1644e5a5@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Nov 2020 21:42:15 +0100
Message-ID: <CACRpkdYFGRsk28hLGxNB4jOE2vVMMmSLEGSxucsBQGnuzxPCeg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: Add driver for Yamaha YAS5xx
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 12:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 28 Nov 2020 22:04:56 +0100  Linus Walleij <linus.walleij@linaro.org> wrote:

> > > > + * YAS530 MS-3E (2011 Samsung Galaxy S Advance)
> > > > + * YAS532 MS-3R (2011 Samsung Galaxy S4)
> > > > + * YAS533 MS-3F (Vivo 1633, 1707, V3, Y21L)
> > > > + * (YAS534 is a magnetic switch, not handled)
> > >
> > > And there is your reason not to use wild cards in the dt file name etc!
> >
> > It's pretty safe as we definately account for all magnetometers
> > of the naming scheme YAS53x. The YAS534 would be in another
> > subsystem (proximity, I guess) so the path to the file gives the
> > right info: this covers all magnetometers named yas53x, goes
> > for both the bindings and the driver I think?
>
> I'd just name it after a specific part.

OK no problem I just name it yas530 everywhere as it is the
oldest supported part number.

> > > > +     c->a2 = yas5xx_extract_bits(&data[3], 10, 15) - 32;
> > > > +     c->a3 = yas5xx_extract_bits(&data[3], 6, 9) - 8;
> > > > +     c->a4 = yas5xx_extract_bits(&data[4], 8, 13) - 32;
> > > > +     c->a5 = yas5xx_extract_bits(&data[5], 10, 15) + 38;
> > > > +     c->a6 = yas5xx_extract_bits(&data[5], 4, 9) - 32;
> > > > +     c->a7 = yas5xx_extract_bits(&data[6], 5, 11) - 64;
> > > > +     c->a8 = yas5xx_extract_bits(&data[7], 7, 12) - 32;
> > > > +     c->a9 = yas5xx_extract_bits(&data[8], 7, 14);
> > > > +     c->k = yas5xx_extract_bits(&data[9], 10, 14) + 10;
> >
> > Since this segment easily fits in a u64 I thought about
> > extracing a u64 and then use FIELD_GET on that.
>
> Could do, but to a degree what makes sense here is dependent on what
> aligns well with the datasheet as that's what people will check against.
> Is there a public datasheet with this in?

There are public data sheets, but no public register descriptions.
The only documentation is code looking worse than what I
wrote (IMO).

Yours,
Linus Walleij
