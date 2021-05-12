Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92437BE51
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELNhT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhELNhR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A08C613DA;
        Wed, 12 May 2021 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620826568;
        bh=IWZVvgBx3j7K8GWviGoztvAzsheerKNafMdt9ZDKe9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KddmOLsT4uN+dWt8Eoso3Pbzk9bjHom0623lZ48XJ3tIhbboUv3Mw6MgpS6rtWNwz
         dnKEwhwvaF4vUXA4vri5ZJcOevra2aU1zYnUFNE8tezomdVlDlX4lww6D3B+KYjGnb
         uy6fGAp15QMABg9kPFXomV1n07B17qxhm8B5aHIVOZhlVx6lgzDfeax3RAZMhglSti
         knerGnE78TnwVkcEDRkV8Z7GsKifRU1cTDNiDfjPK9mdM4z7CbuUrtljSoO0QxU00Y
         TENoGsSKKMK075BN3YymCyIRueSQVTjqTXsO++Pu/lYRl3JG8r2Q8SzwH8JhYct2Uw
         jMzH0tCxW3cMw==
Date:   Wed, 12 May 2021 15:36:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 04/28] iio: accel: bmc150-accel: Balanced runtime pm +
 use pm_runtime_resume_and_get()
Message-ID: <20210512153603.6790f26c@coco.lan>
In-Reply-To: <20210509113354.660190-5-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-5-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:30 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A call to pm_runtime_put_noidle() doesn't match any call that would
> result in a get().  It is safe because runtime pm core protects against
> the reference counter going 0, but it makes it harder to understand the
> code.
> 
> Whilst here use pm_runtime_resume_and_get() to tidy things up.
> The Coccinelle script didn't get this one due to more complex code
> structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> ---
>  drivers/iio/accel/bmc150-accel-core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 62a164a7b852..43cfadf8f6b7 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -389,7 +389,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
> @@ -398,9 +398,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	if (ret < 0) {
>  		dev_err(dev,
>  			"Failed: %s for %d\n", __func__, on);
> -		if (on)
> -			pm_runtime_put_noidle(dev);
> -
>  		return ret;
>  	}
>  
> @@ -1836,7 +1833,6 @@ int bmc150_accel_core_remove(struct device *dev)
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
>  
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  



Thanks,
Mauro
