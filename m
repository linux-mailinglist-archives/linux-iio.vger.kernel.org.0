Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC087391D69
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhEZRAX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 13:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233648AbhEZRAX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 May 2021 13:00:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87650613E1;
        Wed, 26 May 2021 16:58:49 +0000 (UTC)
Date:   Wed, 26 May 2021 18:00:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] iio: dummy: Fix build error when
 CONFIG_IIO_TRIGGERED_BUFFER is not set
Message-ID: <20210526180018.66ac9989@jic23-huawei>
In-Reply-To: <20210524140536.116224-1-weiyongjun1@huawei.com>
References: <20210524140536.116224-1-weiyongjun1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 May 2021 14:05:36 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Gcc reports build error when CONFIG_IIO_TRIGGERED_BUFFER is not set:
> 
> riscv64-linux-gnu-ld: drivers/iio/dummy/iio_simple_dummy_buffer.o: in function `iio_simple_dummy_configure_buffer':
> iio_simple_dummy_buffer.c:(.text+0x2b0): undefined reference to `iio_triggered_buffer_setup_ext'
> riscv64-linux-gnu-ld: drivers/iio/dummy/iio_simple_dummy_buffer.o: in function `.L0 ':
> iio_simple_dummy_buffer.c:(.text+0x2fc): undefined reference to `iio_triggered_buffer_cleanup'
> 
> Fix it by select IIO_TRIGGERED_BUFFER for config IIO_SIMPLE_DUMMY_BUFFER.
> 
> Fixes: 738f6ba11800 ("iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks,

Applied to the fixes-togreg branch of iio.git.

Jonathan

> ---
>  drivers/iio/dummy/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
> index 5c5c2f8c55f3..1f46cb9e51b7 100644
> --- a/drivers/iio/dummy/Kconfig
> +++ b/drivers/iio/dummy/Kconfig
> @@ -34,6 +34,7 @@ config IIO_SIMPLE_DUMMY_BUFFER
>  	select IIO_BUFFER
>  	select IIO_TRIGGER
>  	select IIO_KFIFO_BUF
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Add buffered data capture to the simple dummy driver.
>  
> 

