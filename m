Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F766FC980
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjEIOvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjEIOvh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 10:51:37 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB530F9;
        Tue,  9 May 2023 07:51:35 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QG1M81Dsxz9sll;
        Tue,  9 May 2023 16:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683643892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsSUpeP81yvnkeAOfTzrLBrfoQ7pc+mTMVWJnKJ8blY=;
        b=OUUrDGh1W9o7SHPRrAAKBGbjVlL+MlbT+z0aDvx7P/eNxFYv3FvK0gdmIubdAMZbVXtajg
        B189a5UQo05FTsWWnNitrx5o8OwhWACWnsH4zzAAa4Pm74p9+yaoNf71oaKma9o3lf4u8A
        c0WQKPKgoTLJY4nFxWebZhk7AdCtLvvuh0I42dONSjQN+Xy/CUcHcR4wj0xzK7QOlgcwzh
        H0NG51CSSTdfhcxqIThqiaNyxHrGfe+GBOpwee7anu5yB3RpmBqVUtY/lReNFTPjO9UZgE
        DrygAr0oKlywCHDVZiuzKJL4S1Cqn//MgsFLYGRcLYyBbBB5juF1w2orCr+d/g==
Message-ID: <d144ddeb-1b54-c08b-7fba-5003a2962d64@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683643890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsSUpeP81yvnkeAOfTzrLBrfoQ7pc+mTMVWJnKJ8blY=;
        b=hhPgt0ycbPhQQrUSEOyneIrX/9qXRBhoiVp9ouTJYUw0eoeroPwhrefcBtfku+ojoChhMh
        VtuIS7ztA410S/ar16tLnEVBS42tJmFqqNMvFLjNPm9uvieQV0BDaOzexZCi9DjhM/ILi1
        GROW/RbPXMMm35PL8PwRReOYcLd+ofuikh4CFf3T/aE9NlGM809Y1etyUEr4d+BxsFNBVz
        eWgB219gOJ4n1b7QMcplQkkEyFu8eTe/b/cLkDXgtRU3cwvZa4tKkAuQ0sqZCh18keOFSP
        XxU+VX6fzJDdTdW+82uN3T3wCXfRDY2Ub1MNBcEd/MevypmbrQGXWftG63i60Q==
Date:   Tue, 9 May 2023 16:51:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix
 adi,ad7476 compatible value
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
From:   Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3102644597f65231860
X-MBO-RS-META: q8cm41mk75y15z6thtf5erc3khxexkzm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/9/23 14:34, Geert Uytterhoeven wrote:
> The conversion to json-schema accidentally dropped the "ad" part prefix
> from the compatible value.
> 
> Fixes: 8c41245872e206ec ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   .../devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml       | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
> index 1c7aee5ed3e0bfb2..36dff3250ea76fe5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
> @@ -90,7 +90,7 @@ patternProperties:
>               of the MAX chips to the GyroADC, while MISO line of each Maxim
>               ADC connects to a shared input pin of the GyroADC.
>           enum:
> -          - adi,7476
> +          - adi,ad7476
>             - fujitsu,mb88101a
>             - maxim,max1162
>             - maxim,max11100

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
