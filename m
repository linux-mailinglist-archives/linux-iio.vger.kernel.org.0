Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754267173D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 10:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjARJRL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 04:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjARJQj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 04:16:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CA74942
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 00:33:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so33100370wrz.12
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e75hqA7VHxcid+O9Gz6U6os7dK9/sLIiCCHXcsw2tuI=;
        b=rbW4tWBSrmwjC0BTyVqBIUS0yKg6ExtAKTmBzL9ct4JcwqqAuZPHPKNv8fNrtFjBiI
         v8UYAZ6VLWVRdy7IeuL5kGXAv4CsnhxsowsIFoF0tWjLltG9FX7hcT2g1z5k8uHMjmNH
         hRyV/ZDPj9OegGJHKqV2Lw2fObmsg2elfVwHpOMCfy03viqSFy/fESa5jO9h7QjjNN/R
         8D9XHAnnA5zV5+wLbjBc+B0jYmdFIchLzNtqeKRP2KfgsQ+n6emovL7691U1hqx8BPZT
         WTvle8CXmm+3xUW6Qx+6gfxXjYcq7bONBX46uBYNuV9rIZrMaA9NCR1U3TvdLEdakVSb
         QkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e75hqA7VHxcid+O9Gz6U6os7dK9/sLIiCCHXcsw2tuI=;
        b=ykZdCjKAt5ObnOwyhlivnLuzqHvU+vvPiogFA7I00bKGeMYs0Vn6rFKFZLcTY3guUn
         xPgZ/YdM6xU2IA/mKFiEqSw03ZhrYkun1Gkn5fH6rlOy1hynom3k1esPscK9byU63ThG
         3zGfqXN6IuXou6UmDQ0mZ/dCwf456NpM+pu8kFdi/G18Lt4dcRp1PWcHYxwNCwB5CcI1
         n4YdbZYEVc6SXj3M8b0iIC5hYB/F7juqPI8gHjlNOJDdhym0hPrd3nj3zFWmlpTZIQIW
         AAUCCeNxAvyzOYTVXygpHfePEfguQhFOLQXwu8OijndRDEOtj9z57H4AbJFoQui5xTb+
         HWTg==
X-Gm-Message-State: AFqh2kqnJ+bVZ7fKMdvt/+O+P8emBsSgbImvuT4/JusEC9VveOmueC7q
        DGoe859NExQQZXZOfQKj5pYjVQ==
X-Google-Smtp-Source: AMrXdXuP5pmdhm4NrRbQJ2PS1L1ya0vhQlfEo9GWLHhR1h3kpjJ/ZouJltVt2eCqK4sknDyncw4/nQ==
X-Received: by 2002:a05:6000:1e0f:b0:2be:449:11b5 with SMTP id bj15-20020a0560001e0f00b002be044911b5mr5418903wrb.69.1674030810863;
        Wed, 18 Jan 2023 00:33:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm36321068wrs.0.2023.01.18.00.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:33:30 -0800 (PST)
Message-ID: <b7a732e3-7d70-f7b4-2e3d-d70f3ea4407b@linaro.org>
Date:   Wed, 18 Jan 2023 09:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/5] dt-bindings: regulator: Add ADI MAX77541/MAX77540
 Regulator
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-5-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118063822.14521-5-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/01/2023 07:38, Okan Sahin wrote:
> Add ADI MAX77541/MAX77540 Regulator devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

