Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7864660051
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 13:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjAFMfJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 07:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAFMfI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 07:35:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4268781
        for <linux-iio@vger.kernel.org>; Fri,  6 Jan 2023 04:35:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z16so1160395wrw.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jan 2023 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHJJcmxoQF6RmTS7KWkeAydRQ3hH8J9+bPjwO9oOfwg=;
        b=LB6/Kj6LBjCWiINiSHkE4K1udV2q1085XdI2d7bQqOz3baZb+Vk/P8IOOhfjDlXdm5
         8QMM2X/fDDeG7CFJGUIDVPtIXnavSCh30zKyeJ2p0g/tW//f4G1zqSLwP9dAN6MvJtKe
         OTWvMykFDOcYj+RWrINucrVWceVsdgMcy/wNKh7+z3YSjOFodK/bpjqhKk5gZCSD+jSJ
         4U1X9ci4ye4XqPAJIJH+HOR9EKppiplvcxKoP3UU4CWY3mAmZdSgTBr+VNNwy/uakEJX
         mGG9zZQ7jLJWxUL6+ls1kBTR69wCuhwMXFvvPktmO2oluXAbebh3S7OgmQ7ZpdOW8ZsR
         w/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHJJcmxoQF6RmTS7KWkeAydRQ3hH8J9+bPjwO9oOfwg=;
        b=tFibje0pQijXFMizq2g8RJyCF1kO2LsoJTQp9A5ap5yk0Dsp0SukiYdDXkoXGWR8ex
         b9Wii6ddaM28CocRt2AplRGTl3FR71vhrC3H+0sfpyHNKzSfi5LnzvL9x1Fii9e9YW7z
         WtcO2g6lQgeryJRNtdPVOZrwEdvf+RICV6dHiKKhPFG1ijEVQGcImgjogNfkeKiatEZk
         9k71T5Nf957jvvM8wJU6jgIIO5dtFzFSQS5EhZnHO9G+zfpLdPKhjbOT2d1K7Ki5bCyO
         1fVkn+KVdzHC2rrRQA60f0eB+gysKFz6SG6nzDL2MUx5CyXAZ1r2xzn6YPbc0KJgFI0I
         3zUQ==
X-Gm-Message-State: AFqh2krc2NBor2NatXJ5ES2yc4v55HA0YRNf4jb+FvHDjE02D723xZsB
        uqwpVflklcRdRWCIWf4kSOdBhg==
X-Google-Smtp-Source: AMrXdXtq7EH+BbYvHh9s5O5NWIhpRY4i2EWNgdfO058HgwYDQMqoMoiaCYmZffGJxaURD+tY5GeA4A==
X-Received: by 2002:a5d:560a:0:b0:27b:45ba:3b47 with SMTP id l10-20020a5d560a000000b0027b45ba3b47mr26535909wrv.57.1673008505734;
        Fri, 06 Jan 2023 04:35:05 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j14-20020adfea4e000000b0027f4a7efc54sm1102338wrn.15.2023.01.06.04.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:35:05 -0800 (PST)
Message-ID: <41525097-7703-c6fc-c265-00dc588dde87@linaro.org>
Date:   Fri, 6 Jan 2023 13:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] dt-bindings: iio: st-sensors: Add LSM303C
 accelerometer+magnetometer
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230106102239.9647-1-stephan@gerhold.net>
 <20230106102239.9647-2-stephan@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106102239.9647-2-stephan@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/01/2023 11:22, Stephan Gerhold wrote:
> The ST LSM303C [1] is a accelerometer and magnetometer combo sensor
> compatible with the existing ST sensor bindings. Accelerometer and
> magnetometer are exposed through separate I2C/SPI devices, so document
> separate compatibles with -accel and -magn suffix.
> 
> [1]: https://www.st.com/resource/en/datasheet/lsm303c.pdf


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

