Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53196F8472
	for <lists+linux-iio@lfdr.de>; Fri,  5 May 2023 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjEEOCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 May 2023 10:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjEEOCr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2023 10:02:47 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F96B61B4;
        Fri,  5 May 2023 07:02:42 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A70848469B;
        Fri,  5 May 2023 16:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683295355;
        bh=FvOK/5NmHWC6hBlswNcw10wjxr8Il3rr5UUFBtSyWH8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wbBUFp5XnRSN+AnXkKQnO+AXax5su/MmD2nZeMTQqXgxbkdzVX78J/LwR/zQw1Oba
         gF+ZA5EWh5+C4lGU80UE6mBM/8wrOsChaUVQaKw1ZAYwVH9vK16EdESBlxO0Lp7lAM
         1XXw/r0JQu5XHiH8GuwI/pdaGrg/VlEeFnizLQK/05ADC6jVaUjh0rGY1GkZjNKKaB
         Er0FzxrLkPAGLZ+3gEVUdGtoDOV4rdugzQyQGkn9KeiFPKxb6PhRT/EDKhAJreOQcT
         YleiA7pqaqrAyVOseJHjKFLKnf+/LjBuYXPaTu0VlZO/1oxgIocvuB9MyT3M1U9vr9
         GfoXLgOjPeDUQ==
Message-ID: <022b927f-7567-b1e9-56c7-8038cc5a42fd@denx.de>
Date:   Fri, 5 May 2023 16:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings:iio:temperature:melexis,mlx90614:
 Document MLX90615 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20230504194750.4489-1-marex@denx.de>
 <0f271a02-dffe-876c-3e41-5697c5917503@linaro.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <0f271a02-dffe-876c-3e41-5697c5917503@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/5/23 08:47, Krzysztof Kozlowski wrote:
> On 04/05/2023 21:47, Marek Vasut wrote:
>> Document support for MLX90615 Infra Red Thermometer, which seems to
>> be the predecesor of MLX90614 . There are significant differences in
>> the register layout compared to MLX90614, but the functionality of
>> the device is virtually identical.
> 
> Subject: add spaces after each prefix:.

I just followed the prior tags from the only other commit:

39616b4e4a02f dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion

But I also prefer the spaces, so added.
