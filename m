Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13CC3C3525
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhGJPff (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 11:35:35 -0400
Received: from vern.gendns.com ([98.142.107.122]:52416 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhGJPff (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 11:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Li7E6A0D5DAm799XCacWf+rKrROWUmAKlNPUEF4ibJk=; b=DAIcXmf9BB2aaqxJFoSsZZsc0O
        rfHH+DS1vNNdVCIFhBZmK0MF45LPvXYEJMYvThhXd8i8UXia7cYLclMWfMtuqBv06ycbfGXqqf1eB
        XpztFd3O2czgJX10UoB5aUJq4a4bQkEc0bh+F8z1o4MnJEWVnELRcUi7sbdaoBkERNgBAVKqW1uIX
        Wfeylw5oi7/GG3eNzCziNY9APS8sgpJ5oc56EBARqFhcQS2traL8qLM8nYDbqxqEc0NuyYNoDOKUB
        lPgaAp4oJwKBtXK1uaOLtowuu9HbWHFeIJcawc09nv9f8pOXGLDPPbl6h3f3ektsZ7S17h6yDOEt+
        b2MmHwZA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45364 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2Ey1-00GS3U-2Y; Sat, 10 Jul 2021 11:32:48 -0400
Subject: Re: [PATCH] iio: adc: ti-ads7950: Ensure CS is deasserted after
 reading channels
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        "kernel@pengutronix.de Mark Brown" <broonie@kernel.org>,
        linux-spi@vger.kernel.org
References: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
 <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
 <20210710121815.yxaylkhessvjbtkf@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <d98603e7-3336-617a-0e2f-e964eb3c894c@lechnology.com>
Date:   Sat, 10 Jul 2021 10:32:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710121815.yxaylkhessvjbtkf@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/10/21 7:18 AM, Uwe Kleine-König wrote:
> Hello,
> 
> Cc += Mark + linux-spi
> 
> On Fri, Jul 09, 2021 at 11:39:48AM -0500, David Lechner wrote:
>> On 7/9/21 5:11 AM, Uwe Kleine-König wrote:
>>> The ADS7950 requires that CS is deasserted after each SPI word. Before
>>> commit e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
>>> CPU usage") the driver used a message with one spi transfer per channel
>>> where each but the last one had .cs_change set to enforce a CS toggle.
>>> This was wrongly translated into a message with a single transfer and
>>> .cs_change set which results in a CS toggle after each word but the
>>> last which corrupts the first adc conversion of all readouts after the
>>> first readout.
>>>
>>> Fixes: e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage")
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>>    drivers/iio/adc/ti-ads7950.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>>> index 2383eacada87..a2b83f0bd526 100644
>>> --- a/drivers/iio/adc/ti-ads7950.c
>>> +++ b/drivers/iio/adc/ti-ads7950.c
>>> @@ -568,7 +568,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
>>>    	st->ring_xfer.tx_buf = &st->tx_buf[0];
>>>    	st->ring_xfer.rx_buf = &st->rx_buf[0];
>>>    	/* len will be set later */
>>> -	st->ring_xfer.cs_change = true;
>>>    	spi_message_add_tail(&st->ring_xfer, &st->ring_msg);
>>>
>>
>> Yes, it seems like the SPI_CS_WORD flag should have replaced this (it's
>> been too long, I can't remember if it was intentional). And removing it
>> doesn't seem to break anything for me.
> 
> If it's not broken for you without my patch, your spi bus driver doesn't
> honor .cs_change in the last transfer. Out of interest: Which bus are
> you using? I wonder if the driver should refuse the request if it cannot
> honer .cs_change?! (spi-imx does honor it only if gpios are used as chip
> select, the native chip selects cannot do that.)
> 


I'm using spi-davinci. It uses the standard spi_transfer_one_message()
which handles cs_change. But I suspect when the SPI_CS_WORD flag is set,
and the message is big enough to use DMA, the hardware is probably
automatically toggling CS after the last transfer before the cs_change
logic asserts it again.

So unless there is a valid use case where we need both SPI_CS_WORD
and cs_change, I don't think we need to fix spi-davinci.
