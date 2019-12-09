Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD3116522
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 03:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLICys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Dec 2019 21:54:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfLICyr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Dec 2019 21:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m2lUrODSpTuA1453mVsRp9l2Fn57jclNVrwv88nJH8Y=; b=ofkFUo2BBScyBoHteW+FYdFTH
        xY8wAN7UTp5i74wJ5G89ooYRGaIjVUTrykMrxdN5eujS01tufh7Z3PJ5S4tVyN46KZ4jxX9yBcMcA
        o5qt/e+a0uJWQMbvu2frMzsRhntfDijHp8RRj6Ke4O7AmiapWfdMpo4esNGzZ49tjtjejZCw88qRl
        qwCdSUrtX57t+tnLOvdhxp5b9m+s/DJTMSy1qaErZLohxzIB1Ft8LW/7+T3muN5XhIPcsSLHNbqRx
        qJCYi5yizWaiCPr/e6h2FZwb8n+cQdV6Xv5yfvFdtm14EaYsdCwtcxUtsws5mtq1jPZO5SzWcE6pq
        ZjKyVGoQg==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ie9CA-00038h-Jy; Mon, 09 Dec 2019 02:54:46 +0000
Subject: Re: [PATCH v5 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20191209014320.13149-1-dan@dlrobertson.com>
 <20191209014320.13149-3-dan@dlrobertson.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf3f2297-dc01-b2c9-657b-933f24b15594@infradead.org>
Date:   Sun, 8 Dec 2019 18:54:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209014320.13149-3-dan@dlrobertson.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,


On 12/8/19 5:43 PM, Dan Robertson wrote:
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index d4ef35aeb579..dc9bc646d403 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -112,6 +112,22 @@ config BMA220
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma220_spi.
>  
> +config BMA400
> +	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> +	select REGMAP
> +	select BMA400_I2C if (I2C)

What's with the parentheses?  I see that there are roughly 2700
"select ... if X" without parens and around 95 like
"select ... if ("  [using rough grep expressions].
The parens are unnecessary.  They are often used on complex
expressions, but certainly not on simple ones (except in iio).

> +	help
> +	  Say Y here if you want to build a driver for the Bosch BMA400
> +	  triaxial acceleration sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called bma400_core and you will also get
> +	  bma400_i2c for I2C.

iff I2C is set/enabled, so could be confusing.

> +
> +config BMA400_I2C
> +	tristate
> +	depends on BMA400
> +
>  config BMC150_ACCEL
>  	tristate "Bosch BMC150 Accelerometer Driver"
>  	select IIO_BUFFER


-- 
~Randy

