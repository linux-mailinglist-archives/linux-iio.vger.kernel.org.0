Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE445C854
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 16:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhKXPNc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 24 Nov 2021 10:13:32 -0500
Received: from aposti.net ([89.234.176.197]:52936 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhKXPNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 10:13:31 -0500
Date:   Wed, 24 Nov 2021 15:10:06 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-Id: <US033R.QUSODS2XXA5V3@crapouillou.net>
In-Reply-To: <CAK8P3a1OmBT2xNTHVp8f3=4TtwtC+6cvn27PCF-j0MMAriK+Hg@mail.gmail.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <KMP13R.I8M265PNR9RU@crapouillou.net>
        <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com>
        <20211124101113.000033c6@Huawei.com>
        <CAK8P3a1OmBT2xNTHVp8f3=4TtwtC+6cvn27PCF-j0MMAriK+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le mer., nov. 24 2021 at 13:23:47 +0100, Arnd Bergmann <arnd@arndb.de> 
a écrit :
> On Wed, Nov 24, 2021 at 11:11 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>>  On Wed, 24 Nov 2021 08:29:40 +0100 Arnd Bergmann <arnd@arndb.de> 
>> wrote:
>>  >
>>  > > The problem then is that the SET_*_PM_OPS macros are defined
>>  > > differently according to CONFIG_PM, so their definition would 
>> need to
>>  > > be changed to use the (redefined) pm_ptr() macro and a 
>> corresponding
>>  > > pm_sleep_ptr() macro. Unfortunately since the SET_*_PM_OPS 
>> macros are
>>  > > used everywhere with code wrapped around #ifdef CONFIG_PM 
>> guards, it
>>  > > wouldn't be easy to change them, and it would just be easier to
>>  > > introduce new macros.
>>  >
>>  > Right, this is what we've discussed multiple times, and I think 
>> everyone
>>  > agreed we should do this, but so far we could not come up with a 
>> name
>>  > for the new macro, and changing the macro in place is not 
>> practical unless
>>  > we change hundreds of drivers in the same way as the iio series 
>> first.
>> 
>>  Nasty indeed and I'm not sure how scriptable either as lots of 
>> subtle variants
>>  unfortunately.
> 
> The minor variants (late, noirq) are actually the easy part, for the 
> macros that
> have fewer users, we can just have one patch per macro that changes 
> it treewide.
> For SET_SYSTEM_SLEEP_PM_OPS/SET_RUNTIME_PM_OPS and their
> DEV_PM_OPS variants, this would be a lot harder:
> 
> $ for i in SET_SYSTEM_SLEEP_PM_OPS SET_LATE_SYSTEM_SLEEP_PM_OPS
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS SET_RUNTIME_PM_OPS SIMPLE_DEV_PM_OPS
> UNIVERSAL_DEV_PM_OPS ; do echo `git grep -wl $i | wc  -l` $i ; done
> 
> 459 SET_SYSTEM_SLEEP_PM_OPS
> 51 SET_LATE_SYSTEM_SLEEP_PM_OPS
> 59 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> 497 SET_RUNTIME_PM_OPS
> 797 SIMPLE_DEV_PM_OPS
> 20 UNIVERSAL_DEV_PM_OPS
> 
> About half of those actually use an #ifdef, while the other half does
> not:
> 
> $ git grep -wl 
> 'SET_SYSTEM_SLEEP_PM_OPS\|SET_RUNTIME_PM_OPS\|SIMPLE_DEV_PM_OPS\|UNIVERSAL_DEV_PM_OPS'
>  | xargs grep -l CONFIG_PM | wc -l
> 712
> $ git grep -wl 
> 'SET_SYSTEM_SLEEP_PM_OPS\|SET_RUNTIME_PM_OPS\|SIMPLE_DEV_PM_OPS\|UNIVERSAL_DEV_PM_OPS'
>  | xargs grep -L CONFIG_PM | wc -l
> 745
> 
> If we rename the macros in the first half of this using a script, 
> then we should
> be able to change the behavior of the normal macros to use the new 
> pm_ptr().

So you want to rename the current macros (to e.g. *_PM_OPS_LEGACY) 
everywhere so that new ones can be defined?

What about we introduce new macros, and just deprecate the old ones 
(with e.g. a checkpatch warning)? That would be way less work.

-Paul


