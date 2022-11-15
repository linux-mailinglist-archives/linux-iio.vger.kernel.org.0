Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C0629572
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiKOKMf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 05:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbiKOKMN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 05:12:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2624F25
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 02:12:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a29so23662294lfj.9
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 02:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YawYGMNwk0lz5irnjO3Ci3Kzm3in8Mf7sW9hSPleXyg=;
        b=Rc8oKB8U198WQWIqvUNHlOw+MWLNLE+nRar20x2oKeiAPcmPpjL2XI+L7+xxVvwRmk
         5GNa6elcozne7vKIi8xb2UgoSI6pO/ryifl1MPqb1tG8jRZ1ruUaAq6sG3mtKDN43wY8
         yLmhoa6cb75zSyYU26jGCv1seNpDkia9DQcUTVZn9D8huZPrrFdJAWU/gyiJTp5CJaz+
         +PRMSGZXpFfb+yBxpEwsgIM6kvoU8/XBMLcESeFnwIhMSpRrhvEithfDN9zIME09l3Px
         /sGx9/QXrULpN3nsXKS3np+5i+8X1YJuam0z/sGXX99EpUl/TVekLi+jJdnouQvVlsBI
         wqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YawYGMNwk0lz5irnjO3Ci3Kzm3in8Mf7sW9hSPleXyg=;
        b=phyUFIJUA5ncJnePUs9aITiM1mPbxdRwqitoy/H9EKTnvCc27ShArdLUDeNLzyh20U
         TOtfoGoIDwH0VKsjYyCgnJUY0wADRFGVGAVdINkiiBqltvHtmg9Gnu/OKQ0mFOutFI6q
         mlQ2A9Vpz3fEQLCQ8VI6X0tVPOOSLTlTTn/QVlRzUB6DT5PFZZXvPe7GJ0EqfjmtZAxp
         6q8gVqIw9A9Iqw6fzB3TBm4mD6hfGG58wa/ZBefJ7axMGIGGQDVpwxQW2tlVQHWaNlsZ
         Lz+FlMt5g+fGazH0JntJHQo6ZMu+juk01V27AiGVDXx3HeBfbhCSP2ZrKtZvVZcaXUCy
         5kmA==
X-Gm-Message-State: ANoB5pm8Nw3s7Tw7yzV31C5GM1pHqNEzET4TpJoME2NY7ikU8671WrjR
        pdPwACr8wL4E+ClG1kVhewkY2w==
X-Google-Smtp-Source: AA0mqf7p9AgPiCAOIaG+ECvuhU2pkosG4asy/jxfgRKwaoWuwTp9cjS7RxMPDbWQPh5hZoftcaFLog==
X-Received: by 2002:a05:6512:3a96:b0:4a2:2bac:e4fb with SMTP id q22-20020a0565123a9600b004a22bace4fbmr6197345lfu.297.1668507129567;
        Tue, 15 Nov 2022 02:12:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f2-20020a056512360200b004ae24559388sm2147963lfs.111.2022.11.15.02.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:12:09 -0800 (PST)
Message-ID: <9f17e519-b3fb-2ec6-7b49-70ee29d9b71d@linaro.org>
Date:   Tue, 15 Nov 2022 11:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: ad74413r: add optional
 reset-gpios
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
 <20221115095517.1008632-3-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115095517.1008632-3-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15/11/2022 10:55, Rasmus Villemoes wrote:
> The ad74412 and ad74413 devices have an active-low reset pin. Add a
> binding allowing one to specify a gpio tied to that.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

