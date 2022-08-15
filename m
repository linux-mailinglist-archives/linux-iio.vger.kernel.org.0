Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3432592AAD
	for <lists+linux-iio@lfdr.de>; Mon, 15 Aug 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiHOHbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Aug 2022 03:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOHbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2022 03:31:23 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB417E39
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 00:31:22 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b2so5001887qkh.12
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=P2IAMSUZ0NTZXOzBZiA6e6bQkwOvIkQXl2ZmS04QqOQ=;
        b=fbyVdBr3LJXOlJ+N0tRKeapkg1B7XWLFiv1GC/u9+as7g2MYSa5mPEJG79BgYC7Xcy
         VEctOxX1wle6zk/vRCOO62/FFq9+fBZmbff9E5erYumPn5GpVZQ8ldbhbvbjSJ5nKeVP
         3zZPawmhnI/XJxPsOa1C4IVPyEArUorANA4h9OnOA8uPVXJPBJAyq5oP8nLgI/hW6IfF
         lXEjX7PhJUtPE73gHMA3g/O2VziqJmSLSLqpiXc3y+8l+bSnCtptlKF8MzV7hNyS2g7Q
         A3g8ZSmbVZ82ZFWH0Nh02ijY+S/xqebw+wQrdtQMU8MtSX6aXRLoe4ZbWX62v6L4QqSs
         Z3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=P2IAMSUZ0NTZXOzBZiA6e6bQkwOvIkQXl2ZmS04QqOQ=;
        b=SI7y+tMiO2yMd7kghI316iEj7kGtGd43XW3gne3BaPoP98mkv+rsQpn0itzvuoKEPb
         H3AqO0jgSPMyIQmQ+eOtksFm6a8qP+rpGD5AIbk38zX3SYG922nD6iVJIE3D4DgWSFVd
         4iGIesefDDSEbkw4JIzMV0W1cXqGF5ZDl4KgrklPDTCKt+hWK5RbGG3zjBGD1MDthAyF
         UCGbS70tCKFSHDzXIpcXM2zt4vbTHWdCcjTrzdUp0BpFVY/CaYUEQIquwLVUZViMKD8v
         rKO5d5CxjnQ+5r1yDTCS+ZMVtwmpV+wZbtRAjWTB1g8PpOOJWawLmayroRATMqrU5uBY
         nY1g==
X-Gm-Message-State: ACgBeo27M5ZR1238yuEbVWKt8V1i3qNIAF7XsgpEEzRhYHCECoMWaVed
        JJ6Cb18EVrv9YfXlq/CvVxtmoHLUW6Myk/pcrL0=
X-Google-Smtp-Source: AA6agR525pEUsueJu8nVUvr9PHVbAEaQSzJcoP2AhyjuDv9YfmTSwPVVXB+bg7cu1KTk4wS62BA9V4jmyL3lJjPHBQk=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr10501780qko.383.1660548681260; Mon, 15
 Aug 2022 00:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-6-u.kleine-koenig@pengutronix.de> <20220813173142.76774c97@jic23-huawei>
 <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com> <20220814213058.dgoxpkoxpn6s4ojj@pengutronix.de>
In-Reply-To: <20220814213058.dgoxpkoxpn6s4ojj@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Aug 2022 10:30:45 +0300
Message-ID: <CAHp75VfD9xoDYyWH3NB9btNW2pBmTH_jBmwjOSUbOQ+Ei_k20w@mail.gmail.com>
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>, Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        David Wu <david.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 15, 2022 at 12:31 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> [dropped Tomislav Denis from Cc: as the address bounces]
>
> On Sun, Aug 14, 2022 at 10:01:08PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 13, 2022 at 7:21 PM Jonathan Cameron <jic23@kernel.org> wro=
te:
> > >
> > > On Mon,  8 Aug 2022 22:47:33 +0200
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > > Make use of devm_clk_get_enabled() to replace some code that effect=
ively
> > > > open codes this new function.
> > > >
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > >
> > > This might have side effects as it now enables the clock before calli=
ng
> > > the clk_set_rate(). Also changes the clock start up ordering. Neither=
 is that
> > > scary a change, but on really fussy hardware they might cause problem=
s.
> > >
> > > Add a few rock-chips people who have sent patches in last few years
> > > to hopefully take a look or even better run a test.
> >
> > I believe you found a bug in the patch. The possible solutions are:
> > - not take the patch
> > - disable and re-enable clock around clk_set_rate()
> >
> > IIRC clk_set_rate() will spit a WARN if clock is enabled.
>
> You mean in general? I think that's wrong. There might be some clks that
> do that, but I'd consider them strange. If you ask me, calling
> clk_set_rate() for a *disabled* clk is the strange concept ...

I think it's correct from the logic and electrical perspective. That's
why the preparation and enablement are separated in CCF. But please
double check, because I can't remember everything by heart.


--=20
With Best Regards,
Andy Shevchenko
