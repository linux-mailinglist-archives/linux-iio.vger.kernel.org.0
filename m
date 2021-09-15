Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9726E40C29F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhIOJR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 05:17:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48081 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhIOJR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 05:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631697400; x=1663233400;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ma3zWFkcsN2tpkbu/znu1sGgtZMKILZTHWWwXdz7ISg=;
  b=kFm9SAGYTU5FEZ+NnSJ5uvGWQRDBCH8q/Xstv1sM7IAraBwYPGJPnHRB
   YdEkU8bG9dix+OOtSNfR8zU5XmS84bpKlZfI39dPw57bHq0aKHtDnoQvu
   9xfjiM2ZSWR5PBQQKyskNlO2rv32EUpKXWCuPE/GUbX//XZMzW+PJDRNI
   AqCvCz8kyqWMs8v54uPIAhxMxJtj7ykxXD5aTGYNIF1fF58HRivZ3XHRa
   CHwtZguGBv2Zs2fohrVEkV8ktQO4ZLpC4e5e2GrreSbvxjtvXcK81RnWl
   X7yyd32DV7CQq3+OE2Pdwj586qztUu7XgM5wZDT7E2NR6Obu+fwt9RYMu
   A==;
IronPort-SDR: rpgf4GtRNa4J7nAJhUlrY+75yDLN2BLA9DGrUJJZvIB9lQ++uBK5pwJCiuhshfNKPG4JmphAGh
 LMyu+xMtF5lOxgwKVcoJ/GcaHiuwH0JBjrzINaiUpiG0mS97LB6+4aZg4w6S9UDEDCc4E2Ft9j
 SXSheqpFGYgWNsYxo6hQN51T6ydMDITajLjjqhafp8V2a3bl9wQvPNX/a4hJjNECLyxMe9xeKQ
 RXLe3DOn4IJ6a/ArXbR1Z9hOsGMZc2zZvtwZE5I71+H7n2eWivpb+nHg24hBnEpMUjXtcCIkMc
 lRcZp4c1ACcCVfEDnmqkSvWF
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="136033834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 02:16:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 02:16:38 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 15 Sep 2021 02:16:36 -0700
Subject: Re: [PATCH v3 00/10] iio: adc: at91-sama5d2_adc: add support for
 sama7g5
To:     Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
 <20210905112805.3e11c2dd@jic23-huawei>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <6d85626b-46e0-0b06-c2c3-014ccd5aaa32@microchip.com>
Date:   Wed, 15 Sep 2021 11:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210905112805.3e11c2dd@jic23-huawei>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/09/2021 at 12:28, Jonathan Cameron wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Wed, 1 Sep 2021 15:30:03 +0300
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
>> Changes in v3:
>> updates for the channel indexes ABI
>> minor nitpicks fixes
>> fixed krobot report
> 
> v2 dropped,
> v3 1-8 applied to the togreg branch of iio.git and initially pushed out as testing
> for 0-day to poke at and to allow me to rebase after rc1 is available.

v3 9-10 applied to the at91-dt branch for 5.16.
It will go through the arm-soc tree.

Thanks, best regards,
   Nicolas

>> Changes in v2:
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
>>
>>
>>
>> Eugen Hristev (10):
>>    dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
>>    iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
>>    iio: adc: at91-sama5d2_adc: remove unused definition
>>    iio: adc: at91-sama5d2_adc: convert to platform specific data
>>      structures
>>    iio: adc: at91-sama5d2_adc: add support for separate end of conversion
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
>>   drivers/iio/adc/at91-sama5d2_adc.c            | 594 ++++++++++++------
>>   4 files changed, 432 insertions(+), 187 deletions(-)
>>
> 


-- 
Nicolas Ferre
