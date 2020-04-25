Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB601B87CA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDYQvr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgDYQvr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:51:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBD1206CD;
        Sat, 25 Apr 2020 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833506;
        bh=7GRAx/g366b6Vsknm4p+ouudygM4owQ/ZTVAfffvD+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CpGn03NCLUp2Xz58JM1N4adrQbiza1/SH4xukNOX23nt+k41PH3ZPC90k+8NwwUKq
         CLLXA/JjzbWfHK2TBvADzOK7UGKwtXDmtxWf2srkZer/ThgD60lQkHYUfQj4EM0+Do
         rR7mB7gc8OzRNshhgEoxjr5KfcGgz9gH0f8f0zqs=
Date:   Sat, 25 Apr 2020 17:51:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 15/16] iio: temperature: max31856: Use
 get_unaligned_beXX()
Message-ID: <20200425175143.01b7c933@archlinux>
In-Reply-To: <20200421003135.23060-15-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-15-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:34 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Added missing header and applied,

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index b4cb21ab2e85..e1966889a962 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -168,7 +168,7 @@ static int max31856_thermocouple_read(struct max31856_data *data,
>  		if (ret)
>  			return ret;
>  		/* Skip last 5 dead bits of LTCBL */
> -		*val = (reg_val[0] << 16 | reg_val[1] << 8 | reg_val[2]) >> 5;
> +		*val = get_unaligned_be24(&reg_val[0]) >> 5;
>  		/* Check 7th bit of LTCBH reg. value for sign*/
>  		if (reg_val[0] & 0x80)
>  			*val -= 0x80000;
> @@ -185,7 +185,7 @@ static int max31856_thermocouple_read(struct max31856_data *data,
>  		/* Get Cold Junction Temp. offset register value */
>  		offset_cjto = reg_val[0];
>  		/* Get CJTH and CJTL value and skip last 2 dead bits of CJTL */
> -		*val = (reg_val[1] << 8 | reg_val[2]) >> 2;
> +		*val = get_unaligned_be16(&reg_val[1]) >> 2;
>  		/* As per datasheet add offset into CJTH and CJTL */
>  		*val += offset_cjto;
>  		/* Check 7th bit of CJTH reg. value for sign */

