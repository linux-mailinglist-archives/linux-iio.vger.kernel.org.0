Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D353790CC5
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjICP1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICP1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 11:27:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF38F1
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f3vobn51vKz601q8mHaKsElZrtGTnv36IlNkrFWdBRw=; b=gRtalDoQMUXmip0PogiLpBxzI0
        DZVyNirPFw1fu2AjTAVPjscypsmS5RGCdz2WnvKhr7cG7jRkBGp57D4DHywfr/D5MFDYwx3Mbozqj
        GXg6vyVZmZ+4wFt/Jz3HKNUdfpAcEupxeFk1QuUjUKaxZWNY/e40mESxmCH91TRF9tceVxo06QjMI
        2rFxURhBNljQmBeCpdIZ8utk7erdM/P8Rb7ceTKtj+DRd5Bym56v5DdrRUIxJjD1c6U1NsE0SUK2U
        W5LRqbLSNJ1HQjoNVuAEmE1xDaI/ZbqKtJw47MTlis3kNpVRGEiaDeR0cG/yRY1nO88w0AMAnCxO8
        nnCTiS8g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qcp0l-002hKG-1u;
        Sun, 03 Sep 2023 15:27:39 +0000
Message-ID: <589ab021-4dca-4547-3b5f-d2d9a9210cbb@infradead.org>
Date:   Sun, 3 Sep 2023 08:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] iio: imu: bno055: Fix missing Kconfig dependencies
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrea Merello <andrea.merello@iit.it>
References: <20230903113052.846298-1-jic23@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230903113052.846298-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 9/3/23 04:30, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver uses IIO triggered buffers so it needs to select them in
> Kconfig.
> 
> on riscv-32bit:
> 
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/iio/imu/bno055/bno055.o: in function `.L367':
> bno055.c:(.text+0x2c96): undefined reference to `devm_iio_triggered_buffer_setup_ext'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-next/40566b4b-3950-81fe-ff14-871d8c447627@infradead.org/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andrea Merello <andrea.merello@iit.it>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/iio/imu/bno055/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> index fa79b1ac4f85..83e53acfbe88 100644
> --- a/drivers/iio/imu/bno055/Kconfig
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -2,6 +2,8 @@
>  
>  config BOSCH_BNO055
>  	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  
>  config BOSCH_BNO055_SERIAL
>  	tristate "Bosch BNO055 attached via UART"

-- 
~Randy
