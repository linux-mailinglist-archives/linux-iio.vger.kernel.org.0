Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63D54BC0E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358387AbiFNUtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 16:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358467AbiFNUs3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 16:48:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8DA41988
        for <linux-iio@vger.kernel.org>; Tue, 14 Jun 2022 13:48:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so119259pjb.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jun 2022 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FKttehnRyWHLRCbEVc8BEN7Nq8NEnIEZrjC6GBkel28=;
        b=um790NINW6SPz/mn/uCi4IfD5Ys9JPSY1K1aZrlnkbmUzqLYmwHi3LhqMrH1CMne2Z
         KC1GQbI50hWzHdQGINwuocWoXQUznEf697nu/aC+ApZ3J4X1VedJ0djtz/LhhowKnLOs
         C298Np/0bxtkPr8F3A7e11bNdcDOHhNbzSOAFTw3XCv0UbrmoHwScsx0zG1zRlIHWgmk
         qyw2RN91dcC22l91sRTVUW3IfsUPvqqpl2i6d2vhiQlOdljYQrhAfQHTzlveycqdQGFU
         Mgux9dPpSS+r01oenXwo8Z4f4ICtbPLhZvNkmi7rQz1RbjarT1pkM0EKFs/rTA8oQep6
         ZTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FKttehnRyWHLRCbEVc8BEN7Nq8NEnIEZrjC6GBkel28=;
        b=36sUHXXPWJD/BhK4GS/oD8lIzk0noF74tZqNEvxo4TcAS9mNb4O8kvx9yjibqPsPh/
         AOnwwAsCiEBR70F7BCITC37rrwjFDbjxKUnFhP1hmfTyGM7SqtTRUV2LWfla980Q9RQa
         KGxAZu8oBEaHleirU0jrwtbdG87cXch4X2xjCIdgLvuPu1R2dE3FYTMFuZD6YZ2ZV0wr
         qJ9BKiuWS+jeATLoQs2LbmH6oaF5VJ/U1l6dak7oH3VsgyYXx+ivsiwU77V+0phEwStP
         WoHNCcN00NSyilIQFZDnkHb/ocfiNdfqypiRw7oM2JkCHfDncjgCaqJkh3KDl9zuT82A
         69MA==
X-Gm-Message-State: AJIora+zdj8AcGt7DLq7Qy9J4ZnkGHJ1B4uMNPmxbQLzTLooerIQEnqY
        RSlJH2fL78gdoDd9iwJS6A2I8w==
X-Google-Smtp-Source: AGRyM1uKnwL63QW7PW0eVtBoAjWN/m9SVuVEQ0O8Xlh8MD9grvwUrzxnRs6wLGish3Lq35jg0oPYfA==
X-Received: by 2002:a17:90b:3591:b0:1e3:25d3:e78e with SMTP id mm17-20020a17090b359100b001e325d3e78emr6345411pjb.29.1655239686545;
        Tue, 14 Jun 2022 13:48:06 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001641670d1adsm7684389plb.131.2022.06.14.13.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:48:06 -0700 (PDT)
Message-ID: <425477c2-7515-1402-f2db-66f15f09cbf4@linaro.org>
Date:   Tue, 14 Jun 2022 13:48:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/6] dt-bindings: mfd: Add mp2733 compatible
Content-Language: en-US
To:     Saravanan Sekar <sravanhome@gmail.com>, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220614194225.2226447-1-sravanhome@gmail.com>
 <20220614194225.2226447-2-sravanhome@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220614194225.2226447-2-sravanhome@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/06/2022 12:42, Saravanan Sekar wrote:
> Add new compatible for mp2733 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> index f91acc42d652..fe13869e2c58 100644
> --- a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> @@ -19,6 +19,7 @@ description: |
>  properties:
>    compatible:
>      const: mps,mp2629
> +    const: mps,mp2733

This does not look like proper syntax. Please run `make
dt_binding_check` (see instructions in bindings directory) to validate it.


Best regards,
Krzysztof
