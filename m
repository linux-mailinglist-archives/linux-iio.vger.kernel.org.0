Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC84B5CED
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 22:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiBNVhe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 16:37:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiBNVhe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 16:37:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E812CC12
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 13:37:25 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E06443F1AE
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644874643;
        bh=kT/ZbStYKrIw4n+GRbiyCeyEm9jDf9nRetcAQkPpfiI=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=b9YWVKSeCNrWsRGpiCecaQoE751kMx5ewRUns/U1nWReKS0cV4h583Uov09y5NFyt
         hUAg7UG6YGgk1KLXSLzjwdSLdPbPLS+9vP9Qe33q0FAnhtBC6qFT2z/chLB1OAvDLQ
         p4KTJSDz7i2FY3j5Gl9dyyCK0o4HmDuV1gGDwjgJGZecznbhTF5aAUees3AE2+7j6k
         WGWmy/rJF3HTBYw7XhIS3JR375yHJ3aPK47xPsppyLCOFpm5Non+KLMeb9rMDMBEE5
         LzmjgAiK45V/2iKPp7d27kyK6dPSxgowmoqU4q5DdfROOxekaA5kTZlTjDEUFFm44r
         9zz1+zZeAWuNQ==
Received: by mail-wm1-f70.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so242739wmc.8
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 13:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kT/ZbStYKrIw4n+GRbiyCeyEm9jDf9nRetcAQkPpfiI=;
        b=5D4Iz7XIqQ55SO4svXmLyfTpUqyCt8cP+OTOMCAIQquPhYTtxuHtPMCZBdusE0BHKu
         u/Js/5eVR0LEI1YvbSbbuK1OQQ6G3vqbrIw8a60F1iEoj2cMb5NY3GXWXjtc94wYGgrJ
         HAJ3i6TvwAejSrkkWlZ5XiFw5zQa5kCF/Y6IuwF8Gfv0N4Dsouob5mv1Payrp2Ea9EX7
         qSpnQU0uLneSs7yIFSwOiZ7pre+8hxx7JI3rm4YtoC81CcdGdmVq3/rfMAflpukdgtK2
         aYwdHaj8KYYAKVAfOmDRujLh4UaqUkDwfone6iJA/LCSWjLV/xxJbn4NP7cqrSb5kA8M
         hsUA==
X-Gm-Message-State: AOAM532xwR18ZYiF9Q5jKJ/iIvoNNl2f9eL3yegvDm0LFsgRNkOegi11
        hMQ93Egu4y+ZQ8Enbm4loyj/RzHNa05D2u+i+xLgXSNJ+VsZRpSmJ8Rxx8j361giwSfTL+70mMy
        +mFZwImPXPdPZtDebykg1aCo/JYA6cig/xe4qhQ==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr716527wrs.275.1644874643596;
        Mon, 14 Feb 2022 13:37:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy8FAd8AthJ50nYJRkJC2MLR9VdV0C5UiWk2N5lGhZra0fVO3q6DDUwAMpmDmMD2+Wryc6ZQ==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr716511wrs.275.1644874643350;
        Mon, 14 Feb 2022 13:37:23 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b15sm26932080wri.96.2022.02.14.13.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:37:22 -0800 (PST)
Message-ID: <a7ab4c1e-99d9-b78e-4c49-c565432f081d@canonical.com>
Date:   Mon, 14 Feb 2022 22:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/4] iio:frequency:admv1014: add support for ADMV1014
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220214073418.4528-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214073418.4528-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/02/2022 08:34, Antoniu Miclaus wrote:
> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v7.
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1014.c | 824 +++++++++++++++++++++++++++++++
>  3 files changed, 835 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1014.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 2c9e0559e8a4..493221f42077 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -50,6 +50,16 @@ config ADF4371
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
>  
> +config ADMV1014
> +	tristate "Analog Devices ADMV1014 Microwave Downconverter"
> +	depends on SPI && COMMON_CLK && 64BIT
> +	help
> +	  Say yes here to build support for Analog Devices ADMV1014
> +	  24 GHz to 44 GHz, Wideband, Microwave Downconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1014.
> +
>  config ADRF6780
>          tristate "Analog Devices ADRF6780 Microwave Upconverter"
>          depends on SPI
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index ae3136c79202..5f0348e5eb53 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,4 +7,5 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADRF6780) += adrf6780.o
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> new file mode 100644
> index 000000000000..59a6b1f3b7cb
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -0,0 +1,824 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1014 driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>

Where do you use/define clock provider?

Best regards,
Krzysztof
