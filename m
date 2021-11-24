Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7845BC89
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 13:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbhKXMbL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 07:31:11 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243783AbhKXM1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 07:27:15 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MzkK9-1mUMKI48Bd-00vdYX for <linux-iio@vger.kernel.org>; Wed, 24 Nov 2021
 13:24:04 +0100
Received: by mail-wr1-f48.google.com with SMTP id l16so3847391wrp.11
        for <linux-iio@vger.kernel.org>; Wed, 24 Nov 2021 04:24:03 -0800 (PST)
X-Gm-Message-State: AOAM530Xj6Dfn7+aOHtVjOe3Ddfc7a40Dk+hnLeT0ZSp/loWq2Pwsman
        FWoFvn/7Y9qJnGPkry+XAhcvr7lAwYub8RKex8w=
X-Google-Smtp-Source: ABdhPJymgj6B5HkUwsge+KxmJCGsGh4l9wTgeQgqKwk9+Jb3Zo6D8PfdODSnhbvY8f5VMGDkAU7ZHJIAHBM29xBIRIU=
X-Received: by 2002:adf:efc6:: with SMTP id i6mr18749818wrp.428.1637756643591;
 Wed, 24 Nov 2021 04:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <KMP13R.I8M265PNR9RU@crapouillou.net>
 <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com> <20211124101113.000033c6@Huawei.com>
In-Reply-To: <20211124101113.000033c6@Huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Nov 2021 13:23:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1OmBT2xNTHVp8f3=4TtwtC+6cvn27PCF-j0MMAriK+Hg@mail.gmail.com>
Message-ID: <CAK8P3a1OmBT2xNTHVp8f3=4TtwtC+6cvn27PCF-j0MMAriK+Hg@mail.gmail.com>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
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
X-Provags-ID: V03:K1:JXECNgD5L3jT2KTHucHQ7A2Z9BYfKtUtcmEkDtdbaNF/xE+BMCq
 4P91F/LtPbgbLJlUu1UcdeW6JstrYwlBcmKlsQY7633/PZb/WhTNVg5gAMJ6C6A+tG9VdN4
 0hdxLT1E2B+pndHLasJx/0YjBnag+I583boRxOuq07ZeShEpa9uBEPH2ZBdc4QZfJQ8Mzvi
 t5pyU+YqJQi5duSBlm82Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1V0UqUs1ByI=:2BHEZBlthWljaUvfWA7+w2
 S48Y1T8y8XZPNOGRzPsVFyIsfxag6O1/k95CrkUySuV+AWAY7fD/9C5aCjdpdp9ZPlA2Jg6OA
 EhiyXY7YwDlvj2Eny16lfC0gHYaO9jbUJNu8q3Bag6XJa/pzYiOWpin5337nqirANS3fs+6vA
 UeV2txRQSTrB68Ezf21nAZD5RXUH3lk5OWbqY6/mdhqDT0zH7/Nt6FzFNWGFKMV5gqRmmTlFz
 MTA/UlWt3OFEVweuPcupmebA+mIDKIIouAe1zk7H0iSh1P6Zom7RI0G3gFHsjEe+4JU6jJfTB
 j5x14GGvjIMziM357By8MZ/tiUdOaVQRj8hGRLuxxA/80lgoFWsUAUcBSC2lrwT4uvfGjUun7
 BkIfca1JotkeGI4++I5K73EItsheQ1ef0ixhPTc3bkdYDD2iG1EdfUt+4zz9z79WdfJ0+rAoX
 c+FNn7uSyUx+TzO4G+sciqN0fYJhmA+Op+kbNZY62wJVBQSsN0eQqmNCVQz6Oy1VwCxjq1Kit
 RguGtfpp72Xls7B7tGe0pG1JHLVvAlWE2Tce2xfXsC4mYuioaDSVWKnMLPIFnjzNM3fnD/ndo
 zfAdyQn3g/c7wnqKjDHw+rdzS9DO72wb40HSYek2+Cm809T5DNpif9GvOKf3CaHoYu071T8em
 ouCSp3HW9x5Ykp/s57MAVko/G9iQTyPB7JmBg19octqFn9km0N7y1kG0ycsyBKPSwGA4iI+rh
 f6m7lL0EgKRUNbt/M+4d4bWcg9tz8iH/qoVTuN/g+K8gX6nvL8QqQ0mrQJupGBIP8dJP5ZGCv
 eUe/55k2GatwHrSQ6J/JvBI6walOK3tZ88iIraZei2mT8efjos=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 24, 2021 at 11:11 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 24 Nov 2021 08:29:40 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > The problem then is that the SET_*_PM_OPS macros are defined
> > > differently according to CONFIG_PM, so their definition would need to
> > > be changed to use the (redefined) pm_ptr() macro and a corresponding
> > > pm_sleep_ptr() macro. Unfortunately since the SET_*_PM_OPS macros are
> > > used everywhere with code wrapped around #ifdef CONFIG_PM guards, it
> > > wouldn't be easy to change them, and it would just be easier to
> > > introduce new macros.
> >
> > Right, this is what we've discussed multiple times, and I think everyone
> > agreed we should do this, but so far we could not come up with a name
> > for the new macro, and changing the macro in place is not practical unless
> > we change hundreds of drivers in the same way as the iio series first.
>
> Nasty indeed and I'm not sure how scriptable either as lots of subtle variants
> unfortunately.

The minor variants (late, noirq) are actually the easy part, for the macros that
have fewer users, we can just have one patch per macro that changes it treewide.
For SET_SYSTEM_SLEEP_PM_OPS/SET_RUNTIME_PM_OPS and their
DEV_PM_OPS variants, this would be a lot harder:

$ for i in SET_SYSTEM_SLEEP_PM_OPS SET_LATE_SYSTEM_SLEEP_PM_OPS
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS SET_RUNTIME_PM_OPS SIMPLE_DEV_PM_OPS
UNIVERSAL_DEV_PM_OPS ; do echo `git grep -wl $i | wc  -l` $i ; done

459 SET_SYSTEM_SLEEP_PM_OPS
51 SET_LATE_SYSTEM_SLEEP_PM_OPS
59 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
497 SET_RUNTIME_PM_OPS
797 SIMPLE_DEV_PM_OPS
20 UNIVERSAL_DEV_PM_OPS

About half of those actually use an #ifdef, while the other half does
not:

$ git grep -wl 'SET_SYSTEM_SLEEP_PM_OPS\|SET_RUNTIME_PM_OPS\|SIMPLE_DEV_PM_OPS\|UNIVERSAL_DEV_PM_OPS'
 | xargs grep -l CONFIG_PM | wc -l
712
$ git grep -wl 'SET_SYSTEM_SLEEP_PM_OPS\|SET_RUNTIME_PM_OPS\|SIMPLE_DEV_PM_OPS\|UNIVERSAL_DEV_PM_OPS'
 | xargs grep -L CONFIG_PM | wc -l
745

If we rename the macros in the first half of this using a script, then we should
be able to change the behavior of the normal macros to use the new pm_ptr().

         Arnd
