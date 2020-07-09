Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4A21A451
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGIQFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 12:05:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54543 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQFQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 12:05:16 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPA id 9DA5B1BF20B;
        Thu,  9 Jul 2020 16:05:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Jul 2020 18:05:11 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/6] iio/adc: ingenic: Cleanups & add touchscreen mode.
In-Reply-To: <CAHp75VcwgL8pH+pH9TnsuwbWr=wSFu37sX8sTkbkfk+iBv7Jng@mail.gmail.com>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
 <CAHp75VcwgL8pH+pH9TnsuwbWr=wSFu37sX8sTkbkfk+iBv7Jng@mail.gmail.com>
Message-ID: <9865deba48fdb1b5bb522ae7cabef7bc@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.13
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Andy,

On 2020-07-09 17:43, Andy Shevchenko wrote:
> On Thu, Jul 9, 2020 at 6:22 PM Artur Rojek <contact@artur-rojek.eu> 
> wrote:
>> 
>> Hi all,
>> 
>> v8 of this patchset introduces some structural changes, which I deemed
>> worthy highlighting here:
> 
> Can you remind me if I gave you tags on the previous version?
I received no tags from you on this patchset so far.

Cheers,
Artur

> If so, is the above the reason to drop them?
> 
>> 
>>  - adc-joystick related changes have been dropped from this patchset 
>> and
>>    will be upstreamed separately. Their only connection to this 
>> patchset
>>    was that they used INGENIC_ADC_TOUCH_* defines in the DTS example,
>>    causing trouble to Rob's scripts.
>> 
>>  - Integrated Paul's changes, which introduce an ADCMD low-level 
>> command
>>    feature. These changes affect patches 5/6 and 6/6, with the former
>>    requiring Rob to re-ack.
>> 
>> Cheers,
>> Artur
>> 
>> Artur Rojek (5):
>>   dt-bindings: iio/adc: Convert ingenic-adc docs to YAML.
>>   IIO: Ingenic JZ47xx: Error check clk_enable calls.
>>   IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
>>   dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
>>   IIO: Ingenic JZ47xx: Add touchscreen mode.
>> 
>> Paul Cercueil (1):
>>   iio/adc: ingenic: Retrieve channels list from soc data struct
>> 
>>  .../bindings/iio/adc/ingenic,adc.txt          |  49 ---
>>  .../bindings/iio/adc/ingenic,adc.yaml         |  71 ++++
>>  drivers/iio/adc/Kconfig                       |   1 +
>>  drivers/iio/adc/ingenic-adc.c                 | 386 
>> ++++++++++++++++--
>>  include/dt-bindings/iio/adc/ingenic,adc.h     |   6 +
>>  5 files changed, 426 insertions(+), 87 deletions(-)
>>  delete mode 100644 
>> Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>>  create mode 100644 
>> Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
>> 
>> --
>> 2.27.0
>> 
