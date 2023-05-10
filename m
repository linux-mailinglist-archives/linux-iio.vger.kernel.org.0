Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51BF6FD854
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbjEJHfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 03:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjEJHeq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 03:34:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4387F76BA
        for <linux-iio@vger.kernel.org>; Wed, 10 May 2023 00:34:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso5672968e87.1
        for <linux-iio@vger.kernel.org>; Wed, 10 May 2023 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1683704051; x=1686296051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/0c8+dGHJ4NLXqQ1Qtv3iVBkUxH00g1cMxDDyZsiTg=;
        b=CBYw8TRCO2/ugYXBqDOHQ/r6QEZVhY6Y+97i+s+uKNd9oNd181pcavEyhsdDDYWZjH
         S7EsXcPaNVQgQ6rKRS8Oo6pOTsQ1y26XtBNGGO84SO1QAPTgjHEZEg/9GszRtylcU/uk
         Co2v0eFK/xbyrOvN4vmhULFlf3dHDchxPArYi3vL9pZcR0HjOpT38XxeWrUXdkMbTq10
         6EwC8k0eh8m/lcX2Z2uFbKe9IHSnii8ZOXGcRyqb/l3pfIKsDHoJT9xoFo9qOUO9RU87
         QX5HRRZWwbIzaml1dr4PAmvov5+Q9xvcAULtjn5sBiN4GEWZ1jiYfbSmSaSJjQPWgIXU
         djOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704051; x=1686296051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/0c8+dGHJ4NLXqQ1Qtv3iVBkUxH00g1cMxDDyZsiTg=;
        b=INrV+OZ0D4YGznrRlNRXfz3WDEhawRkNJYLKOxeNuErFzww2rrqbu9Jxvt9tyqWdB5
         Hp+SNr0ybggav4/T9lRzvR0dJK3peA8jO3Vgb/Rx7AYWw3cTR9OigWLlq0OHbdnfo6b4
         v9xGJkD2ZPYR2871vu5/rqoKwYrQZz7314BOdDxE3qC1v72XTbRMlV5EU6M0/c8Hu9Yx
         i713s97/ipauMFj0LHrEJz14fyRjPYXrXCwtgn0C7da+QwtelVQH6E2Ax/S0ytEZR7fz
         fM9tTFcAVOKl+Jj7IuxIn/92nTP8GN1ojaHbjKJW85HP+eA5kAIWPtxgN9LIBuIkvwkS
         xyow==
X-Gm-Message-State: AC+VfDztA2ng9ueu2brNyRoxEfIr96UbFj9/NDUK4H0OWGQRaqLGCiJG
        eE9pjxYEDWt5jYlmW2RZ04aVDBp/aVDIr91f3hD3sQ==
X-Google-Smtp-Source: ACHHUZ66I1c/FnItLm+TU8Z8/zle/CFQYO0aOJFZ04x+McYjBzvTDPvOjGdXkL/qjFniN0liuPknbzbH/LdC57VjYlo=
X-Received: by 2002:a19:a40f:0:b0:4d1:3d1d:4914 with SMTP id
 q15-20020a19a40f000000b004d13d1d4914mr1498012lfc.33.1683704051199; Wed, 10
 May 2023 00:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230507184649.39290-1-marex@denx.de> <20230507184649.39290-5-marex@denx.de>
 <CAKv63utbVqRjmyP_cN=d2Jewpp6hgVHzSJdm4gjKBkaHKb2LuQ@mail.gmail.com> <189306ca-dbd9-508c-a6ca-32199dbaeb79@denx.de>
In-Reply-To: <189306ca-dbd9-508c-a6ca-32199dbaeb79@denx.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Wed, 10 May 2023 09:33:34 +0200
Message-ID: <CAKv63uscjBSfkBMLR1gBRsu3=R7Quu1aReuGjnfQvh=aRsc6gw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: mlx90614: Add MLX90615 support
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 May 2023 at 13:32, Marek Vasut <marex@denx.de> wrote:
>
> On 5/8/23 12:10, Crt Mori wrote:
>
> [...]
>
> >> @@ -666,14 +678,43 @@ static const struct mlx_chip_info mlx90614_chip_info = {
> >>          },
> >>   };
> >>
> >> +static const struct mlx_chip_info mlx90615_chip_info = {
> >> +       .op_eeprom_emissivity           = MLX90615_OP_EEPROM | 0x03,
> >> +       .op_eeprom_config1              = MLX90615_OP_EEPROM | 0x02,
> >> +       .op_ram_ta                      = MLX90615_OP_RAM | 0x06,
> >> +       .op_ram_tobj1                   = MLX90615_OP_RAM | 0x07,
> >> +       .op_ram_tobj2                   = MLX90615_OP_RAM | 0x08,
> >> +       .op_sleep                       = MLX90615_OP_SLEEP,
> >> +       .dual_channel                   = false,
> >> +       .wakeup_delay_ms                = MLX90615_TIMING_WAKEUP,
> >> +       .emissivity_max                 = 16383,
> >> +       .emissivity_res                 = 1000 000 000 / 16383,
> > This makes me wonder if we could just drop the emissivity_res and have
> > it calculate it using emissivity_max, since both chips will do it.
>
> We can do that (i.e. change done locally now).
>
> >> +       .fir_config_mask                = 0,    /* MLX90615 FIR is fixed */
> >> +       .iir_config_mask                = MLX90615_CONFIG_IIR_MASK,
> >> +       /* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
> >> +       .iir_valid_offset               = 1,
> >> +       .iir_values                     = { 723, 77, 42, 31, 28, 20, 18 },
> >> +       .iir_freqs                      = {
> >> +               { 0, 180000 },  /* 14% ~= 0.18 Hz */
> >> +               { 0, 200000 },  /* 17% ~= 0.20 Hz */
> >> +               { 0, 280000 },  /* 20% ~= 0.28 Hz */
> >> +               { 0, 310000 },  /* 25% ~= 0.31 Hz */
> >> +               { 0, 420000 },  /* 33% ~= 0.42 Hz */
> >> +               { 0, 770000 },  /* 50% ~= 0.77 Hz */
> >> +               { 7, 230000 },  /* 100% ~= 7.23 Hz */
>
> Before I send a V3, can you please double-check these ^ IIR coefficients
> ? I approximated those, but I suspect my approximation might not be
> accurate.
>
I have reached out to the developer for the 90615 and here is his message:

0b0000 - Forbidden value
0b0001 - 100% - settling time = refresh rate = 205ms (around 5Hz)
0b0010 - 50% - settling time = 2050ms (around 0.5Hz)
0b0011 - 33% - settling time = 36900ms (around 0.3Hz)
0b0100 - 25% - settling time = 5125ms (around 0.2Hz)
0b0101 - 20% - settling time = 6355ms (around 0.15Hz)
0b0110 - 17% - settling time = 7790ms (around 0.13Hz)
0b0111 - 14% - settling time = 9225ms (around 0.1Hz)

It does differ to yours, so what was your source?
> [...]
