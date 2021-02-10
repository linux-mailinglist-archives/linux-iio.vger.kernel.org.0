Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB8316AF6
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhBJQR0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 11:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhBJQRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 11:17:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D038C061574;
        Wed, 10 Feb 2021 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=mNzO7j9/x5Yd7dEqVlt+vUta44uY5Ki9uTVGpYsuxWM=; b=bEoROgE/sWTyi7gJGxK8E3mEFh
        w+vu0JypURj+DUOCM+dwQHR35oYh5E8+oZq7Q4UqSvhpL33pD2/2PXxqom3pVQjsYaf0FQyJbhSDZ
        WfAI6Bs2rGgWJLmn2MMKBa4bRWv0CMCcM+G1LavtWQvvEBeZEMFH69xcctTplY0llkyKG9Ug51C5q
        TRESg9LkYJGEW0LXlFb0R3VifzaCsoPut2tPdjtNh4AzaKY0DMSxTacbpqQZ1p1jG19Bv+j7HV1yc
        2MSKaBcOm9yrh71N1FcT/qjQlg6bJGSwgSoet2+V0sk+1LLa0KEvE9/I8J7AkYCjCeb0CT51q4eIM
        +m7PtYTg==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9sAS-0006Am-AZ; Wed, 10 Feb 2021 16:16:40 +0000
Subject: Re: [PATCH] drivers: iio: proximity: Fix a spelling postive to
 positive in the file sx9500.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210085704.1228068-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b19d9d8e-206e-757f-46ab-5fa159a30a88@infradead.org>
Date:   Wed, 10 Feb 2021 08:16:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210085704.1228068-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/10/21 12:57 AM, Bhaskar Chowdhury wrote:
> 
> s/postive/positive/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/iio/proximity/sx9500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index acb821cbad46..67353d33af94 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -758,7 +758,7 @@ static const struct sx9500_reg_default sx9500_default_regs[] = {
>  		.reg = SX9500_REG_PROX_CTRL5,
>  		/*
>  		 * Debouncer off, lowest average negative filter,
> -		 * highest average postive filter.
> +		 * highest average positive filter.
>  		 */
>  		.def = 0x0f,
>  	},
> --


-- 
~Randy

