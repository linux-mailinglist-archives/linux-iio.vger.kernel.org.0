Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE2780F77
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351092AbjHRPnz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Aug 2023 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378292AbjHRPna (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:43:30 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B0BF;
        Fri, 18 Aug 2023 08:43:28 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-583d702129cso10097197b3.3;
        Fri, 18 Aug 2023 08:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692373407; x=1692978207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmuy4FxgjC+289hLEb+tGmhM8uHvwVPgUQg13yVgPPo=;
        b=OBtLpZ4qEguHBQ3zGArvpcE17ARQQRnyHV6PUb15adJtABk/Zlb5GgOySKbEyaTXVm
         UvWpJ4tkB7hJUwrgFRMZGrK1gO8cJ3IcDB38n/x2JRMHjbK3Us6RVQ+V9pEJG6GHuJbc
         xs+xbkXst4dvYW2QFK4XCH4ybkqC0iVwLedmsq2XL4YssbaLEU73Eob0OyHtm8oT4GPO
         NtwnyZBa3lJYK2CMPDrzLrzDFwHaQ8yjS0tnF9SecTrn+qs82vG4vanHKhL8ymw4EkG/
         HYTacUq2bJ9tKW3aQUPT+e4uG8G7eheHgp9keKpP0BygBAt0fJv+h5lALT2fQ0n6RvCz
         yhMw==
X-Gm-Message-State: AOJu0Yxv7D4MzTyqvK3z0/ajZU277ji5JR6cs9w/+hgq4UxPMJbtyEP0
        oevEAjjIkDTS5Auna+q6GYNFIpvRoNYp8U4V
X-Google-Smtp-Source: AGHT+IEk0PxoomUFWitaW6g0W9I6qpzP1Zf+j2+3xvz2gjLGwF7ULFwGgJv6tnQEenVAdcGWZrKMIw==
X-Received: by 2002:a0d:d441:0:b0:589:eac3:d5c0 with SMTP id w62-20020a0dd441000000b00589eac3d5c0mr2869425ywd.20.1692373407547;
        Fri, 18 Aug 2023 08:43:27 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m134-20020a0dca8c000000b0058c55d40765sm553733ywd.106.2023.08.18.08.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 08:43:26 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d67869054bfso1055143276.3;
        Fri, 18 Aug 2023 08:43:26 -0700 (PDT)
X-Received: by 2002:a25:424b:0:b0:d3c:5c3e:c2a with SMTP id
 p72-20020a25424b000000b00d3c5c3e0c2amr3058290yba.24.1692373406256; Fri, 18
 Aug 2023 08:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com> <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com> <ZN+PpLsAayzfgTtb@smile.fi.intel.com>
In-Reply-To: <ZN+PpLsAayzfgTtb@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 17:43:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAG8JmOaGzeRd8kgoZqMmG1Qf7PFjZFJiQBXpp9Sa8pg@mail.gmail.com>
Message-ID: <CAMuHMdXAG8JmOaGzeRd8kgoZqMmG1Qf7PFjZFJiQBXpp9Sa8pg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Fri, Aug 18, 2023 at 5:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Aug 18, 2023 at 04:55:18PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Aug 18, 2023 at 1:30 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > > > Sort OF table alphabetically by compatibles.
> > >
> > > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Wrong, I haven't suggested that. See comment to the previous patch.
> > >
> > > And this is definitely wrong as Geert explained already why.
> > > You need to fix the code that handles the ID table first.
> >
> > I retracted my own comment:
> > https://lore.kernel.org/r/CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com
> >
> > Upon a second read, I agree my reply
> >
> >     Seems like it is, cfr. the scoring system in drivers/of/base.c
> >
> > was confusing, as it was not super clear if it was a response to the
> > first or the second line of your comment:
> >
> >     You mean the OF ID list must be specifically ordered?! What a nice
> > minefield!
> >     This has to be fixed somewhere else, surely.
> >
> > Conclusion: there is no issue, the scoring system handles primary
> > vs. fallback compatible values, irrespective of ordering.
>
> Now I'm totally confused. Previously you mentioned a couple of
> different APIs — one in OF, one in SoC. AFAIU the second one
> still needs to be fixed to follow the logic that OF does.
>
> My previous understanding was that
>   OF code — no issue
>   SoC code — the ordering is required to be correct

Correct.

> Can you confirm that there is no issue in that second case?
> And if there is none, why did you mention it?

There is still an issue (read: you have to be careful) in the second
case, which does not matter here, as this driver does not use
soc_device_match().
I mentioned soc_device_match() because it is the second popular way
to match on OF platforms, but behaves slightly different than
of_match_node().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
