Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6843B37B70A
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELHqV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHqV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 03:46:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90693C061574;
        Wed, 12 May 2021 00:45:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g14so25926284edy.6;
        Wed, 12 May 2021 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WqKbFi1zcT06ocFbBAnAZcAvyy09Fxb57wc82froFIk=;
        b=t6VE6y+eXUA0deIf7OOmOlR9KMXybIqSnMCv9l6s/HwvHP1i6v5lRKB9NW8QZZFPPY
         zPYAIAGOaEoQIwRPlB861nJ8EmP+Vqyn55U49PPVYDSzDfoFW5bNibMSQ0UTo8eyVlbz
         GGchffGgDQKXQr7tOma+86+kMFiRVIG7HNc5DBD5woNdZ71DR7eHPyh4JaqT7wVlTzZq
         7apDiU8VgC3OxX3Lqwv30GcpqAtnNGXHbGzdiOO0Nu/TTEpbgfWl67gHVpWTu1sr2/YR
         F6RvSynr3ce6pN40lgdN3oKse0Dw0+V0h+gcBAmm/sObkJZdaUEn1k2q4hYPC+ut9uLb
         FV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WqKbFi1zcT06ocFbBAnAZcAvyy09Fxb57wc82froFIk=;
        b=EDKjfdFiKDm5OCVudEaJrTa+6o+tjm+8NRpyCKKBKjkRyMs5hkeJ25Wj4iq6cvKs9y
         zRN27kTA1BeZnFek18Y84yvg6YdZdTAMjpD3JFTaqqsSGs7UmeKBywqGR9vJnc8LAkqg
         T+Ud1CAXz9M6N7NYStchvGQp5EK+QF7PGMbqVdXDP0jJAdtCJ06SfXuR+E+kvgFsyycH
         zUbGlBz8skURWW2Qdf65qKzI96dBKeGzEeKBcIDJVpN0wL2FwK3qCow4nkNpZ6/oKJlo
         KEeOGinbJMW6a91mOb8kAyKne1nvJMdjS52J0nRiVgWhjTpO8lW5Vmo1b9q+XFgQdEhZ
         8QPw==
X-Gm-Message-State: AOAM531wo7vkHn3yv3nklXCDialo46kYfyyDUN0SmwuDok6dY7yVla8c
        U2zdUtSG/lMYT7SCpRwyqoc=
X-Google-Smtp-Source: ABdhPJxR8SXu0XSUhDZsOCyAn0XAtiue+uZX2UQBu9BohSYTysGTeFAPxIsKoOX3+a4KV5/je/odEg==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr41640429edr.111.1620805512335;
        Wed, 12 May 2021 00:45:12 -0700 (PDT)
Received: from agape.jhs ([5.171.80.141])
        by smtp.gmail.com with ESMTPSA id y8sm4729219edo.90.2021.05.12.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:45:12 -0700 (PDT)
Date:   Wed, 12 May 2021 09:45:09 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7746: clean up driver comments
 and probe return
Message-ID: <20210512074508.GB1413@agape.jhs>
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
 <687a1923add71303da13e3a838e97a6ffc7dcda7.1620766020.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687a1923add71303da13e3a838e97a6ffc7dcda7.1620766020.git.lucas.p.stankus@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lucas,

On Tue, May 11, 2021 at 05:54:01PM -0300, Lucas Stankus wrote:
> Remove vague comments, align temperature comment with indent block and
> simplify probe return on device register.
> 
> Also fix the following checkpatch warning:
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index dfd71e99e872..e03d010b2f4c 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -84,10 +84,6 @@
>  #define AD7746_CAPDAC_DACEN		BIT(7)
>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>  
> -/*
> - * struct ad7746_chip_info - chip specific information
> - */
> -

Comment deletions should go in a separate patch


>  struct ad7746_chip_info {
>  	struct i2c_client *client;
>  	struct mutex lock; /* protect sensor state */
> @@ -232,13 +228,14 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  
>  		if (chip->capdac_set != chan->channel) {
>  			ret = i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACA,
> -				chip->capdac[chan->channel][0]);
> +							AD7746_REG_CAPDACA,
> +							chip->capdac[chan->channel][0]);
>  			if (ret < 0)
>  				return ret;
> +
>  			ret = i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACB,
> -				chip->capdac[chan->channel][1]);
> +							AD7746_REG_CAPDACB,
> +							chip->capdac[chan->channel][1]);
>  			if (ret < 0)
>  				return ret;

Alignments of function argument form a different logical change
and should go on a separate patch...
 
>  
> @@ -564,10 +561,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -		/*
> -		 * temperature in milli degrees Celsius
> -		 * T = ((*val / 2048) - 4096) * 1000
> -		 */
> +			/*
> +			 * temperature in milli degrees Celsius
> +			 * T = ((*val / 2048) - 4096) * 1000
> +			 */
>  			*val = (*val * 125) / 256;
>  			break;
>  		case IIO_VOLTAGE:
> @@ -669,10 +666,6 @@ static const struct iio_info ad7746_info = {
>  	.write_raw = ad7746_write_raw,
>  };
>  
> -/*
> - * device probe and remove
> - */
> -
>  static int ad7746_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -730,11 +723,7 @@ static int ad7746_probe(struct i2c_client *client,
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

this return value fix should go in a separate patch

>  
>  static const struct i2c_device_id ad7746_id[] = {
> -- 
> 2.31.1
> 
> 

so, in my opinion, this patch could be split
in three different patches.

Thank you,

fabio
