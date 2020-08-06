Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0623DEFC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgHFRfz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 13:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbgHFRfy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 13:35:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954B9206B2;
        Thu,  6 Aug 2020 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596735354;
        bh=TyTUr8q/1rKhjHP8vq95a6iw2Ddg2Upyx6KD5BB0oeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CB1BRjQmgUGmP7ogwWNci2gblbDxBeFXYlJEgf8F+U0T+ZNTb5qeK9+nTG/dsq2KP
         5E7EduU8x5H+wYTRJ8c8LwlaSuU2yBozMd3BV3FKPu1DIJ2IOP+hu2VgI9Lu1SfKSS
         ZVhh/6QJeCvkZoMP+OWvOIooJ2fPusOcoROdfhXk=
Date:   Thu, 6 Aug 2020 18:35:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Calvin Glisson <taragaram@gmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad9834: Remove excess blank line
Message-ID: <20200806183549.46c67d94@archlinux>
In-Reply-To: <20200805222300.GA5402@ougon.homenetwork>
References: <20200805222300.GA5402@ougon.homenetwork>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Aug 2020 15:23:00 -0700
Calvin Glisson <taragaram@gmail.com> wrote:

> Remove excess blank line after variable declarations.
> Improves code consistency and readability.
> Change suggested by checkpatch.pl:
> 
> CHECK: Please don't use multiple blank lines
> 
> Signed-off-by: Calvin Glisson <taragaram@gmail.com>
Applied

> ---
>  drivers/staging/iio/frequency/ad9834.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 77f77a2b2e05..262c3590e64e 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -397,7 +397,6 @@ static int ad9834_probe(struct spi_device *spi)
>  	struct regulator *reg;
>  	int ret;
>  
> -
>  	reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(reg))
>  		return PTR_ERR(reg);

