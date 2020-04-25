Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5971B87A4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYQOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQOY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:14:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BC520704;
        Sat, 25 Apr 2020 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587831264;
        bh=jfnYc+S6PZPHEJ8hV216bfG0RLf7tzii15lAmToy2fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eh5XIWJQG+shyNP00JgBYuhwceLFLv1mLMVXMR9z2XbrBKmbjX+P2W1P4kJNxoDmt
         NM1pQ9Noulsl3RUIw/Eprd//3b4PWQGla4s0MHIBWoJds5dr2tbd8gYwzLEtUzTMey
         hnli4YNmlysO5mldP5hydwK6QHgEn+NQFeNpXLTs=
Date:   Sat, 25 Apr 2020 17:14:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 02/16] iio: adc: mpc3422: Use get_unaligned_beXX()
Message-ID: <20200425171420.5c46ac1a@archlinux>
In-Reply-To: <20200421003135.23060-2-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks good to me.

Applied

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index ea24d7c58b12..b247eb209f10 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -117,11 +117,11 @@ static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
>  
>  	if (sample_rate == MCP3422_SRATE_3) {
>  		ret = i2c_master_recv(adc->i2c, buf, 4);
> -		temp = buf[0] << 16 | buf[1] << 8 | buf[2];
> +		temp = get_unaligned_be24(&buf[0]);
>  		*config = buf[3];
>  	} else {
>  		ret = i2c_master_recv(adc->i2c, buf, 3);
> -		temp = buf[0] << 8 | buf[1];
> +		temp = get_unaligned_be16(&buf[0]);
>  		*config = buf[2];
>  	}
>  

