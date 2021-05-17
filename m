Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8C383AE8
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhEQROj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 13:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235848AbhEQROi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 13:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E71861261;
        Mon, 17 May 2021 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271602;
        bh=LqxcP+iRytVRKoR8B0Oxj0Pc29HXawdIxiiLNmrB1wM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EJ/LjhI4ApufpBwUEoYcMb9b6pVXuljp5rIRKsBNvrdY/1eKO/ZmQ9vV0FEAww4lB
         KmiobiN7mUecp8TFeZOc5fflPVF4g9PdnPKFgPMHdn6spuPKEVV4mdc62AaEe5j0X9
         2/6HtZs9USJBCSX+gDJwTvMS8Xsw12CcfcL62tf51OIKLvyn7lLg3RuSXFtFNeGkio
         /2UXAAHnBliOuqcxHl+NvRkB4iRQYG0kYZaCuVH1JGOyRX6lRMWS/tJ4g+UabkHeet
         3NDAKEVIYrp/WA/BA50uYM3glVCCXfyHuE+0zQEcEndIG3aIx7xkiO9Pu/5eL1lh9n
         CPhRszRxQnrFg==
Subject: Re: [PATCH 4/4] iio: chemical: sgp30: Drop use of %hx in format
 string.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
References: <20210517125554.1463156-1-jic23@kernel.org>
 <20210517125554.1463156-5-jic23@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <d8f92d79-799e-3533-e075-ed92fec80c84@kernel.org>
Date:   Mon, 17 May 2021 10:13:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517125554.1463156-5-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/17/2021 5:55 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Since:
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]")
> use of these format strings has been discouraged.
> 
> As there are only a few such uses in IIO, lets clear them all out and
> avoid chance of them getting copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Andreas Brauchli <andreas.brauchli@sensirion.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   drivers/iio/chemical/sgp30.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index 1029c457be15..2343d444604d 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -425,7 +425,7 @@ static int sgp_check_compat(struct sgp_data *data,
>   
>   	product = SGP_VERS_PRODUCT(data);
>   	if (product != product_id) {
> -		dev_err(dev, "sensor reports a different product: 0x%04hx\n",
> +		dev_err(dev, "sensor reports a different product: 0x%04x\n",
>   			product);
>   		return -ENODEV;
>   	}
> 

