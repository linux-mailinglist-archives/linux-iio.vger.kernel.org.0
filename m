Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC926AD92E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCGIXK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 03:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCGIXJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 03:23:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF6206BE
        for <linux-iio@vger.kernel.org>; Tue,  7 Mar 2023 00:23:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ec29so18207443edb.6
        for <linux-iio@vger.kernel.org>; Tue, 07 Mar 2023 00:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsvQEVxWDlGqG69PjKx9UwP7aecD3y/kUgXUmvfhHcQ=;
        b=lsQEz275pvH+8FEj/h7Ww0GEFcurhFSWm4+mdoMwomxK5qXxkz2O/re+ouGJQQUs2M
         yqgZlws2ppqtaEwPjP8/OIA0TaDB6hFJ4YPfu/twHafTCHBhb7e3ToeH8eVKGt6iEvSp
         q1vHYlnf7bGpikgLk1zIrov7DJ0xl+b11ROJ7DETq60rJR6PRcSlB3rWCNlrd5Ldt9Ry
         5kpNhu5TwJieQ+RhUUcqWk7CuGZXLdEOu7F/f916zkGuv82pE0E1kjmTUkYc8ujylZAQ
         J4TUYTAPwHBfWHNk4AXWXs3UOX4+VgyWEPf+ywmjvnY0nUt+VgkyCrNagRpmNEwj5pSh
         8gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsvQEVxWDlGqG69PjKx9UwP7aecD3y/kUgXUmvfhHcQ=;
        b=g47GlmMDjK6qdAEqhXfqefwPmR+cBcvAC6GEFmDSNF7H2178J0FvMH/lUKSSH7W3Hs
         /Nhr9hHHJJOwGDFOWQ6c7qZD9MG2oCFEgJ31ssupwd9oXZnuV+Uz3BZMaIRL6FZtC2x7
         92+H08uceyaySnPwgEjkYZhgRxvryY0Rlpozy6Z4WJBk3cI0hzsIp/D49q/C/QlOQfuX
         zaJLMT3o+1rACUXNjS4Q3rQNy7KvPaGMCxtcESK1emXpdFQfuCEVej/QOvizDuqvc83d
         cQL0NXGvtVEbxfBboSV5JwOAVVI710JhVitgzBP+Fagl7mZE/mbP9bs3lfNYkiyBj+kh
         /ubg==
X-Gm-Message-State: AO0yUKWHewz3NPDgqgTFLriTclVCdlDBYCgXkXe59y/UzlKrHokfQt11
        k18k5eMlMnFLVCLvc/ednGKpqg==
X-Google-Smtp-Source: AK7set/pI4T5zAiugz10LG3mVZbxPx0VWV8mlvPrlq47VZ6OHWxQlyt6zxG0+wRCbDHpRtbVbNP0Yw==
X-Received: by 2002:a17:906:8a72:b0:881:a3ec:2b40 with SMTP id hy18-20020a1709068a7200b00881a3ec2b40mr12386452ejc.59.1678177386739;
        Tue, 07 Mar 2023 00:23:06 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id y7-20020a170906470700b008ef13127b5fsm5714065ejq.29.2023.03.07.00.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:23:06 -0800 (PST)
Message-ID: <633b1e27-d148-62d2-ef83-2d0da432c0a7@linaro.org>
Date:   Tue, 7 Mar 2023 09:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/8] dt-bindings: iio: st-sensors: Add IIS328DQ
 accelerometer
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
 <20230306172249.74003-5-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306172249.74003-5-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/03/2023 18:22, Stefan Wahren wrote:
> From: Stefan Wahren <stefan.wahren@chargebyte.com>
> 
> The ST IIS328DQ is an accelerometer sensor compatible with
> the existing ST sensor binding.

If it is compatible with existing binding, then make it compatible.
Although your driver change suggests it is not compatible...

Best regards,
Krzysztof

