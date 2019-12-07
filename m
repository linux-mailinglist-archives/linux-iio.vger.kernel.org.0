Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5E115BCF
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLGKQ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKQ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:16:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5BF217BA;
        Sat,  7 Dec 2019 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575713818;
        bh=pUFQAu+qRh8xlQWteenzQT6oi7k9uNrR7iKBLQfQ3Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bJ9QlfDsizvVHA1ZDJqUm3iiIbU9pZpJbTw88UlkpL4aQKhA9b9u0VYfRTYU2epm+
         aBjNdkR+qpufiTciXEKibKI0Mz95+creq4/q3dy86+IhHFSSS3jbZVqDz86fp25KmI
         ghR/7DqlqRT1GENAryyt7m7qziVD2uUDjdm1RhBc=
Date:   Sat, 7 Dec 2019 10:16:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: atlas-ph-sensor: Drop GPIO include
Message-ID: <20191207101654.66c807cf@archlinux>
In-Reply-To: <20191202091837.82150-1-linus.walleij@linaro.org>
References: <20191202091837.82150-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 10:18:37 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The driver includes <linux/gpio.h> yet fails to use symbols
> from any the header so drop the include.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
+CC Matt

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to do something or other.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 6c175eb1c7a7..b7c20c74239b 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -14,7 +14,6 @@
>  #include <linux/err.h>
>  #include <linux/irq.h>
>  #include <linux/irq_work.h>
> -#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>

