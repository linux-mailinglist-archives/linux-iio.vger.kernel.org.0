Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B599326C738
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgIPSV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgIPSKo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:10:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47AB2083B;
        Wed, 16 Sep 2020 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600279827;
        bh=Ju+mDAYgGgYm5szp6plQMoO737lg/ofifEnvRT90SNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uigVu9nT/DR8STMbyQA9tMT/XkN6el3Pw15dPTt8xh/BbT/YlbLT2pDFr6UdeUYo0
         HbpOF80HJsVzvdniwdV2k9f1EtOg/eNVhYp8gLWbIR5hvLedQgUjzrboKXUgQNs/Is
         55NRPAOwYxB4o39VSGRCT1FcBTK+778DMRhEPGqA=
Date:   Wed, 16 Sep 2020 19:10:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] iio: adc: palmas_gpadc: use
 module_platform_driver to simplify the code
Message-ID: <20200916191026.56932e1c@archlinux>
In-Reply-To: <20200914065401.3726354-1-liushixin2@huawei.com>
References: <20200914065401.3726354-1-liushixin2@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Sep 2020 14:54:01 +0800
Liu Shixin <liushixin2@huawei.com> wrote:

> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 1ca6570be66a..889b88768b63 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -834,18 +834,7 @@ static struct platform_driver palmas_gpadc_driver = {
>  		.of_match_table = of_palmas_gpadc_match_tbl,
>  	},
>  };
> -
> -static int __init palmas_gpadc_init(void)
> -{
> -	return platform_driver_register(&palmas_gpadc_driver);
> -}
> -module_init(palmas_gpadc_init);
> -
> -static void __exit palmas_gpadc_exit(void)
> -{
> -	platform_driver_unregister(&palmas_gpadc_driver);
> -}
> -module_exit(palmas_gpadc_exit);
> +module_platform_driver(palmas_gpadc_driver);
>  
>  MODULE_DESCRIPTION("palmas GPADC driver");
>  MODULE_AUTHOR("Pradeep Goudagunta<pgoudagunta@nvidia.com>");

