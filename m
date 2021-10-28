Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33643F241
	for <lists+linux-iio@lfdr.de>; Fri, 29 Oct 2021 00:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhJ1WH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJ1WH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 18:07:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26196C061570;
        Thu, 28 Oct 2021 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=C0URAtIqTgzQHryIDaXXjHNMTGhauwHVxMJmkYTTzcw=; b=I3xholVEQwOxRuk+KBgytIi7NE
        dMq2/VOKL87Gb1Z02gGctYBsEcSY3I/0ztJPKeD5K92k/tfLeikdTaARinMxo94EORTUUfXMZkwJr
        eVDv3lUE0pBekA3+62d8Ev1/d2mDaf8EQoaIwp9Abqbh+x9xz8wTVnx+h+8mzIXmGWFDEgUwbV4Jm
        0unwxjYpsw11aL5gbJB3l9lF36CU80XzT3Rb984X2VS4iANDp6QNNRZqFcPePm8wfPBrjeiRUNy2j
        2iHpCgdAj1PIBPpTEO8L+YBOA1e/RUJV+MZPAq0L1bOgzawtbDnct82/QWdm62E9RcvAwL3uKZFnp
        Yfi9E/hA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgDW0-009D9u-33; Thu, 28 Oct 2021 22:04:52 +0000
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
 <20211028101840.24632-11-andrea.merello@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
Date:   Thu, 28 Oct 2021 15:04:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028101840.24632-11-andrea.merello@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/28/21 3:18 AM, Andrea Merello wrote:
> This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
> and it enables the BNO055 core driver to work in this scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>   drivers/iio/imu/bno055/Kconfig      |  6 ++++
>   drivers/iio/imu/bno055/Makefile     |  1 +
>   drivers/iio/imu/bno055/bno055_i2c.c | 54 +++++++++++++++++++++++++++++
>   3 files changed, 61 insertions(+)
>   create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
> 
> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> index 941e43f0368d..87200787d548 100644
> --- a/drivers/iio/imu/bno055/Kconfig
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
>   	tristate "Bosh BNO055 attached via serial bus"
>   	depends on SERIAL_DEV_BUS
>   	select BOSH_BNO055_IIO
> +
> +config BOSH_BNO055_I2C
> +	tristate "Bosh BNO055 attached via I2C bus"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select BOSH_BNO055_IIO

Hi,

The config entries that have user prompt strings should also
have help text.  scripts/checkpatch.pl should have told you
about that...

-- 
~Randy
