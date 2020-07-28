Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB1231494
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgG1V0t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgG1V0s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 17:26:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12028C0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:26:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t142so924071wmt.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4COYxTSTRnEzjznO2W6thCBJlNbZdidcvO9PjI7DyOk=;
        b=vhJzTBeIpGarovZTpfjGx2Wa4L/R56gWYMM4br6jBZCGiL2RRlaYq6F4HADG0Jjh7q
         7Shwf2OOdpkL8UVhuKmh7ZmlASrWEca4vvwloDyjOrKINAPXNaHEGtDRpr0znTDrmaua
         483jKJ7GAIXEtLrDBZcp2eBOuVkAkNJne8hkdo8Q5YJSQ0zCAMZNG4bjgm6bLgy53Rdc
         8nkfTTqq/EjxzgNheidLNbMFafSvM+iXL2mqii/7G62yoWSTo0zW+7CrOFteXyjjABxc
         I6doe35twysT/7Csc71/R79KFQHEslNiMmAxLzM+m+Z/SZfijuV9ZxBPlryaFjXwSmYr
         4Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4COYxTSTRnEzjznO2W6thCBJlNbZdidcvO9PjI7DyOk=;
        b=aHAb2k9toxDHj+M0499AYye0Pw08z8OYCGvF0NjyXmAWdogJAQYnUSthlq1E0pGJ7X
         lFIpcT/i1U/NjFKIfATtNJPFkaLnfGjCfR1W87zIM6sRvfOPW1wbwy9HP4ubFHzrzmEa
         pyylGPga75P5wmCWRVnlks3whW12rP3+8+JNegB6FsbI8wCjYI56+ZNTMamt0F9etwxw
         HmgQE9l4QKkG9Kam+EAVmxPBqUYNmt1l0Y4RGTtmgKjZVatOHBra4aCJFItfFYMDiVZw
         vNiDahrUsquxTZQiPUZVCJGmpLogffyKl5KpWVCpzUE0KzL7ki6+rJ/7z0BKXxafeRty
         Z63g==
X-Gm-Message-State: AOAM530GnVXB+findsZSZGNwTh815owQK+FTQWKdUN+vCH2snTB0fBXD
        U96RcTTHQpypPzJjwFXvbHgocCxUN8VA8AzzSfceAw==
X-Google-Smtp-Source: ABdhPJxRU30KGbLhwtAg0ELxyVwt4UfnHqz95LfEc0Qp6GL8XOPE3pFebCMm7ev+0CUib1mosoa7cggc2QZ9CjzdnSY=
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr5391985wmc.115.1595971605637;
 Tue, 28 Jul 2020 14:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.6.I27a5605d9cb3ff643ef040c4ef932a30df9a8fac@changeid>
 <CAHp75VfLYqPpO5M6GaHfSBBkQoZpnVTHFKVX5k9Pu_RjMO-whw@mail.gmail.com>
In-Reply-To: <CAHp75VfLYqPpO5M6GaHfSBBkQoZpnVTHFKVX5k9Pu_RjMO-whw@mail.gmail.com>
From:   Daniel Campello <campello@google.com>
Date:   Tue, 28 Jul 2020 15:26:09 -0600
Message-ID: <CAHcu+VbxtAz-2y9FLdraqhYjzHKmi-5O=MioSU1caupT_y6PrQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] iio: sx9310: Align memory
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 12:11 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 6:15 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Use __aligned(8) to ensure that the timestamp is correctly aligned
> > when we call push_to_buffers
> >
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > ---
> >
> >  drivers/iio/proximity/sx9310.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index de52afd7c13333..fb5c16f2aa6b1a 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -131,8 +131,8 @@ struct sx9310_data {
> >          */
> >         bool prox_stat[SX9310_NUM_CHANNELS];
> >         bool trigger_enabled;
> > -       __be16 buffer[SX9310_NUM_CHANNELS +
> > -                     4]; /* 64-bit data + 64-bit timestamp */
> > +       /* 64-bit data + 64-bit timestamp buffer */
> > +       __be16 buffer[SX9310_NUM_CHANNELS + 4] __aligned(8);
>
> If the data amount (channels) is always the same, please, use struct approach.
> Otherwise put a comment explaining dynamic data.
I'm not sure what you mean here. I have a comment above for the size
of the array.
>
> --
> With Best Regards,
> Andy Shevchenko
