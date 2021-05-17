Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928E9383AA6
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhEQRBt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 13:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236776AbhEQRBs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 13:01:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59CE861185;
        Mon, 17 May 2021 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621270831;
        bh=kvGcl1jg3vnyaJfsKuv2eV98xymBY/ABPqrDZtVJyB0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fVIGHOZTsQlYUQcszg6S9WnyLGe/yOvjdGqEr+zql+eoc3CgrQsysU+vKdNpHskPz
         um7AmYYCfcVkq+FDzxISBJn1ql1aR8BQJJZanZU+EQEYhALjlicRl64NIL68FGrTeE
         CCIN29uEjNYJw6CwHyB1nQwJK7ZTnFOz+Jv/tq7LlYLXKoTqryDxopH4RmJnbmiVla
         g+5XdDNyz35v1N2WWwnxys/JPFuiFcjFurjYfxsmU1Qh7CA8Rx6fr5Noas1x3msU8I
         4eLBOopLtbdEx/26TwQXFtFuxGXFZMFI0YQLQfSlpv10IT0N0hX2FJkSm/hmMaZX8b
         NiRi52/++rrEw==
Subject: Re: [PATCH 1/4] iio: imu: inv_mpu6050: Drop use of %hhx format
 string.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210517125554.1463156-1-jic23@kernel.org>
 <20210517125554.1463156-2-jic23@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <f4ef58eb-b9dd-e53b-c5d1-fec3137483eb@kernel.org>
Date:   Mon, 17 May 2021 10:00:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517125554.1463156-2-jic23@kernel.org>
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
> Part of a series removing all uses from IIO in the interestings of
> avoiding providing bad examples for people to copy.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 6244a07048df..3169d3153b83 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1314,8 +1314,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>   		for (i = 0; i < INV_NUM_PARTS; ++i) {
>   			if (regval == hw_info[i].whoami) {
>   				dev_warn(regmap_get_device(st->map),
> -					"whoami mismatch got %#02x (%s)"
> -					"expected %#02hhx (%s)\n",
> +					"whoami mismatch got %#02x (%s) expected %#02x (%s)\n",
>   					regval, hw_info[i].name,
>   					st->hw->whoami, st->hw->name);
>   				break;
> @@ -1323,7 +1322,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>   		}
>   		if (i >= INV_NUM_PARTS) {
>   			dev_err(regmap_get_device(st->map),
> -				"invalid whoami %#02x expected %#02hhx (%s)\n",
> +				"invalid whoami %#02x expected %#02x (%s)\n",
>   				regval, st->hw->whoami, st->hw->name);
>   			return -ENODEV;
>   		}
> 

