Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78409452384
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 02:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350747AbhKPB04 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 20:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbhKOTIK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 14:08:10 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD438C06EDE1;
        Mon, 15 Nov 2021 09:58:21 -0800 (PST)
Received: from [2a04:4540:1401:b700:606b:3eee:8c1b:a587]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1mmgF6-0005a6-Ay; Mon, 15 Nov 2021 18:58:08 +0100
Message-ID: <4342c4de-b516-8992-a3f3-4eea7ff4de40@phrozen.org>
Date:   Mon, 15 Nov 2021 18:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] mips: lantiq: add support for clk_get_parent()
Content-Language: en-GB
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20211115012051.16302-1-rdunlap@infradead.org>
From:   John Crispin <john@phrozen.org>
In-Reply-To: <20211115012051.16302-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 15.11.21 02:20, Randy Dunlap wrote:
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

Acked-by: John Crispin <john@phrozen.org>

// we added the same fix for mips/ralink a while back

> ---
>   arch/mips/lantiq/clk.c |    6 ++++++
>   1 file changed, 6 insertions(+)
> 
> --- linux-next-20211112.orig/arch/mips/lantiq/clk.c
> +++ linux-next-20211112/arch/mips/lantiq/clk.c
> @@ -158,6 +158,12 @@ void clk_deactivate(struct clk *clk)
>   }
>   EXPORT_SYMBOL(clk_deactivate);
>   
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +
>   static inline u32 get_counter_resolution(void)
>   {
>   	u32 res;
> 
