Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56A24D675C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350649AbiCKRRb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 12:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350447AbiCKRRa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 12:17:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22F198EC8
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 09:16:27 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 371713F7E7
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647018986;
        bh=3ix8XaEwqnXAxmcHs/PYiSgYguAbESAsak2MuFDuRRs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GGel9XU41L8AGcLm105EgExuQjXMelTWvd1lySXa0wRLAmRlWA5hWdeggdy9BDc8N
         0wMjRldjGErJjqMaDylHKO3Q8M9JB0QUWJk5VgBOy5CF3U+AHliNVR0gsi+uMWM7ml
         d7cN54FtWxw9JpOklUx1Qmh6wk1wO2b55DhvgT0eucEa7vADFy+3SkI1tDb8aQm8Wf
         4Dz0pbfFNFeuPIy5zXLZhtKsWaaHIirg4v40a6nhcSvs6q1Awnvgdsw85rKgg42mIl
         Ei6/7HnicJgL9fzgeib2LrqKeFang2+BRBC4vComhUL6S4F5nyUDW9FBEZTWydAVLH
         xekLEM2pcmPzQ==
Received: by mail-ej1-f70.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso5262263ejf.21
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 09:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3ix8XaEwqnXAxmcHs/PYiSgYguAbESAsak2MuFDuRRs=;
        b=8RbaIM6fiyAW47P9uTiEfuvwhE0MdySc7fm2DcUJkPl2MyJwIn1Qzyldv8OkIJ/+4z
         /fxzS9yyNlgqZDHpuHWhvOwy4MDldWZgbcOwPSQjbGFgV+k2YprL3V+931JOS1JJB1eN
         +UuNQ2rIThyWDTL8/wDlX+xg2qq0TH4A3rYllC0CwN4mjZoakweRyiVzvKq89Te9XmbD
         OYJr1+qOK8IZKt6MW0J7gKzhe4wmrr/aYOkx2T7gqDAERxu3e2zuoTkErYUpNQaMIihC
         SfCMXJKG7vqBydBJN9/nwp9NxgVb2mEoTEWdddqcSjvK8lac7YneB3teYbgER3+KzTIs
         R1+w==
X-Gm-Message-State: AOAM5300TsxExt9A/8o8K4DuuaUWNZBCzF+HB/q1GB3ek36Oav5jJccU
        oH4dQxywdfEplIGIFHjsVNNHQKn0rW5UfGdTjGqNGlX9zlZS8kjZaOvcLt+L+2gGKEb+ffd/bfS
        XJ682nuYtZstUw+9Hyl1bHvBJsFWhusSjaodt+w==
X-Received: by 2002:a50:e081:0:b0:401:8823:c9a8 with SMTP id f1-20020a50e081000000b004018823c9a8mr9802456edl.401.1647018985808;
        Fri, 11 Mar 2022 09:16:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6Ejk8Ndl1YbVPjkJj6LbZfXV9rwKw5bSN2C9ns9NB8rRIz5kdDXUU5AylbFw5L3AsJUNmJA==
X-Received: by 2002:a50:e081:0:b0:401:8823:c9a8 with SMTP id f1-20020a50e081000000b004018823c9a8mr9802440edl.401.1647018985642;
        Fri, 11 Mar 2022 09:16:25 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm3170766eji.67.2022.03.11.09.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 09:16:25 -0800 (PST)
Message-ID: <ace67429-5982-a905-de96-b89abc97d36a@canonical.com>
Date:   Fri, 11 Mar 2022 18:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Content-Language: en-US
To:     michael.srba@seznam.cz, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20220311161600.1469-1-michael.srba@seznam.cz>
 <20220311161600.1469-3-michael.srba@seznam.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311161600.1469-3-michael.srba@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/03/2022 17:16, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> The difference between the ICM-20608-D and the other ICM-20608
> variants is the addition of a DMP (Digital Motion Processor) core.
> This difference is deemed substantial enough to change the WHOAMI
> register value.
> Since this driver doesn't currently acknowledge the exisence of
> something like a DMP core, simply copy ICM-20608 except for the
> aforementioned WHOAMI register.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
> changes:
>  - v2: none
> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        | 4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 5 +++++
>  5 files changed, 24 insertions(+), 2 deletions(-)
> 

FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
