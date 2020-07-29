Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80A42319CC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG2Gws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Gws (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 02:52:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A900C061794;
        Tue, 28 Jul 2020 23:52:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so1128942pje.0;
        Tue, 28 Jul 2020 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Am/TtCrrFfKaXzlFwmxItzz2ITP6WZphTK/VPluVd2M=;
        b=H556AlVJ3PQbgvszJ3rDpBSedjj6NHM8AiBtkDSGSk3h+9vrKtaqRzDb7pu5tr4X8L
         VkAIhR6IJO7JCR5QwjBlhhBmDpXSVhDOlmgoZfDzNJFXWSUObQ8b5FG4fnDEiviay7mf
         JYHWprbM3olkcW3XBdztpfRIAtzyDxy3lwdVj5dOIM1N3llDSu+2UmG2XojD/XYU1hX5
         H0YvOk9+mNvPIOA3Djw5/t8OJpDgYzMG2IQ8iuILcjsDv9+KHkroszFIaSS5rfvh0OjN
         wXhUmFjH5pabpyIRR3/tx5rIpbTQ0ZoGLGUejWZ395oWOk7FJEkEToy4cplCeaB+jjpl
         LN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Am/TtCrrFfKaXzlFwmxItzz2ITP6WZphTK/VPluVd2M=;
        b=P8McIeSQVCTxB9MBDneZBUtQa9djaxLwRhZJtdlcMtakJ+Q+dkruch6W5YOkFRuMw+
         UR9X+NiWSftW2P2ZMnvZGzeezDkQaXDt9iSy0d843pKOSRPR6E+2TxD8GyUZtlbmmNB5
         YSyFqq1cS0PqY+9TRG6VfmJefgVlpRMpAoZUpJriP1WUw3sImTrcUTXakJAQ/KROoNgw
         6ryftmaZOjB15pnbqMa1lJtD17FI6xldOz7Iyw2Shq6oHWcl9xj9998yijBxfPkiGr0R
         zEUmzluXOIF+njfprN4MFutLiwhIbMvtU+sUGNyUVTsJ5HkCAhMX+AKhUOEfwM8YJHCp
         jpdw==
X-Gm-Message-State: AOAM532aRivAKYQ82xF2hAb1NICariEvT+S79yVGd9VtnIALX5ffvA+O
        ecdHt9END1ELwsLRADkQTWfm0MWcjk0mMY7yKfs=
X-Google-Smtp-Source: ABdhPJwF4/zcqOFXvt7wM9A0X11E9f0a+SFZxtElBWQOlf1Ie76TxW7/SBaEQzrkzP1MKJBI1UukqNBoS5bUnf5iIvE=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr10863883pla.18.1596005567346;
 Tue, 28 Jul 2020 23:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.6.I27a5605d9cb3ff643ef040c4ef932a30df9a8fac@changeid>
 <CAHp75VfLYqPpO5M6GaHfSBBkQoZpnVTHFKVX5k9Pu_RjMO-whw@mail.gmail.com> <CAHcu+VbxtAz-2y9FLdraqhYjzHKmi-5O=MioSU1caupT_y6PrQ@mail.gmail.com>
In-Reply-To: <CAHcu+VbxtAz-2y9FLdraqhYjzHKmi-5O=MioSU1caupT_y6PrQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jul 2020 09:52:30 +0300
Message-ID: <CAHp75VejNVhRhVEPimbj3S4zMPTsiBgk3qmMAX+jfYN2_i2G0A@mail.gmail.com>
Subject: Re: [PATCH 06/15] iio: sx9310: Align memory
To:     Daniel Campello <campello@google.com>
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

On Wed, Jul 29, 2020 at 12:26 AM Daniel Campello <campello@google.com> wrote:
> On Tue, Jul 28, 2020 at 12:11 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 28, 2020 at 6:15 PM Daniel Campello <campello@chromium.org> wrote:

...

> > > -       __be16 buffer[SX9310_NUM_CHANNELS +
> > > -                     4]; /* 64-bit data + 64-bit timestamp */
> > > +       /* 64-bit data + 64-bit timestamp buffer */
> > > +       __be16 buffer[SX9310_NUM_CHANNELS + 4] __aligned(8);
> >
> > If the data amount (channels) is always the same, please, use struct approach.
> > Otherwise put a comment explaining dynamic data.
> I'm not sure what you mean here. I have a comment above for the size
> of the array.

Here [1] was a discussion about commenting on the dynamic amount of
data [see the cover letter and replies to it] in the buffer and the
struct approach [e.g. very first patch in the series].

[1]: https://lore.kernel.org/linux-iio/MN2PR12MB43905A2256F98BB5EFCE7DD3C4770@MN2PR12MB4390.namprd12.prod.outlook.com/T/

-- 
With Best Regards,
Andy Shevchenko
