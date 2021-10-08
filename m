Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E59426E79
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJHQRj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJHQRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 12:17:38 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C0C061570;
        Fri,  8 Oct 2021 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cqea7aJsIwkjTETZX+tl9UYSNz/ZUpYgx3Oi7UYbWD8=; b=dmXvFw8l/E+W1MaXMgWJsp496R
        nwIUZ9rNYJ5CR6dPW0pUFbnfDdFcsafWzpehL+Zpr1Yjd3NZQXAAm3koOlXEsN0L33VCMGhok4Ny2
        WW9eS8iAmi1A4XCTEMRTkvwFGKlJXQcFj8tWw4VigwCSG5yQuUma60+ZHzhnKrT69CsV6UApCalAo
        RY6xrizm8tq/iARAGZgHXttKa05h2T6BVYinQLM9KBkzuFYtlUyNFTxP4tIGI/M8279ssweu9/I8Z
        yJMTYMlGKd/u83PElwNTdvPorqAM1UceZwjfnrqb6RWDcKigfi2+n02KDry4OB4a1F9Ws+CvegSoY
        /wMO94sw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYsX2-003Spz-Uk; Fri, 08 Oct 2021 16:15:37 +0000
Subject: Re: [PATCH v5 3/4] drivers: iio: chemical: Add support for Sensirion
 SCD4x CO2 sensor
To:     Roan van Dijk <roan@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20211008101706.755942-1-roan@protonic.nl>
 <20211008101706.755942-4-roan@protonic.nl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <77c51ca8-c77c-83ea-12da-8ffb27d4efd0@infradead.org>
Date:   Fri, 8 Oct 2021 09:15:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008101706.755942-4-roan@protonic.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/8/21 3:17 AM, Roan van Dijk wrote:
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index c03667e62732..f4d2fcb1b9ac 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -118,6 +118,19 @@ config SCD30_SERIAL
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called scd30_serial.
>   
> +config SCD4X
> +	tristate "SCD4X carbon dioxide sensor driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say Y here to build support for the Sensirion SCD4X sensor with cabon

	                                                                  carbon

> +	  dioxide, relative humidity and temperature sensing capabilities

	                                                     capabilities.

> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called scd4x.


-- 
~Randy
