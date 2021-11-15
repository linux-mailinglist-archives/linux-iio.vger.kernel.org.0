Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE67B44FDD7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 05:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhKOEV1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 23:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKOEVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 23:21:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52310C061746;
        Sun, 14 Nov 2021 20:18:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so7892245plg.1;
        Sun, 14 Nov 2021 20:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zv3FZFDa9f+2j3PeejvbeVmRdaCyODNvuYwLOlYEPkM=;
        b=VXb5K929vEMzj97pDzs0PXiXFoZ8Km6hWj5/BkCXmV+HpHBXDsS9luWik3RIl33fv+
         XMjh/bxKik+zjF+z/gGmJqrDiVeI3/Y+3BYZU38gojmlNL9g8gDosNnlip9ysesmyy9/
         G3qkk3A0i1SSlLVV6VVb+EwD/jIa3wVkA5rba4Qxexax1SAiWiB4/g4FWkQCs7RHSIkf
         tzg15ZOQtpfldLPV0u5T+js8Y/EbXxU0xNHXrfECXZ4Z0kjfg3YT7kl6q97JnnUZZJ5T
         08HBGfv1Cy5PhV6ArmunI7YmTXbQkjDkwFCzUF/cR7vS4uKF+i3Ll64+I8AOwfHqC7Ox
         cnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zv3FZFDa9f+2j3PeejvbeVmRdaCyODNvuYwLOlYEPkM=;
        b=F8q1gLq/50N56bsRNi16cH03yRjQ2TdexSMCCM02ve9v8Pwz1/pc+T5KIfYaOhAifE
         QVQXVMEHCS/d1Lmx36jeBZD8hsnbXrtRsXelGIy4VvypHAPFXFy96y/mruGwO2ic6Zro
         kp78CiWbSKhE8Dj6iu7MCG8QTnCa2ek+QKdC/l3y3OTfyklP+FHCov2Ar2OyR6+7ZlWd
         YwfAzu3fjSisr5Cqe9MkieVD0nBR59hvE5WLz4MKgsdzT1WJDxPzJb8h0yeURO5w1Sm+
         RYX4DVlvfuUnZ35i1k6ziWAHBuCTJ4vmvQ8Z3mI+4jeWNN7SpTZZX9vD6HT4ak5D8jYt
         U36g==
X-Gm-Message-State: AOAM533LBUmn5mjqDvvV2RaPBttfdRiF6Bek04nHRK0krkQ3EFgSqTeg
        paYnd0nL2M6ND6P3E9XID1M=
X-Google-Smtp-Source: ABdhPJyto7ZuVYw/P5Z2853eYUZdPudgQAGiqtwBJhcvb+A6ObKAhxXUpKmYl/AmKMBe4XVQNdgmpA==
X-Received: by 2002:a17:902:d2cf:b0:141:b347:df9d with SMTP id n15-20020a170902d2cf00b00141b347df9dmr32090970plc.37.1636949901748;
        Sun, 14 Nov 2021 20:18:21 -0800 (PST)
Received: from ?IPV6:2600:8802:600:10b:e5cf:8396:baa0:58f1? ([2600:8802:600:10b:e5cf:8396:baa0:58f1])
        by smtp.gmail.com with ESMTPSA id q6sm10304260pgn.42.2021.11.14.20.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 20:18:20 -0800 (PST)
Message-ID: <b6f5515e-ca60-d0cc-7970-b7ae853c820c@gmail.com>
Date:   Sun, 14 Nov 2021 20:18:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4] mips: bcm63xx: add support for clk_get_parent()
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211115004218.13034-1-rdunlap@infradead.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211115004218.13034-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/14/2021 4:42 PM, Randy Dunlap wrote:
> BCM63XX selects HAVE_LEGACY_CLK but does not provide/support
> clk_get_parent(), so add a simple implementation of that
> function so that callers of it will build without errors.
> 
> Fixes these build errors:
> 
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Cc: Artur Rojek <contact@artur-rojek.eu>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Jonas Gorski <jonas.gorski@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
