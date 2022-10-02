Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255695F235A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJBN1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBN1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 09:27:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30102C67D
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 06:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D65B80113
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 13:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6EBC433D6;
        Sun,  2 Oct 2022 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664717223;
        bh=n2jiGhmjwA/j8byInYN5i0QP/jg3Sa/Om506hbIDYIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPt30+QkdTElAQZixDNkIeJ768PqXtyffIJ5affXWL/a14PyzSG7oubSRNJ2RQbvS
         Oest9YFCsntm0ytk5h837IoirHjGVb98mbYkiLMa/+WurQqMyzCWcySqsNxzTOb4rV
         W0WyZW4yTWlQcBh5/wOV4/5vqbwZ6wlDi8VhjS1xXb+zOmL2UbNf2t46Lke+s8hWEX
         Tk3ZagFwkJkQnTcSwdl4Swr7mGcJ+C/AEntV/ulMJVnIKdxPsU3ZosCMR/UFkDc1Nm
         V3XHVeoHbLpqVe3Tyczo0WIp2dclqCNT3e09W8KR1M4Zfc1R1Lt6Ov0fRy+2YvNUS7
         afxWAnfBb37Ww==
Date:   Sun, 2 Oct 2022 14:27:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ltc2496: Fix possible null-ptr-deref in
 ltc2496_probe()
Message-ID: <20221002142719.2c4c0d71@jic23-huawei>
In-Reply-To: <20220928040949.581092-1-weiyongjun@huaweicloud.com>
References: <20220928040949.581092-1-weiyongjun@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Sep 2022 04:09:48 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> KASAN report null-ptr-deref as follows:
> 
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 282 Comm: python3 Tainted: G N 6.0.0-rc7-next-20220927+ #153
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:ltc2497core_probe+0x77/0x440 [ltc2497_core]
> Call Trace:
>  <TASK>
>  ltc2496_probe+0xf4/0x150
>  spi_probe+0x158/0x1f0 drivers/spi/spi.c:421
>  call_driver_probe drivers/base/dd.c:560 [inline]
>  really_probe+0x207/0x750 drivers/base/dd.c:639
>  __driver_probe_device+0x229/0x2a0 drivers/base/dd.c:778
>  device_driver_attach+0xb8/0x1e0 drivers/base/dd.c:1105
> 
> This happend when probe ltc2496 device with spi device id but without
> dts, device_get_match_data() return null chip_info. Fix it by adding
> null check for chip_info in ltc2496_probe().

What tree are you based on?  When I look at this file I'm not seeing a
spi_device_id table so how is it matching?

Also I'd prefer a more comprehensive fix that ensured the same data is
available via the spi_device_id table and uses that if
device_get_match_data() == NULL.

Jonathan

> 
> Fixes: 1695c52a1260 ("drivers: iio: adc: ltc2497: Rename the LTC2499 iio device")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> index 2593fa4322eb..a7353c3dd006 100644
> --- a/drivers/iio/adc/ltc2496.c
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -76,6 +76,8 @@ static int ltc2496_probe(struct spi_device *spi)
>  	st->spi = spi;
>  	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
>  	st->common_ddata.chip_info = device_get_match_data(dev);
> +	if (!st->common_ddata.chip_info)
> +		return -ENODEV;
>  
>  	return ltc2497core_probe(dev, indio_dev);
>  }

