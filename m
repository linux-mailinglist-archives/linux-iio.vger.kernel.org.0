Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DC6D36C5
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjDBJzq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBJzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 05:55:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9221B5
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 02:55:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t10so106160999edd.12
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680429342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qOcw5c52dYpyKHrYXZEVHM/zl+hEaxxU+kA54pWk9Y=;
        b=DWUOglP9AcVdiW0K7+s/g7piIWl8guG5sxjbTdH2FD9vsZgA6nXXhhLRWk6vJzMXt2
         stWMcZsuhX/XKOj44u6D6IyimIOjsFrqUtYkV3R8Su5cUzvsLdjs3nQp53DjlLHCpRkB
         Q1ihhaheDvrXh1IrzGVBUVbNlpzLzf6bZGKeI0Nvs+zVwDxuN+dwnexvOeWqXv7dM7aX
         QReLlvrlJabArE+AQ+fzgBYlDR+WX/GmAHxe5aFb1NkJoAGvY3kbnHdCbwKOlWzJ2qqM
         rVOBKwdD9axioQqQ4kdrCKOqdOjeDLH0/H2yEkNWTSPHQe69mfSkDb6TQKtYLpgD1JJT
         +1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qOcw5c52dYpyKHrYXZEVHM/zl+hEaxxU+kA54pWk9Y=;
        b=pv7Zm1v8zBSuEZ2jgYgX9jZN58SObmCGEIEC97yMDyPhRSALGHnUHp/wn4Z5Vzw7Xx
         q+zb25zLF7C6DwDnYTua18FJabLuv1IVi5MggML7SCTa48p/ejp5iv2q7qkCcS1y9GV+
         0UXetXc+MIjz+EBwstH8YWT+F4hWSVbLz0PUDeXbmJnLYnJOp408nil5xI27N+Ay/4bn
         p79RmT7P1JC7bJqUMu5PmwMMHrmeYSt5Dzkq5ehKr1z8JXKOMaTJ7ykqFUgz/j8L9Tt9
         WXgTFIvEh2nzGVJc/zWZUyahA08bbreDNXe6KKnOguqQzG1TzkrKSJI552D9rR+N6ZYc
         yEWw==
X-Gm-Message-State: AAQBX9egIbmpjLx0p/8No/BDhKucW76jd+fXkfmKEE6f4XKw3lHF9jrF
        Mn65/oNC8/zJKpEw//3RG/ORsw==
X-Google-Smtp-Source: AKy350Z6sz3BJUxyuvQ/4FwqO6Mj5Dovdy4rBa89PqUsmYbFjuNa37cA70rMHp5V7fP/lP1DmYUvlg==
X-Received: by 2002:a17:906:d975:b0:947:d991:8e4c with SMTP id rp21-20020a170906d97500b00947d9918e4cmr5331857ejb.68.1680429342507;
        Sun, 02 Apr 2023 02:55:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id cw1-20020a170906c78100b0093de5b42856sm3033800ejb.119.2023.04.02.02.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 02:55:42 -0700 (PDT)
Message-ID: <10626c79-46da-3f66-0327-66576b3e5f2c@linaro.org>
Date:   Sun, 2 Apr 2023 11:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/22] arm64: dts: qcom: remove duplication in PMIC
 declarations
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/04/2023 00:07, Dmitry Baryshkov wrote:
> The sc8280xp platform uses its own copy of PMIC declarations. This can
> easily end up with the issues that are fixed in the main PMIC include
> file, but are not fixed for sc8280xp (and vice versa). For example
> commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the correct PON
> compatible") changed pmk8350 to use "qcom,pmk8350-pon" compat for the
> PON device, while sc8280xp-pmic.dtsi still has the incorrect
> "qcom,pm8998-pon".
> 
> Another example is pm8280_2_temp_alarm device, which uses interrupts
> tied to SID 2, while having SID 3. This can be easily left unnoticed.
> 
> Employ a small amount of C preprocessor magic to make
> sc8280xp-pmics.dtsi use standard PMIC include files

Preprocessor magic is disliked in DTS. We allow only simple defines, no
undefs. Sometimes some nodes or strings could be concatenated, but in
obvious way. You should not parametrize it and have different, generated
labels in DTS based on something coming external to that DTS.

Best regards,
Krzysztof

