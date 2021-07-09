Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5A3C2808
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGIRLt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 13:11:49 -0400
Received: from vern.gendns.com ([98.142.107.122]:36592 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGIRLt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 13:11:49 -0400
X-Greylist: delayed 1754 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 13:11:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vZpXdt9nocvsDGpQLxYwSxXUXM76dmb0REned6D4/EE=; b=qdvMqjP+J2zi250MhU62Ce28fB
        URbzOP2zlGjTyXmBOqJtJh2cRczxRoiMXpMOKYV9/JUb1/SUhVg1j7HgbIJEaoYCNhfZ88sI0i0ZL
        4D1YvkwDjj8ZQj1Dr85ZgSVEef3FQnPPly7tM/hoGq3+k9mfrTZL5K/yom8Osfnh83xB0O7TXVObz
        oPGD+7orp07WwK3uuVtfymVWJ/J6wGL0Spyt/vcWqnCVBTm0H4qINcj348VlWKt4WjijwnPcIqxNA
        bK+Arghfb/y0ZO6Ru/LuJ8G06HqkO9urBHwYJmGPV/Z9CD7v4Xj536B/D/VOoC3M0gEaNhRmn2ebj
        Juloiw5w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50140 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m1tXN-00B1Ex-7N; Fri, 09 Jul 2021 12:39:50 -0400
Subject: Re: [PATCH] iio: adc: ti-ads7950: Ensure CS is deasserted after
 reading channels
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
References: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
Date:   Fri, 9 Jul 2021 11:39:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
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

On 7/9/21 5:11 AM, Uwe Kleine-König wrote:
> The ADS7950 requires that CS is deasserted after each SPI word. Before
> commit e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
> CPU usage") the driver used a message with one spi transfer per channel
> where each but the last one had .cs_change set to enforce a CS toggle.
> This was wrongly translated into a message with a single transfer and
> .cs_change set which results in a CS toggle after each word but the
> last which corrupts the first adc conversion of all readouts after the
> first readout.
> 
> Fixes: e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/iio/adc/ti-ads7950.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 2383eacada87..a2b83f0bd526 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -568,7 +568,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
>   	st->ring_xfer.tx_buf = &st->tx_buf[0];
>   	st->ring_xfer.rx_buf = &st->rx_buf[0];
>   	/* len will be set later */
> -	st->ring_xfer.cs_change = true;
>   
>   	spi_message_add_tail(&st->ring_xfer, &st->ring_msg);
>   
> 

Yes, it seems like the SPI_CS_WORD flag should have replaced this (it's
been too long, I can't remember if it was intentional). And removing it
doesn't seem to break anything for me.

Reviewed-by: David Lechner <david@lechnology.com>
Tested-by: David Lechner <david@lechnology.com>
