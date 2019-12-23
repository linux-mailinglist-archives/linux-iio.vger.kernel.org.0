Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F103C12989B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWQQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfLWQQC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:16:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FAB20709;
        Mon, 23 Dec 2019 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577117761;
        bh=zrI6qq61ESbOwIWnyCWKCMQ99GjUjlnLpRmvl9ZFF9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q5k2+j09jliCXwnbM+xO/9UARoxBUfjuYZSt9V1U6BkZkRPdPD6/GNx4KXaAqJ4UR
         yx+OYg1Kr/pz2Za9C/LBu6kGz/DWmkbBXIvCLgpWFZpuxZeEpqUCS0aSbZ1Or9/Xb7
         SZ87/XV/APccRkbnvJzoMFnIo+S7gcgfmOiVCt40=
Date:   Mon, 23 Dec 2019 16:15:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/9] iio: light: st_uvis25: Drop unneeded header
 inclusion
Message-ID: <20191223161556.7016498f@archlinux>
In-Reply-To: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 19:38:45 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no evidence that the driver supports or needs ACPI APIs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/light/st_uvis25_i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
> index dacbac6a6662..4889bbeb0c73 100644
> --- a/drivers/iio/light/st_uvis25_i2c.c
> +++ b/drivers/iio/light/st_uvis25_i2c.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/regmap.h>

