Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AEC4A48E8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359871AbiAaOAb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 09:00:31 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiAaOAa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jan 2022 09:00:30 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7xml-1m9UIY10nT-014yH8 for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022
 15:00:29 +0100
Received: by mail-wm1-f53.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so4478149wmb.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 06:00:29 -0800 (PST)
X-Gm-Message-State: AOAM533/x+MfZdpfWhtsM7DKAlm1HtukaDjMns3b556WR2HgE3xseztR
        Akt37r1yrUPFPDzABlYVDxH/7l/H23RTMpOgi9g=
X-Google-Smtp-Source: ABdhPJz58wZTfj8xGlghaVKBQYqU0rtXmYoZnrdMp/2qs9duxmS6uOQXOuYUiFFzHeYmZ4BSGKLBZqskw1zE9uDpHD8=
X-Received: by 2002:a1c:f309:: with SMTP id q9mr27088267wmq.173.1643636013274;
 Mon, 31 Jan 2022 05:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20220130193147.279148-1-jic23@kernel.org>
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 14:33:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0WGEhPX9biP0DE-1SsedTX-njz5JhgdOS56_EwU5xoUg@mail.gmail.com>
Message-ID: <CAK8P3a0WGEhPX9biP0DE-1SsedTX-njz5JhgdOS56_EwU5xoUg@mail.gmail.com>
Subject: Re: [PATCH v3 00/50] iio: Tree wide switch from CONFIG_PM* to
 pm_[sleep]_ptr etc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>,
        Crt Mori <cmo@melexis.com>,
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
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JH7KeQRkJIUxOJCRm+gn3hk1CEvnRZUQVWi08hjeHdF824OC0gR
 2glmLb+yskqIXJBzc6dGSgWIkO1s8ylpguQMEXxfSaCioS8+SP6efAfKik0XSKUFEdPZom8
 qX6THGSDBhTxG6Hu6QLjmDCR6vXAFhzgTZ3xa3/n0IOSs2FziccoHl6l8iHab+stPdSx6yJ
 N9Lx8V646YLn8HKVX8EJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2sChHhrQLnU=:ex5G8EccEpIhzb3zns0I/Y
 EYWfKm+YWoUBkhiXZzi5twbKnMREOqyYThsnMFUBXJ2MDkbsFxwjWXomj7g057jmokT/pMTJN
 cXUQDc79g3KUQ4ldM1XHvHjeGVF4/OZGDH11mq8viUZdhPMGP3z0/mfacCN7pJX/3cEbNIkv1
 XWrDtGp7s1JXmwGW3O7/m2dat4RsR+Yqc1fGOENKEzoJKz58yh4hAc8UEo7mHVP421xH5awub
 1ys6x+pzj2gBpXt/6P+jPSRaLJ6Tm0R/TNuPq2Ot7SOIyUZe3Nza/HiYITVUXqd+NtuN/grmb
 t0eX3dAKSz7muefYal/4POb4deakPjLLa86FtIErqsfEI5DM1NqR79o2GiWywlRcXPCi6j5U8
 8WFuqpYpUbSEu3h4dTsj3jhWHrM1c4FsHTfOU222Unss1agN2YAYvEslx4D0lxJ3BtFhCUbsk
 c3aEt8pe0BSsHl2HpL5oA9pLiJylmk25OQFVs9Sew/bwgr9awZ6EwQNvo1oMqLFewj6eoIsmN
 Bl35LXs65XoP96xzc/sLFmhCG+jEVOWWIdd/HaVXyscFT9lRyBNcArHQaWTuRSHTb8qDp4w4f
 hzB0rg2vSq7Qk4s0OsLP3S7dGsIkr0CqaYKU+IBB5BdPgVaxxwLr9lSfwiT4HkFdgrvtIEck7
 tYAm0WlJriKPrQxRlfh50Lu6+O+1nRZfoiwp+5/i2CVhT3RfeuKEe4CJ7Vz9hCrdkoee23q1f
 nWp/IxrD0zRbBWAAs5pUUWBrYjFO8JniWb791SJ97Vq1iiPAzuRwuwUAYffUxllnq1dtVQfg1
 hP5A9azKoQxgN8EMKjvljQ7F18lcsaJg4rIC66mKMK3uy1Tg4k=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 30, 2022 at 8:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Note that I have cc'd no one for a number of drivers touched in this
> set because we don't have a known active maintainer, so if anyone
> has time to sanity check those it would be much appreciated.
>
> Now that Paul Cercueil's rework of the pm_ptr() and related macro magic
> to ensure we the compiler can remove unused struct dev_pm_ops and related
> functions when either CONFIG_PM_SLEEP is not set or both that and
> CONFIG_PM are not set is upstream [1], lets revisit this series of
> cleanup of CONFIG_PM* guards in IIO.

I have not done an in-depth review of any particular patch, but I have
glanced over all of them and I am perfectly happy with this version, and
I'd say you should just put them into linux-next once no more Acks
come in. If anything breaks, it can be fixed on top.

        Arnd
