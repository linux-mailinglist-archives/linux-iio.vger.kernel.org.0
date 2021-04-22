Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35053676BB
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 03:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhDVBV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 21:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhDVBV2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 21:21:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B95C06174A;
        Wed, 21 Apr 2021 18:20:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 4so9719179lfp.11;
        Wed, 21 Apr 2021 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DteZ2nWiSB1ODY2173dhIvFCb3CtLxUhJ2lFgomQ3T8=;
        b=sbHJ/r/nqJ8hUrngDEmyPCSWcbXH/Um57a/9Cymi3uJbxqDiBEfBvr9Y4VwvpwrJ7Z
         T15AajeH3gOE3zmTzzficptb6y91bIhNXnTe1zS4QP0WKpfom3c97Q/dQ4s3sAYIE9wg
         R4yv+eCUZE5zg/Epkwm03uUy+jwHVqz0CEs2QpyIeUnpMpf9iJ/rNYmKkGlTTOpkcYr9
         TzdMiNqI8V96xE7DymK+lJMC/zUUCuK+liFMeXR8ovmxPToFMkPi4LqADjh+N4jvtolG
         DShN4pWFpUzUCEa6kLt0HOf7ZHJBPdLr9cjSk4zkPuEsgjH++eOG4TTbEjp9YKxVI3cB
         x+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DteZ2nWiSB1ODY2173dhIvFCb3CtLxUhJ2lFgomQ3T8=;
        b=pKYtTggqxmcIKBOiPVlYxhSkMXFYG+zcfvWJRQqqqZCLchKcUVQKEk8fWF46IKph4J
         7wnoHZoWE8EatH+27Ok1zsHQg6FGG3dFClMjTLqqp5G3pTLSgmMVYgrf1W3wZLl8+Ahe
         6ePKXilY4FHvjbkaRtzujPeexQ9ESg4OGlzL+fi+CPEz5BCujfKswiBbaN3GRBjfr17v
         O7+rtv0vecI/Aw/2tz069sFUygNUKIqFd4s9Q8FtUs93ZMwnMf4LCAhcWDP1Nobrfpge
         VoL9oHwAaVByP5kMK0YZfQT9sg+TDGrdLDnpz83IjPGW7BJtinmFxJUDKLIozteLftrn
         afJQ==
X-Gm-Message-State: AOAM53235My5QwgXVFlu/C4yNAvlgrp6RGu7fz4bLApezLY8VQAhEsdb
        rKB5R3/Zo+NhPUirVTRxohfP33Fc+fg=
X-Google-Smtp-Source: ABdhPJxN4KSYM+z6XfNnvBFfEgaDpvZHIsNsDonEkjeTTWLxxO0b7pIW9+mC9y+ka6AatjmiW0/3GA==
X-Received: by 2002:ac2:499d:: with SMTP id f29mr645481lfl.337.1619054453382;
        Wed, 21 Apr 2021 18:20:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id f11sm111151lfr.119.2021.04.21.18.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 18:20:53 -0700 (PDT)
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Fix reported temperature value
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210421234820.32211-1-digetx@gmail.com>
 <CAHp75VcuU_=OxdFo=9cxDtguCTjQ4jQytFzHUb3WoxJgcwDFxA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4a52b38-733a-f800-52f5-0b98acf360d9@gmail.com>
Date:   Thu, 22 Apr 2021 04:20:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcuU_=OxdFo=9cxDtguCTjQ4jQytFzHUb3WoxJgcwDFxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

22.04.2021 03:34, Andy Shevchenko пишет:
>     -                       /* The temperature scaling is (x+23000)/280
>     Celsius */
>     +                       /*
>     +                        * The temperature scaling is (x+23000)/280
>     Celsius,
>     +                        * where 23000 includes room temperature
>     offset of
>     +                        * +35C, 280 is the precision scale and x is
>     the signed
>     +                        * 16bit integer which corresponds to the
>     temperature
> 
> 
> “...16-bit signed integer...”
>  
> 
>     +                        * range of -40C..85C.
> 
> 
> 
> Datasheet says -30°C..+85°C.

Datasheet says this for the "Best fit straight line", while the min
value is -40C.
