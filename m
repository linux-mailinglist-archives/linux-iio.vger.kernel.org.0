Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71172460636
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352596AbhK1Mt5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 28 Nov 2021 07:49:57 -0500
Received: from aposti.net ([89.234.176.197]:46624 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345845AbhK1Mr5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Nov 2021 07:47:57 -0500
Date:   Sun, 28 Nov 2021 12:44:23 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
Message-Id: <ZP8A3R.E5LXPYJPNM112@crapouillou.net>
In-Reply-To: <CAK8P3a2DNbkX4AbHGjtdKBFsS6-nffq16Tmvd3a3KLv0TKW=6w@mail.gmail.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <KMP13R.I8M265PNR9RU@crapouillou.net>
        <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com>
        <20211124101113.000033c6@Huawei.com>
        <CAK8P3a1OmBT2xNTHVp8f3=4TtwtC+6cvn27PCF-j0MMAriK+Hg@mail.gmail.com>
        <US033R.QUSODS2XXA5V3@crapouillou.net>
        <20211127180923.4cfce721@jic23-huawei>
        <CAK8P3a2DNbkX4AbHGjtdKBFsS6-nffq16Tmvd3a3KLv0TKW=6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Arnd, Jonathan,

Le dim., nov. 28 2021 at 10:17:55 +0100, Arnd Bergmann <arnd@arndb.de> 
a écrit :
> On Sat, Nov 27, 2021 at 7:09 PM Jonathan Cameron <jic23@kernel.org> 
> wrote:
>>  On Wed, 24 Nov 2021 15:10:06 +0000 Paul Cercueil 
>> <paul@crapouillou.net> wrote:
>>  > Le mer., nov. 24 2021 at 13:23:47 +0100, Arnd Bergmann 
>> <arnd@arndb.de>
>>  >
>>  > So you want to rename the current macros (to e.g. *_PM_OPS_LEGACY)
>>  > everywhere so that new ones can be defined?
>>  >
>>  > What about we introduce new macros, and just deprecate the old 
>> ones
>>  > (with e.g. a checkpatch warning)? That would be way less work.
>> 
>>  Sounds like a sensible approach to me. If Arnd is happy with that we
>>  can move forwards and get the bikshedding on the naming started.
> 
> I suggested renaming the current macros as a way to avoid having to
> come up with new names. If you have an idea for a new name that makes
> sense in the long run, please just go ahead with that.

Yes, I totally understand that. But renaming such a widespread macro 
sounds like a huge undertaking...

What about:

#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)    \
    .suspend = pm_sleep_ptr(suspend_fn),              \
    .resume = pm_sleep_ptr(resume_fn),                \
...

#ifndef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(a, b) SYSTEM_SLEEP_PM_OPS(a, b)
#else
#define SET_SYSTEM_SLEEP_PM_OPS(a, b)
#endif


#define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
static const struct dev_pm_ops name = {                       \
    SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn),               \
}


SET_SYSTEM_SLEEP_PM_OPS -> SYSTEM_SLEEP_PM_OPS, with the old one now 
defined from the new one;
SIMPLE_DEV_PM_OPS -> DEFINE_SIMPLE_DEV_PM_OPS.

Thoughts?

Cheers,
-Paul


