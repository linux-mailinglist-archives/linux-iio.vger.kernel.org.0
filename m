Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4EECCB55
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfJEQlw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfJEQlw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:41:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0FD22475;
        Sat,  5 Oct 2019 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570293711;
        bh=AwMvo+txXHzmVFqM/xX4gaVSix9svT/NKLkxdiIkruc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y06ZWAprxYidmV2WmdmRL0tJUXsnUzF4T4RDgJRm2L5S9JeiATYHJePEE/967JPU3
         xOyZ4jV1Ukf38MTihKhXVRvzKRjKmCXO0XaC+v0dxZ/yC1865wvDOIHNISOAdZVkXJ
         QFHN6kzLP4D2ov5wjlYEKUgk3RftGfMJi/2f1Wmg=
Date:   Sat, 5 Oct 2019 17:41:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: Fix an undefied reference error in noa1305_probe
Message-ID: <20191005174146.6ae6c528@archlinux>
In-Reply-To: <1569204272-20365-1-git-send-email-zhongjiang@huawei.com>
References: <1569204272-20365-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Sep 2019 10:04:32 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> I hit the following error when compile the kernel.
> 
> drivers/iio/light/noa1305.o: In function `noa1305_probe':
> noa1305.c:(.text+0x65): undefined reference to `__devm_regmap_init_i2c'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 08d7e1e..4a1a883 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -314,6 +314,7 @@ config MAX44009
>  config NOA1305
>  	tristate "ON Semiconductor NOA1305 ambient light sensor"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	 Say Y here if you want to build support for the ON Semiconductor
>  	 NOA1305 ambient light sensor.

