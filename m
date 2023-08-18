Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC295780E5C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377885AbjHROzs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Aug 2023 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377903AbjHROzd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 10:55:33 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394430F3;
        Fri, 18 Aug 2023 07:55:32 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-58c5642701fso10203337b3.0;
        Fri, 18 Aug 2023 07:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370531; x=1692975331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeY71DU+USysSBndOPqy+YAmfXldU/2lkhsXmsd4vgI=;
        b=EF2NbQJFAoUjDGmR7fYUmXqulf1vHdDoPXzRCVLWosx4ooVSgkVZIU/ahnj90kUuTG
         EjUNTVWUYNCy4EmwUNrFlD8oKrQY/aNi0qSuX0hvOfx9cBGS1k0P3Jj2vmmxZdf72pAt
         e0TI+XIK7ucijeeQOctVBKL3dSuzhxxpJPLiEpaR8dmWXoitUQUjbqsziA6XXViSha54
         cYj1wkeY2TSIzP69HfnJgxPewRArjcNdKwRflhx3E2YjxLMCr37Hg0w7X2IeEfjEgrzD
         7Ie4aYRwFp99b+n0vmia938TY6aufLlPiHFTojNKBbca4T9Hj5QJezl+TBBS8L8XXYCx
         MYog==
X-Gm-Message-State: AOJu0YzbuC9BbXobN2be6vPQ6uYi2Q2MIjG/B7PQt/uXuxipznhbpjKg
        Bz8A7voKqFjvqEjlR3MPFBcNnB5gsz+BKNCY
X-Google-Smtp-Source: AGHT+IEZp8ejNzZzhgTvibPM37whBBg58dEVs+UAQq5/M958vUNmlWw8rjMLeAuXl1ECRdAtXNeCrA==
X-Received: by 2002:a0d:c985:0:b0:56c:f68f:d824 with SMTP id l127-20020a0dc985000000b0056cf68fd824mr2706131ywd.45.1692370530878;
        Fri, 18 Aug 2023 07:55:30 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id l74-20020a0de24d000000b00583d1fa1fccsm542800ywe.0.2023.08.18.07.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:55:30 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d650a22abd7so965912276.3;
        Fri, 18 Aug 2023 07:55:30 -0700 (PDT)
X-Received: by 2002:a25:2357:0:b0:d3f:1009:8beb with SMTP id
 j84-20020a252357000000b00d3f10098bebmr2678414ybj.41.1692370529865; Fri, 18
 Aug 2023 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com> <ZN9WVvo+pixspCsw@smile.fi.intel.com>
In-Reply-To: <ZN9WVvo+pixspCsw@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 16:55:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
Message-ID: <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
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

On Fri, Aug 18, 2023 at 1:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > Sort OF table alphabetically by compatibles.
>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Wrong, I haven't suggested that. See comment to the previous patch.
>
> And this is definitely wrong as Geert explained already why.
> You need to fix the code that handles the ID table first.

I retracted my own comment:
https://lore.kernel.org/r/CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com

Upon a second read, I agree my reply

    Seems like it is, cfr. the scoring system in drivers/of/base.c

was confusing, as it was not super clear if it was a response to the
first or the second line of your comment:

    You mean the OF ID list must be specifically ordered?! What a nice
minefield!
    This has to be fixed somewhere else, surely.

Conclusion: there is no issue, the scoring system handles primary
vs. fallback compatible values, irrespective of ordering.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
