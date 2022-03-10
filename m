Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E04D4749
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiCJMxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 07:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbiCJMxE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 07:53:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7F149959
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 04:52:04 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA4F43F4BC
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646916722;
        bh=SpN3BJMWANRJWoIKeyCH+Mmo+u4Z4THt7au3Z4R2b1M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=AWp+W8ug+YN62QTgzuL84LR8vwhgNB49v7aEiC26KcUhZFFZIQ4KPgP0VI2KJIuu6
         4JNV/dvisEg65bEZ2VAiLxEMlnOGel/lcwtZoS/cZT/KZ3LyvkFVJ4p4shSY2Ht/vx
         HTzXkZX0igMTLxB+ZAfhXK2jFO0Rxxz/QkdRlid+vTksofckDkRqnd0wH3S0xn67M4
         xnyJbameO9jgbWk4MRKhZfGlhsqKIfd+lJ3aJch/2C0m9/e/Xc8X9Q005kf5CgnAVT
         NdQMGlTshmMvXEfPRBDJISccEmgjHGEEF6mZy3K7UZAoK3PL6464fBB/6NeP4knvCG
         0SU1e/Myr3o2A==
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so3027356ejw.9
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 04:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SpN3BJMWANRJWoIKeyCH+Mmo+u4Z4THt7au3Z4R2b1M=;
        b=vsLH8R8r/1DNGwNy2/DUllzbEV/GkvSuTYBMw9w3WC3HQyKZhdorSHZuDp3+e9blyd
         tQBsjHS48zGElfpaeywE4vBQ4WjN/SyYYSaSO9UIFyb2ajW2mJTnub4qaUfzrvgfOU5C
         c8YurANak9KPjjHyhmGHxZIpzQo6pnypuD4ZUEdghqeD3GZrYPOYHgWj1/SH6qUDXV8l
         X3QR5Q+zVyQtwsJ2OI9kXFUrhF3+IMWX+Wj3dIYcgNSTjWZd5Bn/lBbqsfbL2dZ4jCdY
         77i+z7dHFTDeOzcTQqLLEg9I42mzIz1rowgIEaUcJJtyuZnK8PYPis0vlYsJ7p8MaL0A
         0shQ==
X-Gm-Message-State: AOAM5307bDExsxdToVl3lFl1uayKBXpTszUcnXyAolUvf7jORZzD8gp2
        wEQkOPLqxBakkZ0l0JgoFGNqNFIhazUfJydF8GKkzQbm5Xpp2Pviw8J67ltHN+BLmVcjvHTmZHL
        4YfFEpWK857g7SQQ5yJ1OojRGe4Q+AG/xeiTB3w==
X-Received: by 2002:a17:907:94c1:b0:6db:67:7214 with SMTP id dn1-20020a17090794c100b006db00677214mr4058024ejc.180.1646916722440;
        Thu, 10 Mar 2022 04:52:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT+ucPSB6FSnXuQ6WKQHUJEzeaZY0XXjc+jN+z9ho6c2DLNcLOlTmPYfpvBngLBatn+X4UtQ==
X-Received: by 2002:a17:907:94c1:b0:6db:67:7214 with SMTP id dn1-20020a17090794c100b006db00677214mr4058005ejc.180.1646916722197;
        Thu, 10 Mar 2022 04:52:02 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm1811632ejc.64.2022.03.10.04.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:52:01 -0800 (PST)
Message-ID: <451e9b0d-9f1a-2a22-9398-2062924cc312@canonical.com>
Date:   Thu, 10 Mar 2022 13:52:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/6] dt-bindings: iio: adc: ti,ads1015: Add TLA2024
 compatible string
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220310003402.490478-1-marex@denx.de>
 <20220310003402.490478-2-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310003402.490478-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/03/2022 01:33, Marek Vasut wrote:
> Add ti,tla2024 compatible string. This device is compatible with
> ADS1015 except it has no on-chip comparator.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
