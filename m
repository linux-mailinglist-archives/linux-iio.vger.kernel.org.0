Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8402D449ECE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbhKHW6R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 17:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240822AbhKHW6Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 17:58:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35654C061570;
        Mon,  8 Nov 2021 14:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bHrIX9cB0So6z8v8dpE1wVEf+y8GwLRTo4Q7rtYefjY=; b=cs8IIcZXWaLgUzbYR7jhvU1yMU
        Ce3ATRipt2+n1ZQPa2smT2RW/1jbgN5jn8o6Y4QBTcJ4FaWDbErV76r0WGskdHtL6PrBQFQJibCj8
        PWvSo0VoAcbnm0Mk0Fjg/OV4i06PUrGGIOCFRzPAZ/VVdB/GGNOlammnV0CFqLEskuGZaEx8LNqBY
        TVfNazOQ72GRtuDJocBLXf4gqUbD9rXafHwxI8+Qv450qjsMXiDihKLwQrrK9sztm7shoqh1N7koP
        GwDveOp+DB7fz+ozCx6UzMQIeKkR/AsQWIJWBRi7/1CeYDZUAG9bEhj0A2HDvzqB5VYM+V96o2aVx
        ShbEWTLg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkDXz-008jrU-Pg; Mon, 08 Nov 2021 22:55:28 +0000
Subject: Re: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org
Cc:     Manish Narani <manish.narani@xilinx.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f81d00b2-8df1-8866-da4e-bedba13c34a2@infradead.org>
Date:   Mon, 8 Nov 2021 14:55:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/8/21 1:05 PM, Anand Ashok Dumbre wrote:
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af168e1c9fdb..6d711f401326 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1278,4 +1278,19 @@ config XILINX_XADC
>   	  The driver can also be build as a module. If so, the module will be called
>   	  xilinx-xadc.
>   
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS for Ultrascale/Ultrascale+
> +	  System Monitor. With this you can measure and monitor the Voltages and
> +          Temperature values on the SOC.

That last line above should be indented with one tab + 2 spaces
instead of all spaces.

-- 
~Randy
