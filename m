Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0057ED55B1
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfJMKwE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 06:52:04 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42879 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMKwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 06:52:03 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A8ED430000CC7;
        Sun, 13 Oct 2019 12:52:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7EDD22E7DAE; Sun, 13 Oct 2019 12:52:01 +0200 (CEST)
Date:   Sun, 13 Oct 2019 12:52:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc:mcp320x: Tidy up endian types in type cast.
Message-ID: <20191013105201.waluu7myfn7bcmmn@wunner.de>
References: <20191013090542.1375572-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013090542.1375572-1-jic23@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 10:05:42AM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fixes the sparse warning:
> drivers/iio/adc/mcp320x.c:167:41: warning: incorrect type in argument 1 (different base types)
> drivers/iio/adc/mcp320x.c:167:41:    expected restricted __be32 const [usertype] *p
> drivers/iio/adc/mcp320x.c:167:41:    got unsigned int [usertype] *<noident>
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas


> ---
>  drivers/iio/adc/mcp320x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 38bf10085696..465c7625a55a 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -164,7 +164,7 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  	case mcp3550_60:
>  	case mcp3551:
>  	case mcp3553: {
> -		u32 raw = be32_to_cpup((u32 *)adc->rx_buf);
> +		u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
>  
>  		if (!(adc->spi->mode & SPI_CPOL))
>  			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
> -- 
> 2.23.0
