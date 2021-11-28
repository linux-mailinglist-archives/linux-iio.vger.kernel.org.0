Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3B46056A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357023AbhK1JXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 04:23:30 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbhK1JVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 04:21:30 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCGag-1mhwvv0wPi-009SPZ for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021
 10:18:13 +0100
Received: by mail-wm1-f48.google.com with SMTP id 137so12046485wma.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 01:18:13 -0800 (PST)
X-Gm-Message-State: AOAM531y4DifdBlz6RnwweP7MJ4UfX+0sjzqRRXlJbbG78N5/Y++OzoQ
        ASaphdAqdFK0Dfa/mzTw1daC9HmqdN7uAdA3Z3g=
X-Google-Smtp-Source: ABdhPJx9AzECwmJFJzoWfVDiLsm0b4ARpdYquZEtdnl7QqjXaBeSvhXNdYCEXrujRvKsfwm1H1hpqj51DUc62rzMCCU=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr28739872wmn.98.1638091092799;
 Sun, 28 Nov 2021 01:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <KMP13R.I8M265PNR9RU@crapouillou.net>
 <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com>
 <20211124101113.000033c6@Huawei.com> <CAK8P3a1OmBT2xNTHVp8f3=4TtwtC+6cvn27PCF-j0MMAriK+Hg@mail.gmail.com>
 <US033R.QUSODS2XXA5V3@crapouillou.net> <20211127180923.4cfce721@jic23-huawei>
In-Reply-To: <20211127180923.4cfce721@jic23-huawei>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Nov 2021 10:17:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2DNbkX4AbHGjtdKBFsS6-nffq16Tmvd3a3KLv0TKW=6w@mail.gmail.com>
Message-ID: <CAK8P3a2DNbkX4AbHGjtdKBFsS6-nffq16Tmvd3a3KLv0TKW=6w@mail.gmail.com>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martijn Braam <martijn@brixit.nl>,
        Maslov Dmitry <maslovdmitry@seeed.cc>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+azzLwE8Y2DNTlva/OCRlM98iHJaH0caDBD/9jATdvLYtwd5vDY
 qEO5rk5Z6mq+TBxIyaZU3aMR0SVVVtnJrxh5VuE5RoEUeSJZAcE+tmkHp1Sucb7xLlwIU2+
 NbwRqtwjV2MevmIcgvyRBF4HigIkz9UQykjccA2DqlCDZwdD2A6Xxy8O1jwDnnlIKM/WWG0
 cn5/YjYBCK+XIWLVqYigA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RB1R7jXhDU=:TqNGpKT8eZsQrFromkrPnF
 2LWJEz0RlDUsmNH4ZM5Ymaal7ivVZNhlcfSh3oPoi0ZF97YuBREdaT/BfmvXBJQj5GSvUeBph
 3JQl5esHmSUPnksagM2y0c2qnggeI+S2UK5bxLdpcHvKEIZAddtvbmoTbfHTj+nzpwLL1MzXz
 YBOPGr13mjBwSog6zbtWATBbCOVVeB5tDtkyL8xa9AnYVVzIBmeIlvzAU2gYBvE35XxQx4JJn
 EDu7kHgPqe3s5Wi1JMXSOc2GMKWdD+l1TeRBPsDWsaCQ0ZPMlQCUoQlRx6gXSwLKhMES+EEgQ
 0ax1szpboPl8q7SCH95AmgLkfTzcdGrE+70tTlQZ3AaYu9OpAYga3Em4bsKmUDEZYvQafcC/2
 Ip8czfABuc/vaWyIh8kTjbN0cXV33fiP0nntR4XqD2U4XT3ajLwEn4eE0D48frT8m1x3u+q0X
 wh6Yc/EAlC63Qs+YirU2FsbX9Aa8DSNzXZ+mN1h5FlGYW4RM7iCbz5GFHeoVLeZNyBFb07J5A
 /TM3vypMuduxNFWtQ+bRBc/bMJRj0ZS1ZAK1h2F0DhoTZmGl2ttdHXkBjip1ZPCnMeEvYFySv
 sJdqj1ckEr4Y7lb7zS2DUOOyBtLKsJ2gQ085nYZ7FPlZ7UgbxUwJtVYjSPydtZc9MF1kwfRJ5
 KjTj2HHojOiAB/tUVZIM021rjUInQMFI30Pkqdgocd6NhS085SGZ5nZoVEbTnlVqvEng=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 27, 2021 at 7:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 24 Nov 2021 15:10:06 +0000 Paul Cercueil <paul@crapouillou.net> wrote:
> > Le mer., nov. 24 2021 at 13:23:47 +0100, Arnd Bergmann <arnd@arndb.de>
> >
> > So you want to rename the current macros (to e.g. *_PM_OPS_LEGACY)
> > everywhere so that new ones can be defined?
> >
> > What about we introduce new macros, and just deprecate the old ones
> > (with e.g. a checkpatch warning)? That would be way less work.
>
> Sounds like a sensible approach to me. If Arnd is happy with that we
> can move forwards and get the bikshedding on the naming started.

I suggested renaming the current macros as a way to avoid having to
come up with new names. If you have an idea for a new name that makes
sense in the long run, please just go ahead with that.

       Arnd
