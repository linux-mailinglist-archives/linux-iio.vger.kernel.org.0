Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31091309C48
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhAaNA6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 08:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231818AbhAaMcD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 07:32:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6269164E25;
        Sun, 31 Jan 2021 12:31:13 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:31:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     zuoqilin1@163.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] iio: fix typo
Message-ID: <20210131123110.5390bf64@archlinux>
In-Reply-To: <20210128021905.963-1-zuoqilin1@163.com>
References: <20210128021905.963-1-zuoqilin1@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Jan 2021 10:19:05 +0800
zuoqilin1@163.com wrote:

> From: zuoqilin <zuoqilin@yulong.com>
> 
> change 'regster' to 'register'
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
Applied.

thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5791.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index e3ffa4b..615d72c 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -76,7 +76,7 @@ struct ad5791_chip_info {
>   * @chip_info:		chip model specific constants
>   * @vref_mv:		actual reference voltage used
>   * @vref_neg_mv:	voltage of the negative supply
> - * @ctrl:		control regster cache
> + * @ctrl:		control register cache
>   * @pwr_down_mode:	current power down mode
>   * @pwr_down:		true if device is powered down
>   * @data:		spi transfer buffers

