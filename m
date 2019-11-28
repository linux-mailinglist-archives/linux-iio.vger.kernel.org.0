Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5869F10CEF0
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1TnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 14:43:14 -0500
Received: from www381.your-server.de ([78.46.137.84]:46190 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1TnO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 14:43:14 -0500
X-Greylist: delayed 1576 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2019 14:43:12 EST
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1iaPHY-0007RS-AT; Thu, 28 Nov 2019 20:16:52 +0100
Received: from [93.104.105.80] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1iaPHX-0007lB-QX; Thu, 28 Nov 2019 20:16:52 +0100
Subject: Re: Doubts in getting started with the Analog AD7928 driver
To:     Daniel Junho <djunho@gmail.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
 <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
 <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
 <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com>
 <74bff1fe1eab887d3d19f3cff3fc02afbc52a12d.camel@analog.com>
 <CAKxs2cBRC1Mkx5+jtW+BNqA_53GL1K2C8Hppf7wuY6SMPiMi+Q@mail.gmail.com>
 <CAKxs2cD=hRpQfAxnWWU-4PJOwuWrqpkcJZ-_AVLCvRui8iOmAA@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <36ecb0e0-a593-2064-caf0-9b161c36f9b4@metafoo.de>
Date:   Thu, 28 Nov 2019 20:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKxs2cD=hRpQfAxnWWU-4PJOwuWrqpkcJZ-_AVLCvRui8iOmAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25647/Thu Nov 28 10:49:14 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/28/19 6:49 PM, Daniel Junho wrote:
> Continuing:
> I will use the kernel 4.4 LTS official and on the mainline to continue.
> I will let you know if my problem continues.
> 
> To make my last update more clear:
> I see the cs rising when sending the command transfer and falling only
> after the read transfer. But not between, that is what I expected with
> the cs_change.
> I also suspected from my device tree but, when using a userspace
> application (with spidev) it worked.
> 
> Also, my device tree is the following one. I'm checking if I'm doing
> anything wrong. Please let me know if you see any obvious problems.
> 
> Thank you

Hi,

cs_change is a bit of an obscure feature since there are not many users
and not all SPI controller drivers get it right.

Check if this commits that was added in v4.6, maybe they'll help
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92dc20d83adec565378254c0630e839ff5674e14

As a workaround you can also do multiple spi_transfer() calls.

- Lars


> 
> dspi3: dspi3@400ad000 {
>     #address-cells = <1>;
>     #size-cells = <0>;
>     compatible = "fsl,vf610-dspi";
>     reg = <0x400ad000 0x1000>;
>     interrupts = <70 IRQ_TYPE_LEVEL_HIGH>;
>     clocks = <&clks VF610_CLK_DSPI3>;
>     clock-names = "dspi";
>     spi-num-chipselects = <2>;
>     /* Previously, this node was without DMA info - segmentation fault on use
>     For proper usage, it MUST contain DMA channel info --> EDMA1 */
>     dmas = <&edma1 0 12>,
>         <&edma1 0 13>;
>     dma-names = "rx", "tx";
>     status = "disabled";
> };
> 
> 
> &dspi3 {
>     status = "okay";
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     /* This will create /dev/spidev3.0 */
>     /*spidev30: spidev3@0 {
>         compatible = "toradex,evalspi";
>         reg = <0>;
>         spi-max-frequency = <50000000>;
>         fsl,spi-cs-sck-delay = <100>;
>         fsl,spi-sck-cs-delay = <50>;
>         status = "okay";
>     };*/
> 
>     ad7928@0 {
>       compatible = "adi,ad7928";
>       reg = <0>;
>       spi-max-frequency = <20000000>;
>       refin-supply = <&reg_5v0>;
>     };
> 
> };
> 
> Daniel E. M. Junho
> 
> On Thu, Nov 28, 2019 at 12:13 PM Daniel Junho <djunho@gmail.com> wrote:
>>
>> Hello.
>>
>> After some effort to extend the AD7923 to include the AD7928, I got
>> stuck because it won't work.
>>
>> After several days trying to figure out, I could use an oscilloscope
>> to analyze and, it seems that the cs_change does not affect the
>> driver.
>>
>> ```
>>   struct spi_transfer t[] = {
>>            {
>>                    .tx_buf = &st->tx_buf[0],
>>                    .len = 2,
>>                    .cs_change = 1,
>>            }, {
>>                    .rx_buf = &st->rx_buf[0],
>>                    .len = 2,
>>            },
>>    };
>>    ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
>> ```
>>
>> The code above sends the first cmd and does not deselect the cs to get
>> the answer.
>>
>> I am using kernel 4.4.107 from Toradex to deploy the driver. That is
>> the version used on the project of the board.
>>
>> Does anyone have any idea what I am doing wrong? Should I update the
>> kernel, or it should work as well in this version? Or any ideas of how
>> to debug it?
>>
>> Daniel E. M. Junho
>>
>>
>> On Wed, Sep 18, 2019 at 3:13 AM Ardelean, Alexandru
>> <alexandru.Ardelean@analog.com> wrote:
>>>
>>> On Tue, 2019-09-17 at 21:47 -0300, Daniel Junho wrote:
>>>> On Tue, Sep 17, 2019 at 3:24 AM Ardelean, Alexandru
>>>> <alexandru.Ardelean@analog.com> wrote:
>>>>> On Mon, 2019-09-16 at 20:50 -0300, Daniel Junho wrote:
>>>>>> [External]
>>>>>>
>>>>>> Hello everybody.
>>>>>>
>>>>>> I am still learning about kernel developing. I would like to try to
>>>>>> develop a device driver for the AD7928 [1], from Analog Device.
>>>>>>
>>>>>> Can someone give some words to guide me?
>>>>>>
>>>>>> I was thinking about forking the analog kernel repo [2] but I don't
>>>>>> know to which branch should I commit to when doing a pull request. Or
>>>>>> if this is the correct way for the devices from Analog.
>>>>>>
>>>>>
>>>>> Hey,
>>>>>
>>>>> Thanks for the interest in writing the driver for this.
>>>>>
>>>>> In some cases, some new parts may have an existing driver available
>>>>> already
>>>>> that can be re-used partially or completely.
>>>>>
>>>>> You're in luck.
>>>>> There is driver seems to be partially implemented via
>>>>> drivers/iio/adc/ad7923.c
>>>>>
>>>>> I've done only a minor/quick check but the control register bits are
>>>>> compatible for the AD7928 as well.
>>>>>
>>>>> Typically, you can extend that driver and add the new parts and test
>>>>> them.
>>>>>
>>>>> So, my suggestion would be:
>>>>> 1. Get an eval-board or a AD7928 part; depending on the case we could
>>>>> help
>>>>> with this
>>>>> 2. Try to set it up with a Raspberry Pi with the eval board
>>>>>    a. it looks to me that you need a 7V-9V power-supply
>>>>>    b. you can hook the SPI to the test-points on the eval board
>>>>> 3. Write a basic device-tree overlay ; you can adapt something from
>>>>> other
>>>>> examples.
>>>>> Look here:
>>>>> https://github.com/analogdevicesinc/linux/blob/rpi-4.19.y/arch/arm/boot/dts/overlays/Makefile
>>>>> Usually  rpi-adXXX.dts  are ADI parts.
>>>>> 4. Enable the driver for the kernel.
>>>>> If using the ADI kernel, there's a guide here for RPi.
>>>>> https://wiki.analog.com/resources/tools-software/linux-build/generic/raspberrypi
>>>>> Check the branch that matches your Raspbian image (rpi-4.19.y is the
>>>>> latest)
>>>>> 5. Build the kernel
>>>>> 6. Write it to the SD-card image
>>>>> 7. Test
>>>>> 8. Modify & repeat
>>>>>
>>>>> Thanks
>>>>> Alex
>>>>>
>>>>>> [1] https://www.analog.com/en/products/ad7928.html
>>>>>> [2] https://github.com/analogdevicesinc/linux
>>>>>>
>>>>>> Daniel Junho
>>>>
>>>> Hi Alex.
>>>>
>>>> It seems that using AD7923 will be the best choice. They are very
>>>> similar.
>>>>
>>>> Thank you for your reply and suggestion.
>>>> I don't have an EVB, but at work, we have a board with the AD7928
>>>
>>> If you have the chip already connected, then it's even better.
>>> You don't need to go through the trouble of interfacing it anymore.
>>>
>>>> using a user driver. So I will try to use it for this development, at
>>>
>>> And if you've already validated with a user-driver, it's again better, as
>>> the connections have been validated.
>>>
>>>> least for now.
>>>>
>>>> I believe that will be fun =)
>>>
>>> Should be.
>>> If this whole thing is new to you, it's always easier to start with a
>>> base/existing driver and extend than go through the process of writing it
>>> from scratch.
>>> It's mostly how I learn(ed) things: taking things apart, seeing what people
>>> have done, and then using the best ideas in my future processes.
>>>
>>>>
>>>> Daniel Junho

