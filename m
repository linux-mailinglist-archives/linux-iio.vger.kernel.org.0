Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C249460618
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhK1MgO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 28 Nov 2021 07:36:14 -0500
Received: from aposti.net ([89.234.176.197]:46122 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242823AbhK1MeO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Nov 2021 07:34:14 -0500
Date:   Sun, 28 Nov 2021 12:30:41 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
To:     Arnd Bergmann <arnd@arndb.de>
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
        Vaishnav M A <vaishnav@beagleboard.org>
Message-Id: <538A3R.42M33QXSDK222@crapouillou.net>
In-Reply-To: <CAK8P3a2znndSzP8L+OS=uayC7sNoOEnp8bqM8bmUqk-ptMy62A@mail.gmail.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <KMP13R.I8M265PNR9RU@crapouillou.net> <20211127180203.5a33c59e@jic23-huawei>
        <CAK8P3a2znndSzP8L+OS=uayC7sNoOEnp8bqM8bmUqk-ptMy62A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Le dim., nov. 28 2021 at 10:26:40 +0100, Arnd Bergmann <arnd@arndb.de> 
a écrit :
> On Sat, Nov 27, 2021 at 7:02 PM Jonathan Cameron <jic23@kernel.org> 
> wrote:
>>  On Tue, 23 Nov 2021 22:11:08 +0000 Paul Cercueil 
>> <paul@crapouillou.net> wrote:
> ?
>>  > The problem then is that the SET_*_PM_OPS macros are defined
>>  > differently according to CONFIG_PM, so their definition would 
>> need to
>>  > be changed to use the (redefined) pm_ptr() macro and a 
>> corresponding
>>  > pm_sleep_ptr() macro.
>> 
>>  Small question here.  Why would these macros need to use pm_ptr() 
>> macro at all?
>> 
>>  Why not just stop them being conditional on CONFIG_PM at all and 
>> let dead
>>  code removal kill them off for us?  You might want to do something 
>> different
>>  for the CONFIG_PM_SLEEP ones though if we care about having it that 
>> fine
>>  grained.
> 
> Agreed, there is no need to use pm_ptr() inside of the new macros, it 
> would just
> be convenient to define them this way.

In that case all the callbacks of a dev_pm_ops will be compiled even 
though .suspend/.resume are only for CONFIG_PM_SLEEP.

The driver could do:
.dev.pm = pm_sleep_ptr(&my_pm_sleep_ops),

But that means the driver's dev needs to be aware that pm_sleep_ptr() 
is for simple PM, and pm_ptr() if runtime PM is used.

The alternative I suggested was to use pm_sleep_ptr() inside the 
SET_*_PM_OPS macros (and not pm_ptr() which wouldn't make much sense, I 
agree) so that the callbacks would be included only when 
CONFIG_PM_SLEEP is set; and the drivers would only ever use pm_ptr() 
for their .dev.pm.

I'm slightly in favor of the first solution, just because it would make 
the kernel smaller if !CONFIG_PM_SLEEP as you wouldn't have an empty 
dev_pm_ops struct.

Cheers,
-Paul


