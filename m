Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2E460572
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352084AbhK1JcP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 04:32:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356812AbhK1JaP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 04:30:15 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6DnM-1mxsAk2IzQ-006d4G for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021
 10:26:58 +0100
Received: by mail-wm1-f48.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso14301013wms.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 01:26:58 -0800 (PST)
X-Gm-Message-State: AOAM533u+gtigvtCV+oA+DG2Cn5UYfBO8ZGcvMhWgQxJXYH/tNRCm6c4
        bIfWNUE0gjkX+zHbxkQS3xv0qwgKHyqEGX1OkNA=
X-Google-Smtp-Source: ABdhPJxvr8RpwID7hIVXCi6sz/SnqrKgg4dNPsHDeLNRtPfZF6L8E0DBBlhiFRyuNC8CE2hkskKTbSd3uUeqadMM94E=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr27234581wmi.173.1638091618151;
 Sun, 28 Nov 2021 01:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <KMP13R.I8M265PNR9RU@crapouillou.net>
 <20211127180203.5a33c59e@jic23-huawei>
In-Reply-To: <20211127180203.5a33c59e@jic23-huawei>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Nov 2021 10:26:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2znndSzP8L+OS=uayC7sNoOEnp8bqM8bmUqk-ptMy62A@mail.gmail.com>
Message-ID: <CAK8P3a2znndSzP8L+OS=uayC7sNoOEnp8bqM8bmUqk-ptMy62A@mail.gmail.com>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        Vaishnav M A <vaishnav@beagleboard.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:98WmByBcslMpwL1V9iJoYoLxlPV6nExw+VNa/GCymNZa4hOnP1i
 SS+yz1ih26ALm2GtY3iVigyeem8g9gcPYLWqNdvfKkyZj5vOdH2pHCHG5yuhsRA+tY4DjqD
 6FJHF/GD4r+VqLPcoEfQahE0QnQX3BItROvYaOHvug0FQ5zwtNEiN0VQpJHlV6lA+4h4pay
 0t0BcarZ69fi7nf2jJv/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/7To0WXr5g=:V/9ek6GxS8qg4uXGucEKp9
 SFB78GFAvbxnkPs44cFrDM4jzwtr/CjuQEg5PpJtel8HgmHNmedGdeLuu2guKyFRNkHE02Lw+
 DI4PA6grmZRTkaPhnFoVqoRLJXxa70iSZlkuzGaI9ypeoxQELK8LFVr9jI4MvJlYBA8eV8MUF
 2Ke8OvBNjUwNr9KXsGTmJRJ3XHjzhhw5vlhAxpIXeRqLVv6nAblWNwfzoxVCZhaKmkYyneStk
 5boCFsfM0WGgTHDQqOwwD+ahmgixArXtrXXe6+5aw1kox3zK6Q3bYV0hjlACnEtmdXvge7dd2
 vch31dtDpCZiK8dREnm9nqgf37iJ02txU5EhKuSRMv4V9w63nq8buGJkB7ZzMPUhLurdXQ+/R
 cMvov7nNUTvvyRXdgCiTMBT5zigEuAsi087uTzAJDymvfO15kgqWdThloSLgwldMd73aDyj55
 XnIX3Fdzqq4I0Vb5qbjg8p8ZfsLpcoVC30koXrVTrxL4ntSwlkxcgchhBnSeEJsdTU3pCbVh/
 wspIaLOawMw/XodCSiG9T4eqyoBa2dfTkD6FV6sdkEASKNRc9E9auUy1uNyIAJCLfnTxogUeB
 4ClmiyTEL/y0S5gQVkGZyhexImFbqLF55eZheNIlPj2OFNPrYf9WMSmwB1O0gHSimlJAd+7WU
 o/mW86mfgCQ6Z7l+3VAJtAaWe/EVtCDk94C4mzUwa0UkEXkBVvEuJN3z3Rz71VZ1NnXY1O1mN
 6R7gCo7+h48/aULwx2PmQkgliOylj7SUYEDDvAUuIRnfdvIvHvw0WQVMSqm2Qduio8UCKVbZw
 fo3adWndDDg8pu1ZDr2OqhAuDEZ3yHj/f25c0t37wFWmQgzyS8=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 27, 2021 at 7:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 23 Nov 2021 22:11:08 +0000 Paul Cercueil <paul@crapouillou.net> wrote:
?
> > The problem then is that the SET_*_PM_OPS macros are defined
> > differently according to CONFIG_PM, so their definition would need to
> > be changed to use the (redefined) pm_ptr() macro and a corresponding
> > pm_sleep_ptr() macro.
>
> Small question here.  Why would these macros need to use pm_ptr() macro at all?
>
> Why not just stop them being conditional on CONFIG_PM at all and let dead
> code removal kill them off for us?  You might want to do something different
> for the CONFIG_PM_SLEEP ones though if we care about having it that fine
> grained.

Agreed, there is no need to use pm_ptr() inside of the new macros, it would just
be convenient to define them this way.

The only requirement is to use a construct with the ?: operator that gets
evaluated at compile time based on CONFIG_PM and CONFIG_PM_SLEEP
so that DCE can do its magic.

        Arnd
