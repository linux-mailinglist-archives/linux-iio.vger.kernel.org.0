Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE403146C6
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBIDB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 22:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBIDBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 22:01:35 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B713C061786
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 19:00:54 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n201so17267765iod.12
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 19:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=przYiSF1VdgRq/mKRAa2VwucMhSYXw4ZBgAm22uZ4H8=;
        b=dDELOdf0vJ714f+79VaneKhTwA+zZHWnXR1I51qWmhq3Alr/Mhyev7u/W2vSGZTfgT
         fgJvxbqLrQZctYOJyIhIGAPTdiMKbWN9pIyRLHysv3sbeUoqY20gr8R31BetKSMTh+3J
         kOQvLdILV7gjfLcZZfmi2fMef2qEgpOuvnDuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=przYiSF1VdgRq/mKRAa2VwucMhSYXw4ZBgAm22uZ4H8=;
        b=E94gnGBsdU7P5TJeoZ5gTSOYTa1p5rm6Mktc7ueLxAEoYFvDqAvh/sycxEdun5iNsL
         hwIFTWyAHqlRZ77o7PI7HU5aqZW9ITnADIfhULg293njDp2kjVFDUp7tf8IuUj19PDT6
         wqrnjpxh1uqz4BSodiMPM0bXZgTgqNX0Hw/k+dKY0viX8VwBnKI3GRjrNSBVb4KRBamP
         QcFBtqeHrcjTOeDyUfnbyvgzH71O4K899iSpKJW2Boc1c6MEbUKU9+Q9USY1FSA0HKUn
         QYpNp8Fe74xeUiJHczbqIXPW1Nw0kJjp/Oe1Q/X6dw/0DCKZIYHFF30X54At7DBfVOyA
         Lytw==
X-Gm-Message-State: AOAM531b6BKKJn2qQt6XmnxSzuKA5WgGtvNgxuev0PihiXxROD3uzVw1
        3FNWoV5rS2OEbg0E6fjGZ0G1lPzB2uJGzgj5Hg1HFQ==
X-Google-Smtp-Source: ABdhPJya5zrPZDbCDLAyB+djbuEecB/iGy7d3LYwG2KvW7lsLxR10cUUHeeuf0/XE3D0nPCFq2l5JpnkFMh2iAdqjN4=
X-Received: by 2002:a5d:9653:: with SMTP id d19mr13736453ios.65.1612839654137;
 Mon, 08 Feb 2021 19:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20210202064541.2335915-1-gwendal@chromium.org>
 <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com>
 <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com>
 <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com>
 <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com> <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com>
In-Reply-To: <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 8 Feb 2021 19:00:43 -0800
Message-ID: <CAPUE2utQFmkCYmUk3M96KbZqjt4PFtQTt4usbR=dZR5oL34Ljw@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 8, 2021 at 6:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-02-08 18:36:19)
> > On Fri, Feb 5, 2021 at 5:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Gwendal Grignou (2021-02-05 13:49:12)
> > > > On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > > > > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > > > > > index 37fd0b65a0140..1a8a441c9774d 100644
> > > > > > --- a/drivers/iio/proximity/sx9310.c
> > > > > > +++ b/drivers/iio/proximity/sx9310.c
> > > > This method of asking first for the number of element and a second
> > > > time for the values is already used at different places in the kernel:
> > > > drivers/power/supply/gpio-charger.c : see init_charge_current_limit()
> > > > or  madera_get_variable_u32_array insound/soc/codecs/madera.c.
> > >
> > > Sure it's used but that doesn't really mean it's a good pattern to copy.
> > > If the number is more than 4 I'd say we should ignore it and move on,
> > > but if it's less than 4 is an error returned?
> > >
> > > >
> > > > However, it could use device_property_count_u32(...), which is more
> > > > readable than device_property_count_u32(..., NULL,0).
> > > >
> > >
> > > How about
> > >
> > >   ret = device_property_read_u32_array(dev, "semtech,combined-sensors", combined, ARRAY_SIZE(combined));
> > >   if (ret)
> > >         break; /* Must have overflowed or not existed; ignore */
> > >
> > >   for (i = 0; i < ARRAY_SIZE(combined); i++)
> > >
> > > and then it should work as before?
> > It will not work:
> > If the DTD has a valid array of only 3 elements (for instance  [CS0,
> > CS1, CS2] as in
> >          Package (0x02)
> >          {
> >              "semtech,combined-sensors",
> >              Package (0x03)
> >              {
> >                  Zero,
> >                  One,
> >                  0x02
> >              }
> >          },
> > )
> >
> > device_property_read_u32_array(...., 4) will return -EOVERFLOW and we
> > will use the default in the driver, which we do not want.
> >
>
> Isn't that a bug in the ACPI property reading code? 3 doesn't overflow 4
> so I'm lost why it would return an error code to indicate it can't fit
> the whole property into an array that is one size larger.

This is how the code has been written: from the documentation (see
commit b31384fa5de37a):
+ * of_property_read_u64_array - Find and read an array of 64 bit
integers [same for 32 bit arrays]
+ * from a property.
+ *
[...]
+ * @sz:                number of array elements to read
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it. Returns 0 on success,[...], and -EOVERFLOW if the
+ * property data isn't large enough.

If the given array is too big, an error is returned. This makes sense
since the elements that can not be read will have undefined values.
Once again, the method of using count=device_property_count_u32() then
device_property_read_u32_array(..., count) is used throughout the
kernel.

Gwendal.
