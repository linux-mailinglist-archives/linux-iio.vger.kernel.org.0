Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96245B8BA
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 11:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbhKXLBg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 24 Nov 2021 06:01:36 -0500
Received: from aposti.net ([89.234.176.197]:38796 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236994AbhKXLBg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 06:01:36 -0500
Date:   Wed, 24 Nov 2021 10:58:12 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>,
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
Message-Id: <05P23R.KVOP6474F7SJ@crapouillou.net>
In-Reply-To: <20211124101113.000033c6@Huawei.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <KMP13R.I8M265PNR9RU@crapouillou.net>
        <CAK8P3a3qs8fb1cMLu9WsFQmtff05zrpfmV--QZQta4_-Nt=MpA@mail.gmail.com>
        <20211124101113.000033c6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le mer., nov. 24 2021 at 10:11:13 +0000, Jonathan Cameron 
<Jonathan.Cameron@Huawei.com> a écrit :
> On Wed, 24 Nov 2021 08:29:40 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>>  On Tue, Nov 23, 2021 at 11:11 PM Paul Cercueil 
>> <paul@crapouillou.net> wrote:
>>  >
>>  > One word about the pm_ptr() macro. Right now it's defined as:
>>  >   #ifdef CONFIG_PM
>>  >   #define pm_ptr(_ptr) (_ptr)
>>  >   #else
>>  >   #define pm_ptr(_ptr) NULL
>>  >   #endif
>>  >
>>  > It could be possible to define it like this instead:
>>  >   #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
>>  >
>>  > The difference is that if !CONFIG_PM, in the first case the 
>> (_ptr) is
>>  > not visible by the compiler and the __maybe_unused is required, 
>> while
>>  > in the second case the (_ptr) is always visible by the compiler, 
>> but
>>  > discarded as dead code. The reason we'd want that is the same 
>> reason we
>>  > use IS_ENABLED() instead of macro guards; and you wouldn't need 
>> the
>>  > __maybe_unused attribute anywhere.
>> 
>>  That sounds like a great idea. I see there are only 12 users of 
>> pm_ptr at
>>  the moment, so auditing all of these should not be a problem.
>> 
>>  I gave it a brief look and found that we probably only need to fix
>>  drivers/net/ethernet/realtek/r8169_main.c if we change the 
>> definition.
> 
> Cool.
> 
>> 
>>  > The problem then is that the SET_*_PM_OPS macros are defined
>>  > differently according to CONFIG_PM, so their definition would 
>> need to
>>  > be changed to use the (redefined) pm_ptr() macro and a 
>> corresponding
>>  > pm_sleep_ptr() macro. Unfortunately since the SET_*_PM_OPS macros 
>> are
>>  > used everywhere with code wrapped around #ifdef CONFIG_PM guards, 
>> it
>>  > wouldn't be easy to change them, and it would just be easier to
>>  > introduce new macros.
>> 
>>  Right, this is what we've discussed multiple times, and I think 
>> everyone
>>  agreed we should do this, but so far we could not come up with a 
>> name
>>  for the new macro, and changing the macro in place is not practical 
>> unless
>>  we change hundreds of drivers in the same way as the iio series 
>> first.
> 
> Nasty indeed and I'm not sure how scriptable either as lots of subtle 
> variants
> unfortunately.
> 
> I'm cynical - don't need a good name.  *_OPS2 works fine for me as 
> long as
> the docs are good.

We could just remove the SET_ prefix,
SET_SYSTEM_SLEEP_PM_OPS -> SYSTEM_SLEEP_PM_OPS,

Or would that be too confusing?

-Paul


