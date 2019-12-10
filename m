Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF07F117E9C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 04:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLJD5K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 22:57:10 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:38470 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJD5J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Dec 2019 22:57:09 -0500
Received: from [10.28.19.135] (10.28.19.135) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 10 Dec
 2019 11:57:40 +0800
Subject: Re: [PATCH] arm64: dts: a1: add saradc controller
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-iio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1575358332-44866-1-git-send-email-xingyu.chen@amlogic.com>
 <7hpngxqfa7.fsf@baylibre.com>
From:   Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <9a2ddfa3-28f3-7d15-bb25-5b84078b77c7@amlogic.com>
Date:   Tue, 10 Dec 2019 11:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <7hpngxqfa7.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.28.19.135]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, Kevin

On 2019/12/10 6:56, Kevin Hilman wrote:
> Xingyu Chen <xingyu.chen@amlogic.com> writes:
>
>> The saradc controller in Meson-A1 is the same as the Meson-G12 series SoCs,
>> so we use the same compatible string.
>>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>>
>> ---
>> This patch is based on A1 clock patchset at [0].
>>
>> [0] https://lore.kernel.org/linux-amlogic/20191129144605.182774-1-jian.hu@amlogic.com
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> index 7210ad0..cad1756 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -93,6 +93,21 @@
>>   				clock-names = "xtal", "pclk", "baud";
>>   				status = "disabled";
>>   			};
>> +
>> +			saradc: adc@2c00 {
>> +				compatible = "amlogic,meson-g12a-saradc",
>> +					     "amlogic,meson-saradc";
>> +				reg = <0x0 0x2c00 0x0 0x48>;
> Why 0x48 here?  AXG uses 0x38 and you're not adding any more registers
> to this driver.

Thanks for you review.

The saradc introduces 4 new registers (as shown below) begin with g12a 
platform, and these registers are used
to save the sampling value of corresponding channel. In other words, we 
can choose fifo or new registers to save
sampling value, but it is not supported by the current driver.

dout register  |---> fifo
                          |---> channel regs -|
                                                            |--- channel-0
                                                            |--- channel-1
                                                            | ...
                                                            | --- channel-7

AO_SAR_ADC_CHNL01：saving sampling data of channel 0/1
AO_SAR_ADC_CHNL23:   saving sampling data of channel 2/3
AO_SAR_ADC_CHNL45:   saving sampling data of channel 4/5
AO_SAR_ADC_CHNL67:   saving sampling data of channel 6/7


This patch use the 0x48 to describe the registers length just follow the 
file meson-g12-common.dtsi. and it doesn't
affect the driver because of the mapped regiter length is limited by 
max_register member in struct regmap_config.

I can replace 0x48 with 0x38 in next patch if necessary.

> Kevin
>
> .
>
