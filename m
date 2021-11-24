Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5512645B55D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 08:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbhKXHdH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 02:33:07 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:35197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhKXHdG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 02:33:06 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhToz-1mCLIt1i7v-00egs1 for <linux-iio@vger.kernel.org>; Wed, 24 Nov 2021
 08:29:56 +0100
Received: by mail-wm1-f41.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so1230653wms.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 23:29:56 -0800 (PST)
X-Gm-Message-State: AOAM532yCg1jjiFa0ZUWltBdppfMmxduzDQtvR52aQe06uioleFYQdfi
        ZNWAzlochZ2nYDoSRzv8zIvDeTf6n7RQFrk5r/k=
X-Google-Smtp-Source: ABdhPJz6OFDas1rA8f9wgrNgk2WUDD0t+wUaaQ12GzQnSNdliTuEWCPfugSYLMu4k/nbixPoFc1uPAUWENo3wChtRko=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr11520712wmi.173.1637738996006;
 Tue, 23 Nov 2021 23:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <KMP13R.I8M265PNR9RU@crapouillou.net>
In-Reply-To: <KMP13R.I8M265PNR9RU@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Nov 2021 08:29:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com>
Message-ID: <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
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
X-Provags-ID: V03:K1:MDK1L6xa1+aFj5I+0yhwuIi2Se1ZBBvKYc/25coAbArVzb/Q3Nk
 ihO8Q+N6kCS0CZEGLkEIYqmp01K6sp4bkv179qqzr2ipkb6frAzNqUxpRBKrsVYRPMjCjlQ
 IRquSRj+hGhC1cRCBtbTzFbBMRDHJDyatBiCU8eJyLnQYy7BGlJLuq5OU25Pu7Ym+/O7ck/
 cuGLDBMHaGQg/98nNvl/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uH+rP9XIw3E=:/Zfb5GYuWder6xN8XYktQ7
 jHeKUajc2BuGjZL/Mj8LCeOqUUOesNjEzFfGFERkA4EHrv4BZWgZteeZ522km7xk/Jsm2hom8
 AF6NvrGUWV0yGr+qpmiFtvkRQaVayDbyMeZ5V214F4DTTAQceIxjgOsoh13Vx4S6+49XuBIJF
 fBB6QWZY6mN47nGvIt39NblAZ/Ei+xWm0VX5lJvJcmifyU8LQinqh8VU4QVDXz9I/04r1gYPT
 eLOYh1nBBGuH09Up3HuvSmvosCIaiZPyVgDyYipr7gdkJRWF1jtvXYinMd9Lbiylc/f2UhgZ0
 YZvcmTOBshRgxE01sVnaTbxFlx7NvHUsKCMwVR8vfYWRjn1X7odaKwlrZzMe+FG8INNruQbwB
 sWlS34q2Zjh3oYlS2NSxYhH7efKpDhhQcvAPr4xBM0cgZ7hfUD2i9mH9eYzffSXjJOcGMXkxO
 9db7/N1V1mmYwKgkjoxH4LlLcixXZ6zfQuPCdQszpFaYOkJR599E7SnlIOCqsi708r4nQHmFP
 6/HW2PMI9ikgSixy5apftzEnEw0S01RKpdAW4IgVX1C7WBWkx2HN5FK+C2IIaJog2x+KLvEAE
 ASVu96yJyAopAnajYMg/jXsbTd/DVqN2+Hu8l1eDYwBISUhhlOvQuRJM3l8JvT/mjZNjQg1o8
 ClpapqID7/mORTPQtluhbYMke4XZFDimeqtPw2t7bX8gj8/wV9JvIC2SQuhxXkaxO7aQ=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 11:11 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> One word about the pm_ptr() macro. Right now it's defined as:
>   #ifdef CONFIG_PM
>   #define pm_ptr(_ptr) (_ptr)
>   #else
>   #define pm_ptr(_ptr) NULL
>   #endif
>
> It could be possible to define it like this instead:
>   #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
>
> The difference is that if !CONFIG_PM, in the first case the (_ptr) is
> not visible by the compiler and the __maybe_unused is required, while
> in the second case the (_ptr) is always visible by the compiler, but
> discarded as dead code. The reason we'd want that is the same reason we
> use IS_ENABLED() instead of macro guards; and you wouldn't need the
> __maybe_unused attribute anywhere.

That sounds like a great idea. I see there are only 12 users of pm_ptr at
the moment, so auditing all of these should not be a problem.

I gave it a brief look and found that we probably only need to fix
drivers/net/ethernet/realtek/r8169_main.c if we change the definition.

> The problem then is that the SET_*_PM_OPS macros are defined
> differently according to CONFIG_PM, so their definition would need to
> be changed to use the (redefined) pm_ptr() macro and a corresponding
> pm_sleep_ptr() macro. Unfortunately since the SET_*_PM_OPS macros are
> used everywhere with code wrapped around #ifdef CONFIG_PM guards, it
> wouldn't be easy to change them, and it would just be easier to
> introduce new macros.

Right, this is what we've discussed multiple times, and I think everyone
agreed we should do this, but so far we could not come up with a name
for the new macro, and changing the macro in place is not practical unless
we change hundreds of drivers in the same way as the iio series first.

       Arnd
