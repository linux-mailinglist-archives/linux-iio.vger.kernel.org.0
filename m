Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00DF77DBEB
	for <lists+linux-iio@lfdr.de>; Wed, 16 Aug 2023 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbjHPIQX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 16 Aug 2023 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbjHPIQP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2023 04:16:15 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D235EAB;
        Wed, 16 Aug 2023 01:16:14 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-58caaedb20bso3837477b3.1;
        Wed, 16 Aug 2023 01:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173774; x=1692778574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJKRJWutwJW0e3CZkEtE6MH7FpoXVLxKfM+jujAToL4=;
        b=YM0kSVDFhDPcHG90cTqUoKl725UhHIOC07ToUHzhTEM7WHk3YFaDoyub4CRQulNhRJ
         UM88Ol9hu/He+KxcnE51G+8AnJ2G6z+vs8cWanZuxxWdW3xwnwYKiURquPqQk7W1tZ0u
         p/7HA6pAEjHJsnPIgZ4HFD6agDFaVst1OFi5wrkIW9DUQfuuJx405NeFA25uxQcpf/x5
         DKsnYDM9h6KbmjDUZ2rgLJsRnNQMkRi4gHSiFd82SjtZSeJTFhuxF6Xbm6WR3IftDCEQ
         9tl53BevF3Nbv08BT4WXqOwlpVO6ATObDEbVDdKrir/Q4UsJRk8sK8wCp8or+puC6cxq
         F0uA==
X-Gm-Message-State: AOJu0YxI4goxLzk/SWynGOeWyyN3f62qMqLn2rhQ/Trsb9ghlouMiew7
        FU7ZVo0fIlQgIIVJCU74diBrRDSUZOvv3Q==
X-Google-Smtp-Source: AGHT+IG3cMSmWamaYTkybzBZ/RYAAF1lBYycyXad6DJ2suHLKFOc3ivmh9LLxweehNurMvBfVF2XdA==
X-Received: by 2002:a0d:da86:0:b0:584:4bbb:963b with SMTP id c128-20020a0dda86000000b005844bbb963bmr1096586ywe.15.1692173773866;
        Wed, 16 Aug 2023 01:16:13 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id t16-20020a81c250000000b00579e8c7e478sm3857811ywg.43.2023.08.16.01.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:16:13 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-58caaedb20bso3837267b3.1;
        Wed, 16 Aug 2023 01:16:13 -0700 (PDT)
X-Received: by 2002:a25:d3c1:0:b0:d19:d73d:7950 with SMTP id
 e184-20020a25d3c1000000b00d19d73d7950mr1014592ybf.27.1692173773023; Wed, 16
 Aug 2023 01:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230812090418.75020-1-biju.das.jz@bp.renesas.com>
 <ZNsm3efpkYlL4Gki@smile.fi.intel.com> <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
 <ZNusymsNh/zFgHg7@smile.fi.intel.com>
In-Reply-To: <ZNusymsNh/zFgHg7@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 10:16:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com>
Message-ID: <CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Tue, Aug 15, 2023 at 6:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Aug 15, 2023 at 09:29:06AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 15, 2023 at 9:19 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Aug 12, 2023 at 10:04:18AM +0100, Biju Das wrote:
> > > > Replace device_get_match_data() and id lookup for retrieving match data
> > > > by i2c_get_match_data() by converting enum->pointer for data in the
> > > > match table.
>
> ...
>
> > > > +     {.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> > > > +     {.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> > > > +     {.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> > > > +     {.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> > > > +     {.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> > > > +     {.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> > > > +     {.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> > > > +     {.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> > > > +     {.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> > > > +     {.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
> > >
> > > I would reorder them a bit.
> >
> > Which is safe in this particular case...
> > But not in general, as there might be fall-back compatible values.
>
> You mean the OF ID list must be specifically ordered?! What a nice minefield!
> This has to be fixed somewhere else, surely.

Seems like it is, cfr. the scoring system in drivers/of/base.c
__of_device_is_compatible().  Sorry for the confusion.

I still tend to order them in match tables though, from most-specific
to least-specific.

Note that soc_device_match() (which is used less, fortunately) does
not have such a scoring system, so order does matter there.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
