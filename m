Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E754DA3B4
	for <lists+linux-iio@lfdr.de>; Tue, 15 Mar 2022 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351347AbiCOUI6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Mar 2022 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCOUI5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2022 16:08:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F95623E
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 13:07:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 17-20020a9d0611000000b005b251571643so74847otn.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hL3fmuRINbdzHJQvKe2mMdjHIbsTe8oN2BbV9WR52C8=;
        b=ZL01UqOMEzhnAcJWVCMtOfoywb6HK6cWvkp8V+00U+AqmioLD/w/Ync8o0srPFYtEw
         odX+FfT1IKMIIw8oR79uTomLQwaJ4CLHB49ixxEPEcGQQelEsUkTejY0tUOP00VKTzWk
         VQfnSL7MYh+7Bpz+eGeQnrLdj55QOk/gVlEhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hL3fmuRINbdzHJQvKe2mMdjHIbsTe8oN2BbV9WR52C8=;
        b=WaLp32Ne3C9z011cjqcSKWrpS8PciZ+DK8EKUnZnP8yxL/RnGvGmNyacX3+t1htsys
         zDY/1JRh6dE9M0iQq4MC+r57253hNAXCV+Nxu9zOi+ftV1g1XCfPYhLjnzfI8BesYxCY
         aVoPQc6KmCPSaGasLkGTnEO3wTt3iYOUG5z4e2Z71GFULAKTE0L7dJtJhN46SNd4EYlu
         v3ajdd3xTmNFKjO2JcRwdUuUomKERMif15SrQM0J68FX4EluzgWbTtkzWWGkITCBiWQm
         Enz49KJvz7t9KHdoAzNTwc8e9a6Eduzux/1CVFonc7skuSObGPUErmErLGa6YTGAMMsL
         RONw==
X-Gm-Message-State: AOAM5320Qwz+SN70Rzfk53PenJVOEm6Yn0ADa8WLnhX9VTg8NrDFCH3Y
        L6+PbCksMf/rLtj/GnkZ2AK8MQUpCYQm9jy+nfOnRF2k8QI=
X-Google-Smtp-Source: ABdhPJyxSNch2t1uu+YyicSTPUIPFMH3uFPLXU3AUh0is91geyF3vHF3bzGeyq0XOPvOaoOaoqMxEEgIG+wKSrVxImc=
X-Received: by 2002:a9d:7687:0:b0:59e:da8c:5d32 with SMTP id
 j7-20020a9d7687000000b0059eda8c5d32mr12930643otl.77.1647374864501; Tue, 15
 Mar 2022 13:07:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Mar 2022 13:07:44 -0700
MIME-Version: 1.0
In-Reply-To: <20220315173042.1325858-4-gwendal@chromium.org>
References: <20220315173042.1325858-1-gwendal@chromium.org> <20220315173042.1325858-4-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Mar 2022 13:07:44 -0700
Message-ID: <CAE-0n51nWLLbQU_MJCg7s3EBcfnykuHzJ5mjqzhpmsDDmT6XOg@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: sx9324: Add precharge internal resistance setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-15 10:30:38)
> Add ability to set the precharge internal resistance from the device
> tree.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9324.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 1bef16437aa84..785af857b23a1 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -70,7 +70,8 @@
>  #define SX9324_REG_AFE_PH2             0x2a
>  #define SX9324_REG_AFE_PH3             0x2b
>  #define SX9324_REG_AFE_CTRL8           0x2c
> -#define SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM 0x02
> +#define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
> +#define SX9324_REG_AFE_CTRL8_RESFILTIN_MASK GENMASK(3, 0)
>  #define SX9324_REG_AFE_CTRL9           0x2d
>  #define SX9324_REG_AFE_CTRL9_AGAIN_1   0x08
>
> @@ -781,7 +782,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
>         { SX9324_REG_AFE_PH2, 0x1a },
>         { SX9324_REG_AFE_PH3, 0x16 },
>
> -       { SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
> +       { SX9324_REG_AFE_CTRL8, 0x10 | SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },

Is this 0x10 an enable bit? So it wasn't being enabled before? Please
make a define for the 0x10 value.

>         { SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
>
>         { SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
