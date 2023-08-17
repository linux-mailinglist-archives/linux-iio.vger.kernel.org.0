Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB977F5BB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Aug 2023 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbjHQLwq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 17 Aug 2023 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350547AbjHQLwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2023 07:52:18 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0634730E5;
        Thu, 17 Aug 2023 04:51:51 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d6fcffce486so3309147276.3;
        Thu, 17 Aug 2023 04:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273101; x=1692877901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6ZtsQjpbvoSFy5V1v25dYKYuqk3BQ0/YcKFrB/U4fE=;
        b=dUJktsZjTTjwIyZ+hFcLMRN3UxqwpFWmQo7oIID+o7bGEUwJjykj0Tzt3tXMC52FQ8
         fSHHuFfrR7sYnxrUyq4Hbv/pP65T0mgV9IgggyI4L5SbKB9TSe3Purj7N5ySLf2EBCCi
         zjXSQ1ReuY7w7GjsUhkrL9SiuyYzCEWRM44lXTHkrROk70GNuDEajwsBhdkxwZalA0CF
         Pk08y62XrzQJIw9VcKYzWlH0VuZmzo7P87r0a7j7OJM09/I+zM2bYXJkR74HJdTFUNYV
         8iyGB+pmCvt7khgV1KXEveApQLRd/ZM821VIJEuoPZZJqEK0ou6eVp/8M8MGN9kteFot
         Sxmg==
X-Gm-Message-State: AOJu0Yz1Y4V73XWy61ksPpT/dEUarwg2ZhvooEgWCIzmoDOp5wRUfFXm
        Z0OJEIrAtdsC0Re9KG6ibz+fpBTj0krH7w==
X-Google-Smtp-Source: AGHT+IF38+dKkFjcVr3N+b28rNv3ZsdlbOQGZXIa4fXjREDwQXQKfmluYft3pjd1T1JeHPW7SAwWCQ==
X-Received: by 2002:a25:d10c:0:b0:d6b:7f20:22d3 with SMTP id i12-20020a25d10c000000b00d6b7f2022d3mr4640112ybg.57.1692273100849;
        Thu, 17 Aug 2023 04:51:40 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id e14-20020a25690e000000b00d682d2d1d62sm169955ybc.51.2023.08.17.04.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 04:51:40 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d45caf42d73so7387223276.2;
        Thu, 17 Aug 2023 04:51:40 -0700 (PDT)
X-Received: by 2002:a25:941:0:b0:d0a:da40:638e with SMTP id
 u1-20020a250941000000b00d0ada40638emr4598174ybm.12.1692273099841; Thu, 17 Aug
 2023 04:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230812090418.75020-1-biju.das.jz@bp.renesas.com>
 <ZNsm3efpkYlL4Gki@smile.fi.intel.com> <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
 <ZNusymsNh/zFgHg7@smile.fi.intel.com> <CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com>
 <ZN30yevtrxRrzmS5@smile.fi.intel.com>
In-Reply-To: <ZN30yevtrxRrzmS5@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 13:51:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVc547yPbstCiaWe9ZEqa91p9XJQd=AEP8d-wgUGZ4HuQ@mail.gmail.com>
Message-ID: <CAMuHMdVc547yPbstCiaWe9ZEqa91p9XJQd=AEP8d-wgUGZ4HuQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ti-dac5571: Use i2c_get_match_data()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jean Delvare <jdelvare@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Thu, Aug 17, 2023 at 12:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Aug 16, 2023 at 10:16:00AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 15, 2023 at 6:50 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Aug 15, 2023 at 09:29:06AM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Aug 15, 2023 at 9:19 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Sat, Aug 12, 2023 at 10:04:18AM +0100, Biju Das wrote:
>
> ...
>
> > > > > > +     {.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> > > > > > +     {.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> > > > > > +     {.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> > > > > > +     {.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> > > > > > +     {.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> > > > > > +     {.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> > > > > > +     {.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> > > > > > +     {.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> > > > > > +     {.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> > > > > > +     {.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
> > > > >
> > > > > I would reorder them a bit.
> > > >
> > > > Which is safe in this particular case...
> > > > But not in general, as there might be fall-back compatible values.
> > >
> > > You mean the OF ID list must be specifically ordered?! What a nice minefield!
> > > This has to be fixed somewhere else, surely.
> >
> > Seems like it is, cfr. the scoring system in drivers/of/base.c
> > __of_device_is_compatible().  Sorry for the confusion.
> >
> > I still tend to order them in match tables though, from most-specific
> > to least-specific.
> >
> > Note that soc_device_match() (which is used less, fortunately) does
> > not have such a scoring system, so order does matter there.
>
> Should be fixed there, because it's a big downside of OF.

Agreed. Note that it is unrelated to OF.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
