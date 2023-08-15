Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44BC77C88B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 09:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjHOH31 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 15 Aug 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjHOH3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 03:29:21 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD92106;
        Tue, 15 Aug 2023 00:29:20 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-584034c706dso56827957b3.1;
        Tue, 15 Aug 2023 00:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692084559; x=1692689359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1VWNBKK3Jicyip27VfchVoQRwKUh8OYZypJqnEBQ1I=;
        b=aCWIacLNpFUwuBQw11ojU6ZHwgbYtf11nETyWjSlrTgDj3UTJJUxoqQ6x8gnXWOpgj
         Q0vNg/dB1QsUmOyoZp9febfUVALS/Fm2MUFPEDYaySzpXiJD8Ggw19op5zj2Du4yttfq
         jfDM8fZUbUU9tV0SqManYpI6k3cIzSGyQ2mFM28BdFxmYQycpTy3NiiAEPC6cCKFazII
         GR0BIqsXsRkzlTXx82IZS/QUf/MpWDYNFI8xrLrDs2a19i14JNnGatyRDMatiphcfCTt
         5tdwP6QWn7Es2laEFgsUw8b4jO2w1wxykfuiiOM8iqfyFguzPblD3HMDDrHnj+ZgiUbK
         f+Dw==
X-Gm-Message-State: AOJu0YzFYV8Ox4VDhHeP/tEonDff9DDBMJNOtOTlNxfO1EGGmm9DoYaa
        081CQ3DUp0Q60mTh1f1NBR6kv8PP3PXXBg==
X-Google-Smtp-Source: AGHT+IEh6cKZnu2Zb9SjRz52GNWxZMRBpdFbcTxAcI6zge+rnbtj9Sb9+wsd6Mrw+XRU5Qkps3WSRw==
X-Received: by 2002:a0d:fc05:0:b0:586:c0bc:77aa with SMTP id m5-20020a0dfc05000000b00586c0bc77aamr12781003ywf.24.1692084559194;
        Tue, 15 Aug 2023 00:29:19 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id k6-20020a0dfa06000000b005731dbd4928sm3228568ywf.69.2023.08.15.00.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:29:18 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d64f0c2bc95so4297957276.1;
        Tue, 15 Aug 2023 00:29:18 -0700 (PDT)
X-Received: by 2002:a25:25cc:0:b0:d19:664:7425 with SMTP id
 l195-20020a2525cc000000b00d1906647425mr12183481ybl.27.1692084558592; Tue, 15
 Aug 2023 00:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230812090418.75020-1-biju.das.jz@bp.renesas.com> <ZNsm3efpkYlL4Gki@smile.fi.intel.com>
In-Reply-To: <ZNsm3efpkYlL4Gki@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Aug 2023 09:29:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
Message-ID: <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Tue, Aug 15, 2023 at 9:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Aug 12, 2023 at 10:04:18AM +0100, Biju Das wrote:
> > Replace device_get_match_data() and id lookup for retrieving match data
> > by i2c_get_match_data() by converting enum->pointer for data in the
> > match table.
>
> ...
>
> > +     {.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> > +     {.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> > +     {.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> > +     {.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> > +     {.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> > +     {.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> > +     {.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> > +     {.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> > +     {.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> > +     {.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
>
> I would reorder them a bit.

Which is safe in this particular case...
But not in general, as there might be fall-back compatible values.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
