Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176D31AF9EF
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 14:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDSMTb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 08:19:31 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56215 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgDSMTb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 08:19:31 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPA id 1C44FFF803;
        Sun, 19 Apr 2020 12:19:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Apr 2020 14:19:26 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
In-Reply-To: <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-3-contact@artur-rojek.eu>
 <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
Message-ID: <ed0b6fdac4fdb89e87082f2c6b0edc51@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,
thanks for the review. Comments inline.

On 2020-04-17 22:59, Andy Shevchenko wrote:
> On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu> 
> wrote:
>> 
>> The SADC component in JZ47xx SoCs provides support for touchscreen
>> operations (pen position and pen down pressure) in single-ended and
>> differential modes.
>> 
>> Of the known hardware to use this controller, GCW Zero and Anbernic 
>> RG-350
>> utilize the touchscreen mode by having their joystick(s) attached to 
>> the
>> X/Y positive/negative input pins.
>> GCW Zero comes with a single joystick and is sufficiently handled with 
>> the
>> currently implemented single-ended mode. Support for boards with two
>> joysticks, where one is hooked up to Xn/Yn and the other to Xp/Yp 
>> channels
>> will need to be provided in the future.
>> 
>> The touchscreen component of SADC takes a significant time to 
>> stabilize
>> after first receiving the clock and a delay of 50ms has been 
>> empirically
>> proven to be a safe value before data sampling can begin.
>> 
>> All the boards which probe this driver have the interrupt provided 
>> from
>> devicetree, with no need to handle a case where the irq was not 
>> provided.
> 
> Device Tree
> IRQ
> 
> ...
> 
>> +               .scan_type = {
>> +                       .sign = 'u',
>> +                       .realbits = 12,
> 
>> +                       .storagebits = 16
> 
> It's slightly better to leave comma in such cases.
> 
>> +               },
> 
>> +               .scan_type = {
>> +                       .sign = 'u',
>> +                       .realbits = 12,
> 
>> +                       .storagebits = 16
> 
> Ditto.
> 
>> +               },
> 
> ...
> 
>>                 .indexed = 1,
>>                 .channel = INGENIC_ADC_AUX,
>> +               .scan_index = -1
> 
> Ditto. You see above? Isn't it nice that you didn't touch that line?
> So, perhaps next developer can leverage this subtle kind of things.
> 
>>                 .indexed = 1,
>>                 .channel = INGENIC_ADC_BATTERY,
>> +               .scan_index = -1
> 
> Ditto.
> 
>>                 .indexed = 1,
>>                 .channel = INGENIC_ADC_AUX2,
>> +               .scan_index = -1
> 
> Ditto.
> 
> ...
> 
>> +static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
>> +{
>> +       struct ingenic_adc *adc = iio_priv(iio_dev);
>> +
> 
>> +       clk_enable(adc->clk);
> 
> Error check?
> 
>> +       /* It takes significant time for the touchscreen hw to 
>> stabilize. */
>> +       msleep(50);
>> +       ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
>> +                              JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
>> +                              JZ_ADC_REG_CFG_PULL_UP(4));
>> +       writew(80, adc->base + JZ_ADC_REG_ADWAIT);
>> +       writew(2, adc->base + JZ_ADC_REG_ADSAME);
> 
>> +       writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);
> 
> Why casting?
After flipping the bits, the resulting value can't be represented by u8. 
Since we care only about the first 8 bits anyway, explicit cast here is 
to silence a compiler warning.
> 
>> +       writel(0, adc->base + JZ_ADC_REG_ADTCH);
>> +       ingenic_adc_enable(adc, 2, true);
>> +
>> +       return 0;
>> +}
> 
>> +       irq = platform_get_irq(pdev, 0);
> 
> Before it worked w/o IRQ, here is a regression you introduced.
> 
>> +       if (irq < 0) {
> 
>> +               dev_err(dev, "Failed to get irq: %d\n", irq);
> 
> Redundant message.
> 
>> +               return irq;
>> +       }

- Artur
