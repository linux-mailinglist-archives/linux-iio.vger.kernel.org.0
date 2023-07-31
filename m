Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A967692BF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jul 2023 12:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGaKJD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jul 2023 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGaKJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jul 2023 06:09:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C15E49
        for <linux-iio@vger.kernel.org>; Mon, 31 Jul 2023 03:08:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RDv4t6tCFz6J6WY;
        Mon, 31 Jul 2023 18:05:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 11:08:47 +0100
Date:   Mon, 31 Jul 2023 11:08:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atul Raut <rauji.raut@gmail.com>
CC:     <cosmin.tanislav@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] iio: accel: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <20230731110846.00004176@Huawei.com>
In-Reply-To: <20230731014406.22810-1-rauji.raut@gmail.com>
References: <20230731014406.22810-1-rauji.raut@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Jul 2023 18:44:06 -0700
Atul Raut <rauji.raut@gmail.com> wrote:

Patch title should mention the device

iio: accel: adxl367: ...


> Replacing zero-length arrays with C99 flexible-array
> members since they are obsolete.
> Use the new DECLARE_FLEX_ARRAY() auxiliary macro instead
> of defining a zero-length array.
> 
> This fixes warnings such as:
> ./drivers/iio/accel/adxl367_spi.c:38:6-17: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>

It isn't a variable length array so the heuristic that provided that warning is wrong.

It could be switched to a u8 but then the code would be slightly harder to read
as the functions it is being passed are typically used with arrays - this one just
happens to only be one element long.

Jonathan



> ---
>  drivers/iio/accel/adxl367_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
> index 118c894015a5..9dc61cb45fc5 100644
> --- a/drivers/iio/accel/adxl367_spi.c
> +++ b/drivers/iio/accel/adxl367_spi.c
> @@ -35,7 +35,7 @@ struct adxl367_spi_state {
>  	 */
>  	u8			reg_write_tx_buf[1] __aligned(IIO_DMA_MINALIGN);
>  	u8			reg_read_tx_buf[2];
> -	u8			fifo_tx_buf[1];
> +	DECLARE_FLEX_ARRAY(u8,			fifo_tx_buf);
>  };
>  
>  static int adxl367_read_fifo(void *context, __be16 *fifo_buf,

