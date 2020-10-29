Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91829EEEB
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgJ2O5S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 10:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbgJ2O5S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 10:57:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B0C206D4;
        Thu, 29 Oct 2020 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603983438;
        bh=5QzBK8DTW+z96CqxRCFoLaWtzoKxTYO2qsUrnBjJlcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1zltunWSFuHEmQFfCXRUiSO1axqiZvjahT7jSpPOA1SzN8B6E9kIwWMAc9Fy6hDfs
         KaQjh3TfjVebr/8lV/I/Ii2yvJWzQRuTLU1m9RPCStmZD5JFxXBKKbFNoQtEjWSTaJ
         0kUpeQ6Y9w8ujS9O2Ye2939R2AjnM+YMukP8s49c=
Date:   Thu, 29 Oct 2020 14:57:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     eugen.hristev@microchip.com, lars@metafoo.de, pmeerw@pmeerw.net,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: remove unneeded semicolon
Message-ID: <20201029145708.3479fd28@archlinux>
In-Reply-To: <20201027200853.1596699-1-trix@redhat.com>
References: <20201027200853.1596699-1-trix@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Oct 2020 13:08:53 -0700
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Applied.

Thanks,
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index b917a4714a9c..56cb9a8521be 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1472,7 +1472,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  		return 0;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
>  }
>  
>  static void at91_adc_dma_init(struct platform_device *pdev)

