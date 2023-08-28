Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2F78B22E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjH1NoW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 28 Aug 2023 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjH1NoM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:44:12 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCDA3;
        Mon, 28 Aug 2023 06:44:08 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-591ba8bd094so38081867b3.3;
        Mon, 28 Aug 2023 06:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230247; x=1693835047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCn7X4SYn2LsLooEbK0lCsA9sbKj3FbEDo96IuhwGMQ=;
        b=I4ZD51dbnkP2D0mYGyHWmCPnJcvIgvklmHXTF7PXCGJZTYxSddu/8lOoWb1Acyw9Ym
         QXUorrNxUcZwYGIlsl/nMJe0WeGPIO98ysAHLWLQUUWiTa38LU732lBhJlosBmq9i/KC
         G0eaxgf4QLKmoOoKKXyCIQOiyiXHotsKUBRO1UyHYquJhT45b9983bknpfnluKKg1fqV
         vG+jt10WBgMRQQ5M+Cg6FjLJdSeCeaxKO/k0AxCxSfx2oWP9lj1PHx/zf41kNgg2XLOH
         dOFcO921N3ZjEuuH+gWXS3eJfIizb7jYFtREmeyxUP8i3SipEorrq8rZsDXSYCK9L7Yc
         GSNw==
X-Gm-Message-State: AOJu0Yxfjjo37yU8p6KLqcmE2SzN6nDZe3SiWKHmJjqNVESdFOPuC0nm
        A1O+tiNWRziUAh0i5cre2v4WFd+Kg1xCqA==
X-Google-Smtp-Source: AGHT+IHtJJlNC0V09/KS6/Ro7bNgW53zr/lEKZL0GKHEheM4m2pgZ6z+Hg47Gw21B60RmoNflkhaZA==
X-Received: by 2002:a81:b659:0:b0:595:1cb4:8921 with SMTP id h25-20020a81b659000000b005951cb48921mr4374665ywk.13.1693230247517;
        Mon, 28 Aug 2023 06:44:07 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id p185-20020a0de6c2000000b005865494000dsm2130322ywe.115.2023.08.28.06.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 06:44:07 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d78328bc2abso2905681276.2;
        Mon, 28 Aug 2023 06:44:07 -0700 (PDT)
X-Received: by 2002:a25:48d:0:b0:d7a:d923:4493 with SMTP id
 135-20020a25048d000000b00d7ad9234493mr5361752ybe.64.1693230247094; Mon, 28
 Aug 2023 06:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230818190429.338065-1-biju.das.jz@bp.renesas.com>
 <20230828133525.5afaea4f@jic23-huawei> <OS0PR01MB59225F5472B4BE500429394C86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59225F5472B4BE500429394C86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Aug 2023 15:43:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEtjrEUCPk_G-kAyp8oEDu21oU+BwWVCZ8N4JJ6VTJUg@mail.gmail.com>
Message-ID: <CAMuHMdUEtjrEUCPk_G-kAyp8oEDu21oU+BwWVCZ8N4JJ6VTJUg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
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

Hi Biju,

On Mon, Aug 28, 2023 at 2:43 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for
> > data in the match tables
> >
> > On Fri, 18 Aug 2023 20:04:29 +0100
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > > Convert enum->pointer for data in the match tables, so that
> > > device_get_match_data() can do match against OF/ACPI/I2C tables, once
> > > i2c bus type match support added to it.
> > >
> > > Replace enum->struct *vz89x_chip_data for data in the match table.
> > > Simplify the probe() by replacing device_get_match_data() and ID
> > > lookup for retrieving data by i2c_get_match_data().
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Biju,
> >
> > Make sure you cc the driver authors etc.
>
> Normally, I ran a script against the patch to get details and additionally I add Geert, renesas-soc , Andy in Cc list.

I don't think there is a need to add renesas-soc (or me, FWIW ;-), unless
the specific device is used on Renesas platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
