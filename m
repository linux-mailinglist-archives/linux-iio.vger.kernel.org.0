Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4B37C04A
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELOhu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhELOhu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:37:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D0DF60FEF;
        Wed, 12 May 2021 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620830202;
        bh=/ebaK6fTgqWgjsqS2iv3AmVEOg762ZZWqYsaZE9PlEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZfcdcBl9hf5Uon0nxN94JED79pFQzB6MR0WyLGZEXmeyI+5Jh+03lD7/zBFpnnG3
         j9ycN0yPm0jaU6SKRm8pPenmA9LWnLhNPHhaVbZGjhBdUBYcxW3ZzFDxzBH68SpMyk
         2yKo1Dk4F3imrRf2PB6mOJsbJWxHcmmj0VQ3y7s7puP/Xiw63GRlXiHYtq+0CF1XoU
         yCD4EdIOwQVqKiDzz+EYzJ7Xk8surIugu4nAKLUMxUr/2mYGCTgeH55kvhDKi/qILt
         XgH5GzLmXFG2pBj/V+3i7aqfyUQCbGgy/pdLr2bdrrrMjUzDqw3Qf/YNfpoZ4krG5O
         Mrl0+zHJtxPAA==
Date:   Wed, 12 May 2021 16:36:36 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH 21/28] iio: light: vcnl4000: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512163636.67a1ac15@coco.lan>
In-Reply-To: <20210509113354.660190-22-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-22-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:47 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/light/vcnl4000.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 4a61865d01cd..01772327a947 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -413,9 +413,7 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);



Thanks,
Mauro
