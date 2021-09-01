Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5B3FD72D
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbhIAJsZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 05:48:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10382 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhIAJsZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 05:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630489648; x=1662025648;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lp2GmPd+gvoAEGs3uUb8OYJK6vgjUO8JTiGxQhCryIY=;
  b=diMYo4EPL/3z8ciAZp6TRnyFXteb7hAAM7LinbSndVGsR2YCaukGTPYm
   CX9pC1IvzOat+WJbZdHLUv5V8ydrfJG935OPsPFYRu4/wBrvZBI+eDXeP
   zQtlbJFflLI4PWM4+d+mbXVS8PElKN8kI8QjwzvBt3wbzInOda52OH1IO
   ellYg7D4IGsqxObVMeNOnw8HlA07HOrobRnkL2iilfz2ByuoNwy7XXR22
   BP/+yFEKbAHusJpshtzfk0MLFwU+bsQUB8Dz9V5EU8mXr3q8LRGHf4nrr
   2bAX8cpUh8dBwwdaw3w9eGyJacRLq4NYKhA4c6S4qpkp/NowJBGGMzsre
   w==;
IronPort-SDR: 5q10mBN8g3OzA/+ZiqxMWcz9qD+FySN6LEaXrtJ7DtAiH6I2nVCOqYOoDJ8zK6FpEW5j/gDnOa
 wJPhVRdx0al836MHOWy6of58tdbrxAeny5LxjBZR1dkTMDuzoCGbfPV3H3xCXDdvr5IG3ARKlO
 xAQG7hW9SZ2ZtJWSSd1gVipuEOAh3YmG5qg+g7l+p29PUMYBqSzXgRUMFnOUj6nr8dEWsU07bh
 Uyr7akkMSefDSPOX2mibZtdzm428FoKWL0CRZs9x7rl9vVGgstRgMHzEdhx/pqXB9Hf7uuN/ap
 UsxiF4Gg3BMDyaxRggTTe6CT
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="142388954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 02:47:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 02:47:14 -0700
Received: from [10.12.72.234] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 1 Sep 2021 02:47:13 -0700
Subject: Re: [PATCH v2 00/10] iio: adc: at91-sama5d2_adc: add support for
 sama7g5
To:     Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
 <20210830132636.16dde030@jic23-huawei>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b6f37986-59c6-3890-8337-96d9ad057d6e@microchip.com>
Date:   Wed, 1 Sep 2021 11:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830132636.16dde030@jic23-huawei>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/08/2021 at 14:26, Jonathan Cameron wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, 24 Aug 2021 14:54:31 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
>> Hi,
>>
>> This series adds support for sama7g5.
>>
>> The sama7g5 is slightly different from sama5d2, but has the same basic
>> operations. The register map is a bit different, so, I added some primitives
>> to differentiate between the two classes of hardware blocks (sama5d2-sam9x60
>> and sama7g5).
>>
>> Sama7g5 has 16 channels ADC, no resistive touch, and extra features
>> (FIFOs, better oversampling , not implemented yet).
>>
>> It is a rework of the series initially sent here:
>> https://marc.info/?l=linux-iio&m=161461656807826&w=2
>>
>> I reworked this according to review by Jonathan, meaning that first I created
>> a no-op patch that will convert the driver to a more platform specific data
>> dedicated type of driver. This adds various structures that hold things like
>> register layout and channel information.
>> After this I created few patches that implement the main differences between
>> sama7g5 and older products: the end-of-conversion new register. I added
>> helper functions to make code more easy to read and more simple.
>> One the last patches adds the layout and channels for sama7g5.
>> At this moment in linux-next, the DT for sama7g5 and sama7g5ek is present,
>> and the last patches add and enable this node in DT for this board.
>>
>> Eugen
> 0-8 applied with the minor tweak mentioned in a reply to relevant patch.
> 
> I'll assume 9-10 will got via normal soc related tree.

Yep, we'll take them through at91 -> arm-soc trees...

> 
> Note that I'm queuing these up for the merge window after this one now
> (5.16).

Yes, soc/dt parts will be queued for 5.16 too.

Thanks Eugen, thanks Jonathan, best regards,
   Nicolas

>> Eugen Hristev (10):
>>    dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
>>    iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
>>    iio: adc: at91-sama5d2_adc: remove unused definition
>>    iio: adc: at91-sama5d2_adc: convert to platform specific data
>>      structures
>>    iio: adc: at91-sama5d2-adc: add support for separate end of conversion
>>      registers
>>    iio: adc: at91-sama5d2_adc: add helper for COR register
>>    iio: adc: at91-sama5d2_adc: add support for sama7g5 device
>>    iio: adc: at91-sama5d2_adc: update copyright and authors information
>>    ARM: dts: at91: sama7g5: add node for the ADC
>>    ARM: dts: at91: sama7g5ek: enable ADC on the board
>>
>>   .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
>>   arch/arm/boot/dts/at91-sama7g5ek.dts          |   8 +
>>   arch/arm/boot/dts/sama7g5.dtsi                |  16 +
>>   drivers/iio/adc/at91-sama5d2_adc.c            | 586 ++++++++++++------
>>   4 files changed, 425 insertions(+), 186 deletions(-)
>>
> 


-- 
Nicolas Ferre
