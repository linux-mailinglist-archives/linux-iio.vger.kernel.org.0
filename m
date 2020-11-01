Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B4B2A1ED4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKAO7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 09:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgKAO7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 09:59:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C61C206DC;
        Sun,  1 Nov 2020 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604242758;
        bh=BXgwnRUohW65M9lp3X9i22MaoJ6RyKoO8qngPKKZikI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mtn/WXNgn2993SQPBqe8n0AzeJMlBeqr7MBNkOEEYmUPC79WuR6oouYNnqn3BeP2E
         +zThX+b225JUWleSGV4R/HZam8WQxdcUBw/BgqwY1Gbk8vi4yudswgPD2Xrisel7iO
         pb+DxLbP0xnpE72uGiz/I72RlWyEghwdzdYT8jho=
Date:   Sun, 1 Nov 2020 14:59:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: remove unneeded semicolon
Message-ID: <20201101145914.27179152@archlinux>
In-Reply-To: <20201031134506.2134698-1-trix@redhat.com>
References: <20201031134506.2134698-1-trix@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 06:45:06 -0700
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-regmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
> index 08c00ac32bda..da136dbadc8f 100644
> --- a/drivers/iio/pressure/bmp280-regmap.c
> +++ b/drivers/iio/pressure/bmp280-regmap.c
> @@ -13,7 +13,7 @@ static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
>  		return true;
>  	default:
>  		return false;
> -	};
> +	}
>  }
>  
>  static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
> @@ -51,7 +51,7 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
>  		return true;
>  	default:
>  		return false;
> -	};
> +	}
>  }
>  
>  static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)

