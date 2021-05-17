Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839DF386CC8
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbhEQWPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 18:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhEQWPh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 18:15:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDAC061573;
        Mon, 17 May 2021 15:14:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o27so7411603qkj.9;
        Mon, 17 May 2021 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8jZwx6c5i2SOaFzHODGVo8OGmNto4+v8Ypo2f4e070=;
        b=B6NKR/6TrH5w0WY/tpQ117wFdQ1QGUn5h2cexgAhLcgnRg/V/fXrRCcbMQVnd1Exmi
         FnFJvomRCg77isFSk1h7coNwVjO3VffU5VRldVU06AGwKHQPVMO+Zxep0QlCU/YFcQ8A
         CS+ZBfW6mDznrlAuT8EOExQ01dszzJVPXL/BiB7s/kHmNzAu+U78GHsR7ffv6ZgtMupG
         My+Ra9A78E64TweZKzEzVfHMM13GjysLtCsmCTglKN5F9Xhfy0X6LJTGEijPX3c1XSHM
         AJB+SXKPuIuMlyvFy9Lx/+e//1CHHObuL1NFvXXzm4A2V4BNEUA6AGCWh4SgsIN4MqQq
         ZNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8jZwx6c5i2SOaFzHODGVo8OGmNto4+v8Ypo2f4e070=;
        b=JDcZf+sVGnnv5njnXum2yDYH0zWfGAMkENqOTWi2ykKS3KNEGXmYeQ6OF/B7krRuhM
         fmOaer+Sd6gqNBYRg3tUFYArloQtROiQdxGIQWSg16MAS0e0TmjcPxOF2fPUlmHT9ERQ
         8rRBDGFGvJMyqnfzB1x52sWXAdFqiscj6vQACKeoSXrp/GECLk8+YDpI8vyT8eVA+Wq2
         k809HX/R+rDy7TJ7JOioGzE00oFaqGcu79y46ovKFniipeKehNbuF7PkNL3grp6MJWQM
         vmMS945tndvQuu/oYZdXSZzZe2A7TyizoNjkPhqA/vfPwAtxUqpzl5BBpHMLEQHHijsu
         U7iA==
X-Gm-Message-State: AOAM532KMAM3Ao90GZelJXEhcHAwnltSqUUqmqRJr7Iw2xSuZDA5nDFe
        JIjjGNZLd9ZgNmNYfO1IuJ4=
X-Google-Smtp-Source: ABdhPJwRSDs4C853GPKUkZ8M4SFnSZ3G0icrJVmKCKNMuG9Oh2gfgt347z8sbwc1os7nVBm3gKOaLw==
X-Received: by 2002:ae9:f50f:: with SMTP id o15mr2174586qkg.445.1621289659862;
        Mon, 17 May 2021 15:14:19 -0700 (PDT)
Received: from smtp.gmail.com ([2804:30c:b19:6700:15d6:7f1d:c87:ccf7])
        by smtp.gmail.com with ESMTPSA id i10sm11539253qko.68.2021.05.17.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:14:19 -0700 (PDT)
Date:   Mon, 17 May 2021 19:14:13 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lucas.p.stankus@gmail.com
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Fix unnecessary check and
 assignment in ad7746_probe()
Message-ID: <YKLqtc8cowOxUTid@smtp.gmail.com>
References: <20210517150006.8436-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517150006.8436-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Tang,

The patch looks overall good, though I think it could be split into two
pieces: one for simplifying ret declaration and another for removing the
check after device register.
Despite that, I guess Lucas might already be working on similar changes.
https://lore.kernel.org/linux-iio/cover.1620766020.git.lucas.p.stankus@gmail.com/

As general advice, I would recommend avoiding using generic words such
as fix in the subject line. It's often better to say something about the
nature of what is being done.


Cc: lucas.p.stankus@gmail.com


Best regards,

Marcelo

On 05/17, Tang Bin wrote:
> In the function ad7746_probe(), the return value of
> devm_iio_device_register() can be zero or ret, thus it is
> unnecessary to repeated check here. And delete unused
> initialized value of 'ret', because it will be assigned by
> the function i2c_smbus_write_byte_data().
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index dfd71e99e..d3b6e68df 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -680,7 +680,7 @@ static int ad7746_probe(struct i2c_client *client,
>  	struct ad7746_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned char regval = 0;
> -	int ret = 0;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
> @@ -730,11 +730,7 @@ static int ad7746_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
>  static const struct i2c_device_id ad7746_id[] = {
> -- 
> 2.20.1.windows.1
> 
> 
> 
