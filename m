Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FC28D15E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgJMPhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 11:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgJMPhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 11:37:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129DC0613D0;
        Tue, 13 Oct 2020 08:37:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so24570676wru.12;
        Tue, 13 Oct 2020 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqpGyIxGkzBe54LbECwQ4ti1dUnwF1pNvzMYS8Ni1qk=;
        b=XVf5bQXdPjnn21q9qd8ieph25Fus4NCdbVyi2mOTg7yq1Zny8DykvIgzN+HC1fete7
         f9vZj3i2oo5QzSR9cR7TBYe9zVSq5eUSqBVw9N3UhCNqAeMRVEsaDBlE1J9bS/HZSOEA
         X5luf2yF6oEX+l4w4nlBDb0xq+INIf0oxr9Ujt2AKtK5CxDXedRK3/rjow/B6dg1DJJA
         UxKmuMAMkkENLUPzht83TDPSTxMHEhPkGjDaipUMLRsiaiS86n0nOL/RdKPryYntQW+0
         ns9bVSv3UwLJKM4j46A2GLAOa0db3yF1roJEqon0ENoym1IRmkGqx2Icqc1J3ZSi1gA2
         JXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqpGyIxGkzBe54LbECwQ4ti1dUnwF1pNvzMYS8Ni1qk=;
        b=Qd0YH2MrpRJx+a+ytLfI/U5fJ5WaxpbzefATeez5PBceBSXF+n+3kXm/jSoWpWj+cP
         9CFKtyTTxwEkow1frl1C8eY0ZJB13qjgzt/DimotLA6u0d3gk7udF/J4fzHLnbBjEdV2
         wBVC0o7i01a/p9spDVjexw7rtsdm16hpnYQDiim/GBVkyaUntap7QMFEYz2oICN4sWQE
         KaDKSGZTSUvzTus6AJ80WfhC2EX+jMJebIAfiNm1ZeM/bnh5eJtoxW5gMF+Q6Nwcadzm
         Dk5X8wmR48vZn1YzrYmjyzPubifGAxQ9yfF4jDvxhMkxmzSKGO4A0mYZUSYJLHpAOqou
         Akpw==
X-Gm-Message-State: AOAM531IcjoMqhVXSFMqo8EedlRTezNvL/u67GLQBfmY9Kqc06tqUMV3
        jw1mEhwy6wp0QOL0pxvFziy2ib7v03f9bA==
X-Google-Smtp-Source: ABdhPJyMK9WV8/XRKrMpteIuKNBL7WJ6l3g7AMZE/IEw4NZFMHr+Ee9oXn0dFKc1icYcWo3QSjPXbw==
X-Received: by 2002:adf:ba85:: with SMTP id p5mr316139wrg.64.1602603433846;
        Tue, 13 Oct 2020 08:37:13 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id f14sm30459748wrt.53.2020.10.13.08.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 08:37:13 -0700 (PDT)
Subject: Re: [PATCH] iio: adc: mediatek: fix unset field
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc:     chun-hung.wu@mediatek.com, alexandru.ardelean@analog.com,
        pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de,
        jic23@kernel.org
References: <20201012194618.2170970-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <61fe6278-a628-820c-6bbd-eeac51b1e7c3@gmail.com>
Date:   Tue, 13 Oct 2020 17:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012194618.2170970-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 12/10/2020 21:46, Fabien Parent wrote:
> dev_comp field is used in a couple of places but it is never set. This
> results in kernel oops when dereferencing a NULL pointer. Set the
> `dev_comp` field correctly in the probe function.
> 
> Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Ouch.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iio/adc/mt6577_auxadc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index ac415cb089cd..7bd48377cd79 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>   		goto err_disable_clk;
>   	}
>   
> +	adc_dev->dev_comp = of_device_get_match_data(&pdev->dev);
> +
>   	mutex_init(&adc_dev->lock);
>   
>   	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> 
