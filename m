Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C9CD025
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfJFJ5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJ5Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:57:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3034120867;
        Sun,  6 Oct 2019 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355835;
        bh=1mAeXC6xQdByjNElffMksG7pUEXmQ6BBlE4Xqu1qO78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HU0qlJDotgC18EXMonSdnt2A+LuvrLk2ZFoZL5vRTKQ8UObIP59PwqEG5np9uHBuv
         uJ1E8LIhNtq8z8JUW6Zhwvea8p9Ym53jrrnGDy30AErUioddxyMZITv+dmjls8zhIC
         WkG6FtBnD37NfeQ2kgkGN1M5LZZYcfrZSP6VQu+I=
Date:   Sun, 6 Oct 2019 10:57:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 3/4] iio: pressure: bmp280: remove stray newline
Message-ID: <20191006105711.3b118d70@archlinux>
In-Reply-To: <20191002085759.13337-4-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
        <20191002085759.13337-4-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 10:57:58 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove a stray newline from the probe callback.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing for
no particular reason (well for the other patches in that tree ;)

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f22400e1e98f..fdbd3bc27921 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1131,7 +1131,6 @@ int bmp280_common_probe(struct device *dev,
>  	if (ret)
>  		goto out_runtime_pm_disable;
>  
> -
>  	return 0;
>  
>  out_runtime_pm_disable:

