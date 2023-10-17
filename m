Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1E7CCC73
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjJQTlF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 15:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjJQTlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 15:41:04 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8BC6;
        Tue, 17 Oct 2023 12:41:03 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso3106665fac.0;
        Tue, 17 Oct 2023 12:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697571663; x=1698176463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR3bNC3fTwfH0+mhYEnQAuVSq+ou4a66cQX/8jr0NI4=;
        b=NRaVK5o3/weqRS13rtDjVoYGGQFc3ZP4GFwbaBT4Y9Vq6hWD8B0LYipKnf/Qbm0WAC
         TgxGUSwRyX2Y6IyMG9APXfR2MyQ0j3KlnX4ftgnrwc/zLLLqm7sA7TQYY1jwOea/4SYy
         i/VFSKr/mkgYszBAF8Bhpi5wXyTIoP6lwgK+1HKWEx/17YzSS57+zJfibjDsjfk1LQjO
         7HQO0jgLp/DxjbY58b72IcakagpRAK1GVimZRUw6P5D8u+rFERVD0ZuCD5mT+orLAuS3
         gtssOTkKZ45uQQ30Vle2KlO9SNJvrXb8wqvInAIZoES65WlQthxdXH/jesubpabczHcd
         U6UQ==
X-Gm-Message-State: AOJu0YyESgxKsTB4BgsErkdwEvM5Oq7FqqBYN1XK0AFugGP3WyGHPYmQ
        H7MKcczEpJAGwBU70ZTLBsCBv7+X/g==
X-Google-Smtp-Source: AGHT+IGe43wxLK4YykHPPU0FQkbx4eJdg+n8Sp4kw8kXBTquDgR1Xt7DwrQ1p1kv7FxLUlj0E0nwzA==
X-Received: by 2002:a05:6870:11d0:b0:1e9:fb1e:870a with SMTP id 16-20020a05687011d000b001e9fb1e870amr1981537oav.3.1697571662697;
        Tue, 17 Oct 2023 12:41:02 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cj19-20020a05687c041300b001e11ad88f7csm379100oac.30.2023.10.17.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:41:02 -0700 (PDT)
Received: (nullmailer pid 2561855 invoked by uid 1000);
        Tue, 17 Oct 2023 19:41:00 -0000
Date:   Tue, 17 Oct 2023 14:41:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nia Espera <nespera@igalia.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/5] iio: adc: add smb139x bindings
Message-ID: <20231017194100.GA2560880-robh@kernel.org>
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-1-bb557a0af2e9@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-1-bb557a0af2e9@igalia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 16, 2023 at 02:47:01PM +0200, Nia Espera wrote:
> Bindings for a charger controller chip found on sm8350
> 
> Signed-off-by: Nia Espera <nespera@igalia.com>
> ---
>  include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> new file mode 100644
> index 000000000000..fe163cd8bbdd
> --- /dev/null
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license please (matching Qcom dts files)

> +/*
> + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
> +
> +#define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | 0x06)
> +#define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | 0x18)
> +#define SMB139x_1_ADC7_IIN_SMB			(SMB139x_1_SID << 8 | 0x19)
> +
> +#define SMB139x_2_ADC7_SMB_TEMP			(SMB139x_2_SID << 8 | 0x06)
> +#define SMB139x_2_ADC7_ICHG_SMB			(SMB139x_2_SID << 8 | 0x18)
> +#define SMB139x_2_ADC7_IIN_SMB			(SMB139x_2_SID << 8 | 0x19)
> +
> +#endif
> 
> -- 
> 2.42.0
> 
