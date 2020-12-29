Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE302E7287
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2RON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2RON (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:14:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801AE21D94;
        Tue, 29 Dec 2020 17:13:31 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:13:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4350: Remove redundant null check
 before clk_disable_unprepare
Message-ID: <20201229171328.7f0e298d@archlinux>
In-Reply-To: <20201218094647.1386-1-vulab@iscas.ac.cn>
References: <20201218094647.1386-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Dec 2020 09:46:47 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to see if they can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/adf4350.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 82c050a3899d..1462a6a5bc6d 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -582,8 +582,7 @@ static int adf4350_probe(struct spi_device *spi)
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
>  error_disable_clk:
> -	if (clk)
> -		clk_disable_unprepare(clk);
> +	clk_disable_unprepare(clk);
>  
>  	return ret;
>  }
> @@ -599,8 +598,7 @@ static int adf4350_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	if (st->clk)
> -		clk_disable_unprepare(st->clk);
> +	clk_disable_unprepare(st->clk);
>  
>  	if (!IS_ERR(reg))
>  		regulator_disable(reg);

