Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1B10CF05
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 20:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1T6m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 28 Nov 2019 14:58:42 -0500
Received: from haggis.mythic-beasts.com ([46.235.224.141]:52371 "EHLO
        haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1T6m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 14:58:42 -0500
X-Greylist: delayed 752 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2019 14:58:41 EST
Received: from [93.93.129.122] (port=47530 helo=erriapus.retrosnub.co.uk)
        by haggis.mythic-beasts.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1iaPjq-00085O-RY; Thu, 28 Nov 2019 19:46:06 +0000
Received: from [192.168.0.7] (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by erriapus.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2027A3A00F8;
        Thu, 28 Nov 2019 19:46:03 +0000 (GMT)
Date:   Thu, 28 Nov 2019 19:23:46 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKxs2cBRC1Mkx5+jtW+BNqA_53GL1K2C8Hppf7wuY6SMPiMi+Q@mail.gmail.com>
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com> <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com> <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com> <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com> <74bff1fe1eab887d3d19f3cff3fc02afbc52a12d.camel@analog.com> <CAKxs2cBRC1Mkx5+jtW+BNqA_53GL1K2C8Hppf7wuY6SMPiMi+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Doubts in getting started with the Analog AD7928 driver
To:     Daniel Junho <djunho@gmail.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DE8FBFB6-1363-444B-BADE-0345EAB7E682@jic23.retrosnub.co.uk>
X-Mythic-Source-External: YES
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28 November 2019 15:13:56 GMT, Daniel Junho <djunho@gmail.com> wrote:
>Hello.
>
>After some effort to extend the AD7923 to include the AD7928, I got
>stuck because it won't work.
>
>After several days trying to figure out, I could use an oscilloscope
>to analyze and, it seems that the cs_change does not affect the
>driver.
>
>```
>  struct spi_transfer t[] = {
>           {
>                   .tx_buf = &st->tx_buf[0],
>                   .len = 2,
>                   .cs_change = 1,
>           }, {
>                   .rx_buf = &st->rx_buf[0],
>                   .len = 2,
>           },
>   };
>   ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
>```
>
>The code above sends the first cmd and does not deselect the cs to get
>the answer.
>
>I am using kernel 4.4.107 from Toradex to deploy the driver. That is
>the version used on the project of the board.
>
>Does anyone have any idea what I am doing wrong? Should I update the
>kernel, or it should work as well in this version? Or any ideas of how
>to debug it?

Sounds like an spi master driver issue.  What spi controller are you using? 

>
>Daniel E. M. Junho
>
>
>On Wed, Sep 18, 2019 at 3:13 AM Ardelean, Alexandru
><alexandru.Ardelean@analog.com> wrote:
>>
>> On Tue, 2019-09-17 at 21:47 -0300, Daniel Junho wrote:
>> > On Tue, Sep 17, 2019 at 3:24 AM Ardelean, Alexandru
>> > <alexandru.Ardelean@analog.com> wrote:
>> > > On Mon, 2019-09-16 at 20:50 -0300, Daniel Junho wrote:
>> > > > [External]
>> > > >
>> > > > Hello everybody.
>> > > >
>> > > > I am still learning about kernel developing. I would like to
>try to
>> > > > develop a device driver for the AD7928 [1], from Analog Device.
>> > > >
>> > > > Can someone give some words to guide me?
>> > > >
>> > > > I was thinking about forking the analog kernel repo [2] but I
>don't
>> > > > know to which branch should I commit to when doing a pull
>request. Or
>> > > > if this is the correct way for the devices from Analog.
>> > > >
>> > >
>> > > Hey,
>> > >
>> > > Thanks for the interest in writing the driver for this.
>> > >
>> > > In some cases, some new parts may have an existing driver
>available
>> > > already
>> > > that can be re-used partially or completely.
>> > >
>> > > You're in luck.
>> > > There is driver seems to be partially implemented via
>> > > drivers/iio/adc/ad7923.c
>> > >
>> > > I've done only a minor/quick check but the control register bits
>are
>> > > compatible for the AD7928 as well.
>> > >
>> > > Typically, you can extend that driver and add the new parts and
>test
>> > > them.
>> > >
>> > > So, my suggestion would be:
>> > > 1. Get an eval-board or a AD7928 part; depending on the case we
>could
>> > > help
>> > > with this
>> > > 2. Try to set it up with a Raspberry Pi with the eval board
>> > >    a. it looks to me that you need a 7V-9V power-supply
>> > >    b. you can hook the SPI to the test-points on the eval board
>> > > 3. Write a basic device-tree overlay ; you can adapt something
>from
>> > > other
>> > > examples.
>> > > Look here:
>> > >
>https://github.com/analogdevicesinc/linux/blob/rpi-4.19.y/arch/arm/boot/dts/overlays/Makefile
>> > > Usually  rpi-adXXX.dts  are ADI parts.
>> > > 4. Enable the driver for the kernel.
>> > > If using the ADI kernel, there's a guide here for RPi.
>> > >
>https://wiki.analog.com/resources/tools-software/linux-build/generic/raspberrypi
>> > > Check the branch that matches your Raspbian image (rpi-4.19.y is
>the
>> > > latest)
>> > > 5. Build the kernel
>> > > 6. Write it to the SD-card image
>> > > 7. Test
>> > > 8. Modify & repeat
>> > >
>> > > Thanks
>> > > Alex
>> > >
>> > > > [1] https://www.analog.com/en/products/ad7928.html
>> > > > [2] https://github.com/analogdevicesinc/linux
>> > > >
>> > > > Daniel Junho
>> >
>> > Hi Alex.
>> >
>> > It seems that using AD7923 will be the best choice. They are very
>> > similar.
>> >
>> > Thank you for your reply and suggestion.
>> > I don't have an EVB, but at work, we have a board with the AD7928
>>
>> If you have the chip already connected, then it's even better.
>> You don't need to go through the trouble of interfacing it anymore.
>>
>> > using a user driver. So I will try to use it for this development,
>at
>>
>> And if you've already validated with a user-driver, it's again
>better, as
>> the connections have been validated.
>>
>> > least for now.
>> >
>> > I believe that will be fun =)
>>
>> Should be.
>> If this whole thing is new to you, it's always easier to start with a
>> base/existing driver and extend than go through the process of
>writing it
>> from scratch.
>> It's mostly how I learn(ed) things: taking things apart, seeing what
>people
>> have done, and then using the best ideas in my future processes.
>>
>> >
>> > Daniel Junho

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
