Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773941ADFFD
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgDQOfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgDQOfM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 10:35:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998AFC061A0C;
        Fri, 17 Apr 2020 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=iC7kMxEwSt+feuKPX5Q0+CbVgJZxBEaT8JMxETzRQ4M=; b=CT2QjIYYjvSJCtHlCc7FUuC400
        Vwwe7u+YORoRTGbwtYaXiBerCQvFgtLtQfqcww0lpdBL70z7y7obAdB8fYT6ZM9bM26K9NAt+Rvpn
        I6TNtCvH7dTiHg4jpGaKPyfWa5Lfl9434WswISvnRD727cfKpwObS7P5srbwUQPEG6ZiWQk4ekYGU
        p0qY6BpHyfkW8W5pYBa6m9yksykY913sa60rOyF9XeSzv2oXqDU/qBaiuOywiSxEazHWhweOIcq6/
        PB+Nf7Yu13bG7Bef99LTz9IRarCb99WONvFLQr5jqHoYl1/TLP2WjF4YC16QebHknBRL+du98CfqL
        8foDxxsQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPS5H-0002iy-KP; Fri, 17 Apr 2020 14:35:11 +0000
Subject: Re: [PATCH v10 3/6] iio: adc: mp2629: Add support for mp2629 ADC
 driver
To:     Saravanan Sekar <sravanhome@gmail.com>, lee.jones@linaro.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200417085003.6124-1-sravanhome@gmail.com>
 <20200417085003.6124-4-sravanhome@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8da9a3d-93a5-b926-b8c0-84138b59ad4f@infradead.org>
Date:   Fri, 17 Apr 2020 07:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417085003.6124-4-sravanhome@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi--

On 4/17/20 1:50 AM, Saravanan Sekar wrote:
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 82e33082958c..ef0c0cd31855 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -680,6 +680,16 @@ config MESON_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called meson_saradc.
>  
> +config MP2629_ADC
> +	tristate "Monolithic MP2629 ADC driver"
> +	depends on MFD_MP2629

	depends on I2C
?

> +	help
> +	  Say yes to have support for battery charger IC MP2629 ADC device
> +	  accessed over I2C.
> +
> +	  This driver provides ADC conversion of system, input power supply
> +	  and battery voltage & current information.
> +
>  config NAU7802
>  	tristate "Nuvoton NAU7802 ADC driver"
>  	depends on I2C

thanks.
-- 
~Randy

