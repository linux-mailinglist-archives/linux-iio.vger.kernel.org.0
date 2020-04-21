Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379CE1B21CD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgDUIiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 04:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUIiG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 04:38:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D1EC061A0F
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2020 01:38:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so13097534ljg.5
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2020 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4dAO+j83mgD+UmslV03QfImVAB/uyBGYdCJ8uFcCa+0=;
        b=Iqa3v6iEK/vf1OCaiees6fAtqxd4Zr9U2KRCS/UOTrXeWozCprYWq+PmZV4eMXUjtc
         17aDzNxmamQLayogoTjZ0JcEx59yJeE3zlGeJ1oYN0SMjEuIQqQcMqpApwhI5t4nNdJS
         SeOMdWmK7FXgOcJ8XIGq+ue2Z9U/N9epfyB3T/uULXgVcrVI9ab41UeMOlbHPXgJ5HNR
         Y+JGFz7zGFqQQOF8BBC9NyASkT5eATBg5iedZ5JDF1BPBZEiGamc5Cgt1Cc3s0SRdKEN
         IleDzJ5w2cRgAAk/qBc0X0KKrsXHqpPrL2c3uIHi61BjuBYfJzgLA+Sc5WCaV2DKkLtD
         IvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dAO+j83mgD+UmslV03QfImVAB/uyBGYdCJ8uFcCa+0=;
        b=pRv/KkX753rf5I6DZoLi0XGrDx6PvzBiQm/4HYWkOgIbffuYPWRyerE4zkbqwsGQZN
         d8ywK5KidP+X58+V9vWqe+qFcWaP2e0KQmyp/hzpNJebbTz5dsz6Yui1dDpq/KoDpSIz
         g98uwkoLpJlPJyM3SknMnpG8ZwMuiPtRlw+Qif7sC8ezzXec/Vz0QdfnPwF0o0qrOvoN
         bV4RFBa12wvZoeGdWQhBFTkrfjCd7XPBAzNf75kbrPVDftSERwIcflwjgsMMhU+uRahN
         jM5v98j5uhdaSVaIJ+bS+63kzc5ayN3Ox+YEuRxsBVj2fLoxalES2agjVJHXSH1ddY7r
         5rcg==
X-Gm-Message-State: AGi0PubUrUn5I7E5oIFqPl0DL9Tkwomn6CF1237Nvx+CMKuAUd2c9oFR
        hZjNwinq/emzAFJLe1qKihv3pYvN
X-Google-Smtp-Source: APiQypKEtQA7ZxWcEhEzKk4EgwNMgjaUipSh4SfvOY5108JxPzaaWmwNGyqpGf6Yr42N9u0U086dNw==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr12666300ljn.151.1587458284027;
        Tue, 21 Apr 2020 01:38:04 -0700 (PDT)
Received: from localhost (89-70-31-203.dynamic.chello.pl. [89.70.31.203])
        by smtp.gmail.com with ESMTPSA id 130sm1551590lfo.42.2020.04.21.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:38:03 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:36:45 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 13/16] iio: pressure: ms5611: Use get_unaligned_be24()
Message-ID: <20200421083645.GA23009@arch>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
 <20200421003135.23060-13-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421003135.23060-13-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 21, 2020 at 03:31:32AM +0300, Andy Shevchenko wrote:
> This makes the driver code slightly easier to read.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/pressure/ms5611_i2c.c | 2 +-
>  drivers/iio/pressure/ms5611_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 8089c59adce5..ced83162ae94 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -50,7 +50,7 @@ static int ms5611_i2c_read_adc(struct ms5611_state *st, s32 *val)
>  	if (ret < 0)
>  		return ret;
>
> -	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
> +	*val = get_unaligned_be24(&buf[0]);
>
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index b463eaa799ab..517295616869 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -45,7 +45,7 @@ static int ms5611_spi_read_adc(struct device *dev, s32 *val)
>  	if (ret < 0)
>  		return ret;
>
> -	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
> +	*val = get_unaligned_be24(&buf[0]);
>
>  	return 0;
>  }

Looks good.
Acked-by: Tomasz Duszynski <tduszyns@gmail.com>

> --
> 2.26.1
>
