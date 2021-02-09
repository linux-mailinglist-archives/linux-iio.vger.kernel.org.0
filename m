Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF24314691
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 03:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBICjI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 21:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhBICjD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 21:39:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098FC06178B
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 18:38:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id my11so767318pjb.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 18:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/MyS4+tYWGRvQvPzl8rurPTHSxxGcL/Xnj0XFVruO4Y=;
        b=Uvps1gDUZd7cK0NUFcabyN+Y5CqHFq5MFijsV/QMWYlFmrGP7167G4CEQUYmXSwPC9
         wd6yRuOK2ehSQ7hNFaYYW6PILr1xibFqb2QnVWT9J6DzZ+bPNDt4pqbAjMTeTw1nI4H1
         0UxCIrQUilmffbP5gap4W53RJxX0mBL0wKjWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/MyS4+tYWGRvQvPzl8rurPTHSxxGcL/Xnj0XFVruO4Y=;
        b=fRVsmq2T+9tAvwjZyuZ2dLrZvF5aLIUM/G1xOzqsU3iYPOOKAViigaiG5R1zuY+gwm
         qNW7WUykD8HdHhKwmeI2EJmp5h+oMyH+uQQdA2Z9wMm58rdmHY+88JhpaVEr6A05Crc/
         WURDyY9MoPQf8jT3GmisbrthWz++1BrdJjesou4jr5amYe+qukFlA2GKeCtv7yJSynPz
         EajZwIR6wiVGPNY18Ebs7m6q5fOLdu/Yo8SlEa9iJtePFV0qzy85NADnblXwe+hhd9A/
         uob3YtZQEXpgpPFq8vddpsyBjkbWWe0tQaaiUa921Tg3joDrTz2DYTW8h2tXLYzV9xcG
         vcPw==
X-Gm-Message-State: AOAM533/HAyIRCa8VrB2Y0ZdZBJ1vNyfPFe2q7o78lio6MtpW/f/4PZ6
        NEaxHTUyYXKHvyqq07NVY3RUNw==
X-Google-Smtp-Source: ABdhPJwh6xu19hANus1CMATjTkgKdH30GbE7ufenib3xJPYdH9EBnPpT1d7WANaMUCUC1JpR99A73g==
X-Received: by 2002:a17:90a:ee8a:: with SMTP id i10mr1834883pjz.210.1612838302396;
        Mon, 08 Feb 2021 18:38:22 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:751a:ba0b:8918:c305])
        by smtp.gmail.com with ESMTPSA id z27sm15437732pff.124.2021.02.08.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:38:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com>
References: <20210202064541.2335915-1-gwendal@chromium.org> <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com> <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com> <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com> <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 08 Feb 2021 18:38:20 -0800
Message-ID: <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-08 18:36:19)
> On Fri, Feb 5, 2021 at 5:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Gwendal Grignou (2021-02-05 13:49:12)
> > > On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> wr=
ote:
> > > >
> > > > Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > > > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximi=
ty/sx9310.c
> > > > > index 37fd0b65a0140..1a8a441c9774d 100644
> > > > > --- a/drivers/iio/proximity/sx9310.c
> > > > > +++ b/drivers/iio/proximity/sx9310.c
> > > This method of asking first for the number of element and a second
> > > time for the values is already used at different places in the kernel:
> > > drivers/power/supply/gpio-charger.c : see init_charge_current_limit()
> > > or  madera_get_variable_u32_array insound/soc/codecs/madera.c.
> >
> > Sure it's used but that doesn't really mean it's a good pattern to copy.
> > If the number is more than 4 I'd say we should ignore it and move on,
> > but if it's less than 4 is an error returned?
> >
> > >
> > > However, it could use device_property_count_u32(...), which is more
> > > readable than device_property_count_u32(..., NULL,0).
> > >
> >
> > How about
> >
> >   ret =3D device_property_read_u32_array(dev, "semtech,combined-sensors=
", combined, ARRAY_SIZE(combined));
> >   if (ret)
> >         break; /* Must have overflowed or not existed; ignore */
> >
> >   for (i =3D 0; i < ARRAY_SIZE(combined); i++)
> >
> > and then it should work as before?
> It will not work:
> If the DTD has a valid array of only 3 elements (for instance  [CS0,
> CS1, CS2] as in
>          Package (0x02)
>          {
>              "semtech,combined-sensors",
>              Package (0x03)
>              {
>                  Zero,
>                  One,
>                  0x02
>              }
>          },
> )
>=20
> device_property_read_u32_array(...., 4) will return -EOVERFLOW and we
> will use the default in the driver, which we do not want.
>=20

Isn't that a bug in the ACPI property reading code? 3 doesn't overflow 4
so I'm lost why it would return an error code to indicate it can't fit
the whole property into an array that is one size larger.
