Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AB23E10A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgHFSkA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgHFS3z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:29:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243072310F;
        Thu,  6 Aug 2020 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738507;
        bh=yE/94/6VDakHTCtm8imxPfkBwiiI/cB0kOHagnGFESA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+AdTman6HMMXdvvzEJ2nA+c2im2TLB+s7J6CseSlWLlU0BFhyjwFqRQN+QL2I+wL
         SHcW/ByAYCz7L07c9Gw41aw6koB3dC44VNsmFeks8XS2E59MHQuuhylkfL73PDwj4p
         x0awvyM6J6M6SyuEJKaxxidu7K1ISoLE260M41lI=
Date:   Thu, 6 Aug 2020 19:28:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 04/15] iio: sx9310: Remove acpi and of table macros
Message-ID: <20200806192821.6452aba7@archlinux>
In-Reply-To: <20200803175559.v5.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Aug 2020 17:58:04 -0600
Daniel Campello <campello@chromium.org> wrote:

> Avoids unused warnings due to acpi/of table macros.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Applied,
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>  - Added #include <linux/mod_devicetable.h>
> 
>  drivers/iio/proximity/sx9310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index dafee85018aa6d..9daf2b8591a0a0 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -16,8 +16,8 @@
>  #include <linux/i2c.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -1049,8 +1049,8 @@ MODULE_DEVICE_TABLE(i2c, sx9310_id);
>  static struct i2c_driver sx9310_driver = {
>  	.driver = {
>  		.name	= "sx9310",
> -		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> -		.of_match_table = of_match_ptr(sx9310_of_match),
> +		.acpi_match_table = sx9310_acpi_match,
> +		.of_match_table = sx9310_of_match,
>  		.pm = &sx9310_pm_ops,
>  	},
>  	.probe		= sx9310_probe,

