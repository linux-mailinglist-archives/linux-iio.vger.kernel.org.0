Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B96612A7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjAGX4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Jan 2023 18:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGX4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2023 18:56:35 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10618B20
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 15:56:34 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 188so5428056ybi.9
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 15:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0oToTwDnFH6g6hDh+EoePGFSIhLbzzaVsn0XI1Fj5Xc=;
        b=jLN7xnaIHIb6Y+hKXdNPw5fcuVVLcqaIlUDkZNp1Efrw0NgJ0OHF5PMgswgFzYGiGm
         JeMl8yBRhfNe1g4hZiHI6PFDZKdONh85cpkfxR74a5M63O+fGiVIgFw5p5T/QoZmTyu/
         VnxPJK9YWje9cHlrFczgCMK9X7jow3IO5zL8MIrjXl91Ey2KtTB8a2GafmCHMbJjfpWK
         7vJEDCEUnL6OaDJ3sV+JVqNkbTDBgPmU12KzNV+x1ApU62IdwqAzAlwrSGCHftiokRiY
         0bdP4tCMp5WlcldvR+vzc4f49AKqHOWLZ+rbQHNSghRzHI8IG61KtfoqFXEVYEeSyk2v
         4bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oToTwDnFH6g6hDh+EoePGFSIhLbzzaVsn0XI1Fj5Xc=;
        b=3NeEEs0GA0V0voM1Fd0+teXRA5x50ZG0FcW2YyqdSCE5RdRF5ndqweXIkbavEdiM+5
         JaMO2gY1a0OfO/wHzLw3ky8x2Qva5upb16imjsB7hMP1G4EC4QVoybpL6yYHEQw0asrs
         fgus09eObSJ5yMhJ9G0306pF2JrPgrXJ1d21Pb4uHm25ti+UKBCmSSznXQePbe1fDxMw
         eNxKRKp2QQ4kpUSR6rhY3oGleEvHeJqVV6oZs+i8RXvpC3ohqxjpZwkx8y5j4oor4Xse
         0ECmDC6souI0JjAtutcvMNCj69670Dbfo5lVPUueCwYUwLB4iJoq6/gI1860y45SBJ3O
         hnng==
X-Gm-Message-State: AFqh2kpqE9CVz1ugQoSg4+w9Lkl/haJjiqghp0CQPXZXesBM2tZ2KM6G
        H4lCNVHo0RN0uiD+ocPMwwRfP+8VsiRqfREzTK36Fg==
X-Google-Smtp-Source: AMrXdXv9BvmHeBIyHQiS/u/+zlClAetgPz+v7PKEjhfwaOBxSXehte1noGLiIx1Pu9BP64FJJ+qZCVNriH42jMop3kM=
X-Received: by 2002:a25:6982:0:b0:700:e0f1:6335 with SMTP id
 e124-20020a256982000000b00700e0f16335mr5290893ybc.520.1673135793948; Sat, 07
 Jan 2023 15:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20230106102239.9647-1-stephan@gerhold.net>
In-Reply-To: <20230106102239.9647-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Jan 2023 00:56:22 +0100
Message-ID: <CACRpkdbiQFumJek5WUh=dcxXDvOV=Dhd+WqCrzzyWJY+i-xKuQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: st-sensors: Add LSM303C accelerometer+magnetometer
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 6, 2023 at 11:24 AM Stephan Gerhold <stephan@gerhold.net> wrote:

> Add support for the ST LSM303C [1] accelerometer and magnetometer combo
> sensor in st_accel and st_magn. LSM303C seems to be more or less
> a combination of LIS2HH12 as accelerometer and LIS3MDL as magnetometer
> so this series just adds two new compatibles for the two sensors that
> are already supported.
>
> [1]: https://www.st.com/resource/en/datasheet/lsm303c.pdf
>
> Stephan Gerhold (3):
>   dt-bindings: iio: st-sensors: Add LSM303C accelerometer+magnetometer
>   iio: accel: st_accel: Add LSM303C
>   iio: magnetometer: st_magn: Add LSM303C

This patch set:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
