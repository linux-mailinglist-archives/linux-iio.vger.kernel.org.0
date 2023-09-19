Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C784D7A6CC9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 23:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjISVPF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjISVPF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 17:15:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21331BF
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 14:14:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so7163593a12.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695158097; x=1695762897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+vdRAFQtk65RLgeHuJ32cdV42XxyxYfOdPY6ilYWbE=;
        b=J26pHuXLmqEkZfOZfiVHX/j2yEFu+26VI4v9QU+SyexeIJF89sITvHa1QdTLs4hEqi
         qOAovk+iFa1ZJf6NtF7LCVVi6cB4r9cquCdLZdgMzvTcKi2/YhVluZ1AyLJyh92WAosL
         L+nzhQyFPozlZy3vMXIZsB0e0ABYknFFLzgQi+N58yhqs+UatPoCwKricUYas1rdsi7e
         1c4N8uM5DAOERyVbiy30WT1EC5Ur4Iflxg2crCMf+K55PXD/xHIYnkGUYLJbGJBJL7Yf
         duy/nXxk/q4g1qCkKJH7X5OEPBlGOMWVDLZ/pmnbxTA+O/I+YVX9F5E13c6h6sgTdPJa
         v4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158097; x=1695762897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+vdRAFQtk65RLgeHuJ32cdV42XxyxYfOdPY6ilYWbE=;
        b=YxM4sRQd7Scl+stOCmSCThs7gvyTbNZwyNslwEkqF8UvejHwkwBOtc+Ge92er8BJhd
         r5xeWaIQzFGZIb9dGnvCoEH/i6qAh1qqPnUYkxZgqVXX3gAra9JoKOkYkLUWKZl5t9+W
         zU0kprDQTgOc9kKjk0NO7DvwDd8+9Bj7nHbGZmwPeUpbxwx9tgBj7BbziT7dOU5dPWTG
         s+KJuYPOyhSgeekrDbrKXIxAWe1bqawwpXBsN9pdl/S3ogrkHuOat+x5b/CV6x+COJjK
         kuRzRkBZuLuRY6WVb+xJf20/Nqpz6NITlTRaG6PB8Yk5oHvWeV51qb1vJ3EUyOaitt18
         gV+A==
X-Gm-Message-State: AOJu0YyE3dwvquX4XMXYItzmgKCo2qLiiLjX1yD8v5KvjnC6Xdgw8hI+
        oj4eylTcLW8I8gy0HaYSVfThyw==
X-Google-Smtp-Source: AGHT+IEAwmmlWU6JGwfOt0t8pmOBkmRPfnSE4PoNAZ4c3slAcim9P7D0V4hcCEc/BynXzi8SCuX8Ww==
X-Received: by 2002:aa7:c54f:0:b0:530:ccf7:37af with SMTP id s15-20020aa7c54f000000b00530ccf737afmr508015edr.12.1695158097495;
        Tue, 19 Sep 2023 14:14:57 -0700 (PDT)
Received: from [172.25.80.155] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id b17-20020a056402139100b005259dd903e5sm7865359edv.67.2023.09.19.14.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 14:14:57 -0700 (PDT)
Message-ID: <32cda956-8c13-9f06-1fd6-b7ad0e4be6d7@linaro.org>
Date:   Tue, 19 Sep 2023 23:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 18/49] iio: adc: qcom-pm8xxx-xoadc: Convert to platform
 remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
 <20230919174931.1417681-19-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230919174931.1417681-19-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 9/19/23 19:49, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
