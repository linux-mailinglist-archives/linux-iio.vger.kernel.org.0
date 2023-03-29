Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB926CD48C
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjC2IZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjC2IZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 04:25:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B835422E
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 01:25:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j11so19080414lfg.13
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlL5AJavP2hu4YCn4uZIdbxT0MDCMysw5QI/NF+KLhE=;
        b=xSiwizA2gvOOxGCmFjenUoYz2LFRtI2BWEUqk8KpkI+U/KFbwXDKepKCtSs1emmZwa
         RbP4NQ0y89exg6fPYHtQFwlBG5AN4LlyZ9mOr2JyHvNd2CCcan67AZAei7xgkKnoOe+J
         WYEvjpVbwN6eAdPtkxaTmdVN5/fU8JlXu5UcHzkyNHypXPePWMg8tDgjopXle9UTEqLe
         i5iwJWzxzSzWAOaFIQQuQ3JObslSJi2afyKwDdOwuymWXoJ1Emlc4gpad6C4A6Xd99fd
         m25oKIg4pV7AYlyW4zFTRzW+RqPk9E4YbUbV6kJ7GuqZ7fP+sstxVK/nPi57mnb/Aw8D
         4V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlL5AJavP2hu4YCn4uZIdbxT0MDCMysw5QI/NF+KLhE=;
        b=wCQhTQ0xcGy8Uq8pStfWCiky5eOaNxnbEgjx9III5xge/no2KJyTfUBjECw6/Hu1wf
         YrgROn+/keIjhCrcn9Fj7mgp9cZ8dbgt/pUw/XTmNglU8CGjK1/rW0UL/3WlWaDGwk+J
         0f0C8DKoXtHwPsdlqMVW/gzP0YmSMoLyQ3IlFiul0tjxgIQcST7P4/DX38KnYDU9weTg
         5b7Y8+2o34JjD/npCvxG2JkVT50DWpCIuFCYpQFjDdZCCKpxdp8G8QAlj45W5URJHFOB
         IHBW7LI5xDeAff8DIR9I5uYkKPUDTUOgdF+fu7//5lrGFNyOnn7gKnifjFIE5ym74LVB
         fuSg==
X-Gm-Message-State: AAQBX9d/8hizVjTz2QFEgr28V7m1LPauYw5+yVOfTR76rgSv8OlWis2I
        UQ3fqITWvLii96B/S9UZdFVlfjDaTh7CvUgf8ZwoMA==
X-Google-Smtp-Source: AKy350YIuYx5LJI9QIHguDk4ssPlVpetYFxjbemVIF2kjh1ya13IaopQhgWsbqTv+IUZ/aNBUadH9w==
X-Received: by 2002:ac2:4352:0:b0:4d5:8f3e:7852 with SMTP id o18-20020ac24352000000b004d58f3e7852mr5278746lfl.49.1680078334494;
        Wed, 29 Mar 2023 01:25:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b004cb35b31b96sm5372230lft.257.2023.03.29.01.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:25:34 -0700 (PDT)
Message-ID: <23b2de4b-1198-bfcc-fd74-285da9af4fb3@linaro.org>
Date:   Wed, 29 Mar 2023 10:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Fix repeated text
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, devicetree@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
References: <20230329074614.1037625-1-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329074614.1037625-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 29/03/2023 09:46, Linus Walleij wrote:
> The description oddly contains a copy of the initial paragraph.
> Let's not repeat ourselves.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: devicetree@vger.kernel.org

Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
commit msg (Jonathan's, Lars', Rob's, mine, DT list). There is no single
need to store automated output of get_maintainers.pl in the git log. It
can be easily re-created at any given time, thus its presence in the git
history is redundant and obfuscates the log.

If you need it for your own patch management purposes, keep it under the
--- separator.


> Reported-by: Diederik de Haas <didi.debian@cknow.org>

I don't think it is a bug yet, so rather:
Suggested-by:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

