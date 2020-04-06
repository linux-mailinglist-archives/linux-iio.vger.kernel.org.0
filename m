Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC77F19F670
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgDFNIU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 09:08:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41852 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgDFNIU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 09:08:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id d24so5883268pll.8
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2020 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1o4gaBgpPeWl/lKYWr3kiJTV7bXRiAZ0S2t8VEJHdw4=;
        b=li5xCr1k3GEGhtxErghBoY23iQHYazmG5QOBN8owoRPV4WClcBUcUin3hIP6Lc1Ofd
         pcUAVHHLfX2rlA8FPtpB1ECMTPlc1Q8D4emjujTNUuamGP99/zEfIXo5clGzS4UnJIld
         7Mav/0t98lzHK7STzimY9FHRiVr9/uxBn3tqwTlsHFNyb7IFFoF+uFi5bUTpGLbIg7EU
         03BTQMi834udph9wB+XJ+HW44y6QEqmny4cv5DZ0qgfIraI48191NkD6miLlKyUK3fFi
         exhz3EI53Z1tel15GLJPz9cNaFzZsKjUufO2FgdUFSRi3stETc7SnvfXPV+cb1Sm+Z8R
         XXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1o4gaBgpPeWl/lKYWr3kiJTV7bXRiAZ0S2t8VEJHdw4=;
        b=bjAcycCDMc04xbTjdx8iyB6+W41jaGRM1Ghq7NBnjrNO+3WRU1LVPXM14lrYQ36d/K
         r+CvgLNaEsEOZZxlWetvbG1OQrvLNRWE0WO3csgfKXRhnGKMJTI+Py9WXbmjmda+TN/6
         L/7i7Im0Glmy77TTmOl9PeaFUuWKIPE1DqWJp83vWmXp0WHF+GXmzPIe1DRuZTgWFpEt
         h0XNEEMx5GOBeZnvT+99f+ugBL5F01diYc5DN0bpVe7h8UeNWfKhBXr8Tz4zcUdADAK5
         sr8eQoK1yc/6agU3alvP2OTo+1fNaKpdR6usqkvaT1eFO3EcLWvcGvGLWkOx/9RJYyiv
         VD5Q==
X-Gm-Message-State: AGi0PuaH/LgIxt/iRKAria3Gd88UWph3jV2Err8VUcDtuMg9zV8ZZSFQ
        bAYFUB/wuyUMRtolCGEkvZA=
X-Google-Smtp-Source: APiQypLd+6McGAgvmYACrWhpOdS2g9zwXctbQrHGEoRrc4DI3u95Q6lV30XAsF4LAdabHHnhuOg48A==
X-Received: by 2002:a17:90a:30cf:: with SMTP id h73mr27513694pjb.189.1586178497370;
        Mon, 06 Apr 2020 06:08:17 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.83.145.32])
        by smtp.gmail.com with ESMTPSA id v25sm11036294pgl.55.2020.04.06.06.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 06:08:15 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:38:09 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/6] iio:chemical:bme680: Tidy up parameters to
 regmap_bulk_read
Message-ID: <20200406130809.GA21539@himanshu-Vostro-3559>
References: <20200405180321.1737310-1-jic23@kernel.org>
 <20200405180321.1737310-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405180321.1737310-4-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 05, 2020 at 07:03:18PM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A mixture of:
> * Unnecessary casts of val parameter to u8 * which makes little sense as
>   the function take a void *.
> * Explicit sizes where we can use the destination type to define that.
>   Note that's not true in all cases as we do read 3 bytes into 4 byte
>   destinations.
> 
> Note that noting was broken here, I'm just trying to ensure this doesn't
> get cut and paste into more drivers so cleaning these out subsystem wide.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> CC: Himanshu Jha <himanshujha199640@gmail.com>

Acked-by: Himanshu Jha <himanshujha199640@gmail.com>

> ---
>  drivers/iio/chemical/bme680_core.c | 36 ++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index ccde4c65ff93..13773e01699b 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -114,14 +114,16 @@ static int bme680_read_calib(struct bme680_data *data,
>  	__le16 buf;
>  
>  	/* Temperature related coefficients */
> -	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG, (u8 *) &buf, 2);

This was exactly 80 chars ;-)

> +	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG,
> +			       &buf, sizeof(buf));


FYI all complex maths + calib reg addr is now available
in the latest datasheet.



Thank You!
-- 
Himanshu Jha
