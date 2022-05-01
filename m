Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059E5162BB
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiEAIcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiEAIcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 04:32:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BD4830E
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 01:28:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a1so13540977edt.3
        for <linux-iio@vger.kernel.org>; Sun, 01 May 2022 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zgc67zkHtnI70Xqrll9RfFl1haspBpx7mPEGkL1rk40=;
        b=A+QEKIECi0tAae9rADyeVBiYUIhqhQK05Yu1OkxFWlyi0dK+56SAbb4CzJ4Ygb70Fu
         LiWghPF6S33uCCEi43H8JbKarRN2QOId+PaWPbtqi0kQOQ1/uKYa2jd3+O+zZpLwlFN/
         AfR1a0UKF/D0vWa7adeWC9oK/lzrmBQW9oPWj9313E38WGJkb3TyL+q4rXicJCIlJE/H
         F31cxaB4YiMbXgPdyOZ6QCK7B7ftcRB0JKzfR7BJAtUsFtwrG8cnWk0TuCUIzSCvfY8r
         aEh4u3sON1SX49EpSNz2p4kzenK4YjLVYACnsF66zTucW6F7qh89TCB3OL0BWDLGjzpD
         h87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zgc67zkHtnI70Xqrll9RfFl1haspBpx7mPEGkL1rk40=;
        b=M7/g8YXyBUCXpeO++VDO1KyAtSXOI5t0AuYz1ytZrm4mSuPeMNNYLicr/t8NWcjsAB
         /z15GZRy1UCZ4V291ww0isbX74U4jsH9Cyxe2MHxJmLox07Ugbdz8fPqJAReTFd+yuOJ
         JkkTXw5ga/DRoUMZw6jyNGq3IUT6mhYAcnHMwbl7S43q9+04U7mSjsA2IGeaRstke57B
         Q//potdIltPS7xg7DsCHy6+UUULfs0Nq+CvWmlRIPFOJMz78TMjISGNZ9l7NeCx/m7H2
         M/KrpWd/ILpen08sb1WsOM1yuUlKg0uXf03V56d3pWozVo31t7H+jkoLVC6qjhmC6xWG
         Kjyw==
X-Gm-Message-State: AOAM531kdms0syPS5w/zg2RQQa09JCHE9831qMfO5kQbVtvMZH9PxaXH
        OsuZPtz3lrEdwL0rfTXJCi8UsQ==
X-Google-Smtp-Source: ABdhPJxElz4BALhOBQaTk8Fr7XUMzW91oTJGLVcpF/k9LdyupAgklMFVfrWCBtTRTY3VvPbjYSEXRA==
X-Received: by 2002:a05:6402:5211:b0:423:fcbe:cf06 with SMTP id s17-20020a056402521100b00423fcbecf06mr7824844edd.39.1651393716700;
        Sun, 01 May 2022 01:28:36 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w17-20020a170907271100b006f3ef214e43sm2388178ejk.169.2022.05.01.01.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:28:36 -0700 (PDT)
Message-ID: <2dab36a0-7262-39f2-f897-4830d3e1ec84@linaro.org>
Date:   Sun, 1 May 2022 10:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v14 04/10] dt-bindings: iio: adc: document qcom-spmi-rradc
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220429220904.137297-5-caleb.connolly@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429220904.137297-5-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/04/2022 00:08, Caleb Connolly wrote:
> Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
> PMI8998 and PMI8994
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
