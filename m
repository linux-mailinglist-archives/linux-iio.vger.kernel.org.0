Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E855C5F2
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiF0Opb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiF0Opb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 10:45:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC3DEF4
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 07:45:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so5792439wml.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IWftomwLpTiMw5geHf9NLR9Uy1YW4MKMGZNLZyCJ+bc=;
        b=u58UnEiLCenA3bkmghyAMBZIb86SCyentNc7dQ60BekrjXgleen868tcyhopyZYiZ9
         bnEl2TCSt53+J8VPJ/nhK2qrtAWWyhl+IHC+1g10BKZ0qE/ThORTfQtraJpM3Ws7ttPu
         w87P/a2ClHh9YFEqB6sHhtd7ce/m3qj8LajwRgkyKutYiPuxkE8dXF2pepzbHaahr6IT
         6mDSUtHC5qUYZ7uai++Xyxle2mVfaqg7T4wQx/jcyyhY1sC/ZUhZKnZF48VR/VZ6r6Ar
         tjIRXb1mL5BkNNwkYffH4KURKN/0fTc+kZHEj2AVX3+N2DymnDdrQwQsRaeLpArVarS3
         oMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IWftomwLpTiMw5geHf9NLR9Uy1YW4MKMGZNLZyCJ+bc=;
        b=a9TKADXOHSKEalgIC8S1XvyUtIXBFQlHq9Hdfr8R7OwfYUrc7G2vN5ivvNo8M+QP7x
         24UnxU/BOF8KRY6K9aBcdzL61bGBGg7UdgeiVOiynHe5f5z0R2wcgzgdgvwj0+X3YpV9
         vUWyAhKOOf6ZWARVJfKyEJ4GeSnwgiMzbHrcniiPunwq0RFe3iQRWOMxiP2ah5cafPQ0
         jpAwM0lTMWa5vENmDju5F/X3S51swvJrPYiB3Bvio8tZDwtxwoN1GCpko+IdZtwLaEWi
         CMG2LjO6iId2hbwWvml6wWvhPacVrS8ZmyLiighHvpUvxLwL8w7bogtQAyzQvW2JFeYS
         qbXQ==
X-Gm-Message-State: AJIora/Zbrr7C1on7zVMPhJ0umgzqzXjBpGLtefySqM3oxcHX9mc53b9
        mi1XSP3UHSub9f7bbMUbhzmi5Q==
X-Google-Smtp-Source: AGRyM1sfNhSDiCgHA/3p6XuvTHhCHDdov0mWMWx5YqxERfwth6tRMz3r/f32ul0NmJFgm8TKdtMPKg==
X-Received: by 2002:a05:600c:2207:b0:3a0:4659:a0b0 with SMTP id z7-20020a05600c220700b003a04659a0b0mr10689793wml.48.1656341128793;
        Mon, 27 Jun 2022 07:45:28 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t18-20020a1c7712000000b0039749b01ea7sm16304940wmi.32.2022.06.27.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:45:28 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:45:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: mfd: Add mp2733 compatible
Message-ID: <YrnChlCiyzgcyyxl@google.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615145357.2370044-3-sravanhome@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jun 2022, Saravanan Sekar wrote:

> Add new compatible for mp2733 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied in place of v1, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
