Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830451A5DEF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDLKAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 06:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLKAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:00:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BBB206DA;
        Sun, 12 Apr 2020 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586685633;
        bh=DiVkzZNd9n/tfy3LeFZlnUenRZDPc3lnjjjY+IbeVWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0yglTGFxm5cYzae5V2eVokB6x2GZMQQMrbKhiRufFvQJeizSt/taN30+NtbnzLJRk
         hGgrPmc/LDW5rVEH4/pGUZNKaaTPu+b0A+ReIybpgpFPn1Hql5puaYF9/rTewCVf37
         8geZ+aGOf08pW0ziqu6eK6ESbY/e9G0zBjKfyXM8=
Date:   Sun, 12 Apr 2020 11:00:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alexandru.ardelean@analog.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis: Add a missing '\n' in a log message
Message-ID: <20200412110005.79af5069@archlinux>
In-Reply-To: <20200410171224.4633-1-christophe.jaillet@wanadoo.fr>
References: <20200410171224.4633-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 19:12:24 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> Fixes: 1fd456702692 ("iio: imu: adis: add support product ID check in adis_initial_startup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index a8afd01de4f3..2e7d0d337f8f 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -419,7 +419,7 @@ int __adis_initial_startup(struct adis *adis)
>  
>  	if (prod_id != adis->data->prod_id)
>  		dev_warn(&adis->spi->dev,
> -			 "Device ID(%u) and product ID(%u) do not match.",
> +			 "Device ID(%u) and product ID(%u) do not match.\n",
>  			 adis->data->prod_id, prod_id);
>  
>  	return 0;

