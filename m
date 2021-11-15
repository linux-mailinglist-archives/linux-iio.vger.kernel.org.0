Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B173A450D68
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhKOR5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 12:57:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4097 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbhKORyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 12:54:53 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HtGrD5MLtz67VcZ;
        Tue, 16 Nov 2021 01:48:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 18:51:54 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 15 Nov
 2021 17:51:53 +0000
Date:   Mon, 15 Nov 2021 17:51:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        <linux-mips@vger.kernel.org>, John Crispin <john@phrozen.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mips: lantiq: add support for clk_get_parent()
Message-ID: <20211115175152.000030d6@Huawei.com>
In-Reply-To: <20211115012051.16302-1-rdunlap@infradead.org>
References: <20211115012051.16302-1-rdunlap@infradead.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Nov 2021 17:20:51 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Provide a simple implementation of clk_get_parent() in the
> lantiq subarch so that callers of it will build without errors.
> 
> Fixes this build error:
> ERROR: modpost: "clk_get_parent" [drivers/iio/adc/ingenic-adc.ko] undefined!
> 
> Fixes: 171bb2f19ed6 ("MIPS: Lantiq: Add initial support for Lantiq SoCs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Cc: linux-mips@vger.kernel.org
> Cc: John Crispin <john@phrozen.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for tidying this up.

Jonathan

> ---
>  arch/mips/lantiq/clk.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20211112.orig/arch/mips/lantiq/clk.c
> +++ linux-next-20211112/arch/mips/lantiq/clk.c
> @@ -158,6 +158,12 @@ void clk_deactivate(struct clk *clk)
>  }
>  EXPORT_SYMBOL(clk_deactivate);
>  
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +
>  static inline u32 get_counter_resolution(void)
>  {
>  	u32 res;

