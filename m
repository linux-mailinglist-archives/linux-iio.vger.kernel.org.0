Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9F656268
	for <lists+linux-iio@lfdr.de>; Mon, 26 Dec 2022 13:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiLZMFg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Dec 2022 07:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiLZMFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Dec 2022 07:05:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DE25FA
        for <linux-iio@vger.kernel.org>; Mon, 26 Dec 2022 04:05:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so15719043lfz.4
        for <linux-iio@vger.kernel.org>; Mon, 26 Dec 2022 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDOG1nNqww0p51xUCX5Wfz4kekK1JrwlHQGDjtTUdkY=;
        b=XjgBvzjtzq6bVySlHC/+JcCxfjrMuyq3FdEQPNTHHpFPdVA6j8tK6DfeN4J5D8Gf+7
         sEWs5FXj6n4Gwk41IuHqntOgSa0XYX7NHb2Yb0LSgANqMLmqfhLeh6sYI/VVDJIxXJAq
         edGYAQAugWz1EUMFupOHulUJ936CqhCYkhkpJLJFL89j9C3NF07eNsyusAszp2yDNarW
         aU3wZZP8U7JRqeE8Jg5RdM7QoMTYQ9sTc/Rxh9uREFjpCyXKhsyANxNmL1IZa8KTxBsq
         T8AQJtbQVCEpplnprr8EWxaGYDFC/YhejCZ0sxX0SOYrK9geWb9aswituyo0azGmA6xQ
         K0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDOG1nNqww0p51xUCX5Wfz4kekK1JrwlHQGDjtTUdkY=;
        b=Bs5Q+GHZySt42SDT+LpD06dS3waCRq2qmCvPUb/55RtuK/GHrukXoboXfbnEoUJFZy
         obE21M2YjgRJd7y25OdAKrF7Jz3hOzdqVoBoXaszuH1plvTrXgfJ0kUY+Jpi6+4PAImw
         JNMlypmwRMSzXGHqWpmuQsFOldAZlBhfuWQkY6A8JhthWfICBrlZkxcxIPRKlySu1P6Q
         CeASCpU9Vxt1TyMNQyNk0ja8miux4BOi6v1JVN5AhILlsfELjbChdVhxQhd08GcwTdez
         dVdDET+ukSNxv9qkF8E+apYolLKpF8Ux69Jt2x/LptpNc6W8y/2lw7sRb6sYTiwfiEdZ
         Sp0A==
X-Gm-Message-State: AFqh2kqnHlG1SwMnM8DyJIx/AADehHyuGURA7qGM2kufJWC/IhRPwMeG
        ybSRcBS+c+kCxpO5ZY7sImarTw==
X-Google-Smtp-Source: AMrXdXtLmMapH2Z7oGlxxLsqWfMASMcRE81G/U10vhDC0zlztG+3K9AeyouqJ/+bss/PF8uD5OS31A==
X-Received: by 2002:a05:6512:3d1f:b0:4a4:68b8:f4d0 with SMTP id d31-20020a0565123d1f00b004a468b8f4d0mr6224655lfv.22.1672056330804;
        Mon, 26 Dec 2022 04:05:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m9-20020a194349000000b004b4ec76016esm1761638lfj.113.2022.12.26.04.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 04:05:30 -0800 (PST)
Message-ID: <6b533031-e46c-3c7a-9d7b-3118c5ab7219@linaro.org>
Date:   Mon, 26 Dec 2022 13:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] dt-bindings: iio: pressure: bmp085: Add BMP580
 compatible string
Content-Language: en-US
To:     Angel Iglesias <ang.iglesiasg@gmail.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
 <778a9d07ad1d88e036cc1ddd9c3fa53390b906a3.1671986815.git.ang.iglesiasg@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <778a9d07ad1d88e036cc1ddd9c3fa53390b906a3.1671986815.git.ang.iglesiasg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 25/12/2022 17:59, Angel Iglesias wrote:
> Add bosch,bmp580 to compatible string for the new family of sensors.
> This family includes the BMP580 and BMP581 sensors. The register map
> in this family presents significant departures from previous generations.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

I did not receive anything else - no cover letter, no rest of patches -
so difficult to judge whether driver is implemented the same way.

For this patch only, assuming it matches the driver:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

