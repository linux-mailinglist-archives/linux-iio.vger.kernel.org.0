Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9582A2041
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 18:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKARS5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 12:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgKARS5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 12:18:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D1672231B;
        Sun,  1 Nov 2020 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604251137;
        bh=28ZgFZ2e7I73dUakYFgA4OWNUtWnzpOj8zQaurp8opk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSDbd6u7wOqPf6LMPHcWMSkIsx9Ac1jm4qWWQVbKN5NXm3i25wLfZV5yc5OCpz1su
         1qK0Zg+TVeYUvbFJNPYM5QxXqGrm25PvQ65QFd7rgAOM9CN6jcdE84jzT4PPgVE14V
         bL6p53ALPgsEQ0kJRkrfFHNGdXPuR9wu0ZUFOMz8=
Date:   Sun, 1 Nov 2020 17:18:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter/ti-eqep: Fix regmap max_register
Message-ID: <20201101171852.18162aaa@archlinux>
In-Reply-To: <20201025165122.607866-1-david@lechnology.com>
References: <20201025165122.607866-1-david@lechnology.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 25 Oct 2020 11:51:22 -0500
David Lechner <david@lechnology.com> wrote:

> The values given were the offset of the register after the last
> register instead of the actual last register in each range. Fix
> by using the correct last register of each range.
> 
> Fixes: f213729f6796 ("counter: new TI eQEP driver")
> Signed-off-by: David Lechner <david@lechnology.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> 
> v2 changes:
> * add Fixes: tag
> * picked up Acked-by:
> 
>  drivers/counter/ti-eqep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 1ff07faef27f..5d6470968d2c 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -368,7 +368,7 @@ static const struct regmap_config ti_eqep_regmap32_config = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> -	.max_register = 0x24,
> +	.max_register = QUPRD,
>  };
>  
>  static const struct regmap_config ti_eqep_regmap16_config = {
> @@ -376,7 +376,7 @@ static const struct regmap_config ti_eqep_regmap16_config = {
>  	.reg_bits = 16,
>  	.val_bits = 16,
>  	.reg_stride = 2,
> -	.max_register = 0x1e,
> +	.max_register = QCPRDLAT,
>  };
>  
>  static int ti_eqep_probe(struct platform_device *pdev)

