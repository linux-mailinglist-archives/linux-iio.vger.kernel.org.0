Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2A420247
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhJCPfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhJCPfW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:35:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505CC61A3A;
        Sun,  3 Oct 2021 15:33:33 +0000 (UTC)
Date:   Sun, 3 Oct 2021 16:37:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: chemical: SENSEAIR_SUNRISE_CO2 depends on
 I2C
Message-ID: <20211003163731.289a5991@jic23-huawei>
In-Reply-To: <20211002232803.5108-1-rdunlap@infradead.org>
References: <20211002232803.5108-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Oct 2021 16:28:03 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix kconfig symbol dependency warning:
> 
> WARNING: unmet direct dependencies detected for REGMAP_I2C
>   Depends on [n]: I2C [=n]
>   Selected by [y]:
>   - SENSEAIR_SUNRISE_CO2 [=y] && IIO [=y]
> 
> Fixes: c3253a3fdc77 ("iio: chemical: Add Senseair Sunrise 006-0-007 drive")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-iio@vger.kernel.org

Thanks.  Applied to the togreg branch of iio.git.  I'll push that out
as testing for 0-day to run it's usual santity checks then push it out
for next to pick up.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20211001.orig/drivers/iio/chemical/Kconfig
> +++ linux-next-20211001/drivers/iio/chemical/Kconfig
> @@ -172,6 +172,7 @@ config SPS30_SERIAL
>  
>  config SENSEAIR_SUNRISE_CO2
>  	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> +	depends on I2C
>  	select REGMAP_I2C
>  	help
>  	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2

