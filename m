Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E0565DD4
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 21:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiGDTKc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiGDTKb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 15:10:31 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B9B22
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Fz6uiurruekU7k9x4bmamwF0IaR1pic94Q2gYX2pqq4=; b=EjowEYNulaONSEV1NFSIFH1/4b
        whSvr6+IoZDcnIXmSkXoyyAkYXC3THdpUfzpvSaNdNt78QwzsZZrWbPq+9sDcMomxgUuwQcbTuOKZ
        2A/cb0cB1aMktaW0lJj4qKmvd1daksMjYy97Vhr9GS7Rz6DWoUwpPSmTlyp6J8YKic6fim0FXGmVg
        AsRa4pdILMrc0m6/YZilk6coyg/xnXevgvdprr5YYnzySj7GtKFj1A+jwz24iJp+oDK7p2cdpBXwC
        +pSbd04sp8q3bAtAI3QzjBU/GG14HAOFiTBpafpaHZtodM3uRMUzGdA7eai8cdFGwY20dWD/h1y3Q
        jQXjwFIQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1o8RSm-0009wb-GW; Mon, 04 Jul 2022 21:10:28 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1o8RSm-0001T4-At; Mon, 04 Jul 2022 21:10:28 +0200
Message-ID: <a0f15b17-a72d-125b-82c3-20c2f406f443@metafoo.de>
Date:   Mon, 4 Jul 2022 21:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fast spi driver development
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Patricio Moreno <pm.pato@gmail.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <ee3d70ac-a9b3-9b91-df92-81fb73c0f93f@gmail.com>
 <CAHp75VdGJKsdcY_ntd4-xy0xPb=J195yOyJM7d7vC_mPj+dm0w@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <CAHp75VdGJKsdcY_ntd4-xy0xPb=J195yOyJM7d7vC_mPj+dm0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26593/Mon Jul  4 09:28:57 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/4/22 20:00, Andy Shevchenko wrote:
> On Sun, Jul 3, 2022 at 3:09 PM Patricio Moreno <pm.pato@gmail.com> wrote:
>> Hello,
>>
>> I'm writing a driver for the TI ADS127x family of ADCs. The ads127x is a
>> 24 bit samples, 4/8 channels, ADC, which can be clocked, using SPI, with
>> up to 25 MHz. For what I've seen, I've followed a common approach within
>> the IIO ADC drivers, but I can't get it to work at high frequencies.
>>
>> I'm using the triggered buffers interface, with a RDY interrupt pin. The
>> problem I have is with timings. When the ADC sends the data ready
>> signal, my handler is called approximately 7µs later. This handler then
>> calls spi_read to get 24 bytes (8 3 bytes samples) and the kernel takes
>> a lot of time to read the SPI bus, actually, to *start* reading.
>>
>> I would really appreciate some guidance on how to deal with this issue.
> +Cc: maintainers and AD guys. I remember there was a discussion about
> supporting HiFreq ADCs in IIO and AFAIR there are some issues (and you
> probably need to use DMA in cyclic mode or so).

A created some slides on this very topic a while ago. See 
https://wiki.analog.com/_media/resources/fpga/peripherals/spi-engine3.pdf

The summary is a general purpose operating system is not well suited to 
this task, mainly, like you noticed, due to the context switch penalty.

In general the solution to this is to batch multiple sample acquisitions 
together to reduce the number of context switches. There are both 
software and hardware based approaches for this.

  * Asymmetric multiprocessing: Dedicate one core to data acquisition 
running a bare metal application. It can control the SPI controller in a 
tight loop and make sure that transactions are scheduled on time. Data 
can be moved to the main OS using a shared memory ring buffer.

  * FIFO in the sensor: Probably the best solution if available. Have a 
FIFO in the sensor with a threshold IRQ and read multiple samples in a 
single SPI transfer when the FIFO is almost full.

  * SPI transfer offloading on the host side: This is what the 
presentation mainly talks about. The host system has a SPI controller IP 
that supports scheduling SPI transfers without software interaction in 
response to a trigger signal, e.g. a timer of external GPIO. The data is 
then pushed to a FIFO or directly to system memory using DMA. The host 
system is notified when a certain amount of samples have been received.

- Lars

