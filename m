Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5974D6DD26D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 08:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDKGJV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 02:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDKGJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 02:09:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971530C0
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 23:09:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sh8so17483846ejc.10
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681193350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G456PqVy7ApF9uqE+9HGHw+r1xq4A9l5JsDj40n+HI=;
        b=JoGT88M7kKKIV3qFCmx+GIOLJfJfUI6TowrnAnVID3KL75oguBDLLmVjdQnYNgya9w
         1ralcyQV3Dh/kvGoY61VHofqubLu1o+zNcraIg7hjXBn+beFkY/HWze8oIA/kM02LRyT
         ++7Nu1dgvKSDab9NgTG7BR00lj37Lr7CjuCignUMqzZhlqUQEag8iCdFowqhpF8THDdI
         j1hnTr6Yd+oX5YmvxezLyNXwan7TpC5p/yk6tG7odgVEG47siAUT6DkNlisIbd3UdMRH
         Vt3n6BFPxXsYKYFezU4MXYWi3ephzmlgGYT8X6v5zjcvOifR9RirOIIJxzYWL7fuOHB6
         YidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G456PqVy7ApF9uqE+9HGHw+r1xq4A9l5JsDj40n+HI=;
        b=Lp8hQcyoYXRvtQqq8CsQiIIQbCF7taUmeKHbOIqPbBv9ndrgst3ot8PnTvzc4Ma8tu
         m6IIAZMz0BWEaogbZNTLmw5gbXwRQrp8Fz5VhZDhU3k654Wl1YqLmS7qoRR4/rxS4Qjl
         7LkQfNRpRaLtCTlcN9R9vlQctokXGLh4mQB0Ezg1c74wiWJTah4c2OSurMkNlWQfq87o
         9wCDgwXyGd4Q85zcqIptIsZd6SYjfaTksxGxhaN1j25jYKBMan0LIOk75IY69d0Iqa0L
         I+ETi15bNLVFUxNoR69AT/yiFGFuSjD11waEGWRlZHRWHFId6FebFLWFlmmintV32iLH
         /ktA==
X-Gm-Message-State: AAQBX9eSk9+Z9zM84Gm/rDnlsGwyc4CgaYWmygQwYkjoUntgu3e0koKd
        IJj4SOcCILz5N0EVPW+iI2+ixA==
X-Google-Smtp-Source: AKy350burpaTkLQPeSniZmK7LQQOd5P4IygJemYYWoCbMDmyh3AbZ5+C/dTP+Po5vUkyxBiJ21+6nA==
X-Received: by 2002:a17:907:1dcb:b0:94d:6913:d007 with SMTP id og11-20020a1709071dcb00b0094d6913d007mr2671729ejc.18.1681193350628;
        Mon, 10 Apr 2023 23:09:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id j18-20020a50d012000000b004c4eed3fe20sm5523103edf.5.2023.04.10.23.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:09:10 -0700 (PDT)
Message-ID: <df0ec7ac-f472-c307-6f84-950f17d5ddba@linaro.org>
Date:   Tue, 11 Apr 2023 08:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 5/5] dt-bindings: iio: adc: Require generic `channel`
 name for channel nodes
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
 <20230410202917.247666-6-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410202917.247666-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/04/2023 22:29, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic `channel`
> node name for ADC channels while storing a friendly - board-specific
> instead of PMIC-specific - name in the label, if/when desired to
> overwrite the channel description already contained (but previously
> unused) in the driver [2].
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

