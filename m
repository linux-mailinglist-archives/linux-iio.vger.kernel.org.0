Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098297CC85B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjJQQGc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJQQG2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 12:06:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B7F1
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 09:06:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507ac66a969so3106870e87.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697558784; x=1698163584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xvYIvKO+3mIU3EAawcs2ywj4vAenzsPefTCCzUDayw=;
        b=pQnEVIr0Xlan6GcNIOcP1aBX2wZxu2MaS4pBcb0hT2EmSlTCsbEtj7PnDDJi+gqbaj
         jR1R8D3j6eczOG2ps5A4M2V5oPE4Zxw+TztolhBNwsUThOeD7ujq8G2bqEHTm0evIa88
         IXzsAvD6et/w+twWTVa4WAZWKN5L5cgaHqZVWCMeLweKhrWBrAqtQjkG07etlGJ2yAOa
         HjcRzXfv6FKf2lneHtcqLWkBH/odjsQx6uyvfvZzQ18JSUdcScGevWPCXZQxedT9SgbY
         Qzm1muaiVgy7/3GP0sf2dqA2RZKxGFI6O6yY5sixfGVCw6dm3fl/qiqfL55uPzlotSQ9
         NNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558784; x=1698163584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xvYIvKO+3mIU3EAawcs2ywj4vAenzsPefTCCzUDayw=;
        b=oFNnG2O6uQ79cmjF1BJj003X5wzbb2JI4EdzSeHXPnutYDWq0Yh4LHXeDhJIGCjY66
         LyAxxaCY8SSG98ok/76HdMrmyprXih5O/wTMKP/RA0oin3xY/Puozr008BfbGG2q7ehQ
         qho7P1sTcaODdyxkZDpZeea0iAnrya7X/hhrz9CkAo9fJo2bB8eGSubB2X0uspJCsR/2
         Fj9dVQjpq07OJmGZzAHvflaenkooX1gPqxcNTejQaPCNFQ5YjeK4tV4v7RX+7aMcA44T
         NDGJi6fEFqK50GLrqJt8PIJHEJ8Zh2oyiATHIxaSZGeinjBA0Cr4UCA1CQkW69aF5Ugm
         m9vg==
X-Gm-Message-State: AOJu0YzAQgKoMATyi1dYonkPqVXT+PvB5zHexo+CcQ/VpnOhcp5OUfVn
        3pCDwBKLVboDfgY5RTJxhq6cFV7j7xZ9VmifPjY=
X-Google-Smtp-Source: AGHT+IHhQNyrTYgGeequm9qL3R/xX0Qa+zpfneS2Tc5Nq7DmGCHtImf+Fy/36eKebqA5lYzx+mCbPQ==
X-Received: by 2002:a05:6512:3ba4:b0:503:221:6b1a with SMTP id g36-20020a0565123ba400b0050302216b1amr2485376lfv.0.1697558783795;
        Tue, 17 Oct 2023 09:06:23 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w26-20020ac2443a000000b005030c533843sm329505lfl.154.2023.10.17.09.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:06:23 -0700 (PDT)
Message-ID: <dfa1699b-271e-42b8-a8f3-17baef37f417@linaro.org>
Date:   Tue, 17 Oct 2023 18:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Nia Espera <nespera@igalia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-5-bb557a0af2e9@igalia.com>
 <CW9WUOLK18R1.2HI2MM4P47HPV@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CW9WUOLK18R1.2HI2MM4P47HPV@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/16/23 15:50, Luca Weiss wrote:

[...]

> You never plugged the device into a USB 3.0 port? Should be trivial to
> test I think?

The biggest blocker is usually the lack of an actual USB3 type-C cable :P

Konrad
