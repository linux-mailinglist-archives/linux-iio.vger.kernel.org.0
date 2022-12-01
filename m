Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB563EE0E
	for <lists+linux-iio@lfdr.de>; Thu,  1 Dec 2022 11:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLAKjt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Dec 2022 05:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAKjp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2022 05:39:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09E54B16
        for <linux-iio@vger.kernel.org>; Thu,  1 Dec 2022 02:39:43 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f21so953627lfm.9
        for <linux-iio@vger.kernel.org>; Thu, 01 Dec 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZtWLKQ/qk0jq11OfvrJd/TpG/sjKwt+6J2GUNOMbdI=;
        b=G1U21MiUkCU8cR7q/BeJOgmhIHOz+8N72LK77kmxqFZY9KFVy9K+DY0EVlGmGtsCgQ
         yRIm5kZF6aDPbh8XBJ81fj69HnN1ArkcJDavbK5Owk0qn7e4he1UjsdZ5VSrM4vAv/uD
         k2kmSeXrG4XHnMubz09RFNEYGNWa5RH7kc9NAMX+xICrdsDgHnWNHPVb12dDol2tBbEk
         /0J4ORtetQjgNpmj7jW/ZgOqI2vvA1ttocf9q/CJtOgHJ0TJbAGMhuush6kWC1yJAxiE
         Uhvk/+f20dNHJZh0qi3GL940QyfCGeL/Kxtq2tFNM7D1JRAkQPY899Ftfi5+U4UwKYsO
         L46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZtWLKQ/qk0jq11OfvrJd/TpG/sjKwt+6J2GUNOMbdI=;
        b=G5IP9pod8zawmB/i3+amER0nB4qI7yNasbSonikz7Yw5qcMDvWS2xo1KKp1Zw3D09h
         XQewEa8qxp7mumMQxcmfp/jyYHKoNVnKjCBa5V5TsissH/ok/4CbsMXDpHkJjileEbEU
         9CLTLwYKYts6QlqxemkvspV04TEOD8WBnhht9iSggyfdoXF35pyP3X56QPot0ew9nvMw
         U3SHdK5HqhcfIXWmgnKMRJ+4X2EQOaVddC8TxWRFuJ7Mwaxx2bTzrX/k6C9yWmAQF9t8
         WNZ2fhAywVW5ZX1Di1Hoj4V3fBcpg0DSILtm1KxY+FjoY6glj5HCaCoPlSSul81hux3H
         3sYg==
X-Gm-Message-State: ANoB5pkvfD98HfgnTqjY5HryF2/E2GC1bB6JmxjYzyCCWy+O/6Yh+NpH
        NvCu8ZOQwH+TmPMNb6mQFk2nIA==
X-Google-Smtp-Source: AA0mqf6oLzlbefyT3caSN0ADbCA/bMXIOsULzuBkHa86jFMHUqoEHmEQq5j1/3e90kERNivSlXddHw==
X-Received: by 2002:a19:6d0b:0:b0:4a2:489d:490f with SMTP id i11-20020a196d0b000000b004a2489d490fmr23152674lfc.196.1669891181807;
        Thu, 01 Dec 2022 02:39:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020ac25fe1000000b004a05837103csm596508lfg.196.2022.12.01.02.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:39:41 -0800 (PST)
Message-ID: <0b2f414d-57a0-a427-3421-1ba8331459d9@linaro.org>
Date:   Thu, 1 Dec 2022 11:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: ad5686: Add an entry for
 AD5337
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221130182632.3856675-1-festevam@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130182632.3856675-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/11/2022 19:26, Fabio Estevam wrote:
> AD5337 belongs to the same family as the AD5338.
> 
> The difference is that the AD5337 has 8-bit resolution instead of 10-bit.
> 
> Add a compatible entry for AD5337.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

