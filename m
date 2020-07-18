Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38CE224BE8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGROjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGROjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:39:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE5220684;
        Sat, 18 Jul 2020 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083154;
        bh=BnlatMn5uJqDSL7prgKupwRyysyX9jNEbeM2XXw8yYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ioEZ5jbR/U0zAmI+t1CmUie4Ch9ux5SZrWigH+ehVvJNABPrVuqAExPTkJ2BHt7OM
         KoMeCg+EK1wQJ27z/Dv0X2E0IN10S8aH1XgquPBrDEprxr0R3nkoBfo0HM0CwTv35u
         E8TXW+Q30AZ56DenzcjGwiXua7ZSHjN2WXa9pfCE=
Date:   Sat, 18 Jul 2020 15:39:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/30] iio: dummy: iio_simple_dummy: Demote unworthy
 kerneldocs and correct misspelling
Message-ID: <20200718153910.71fcdb36@archlinux>
In-Reply-To: <20200716135928.1456727-10-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-10-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:07 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> File header comments are not good candidates for kerneldoc.  Neither
> are generic comment blocks.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dummy/iio_simple_dummy.c:26: warning: cannot understand function prototype: 'const struct config_item_type iio_dummy_type = '
>  drivers/iio/dummy/iio_simple_dummy.c:564: warning: Function parameter or member 'name' not described in 'iio_dummy_probe'
>  drivers/iio/dummy/iio_simple_dummy.c:564: warning: Excess function parameter 'index' description in 'iio_dummy_probe'
>  drivers/iio/dummy/iio_simple_dummy.c:700: warning: cannot understand function prototype: 'const struct iio_sw_device_ops iio_dummy_device_ops = '
> 
Misspelling is an interesting way of describing that part.  I changed
it to "wrong parameter in docs".

Applied.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index 6cb02299a2152..be66b26373723 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (c) 2011 Jonathan Cameron
>   *
>   * A reference industrial I/O driver to illustrate the functionality available.
> @@ -553,7 +553,7 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
>  
>  /**
>   * iio_dummy_probe() - device instance probe
> - * @index: an id number for this instance.
> + * @name: name of this instance.
>   *
>   * Arguments are bus type specific.
>   * I2C: iio_dummy_probe(struct i2c_client *client,
> @@ -687,7 +687,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
>  
>  	return 0;
>  }
> -/**
> +/*
>   * module_iio_sw_device_driver() -  device driver registration
>   *
>   * Varies depending on bus type of the device. As there is no device

