Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98185A0FEA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Aug 2022 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiHYMEp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Aug 2022 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbiHYMEo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2022 08:04:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50669A6C39
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2022 05:04:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id d9so3136787ljl.8
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2022 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/aAGWIDmltGqXOS1ncXoIYBBvj6+VUj5xGoOzvsU0MA=;
        b=AC7iwM+IU6rZ2DikNLEp56ucV1olYMqe5wPpPx5IJcqfDfIwnjZsXq/r18dgvyR9gy
         VpZuBNdAqojv/7IkgmQLq2E8XyGHApvRu6J8P2q3nEPrFKj1UkdMqnL5TP6VdIY7j6Mw
         uORdf9m7tt4x4PGKy0ZA3snFXrGETle6kJDRZWR/RNcj/fawcnaYbOOzJgfBBzJbvYBy
         tQRDi9nBlFRZB7FOip+qeTQdHflXlM5s2JaZfH60KNK60c7aujOfOuzs++8nIWce4lSk
         /oJ/keczT8JhhPHJ1ybwzx4sm+o79v5xZU3u5Z+JzrJOTkQyTjYcX4vzv3P6u7aAnUpM
         41Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/aAGWIDmltGqXOS1ncXoIYBBvj6+VUj5xGoOzvsU0MA=;
        b=uAwWh+W3t0h86Zcem7QSwHcS809JVrRY/rb6zcDqNALmoNBD9lPPPPQP+P8p/NVDje
         WnKzsNgArt1DWwZSCeqkH9nHFoSybo/YcOdcUIhqq5wVLcdgi/Gf0ybXJYz7od+nmG0v
         DfprebIlcUoABdC+oMgrDXj/5HtT8trtrW0VE32GaggpS63xqNDQajc7gkTXAsR0tzK7
         RG5hwWuXk22S4xdBY1ZitqpVJE8G56MeIaTYgOaFUH3Ppwgg787vZ2tIASTCm3a6v7tK
         7z8245HhHzUMbkWAJHONahRI+ww45ppxjVkI6i00DxC+XkotCdPJNXkgw7cejDAiGwIu
         8tjQ==
X-Gm-Message-State: ACgBeo01N9MEessl7lvOFgz5//Kdy4z6BKjnAJ4lw67RRiLePp7aA54R
        iMbdTerUtgdu2II5ThbW4c87oQ==
X-Google-Smtp-Source: AA6agR42/GKcvjXHoKZTIcWaMOnISvqmUCz5H3K5w7VvlWmt0SgXX+Q+rpIDqNHTEiSTnkRLIymPBg==
X-Received: by 2002:a05:651c:2112:b0:261:b9c1:509 with SMTP id a18-20020a05651c211200b00261b9c10509mr1078828ljq.39.1661429076514;
        Thu, 25 Aug 2022 05:04:36 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id p11-20020a05651211eb00b0047f647414efsm460280lfs.190.2022.08.25.05.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:04:34 -0700 (PDT)
Message-ID: <99dfcc39-ab1b-1b24-c6b2-67de5509f5ac@linaro.org>
Date:   Thu, 25 Aug 2022 15:04:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: iio: Add missing
 (unevaluated|additional)Properties on child nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220823145649.3118479-2-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/08/2022 17:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
