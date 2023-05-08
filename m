Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82B6FA3CD
	for <lists+linux-iio@lfdr.de>; Mon,  8 May 2023 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjEHJvu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 May 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjEHJvs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2023 05:51:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046CC1FF1
        for <linux-iio@vger.kernel.org>; Mon,  8 May 2023 02:51:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so48337191fa.2
        for <linux-iio@vger.kernel.org>; Mon, 08 May 2023 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1683539504; x=1686131504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONPNjNHYnR/ydPkWIITuhB1nIjNs5oUMqENbi1kNTOI=;
        b=d8SxfPo7KuUQPCbwFjdrS+OmnHSMgledqH/IF/lPVzPbzksuSp7ouAFrmnLqcHoO7A
         bkbYiZB6ozLWHDtHBa4KYPXAocv3rr6yQK7khW9muW90E3V7K3rhuUM1NVDDwzG+pDb7
         MVwo+XGe1+KqffC52EZP5i3fNfW03UUR7EAeBU/bgcqYmyeuV538rET1NXBtidzNAMz2
         gt8nn5IaIbMaBkz3jTkBh5zsH3YypkRP6pLkATveX99X/Sb1xgfNq2ki0UuBsGURVy//
         FlWEULLjqLiiFQ0e84FWLCScDMhu89NWqNNiV77uW1aKB2V4pPxhR5lQsg/o7R6yPcUL
         ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683539504; x=1686131504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONPNjNHYnR/ydPkWIITuhB1nIjNs5oUMqENbi1kNTOI=;
        b=eI3/tWUex40p4Ol/Guva+blaRRHeSiRwaEJQmRtZ1fT8ST6wJn3a6NZ2m46oS/JEAS
         axL1a+deifSb2H9tys1XQDQY7Bx7Lc/rKj1gCundes6DUtJHfP2XdCaQ53oq+ir69pbJ
         /DbXFNPUkH3Qc841Cickdh9a2I5fuiSr+AyRI/DVq50aLd2xrEdlRKQW86pl833kIAXQ
         xC41nb5APK+zUxGNFuAhur90oOrxFdnrnehVEO+Fk7f8y/P4NQU9YTLLkhgp/MA4/b9A
         IZWPGqVL7wjoN91kyPC7fgmdVrWz278RYGQcLcxJ/D+HaiNXdk2PCrVD/tChrOFUlHUp
         sbKQ==
X-Gm-Message-State: AC+VfDw8vrrtFj7IxG4iIIc4DvAvtC4hxK6H6zhOHfwHAOTxQO10CVZa
        wQngy8mFpFp9iqw3H7xtVKdVX562bezjV8kRQKDDaQ==
X-Google-Smtp-Source: ACHHUZ6ftVLRNjF0ZTuItls03JLRAcgK9lOclWNuSbJuaoF1N6uRN/YAcYrLS3y/IH4nYsMagOnVLuCcrQw36j9CUqM=
X-Received: by 2002:a2e:9d47:0:b0:2ac:bd28:d457 with SMTP id
 y7-20020a2e9d47000000b002acbd28d457mr1757219ljj.14.1683539504193; Mon, 08 May
 2023 02:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230507184649.39290-1-marex@denx.de> <20230507184649.39290-3-marex@denx.de>
In-Reply-To: <20230507184649.39290-3-marex@denx.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 May 2023 11:51:08 +0200
Message-ID: <CAKv63uvfkV3aTvR6XsWNy_Pra5-4U4pve=Omax3Uy2Ud7kHWRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: mlx90614: Drop unused register macros
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I was retaining these macros in case future development would need
them. Since 90614 already has successor in 90632, I can agree to their
removal.

Acked-by: Crt Mori <cmo@melexis.com>

On Sun, 7 May 2023 at 20:47, Marek Vasut <marex@denx.de> wrote:
>
> To simplify addition of support for new parts, drop unused register macros.
> No functional change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> V2: New patch
> ---
>  drivers/iio/temperature/mlx90614.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index bd92b24918253..b0f69a7b05abc 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -35,8 +35,6 @@
>  #define MLX90614_OP_SLEEP      0xff
>
>  /* RAM offsets with 16-bit data, MSB first */
> -#define MLX90614_RAW1  (MLX90614_OP_RAM | 0x04) /* raw data IR channel 1 */
> -#define MLX90614_RAW2  (MLX90614_OP_RAM | 0x05) /* raw data IR channel 2 */
>  #define MLX90614_TA    (MLX90614_OP_RAM | 0x06) /* ambient temperature */
>  #define MLX90614_TOBJ1 (MLX90614_OP_RAM | 0x07) /* object 1 temperature */
>  #define MLX90614_TOBJ2 (MLX90614_OP_RAM | 0x08) /* object 2 temperature */
> @@ -52,8 +50,6 @@
>  #define MLX90614_CONFIG_DUAL_MASK (1 << MLX90614_CONFIG_DUAL_SHIFT)
>  #define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
>  #define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
> -#define MLX90614_CONFIG_GAIN_SHIFT 11 /* gain */
> -#define MLX90614_CONFIG_GAIN_MASK (0x7 << MLX90614_CONFIG_GAIN_SHIFT)
>
>  /* Timings (in ms) */
>  #define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
> --
> 2.39.2
>
