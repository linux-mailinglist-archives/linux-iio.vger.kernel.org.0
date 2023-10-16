Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382B37CAA7D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjJPNxs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPNxs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 09:53:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626DF0
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 06:53:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso2024464a12.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697464425; x=1698069225; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOvRSIBCKDO/EoG06SNXpskpBSv5uHfI6z7Qbijhh84=;
        b=ZGfXHDIEVPsrSdi6s+cmpqGpouYUKTMnHCS0XjgyskuNwWucIDjhMF7sJdA650u0aF
         F6LffFSACGmJSI0ChVpnRRmsvDqaSedds+h4Pq2bhnEXceocq6j1uKfCv5VZk5GxK8LQ
         QGlBpWwk0qLq3vPnL4ILlwUdvrCcYNkzABzYzs1HEiKVKwYFehlXmDnkLhGVla1K6qq/
         5Dpoa8QwjjfdotnmCzsEhOl7rplTtfTMuEPnT6YtISlME/pEkSdm5bxTXeoB7YeiOgHN
         TGDg77JFPEL7UTIhgBoRUTcVz+P0KCmntScaYclCQVXVL3ZqPWrlU5GndpHBd/CXgr9e
         Hq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464425; x=1698069225;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vOvRSIBCKDO/EoG06SNXpskpBSv5uHfI6z7Qbijhh84=;
        b=HceUR4SasiuQ4MZ+0asK19WigIC3Ep0jvs7o3cqDLz2qTA3ANkdd6KSUyMA+i8H+7n
         fzl0v7ASgthm63auIe3JmT5JuPiBMuvziwxhk8OGRFvTOiTzoNhBV5Q/Ty2V4CUn7D3G
         gDD53U1ZzAmsIeXmPDrtN2rSD2d267fmZUYIxpUX2daBkHftHkllNebZk2vcboaH/noD
         2yR8lcK81NnPDt8cQ/0oo1owYWZ5QyTxn0G1LAQJ25tS2fssqhHqTrq8sJzzQJuEbQ/d
         VZBSuuHyFM29vDEdgWaAkq0O+3LA6nwMQQh+K1v9g/Foinuc5EbFNs9QzriwqCoKQDaa
         I2lg==
X-Gm-Message-State: AOJu0YyqkVXJJgNjZ+2OEVmUYixb/cIbADh23T0iMoWF0duJBjJZfmck
        UuVbkeMsSrS83hxQdp4DTKSz6w==
X-Google-Smtp-Source: AGHT+IHoxPW8PwdZUvfviYS7QdbDikx9yohEhHLS/XOTq3T9uH87ZFiSCdLJimiupbVDzkcfzqrchA==
X-Received: by 2002:aa7:c549:0:b0:525:6e47:10f6 with SMTP id s9-20020aa7c549000000b005256e4710f6mr29895269edr.22.1697464424717;
        Mon, 16 Oct 2023 06:53:44 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q18-20020a50c352000000b0053e9352643csm3015296edb.62.2023.10.16.06.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 06:53:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 Oct 2023 15:53:42 +0200
Message-Id: <CW9WX2BFW95K.2PHV8UU363BFE@fairphone.com>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <phone-devel@vger.kernel.org>,
        "Rob" <Me@orbit.sh>, "Clayton Craft" <clayton@igalia.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 1/5] iio: adc: add smb139x bindings
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Nia Espera" <nespera@igalia.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
X-Mailer: aerc 0.15.2
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-1-bb557a0af2e9@igalia.com>
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-1-bb557a0af2e9@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Oct 16, 2023 at 2:47 PM CEST, Nia Espera wrote:
> Bindings for a charger controller chip found on sm8350
>
> Signed-off-by: Nia Espera <nespera@igalia.com>
> ---
>  include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/d=
t-bindings/iio/qcom,spmi-adc7-smb139x.h
> new file mode 100644
> index 000000000000..fe163cd8bbdd
> --- /dev/null
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
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

I think you should expand qcom,spmi-vadc.h with the 0x06, 0x18 and 0x19,
in the ADC7 defines somewhere below ADC7_REF_GND.

Regards
Luca

> +
> +#endif

