Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D016314754
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 05:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBIELz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 23:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBIEJA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 23:09:00 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4757C061788
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 20:07:30 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u20so17403673iot.9
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fGYCGRWIiJQStmUSJuig24BownwHa86HaZ0Sa61dU8=;
        b=frN/peSPGiALR34Va9d3kTfsn6SDblb5ekL3wpPEEMY5K1gOEJ5bpLZ8GWPCMC1Ykv
         VEqtMF+qP2PE9sx1evFBup4Yze811VYH0AHhrR/qlf76WSo8uUaDGmwYGL7j37UYQ6Lp
         ayXpGZumEI+0xtC9hho2LEDFdRdsRPrGT7PW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fGYCGRWIiJQStmUSJuig24BownwHa86HaZ0Sa61dU8=;
        b=P1n5jmMCEzbT276Q75Anz5xwV8kuU0yN+j3jP6fqS/R+GG4aR5ixAB4mb2OxEp5xot
         nkVZvybztuO2gPD4kPaTxbXm0sCL5HCEIirhF+ZfqSZvGkrlcNdFNzIV74LleYPvFwfn
         ao40I1hEv9q9zr2M4a2DkxYYQ+nRpLmdeX6//fxgPvazsQYGua4gy360c47Hd1A1quNu
         lx99FUZ7er0kAHgssj2y8N+HzJFiWW3QPs5CWmI0wddjVHcT2vnDwhrHh3OUGbSKsjkJ
         8LcFB03BMCGjfRo/LE8vjktYXYsx2iNHBVcJabLd+sJRl1mIuedt02RNE6cUPtYKF5Nz
         6vrQ==
X-Gm-Message-State: AOAM53148fvQtnNvVbDn3rNlTw6aoVn/fhYO2c1OKASjFRGQWI1a8z5L
        7C2rugy6HCna4veYplcxn88GtwFUKiELLYC728sedA==
X-Google-Smtp-Source: ABdhPJx5ZoAejjjyoz2dKTciKkhit+sqHkhO/phC9wSULBT2C73VZG9dsBrpgg4aauuF2ua7wOzwWcpwW6kFD/gjokU=
X-Received: by 2002:a02:ce33:: with SMTP id v19mr20936581jar.52.1612843650319;
 Mon, 08 Feb 2021 20:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20210202064541.2335915-1-gwendal@chromium.org>
 <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com>
 <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com>
 <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com>
 <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com>
 <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com> <161283922598.76967.9707750025474688009@swboyd.mtv.corp.google.com>
In-Reply-To: <161283922598.76967.9707750025474688009@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 8 Feb 2021 20:07:19 -0800
Message-ID: <CAPUE2usY4GZhGkjmibMfVUTzK3c_Lz5HqNFo_fVRa_gqkmk8OQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 8, 2021 at 6:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Stephen Boyd (2021-02-08 18:38:20)
> > Quoting Gwendal Grignou (2021-02-08 18:36:19)
> > > On Fri, Feb 5, 2021 at 5:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Gwendal Grignou (2021-02-05 13:49:12)
> > > > > On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > > >
> > > > > > Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > > > > > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > > > > > > index 37fd0b65a0140..1a8a441c9774d 100644
> > > > > > > --- a/drivers/iio/proximity/sx9310.c
> > > > > > > +++ b/drivers/iio/proximity/sx9310.c
> > > > > This method of asking first for the number of element and a second
> > > > > time for the values is already used at different places in the kernel:
> > > > > drivers/power/supply/gpio-charger.c : see init_charge_current_limit()
> > > > > or  madera_get_variable_u32_array insound/soc/codecs/madera.c.
> > > >
> > > > Sure it's used but that doesn't really mean it's a good pattern to copy.
> > > > If the number is more than 4 I'd say we should ignore it and move on,
> > > > but if it's less than 4 is an error returned?
> > > >
> > > > >
> > > > > However, it could use device_property_count_u32(...), which is more
> > > > > readable than device_property_count_u32(..., NULL,0).
> > > > >
> > > >
> > > > How about
> > > >
> > > >   ret = device_property_read_u32_array(dev, "semtech,combined-sensors", combined, ARRAY_SIZE(combined));
> > > >   if (ret)
> > > >         break; /* Must have overflowed or not existed; ignore */
> > > >
> > > >   for (i = 0; i < ARRAY_SIZE(combined); i++)
> > > >
> > > > and then it should work as before?
> > > It will not work:
> > > If the DTD has a valid array of only 3 elements (for instance  [CS0,
> > > CS1, CS2] as in
> > >          Package (0x02)
> > >          {
> > >              "semtech,combined-sensors",
> > >              Package (0x03)
> > >              {
> > >                  Zero,
> > >                  One,
> > >                  0x02
> > >              }
> > >          },
> > > )
> > >
> > > device_property_read_u32_array(...., 4) will return -EOVERFLOW and we
> > > will use the default in the driver, which we do not want.
> > >
> >
> > Isn't that a bug in the ACPI property reading code? 3 doesn't overflow 4
> > so I'm lost why it would return an error code to indicate it can't fit
> > the whole property into an array that is one size larger.
>
> Or it's a bug in the driver because it's assuming that it can read the
> DT property out even when it is only length 1 when the property read
> should be variable length. Can you split this into two and fix the
> underlying problem with the read of the array not matching the length of
> the property? I think it needs to be
> of_property_read_variable_u32_array() with 1 and 4 for min and max.
Splitting the patch in 2 does not make sense given
of_property_read_variable_u32_array has no equivalent in the
device_property_read_ realm.
That function introduced in the first patch would be removed in the
second patch.
I will update the commit message to indicate this patch takes care of
the "semtech,combined-sensors" variable array for both DT and ACPI.

Gwendal.
