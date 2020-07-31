Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242F02348B5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgGaPwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgGaPwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 11:52:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C9C061574;
        Fri, 31 Jul 2020 08:52:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so12317542plz.10;
        Fri, 31 Jul 2020 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jppr8gO+oYSsBQjmvASbgGn6v8zjouS1E/rNTCOyFfU=;
        b=W1WM7SwvjDrTYShvzz81Bf1zNEhW/XcxE3lW52TQ3XB+SjzY1TXZj86UsmeDGcoHj+
         JS5RZSLo1ZK85ko+5Wes3WjkCMw421mlswP8Y7n1axo/HTBZph4fukJm0xeIEa6s0IsN
         AedyEJBnHmB1k6Agjp/8PKuRZGHxGAOtrGLHV0MGp6lWvcLrrmECdnX/R/vt7gliZLFd
         RpFiC0k/Jj9wn4mWXtpD9XaGOgwluplijTLv8RWmn1ACf2jmlb+hPOj4p8WRNyQEIPQE
         XGm1dmFqZ1IfVG6hVjCVWtkevDZm+FXSBJq58k2cyLOFwD+IDMfxProXY+z3Q6w7UP/T
         RzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jppr8gO+oYSsBQjmvASbgGn6v8zjouS1E/rNTCOyFfU=;
        b=LlvxCiLaLGHI52Md1gV6JVt1u/CVGCcL/2DaMQ0dVz9+fdvGyfUjECTTytWJlmT/F9
         cIWhIc7lF7GfI3JnVP/6yr+Oo+SZlLPYFJZupeKKRqbtD+Chy1BJu3Ni2MtdJYjNaGwO
         9Z5tjs0sF8rWNnUCYRzkJQpspxK4UEKyDeYv/h7jLooKL9ef5Iqvgyh+wF34MkZm0K4J
         53UV605nMpYIxLEIiQXJlkEjm56IKPh7HCoREuK2FK4fMJlJvFcEQIuxqGWVVNds7YzS
         Qsjdy/CcF3z1fNU3Hx9mPP3RPtfNO5nA4BCheu2+QjAKu6u3YGrbE7Ni2IjM9ry1Tu6E
         BAPA==
X-Gm-Message-State: AOAM530stjdU+WmO52u4eQSvhnqX+xNF2ELyLV0CWSPbA+xC6pJuR1p8
        /0kFuZAuzZwrkvyK0T0ZdmS36eUBC0wG7BDam1U=
X-Google-Smtp-Source: ABdhPJyuHLtjMmPKrplNVTpqkQVVio6fhm7SPCLrgUtF3PiOALVRV7K1x/iTGB5+BtooFM3RqUcK7ALncdj3FtxiZVc=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr4849916pjb.129.1596210737952;
 Fri, 31 Jul 2020 08:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
 <159598461271.1360974.15436404116157938506@swboyd.mtv.corp.google.com>
 <CAHp75Vc_3VYAkVcTCAXzqxqFnpQ4Qi=iPSFW_sUjYGO=o6YMtA@mail.gmail.com> <CAHcu+VaKGNxAY_OQ4oS5NtkoDLGkv2x_VrQhZ7OvEFAnNbYZeg@mail.gmail.com>
In-Reply-To: <CAHcu+VaKGNxAY_OQ4oS5NtkoDLGkv2x_VrQhZ7OvEFAnNbYZeg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 18:52:00 +0300
Message-ID: <CAHp75VeoS-K7v=iJLuFqXQJpqUjmdopJraUGOiOURekCh0=QTA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] iio: sx9310: Use long instead of int for channel bitmaps
To:     Daniel Campello <campello@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 6:45 PM Daniel Campello <campello@chromium.org> wrote:
> On Wed, Jul 29, 2020 at 1:00 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Jul 29, 2020 at 4:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > Quoting Daniel Campello (2020-07-28 16:05:13)
> > > > Uses for_each_set_bit() macro to loop over channel bitmaps.
> >
> > ...
> >
> > > > +       unsigned long chan_prox_stat;
> > >
> > > This can be DECLARE_BITMAP(chan_prox_stat, SX9310_NUM_CHANNELS)
> >
> > > > +       unsigned long chan_read;
> > > > +       unsigned long chan_event;
> > >
> > > Same for these?
> All of these are eventually used by regmap_update_bits() which expects
> unsigned int. I believe the extra complexity is not worth it given the
> number of channels.

Okay then. Good to have some build check for the limitation, so, what
about adding

static_assert(..._NUM_CHANNELS < BITS_PER_LONG);
after the _NUM_CHANNELS definition?

-- 
With Best Regards,
Andy Shevchenko
