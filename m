Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2183D78117C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357423AbjHRRSZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Aug 2023 13:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378925AbjHRRSH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:18:07 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE901BF;
        Fri, 18 Aug 2023 10:18:05 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58f5f8f998bso10653597b3.0;
        Fri, 18 Aug 2023 10:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692379085; x=1692983885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QnDhU5gjq58p7FQxqcs72n7OvCNiSSW9ZnBUq7cRIg=;
        b=eM9P0w8IYUigbA+RndNVKr3M+rKIhojPlhF9c0VXqPx7RqOH430wYerKe5JOabT9Mv
         NVk+7BMfgP5beLqfuuiZNGAe4eijqGKhDmXwyHUW7tUyc+Ew2ezUR6gq2R8LqTqzX80d
         7JR6QdbmFVSplYK7H9BPMWsU+fzFOabc2/uVRbiaYpJucPGOteOpdN+sMCKRn+u2d2sp
         m1U2ymkBGXPhZWC7P0qATiF91znWdpGY7JUsoB76R9ulFwlNIbf1795h9K16AwmaM9mB
         3c8gT8eAgdumfnA2hUknoQ2/bXXyFnNgD+fOe/70D3EklwATjGvGgUCDlBqASZ1ChqhH
         2/+g==
X-Gm-Message-State: AOJu0Ywr+GRtnZTG6kCSZdHGansOU6YWq400kYM+rtGIXxZQ3QhLkSKR
        SKE2CaKLwnMf/03Rq2FTeurBO0pMQZHhxw==
X-Google-Smtp-Source: AGHT+IE9jvCsH30+T95TGn8tp9N0mh2ysthqFhHy3uqDH3Ww4bbAD2IdjaHTT+57BXs5HzBbwkYrCQ==
X-Received: by 2002:a81:6d53:0:b0:58c:6ddc:7717 with SMTP id i80-20020a816d53000000b0058c6ddc7717mr3552414ywc.37.1692379084787;
        Fri, 18 Aug 2023 10:18:04 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id w10-20020a81620a000000b005774338d039sm608168ywb.96.2023.08.18.10.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 10:18:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso1083142276.1;
        Fri, 18 Aug 2023 10:18:03 -0700 (PDT)
X-Received: by 2002:a5b:74c:0:b0:c83:27d4:c0d6 with SMTP id
 s12-20020a5b074c000000b00c8327d4c0d6mr3357274ybq.37.1692379083638; Fri, 18
 Aug 2023 10:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com> <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
 <ZN+PpLsAayzfgTtb@smile.fi.intel.com> <CAMuHMdXAG8JmOaGzeRd8kgoZqMmG1Qf7PFjZFJiQBXpp9Sa8pg@mail.gmail.com>
 <ZN+knFD5pFilfBcT@smile.fi.intel.com>
In-Reply-To: <ZN+knFD5pFilfBcT@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 19:17:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVTSoKNt7D4f7kBgiGfuY7DympEyVt2t5PQmMXgESZzw@mail.gmail.com>
Message-ID: <CAMuHMdVVTSoKNt7D4f7kBgiGfuY7DympEyVt2t5PQmMXgESZzw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Fri, Aug 18, 2023 at 7:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Aug 18, 2023 at 05:43:15PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Aug 18, 2023 at 5:35 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Aug 18, 2023 at 04:55:18PM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, Aug 18, 2023 at 1:30 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > > > > > Sort OF table alphabetically by compatibles.
> > > > >
> > > > > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >
> > > > > Wrong, I haven't suggested that. See comment to the previous patch.
> > > > >
> > > > > And this is definitely wrong as Geert explained already why.
> > > > > You need to fix the code that handles the ID table first.
> > > >
> > > > I retracted my own comment:
> > > > https://lore.kernel.org/r/CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com
> > > >
> > > > Upon a second read, I agree my reply
> > > >
> > > >     Seems like it is, cfr. the scoring system in drivers/of/base.c
> > > >
> > > > was confusing, as it was not super clear if it was a response to the
> > > > first or the second line of your comment:
> > > >
> > > >     You mean the OF ID list must be specifically ordered?! What a nice
> > > > minefield!
> > > >     This has to be fixed somewhere else, surely.
> > > >
> > > > Conclusion: there is no issue, the scoring system handles primary
> > > > vs. fallback compatible values, irrespective of ordering.
> > >
> > > Now I'm totally confused. Previously you mentioned a couple of
> > > different APIs — one in OF, one in SoC. AFAIU the second one
> > > still needs to be fixed to follow the logic that OF does.
> > >
> > > My previous understanding was that
> > >   OF code — no issue
> > >   SoC code — the ordering is required to be correct
> >
> > Correct.
> >
> > > Can you confirm that there is no issue in that second case?
> > > And if there is none, why did you mention it?
> >
> > There is still an issue (read: you have to be careful) in the second
> > case, which does not matter here, as this driver does not use
> > soc_device_match().
> > I mentioned soc_device_match() because it is the second popular way
> > to match on OF platforms, but behaves slightly different than
> > of_match_node().
>
> Now it's clear, thanks.
> Biju, please add that to the commit message.

All of that? The only thing that matters is that OF match tables
use scoring, so order shouldn't matter.

soc_device_match() uses different tables, and is irrelevant here.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
