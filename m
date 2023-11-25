Return-Path: <linux-iio+bounces-378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BA7F8F29
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 21:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D748281585
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70630CFA;
	Sat, 25 Nov 2023 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMg7kcfx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F53066C;
	Sat, 25 Nov 2023 20:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82379C433C7;
	Sat, 25 Nov 2023 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700945343;
	bh=By6S2NY0eBp0qntAaH6BVeBEX9Zm0qYIHhQZPhrXhuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QMg7kcfxfWqw0cPWEjfDtDjDsnhH6xqQ/g74kyPwOf65WczUoktH8rf7UC1s9rwx1
	 2BoQBvtaLmDmWwMq4xudZVfUd452/AddQ1o7k/+BieHAJ/RysG5CXslSROe0vseCCN
	 ztCjymuiTqk2XOtABhYotw1v7Ly7Dp0r7rU/h/QDVABPyQ7r4I8XjWdMKKthjl4FBY
	 31cKdJ7r2zjqXDrhExCCEvIasXcUaG3/KR3XeFXi2aYucmiXrJay1F3RdkGHmLJ3ZH
	 6pMJY64+aQGQgTOVXLgJIZVruVAmXalCXX/zndiSsjyiuqE+iGI95OWhIhXJVJzGnt
	 PR0iSxBWy+04A==
Date: Sat, 25 Nov 2023 20:48:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nia Espera <nespera@igalia.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Vinod
 Koul <vkoul@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 phone-devel@vger.kernel.org, Rob <Me@orbit.sh>, Clayton Craft
 <clayton@igalia.com>, Caleb Connolly <caleb.connolly@linaro.org>, Luca
 Weiss <luca.weiss@fairphone.com>, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/6] dt-bindings: iio: adc: qcom: Add Qualcomm
 smb139x
Message-ID: <20231125204850.02e0b9a0@jic23-huawei>
In-Reply-To: <20231111-nia-sm8350-for-upstream-v4-1-3a638b02eea5@igalia.com>
References: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
	<20231111-nia-sm8350-for-upstream-v4-1-3a638b02eea5@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Nov 2023 23:07:39 +0100
Nia Espera <nespera@igalia.com> wrote:

> Bindings for a charger controller chip found on sm8350
> 
> Signed-off-by: Nia Espera <nespera@igalia.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h | 19 +++++++++++++++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h         |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> new file mode 100644
> index 000000000000..c0680d1285cf
> --- /dev/null
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> +/*
> + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +
> +#define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
> +#define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
> +#define SMB139x_1_ADC7_IIN_SMB			(SMB139x_1_SID << 8 | ADC7_IIN_SMB)
> +
> +#define SMB139x_2_ADC7_SMB_TEMP			(SMB139x_2_SID << 8 | ADC7_SMB_TEMP)
> +#define SMB139x_2_ADC7_ICHG_SMB			(SMB139x_2_SID << 8 | ADC7_ICHG_SMB)
> +#define SMB139x_2_ADC7_IIN_SMB			(SMB139x_2_SID << 8 | ADC7_IIN_SMB)
> +
> +#endif
> diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
> index 08adfe25964c..ef07ecd4d585 100644
> --- a/include/dt-bindings/iio/qcom,spmi-vadc.h
> +++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
> @@ -239,12 +239,15 @@
>  #define ADC7_GPIO3				0x0c
>  #define ADC7_GPIO4				0x0d
>  
> +#define ADC7_SMB_TEMP				0x06
>  #define ADC7_CHG_TEMP				0x10
>  #define ADC7_USB_IN_V_16			0x11
>  #define ADC7_VDC_16				0x12
>  #define ADC7_CC1_ID				0x13
>  #define ADC7_VREF_BAT_THERM			0x15
>  #define ADC7_IIN_FB				0x17
> +#define ADC7_ICHG_SMB				0x18
> +#define ADC7_IIN_SMB				0x19
>  
>  /* 30k pull-up1 */
>  #define ADC7_AMUX_THM1_30K_PU			0x24
> 


