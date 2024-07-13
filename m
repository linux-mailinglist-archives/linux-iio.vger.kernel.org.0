Return-Path: <linux-iio+bounces-7595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7E93057E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 14:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA3D2831C8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B31304AA;
	Sat, 13 Jul 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu8rXhC8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299317591;
	Sat, 13 Jul 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720872040; cv=none; b=JS59GNeCbpIDZrWZ5K4o9+fL3EooMhm9iK3HtFsDLIZVqP2xS/Vm46W5gCbEOPznXkO2OlC2WQY6n5TMgN0cA4CBMezMdNGDs+JUrGKiXiHao+hMYjsBtMsOhyVaSosDAJ5TfvhZcBQvBkM9sUG57aHy6r/ZqlTUFa3gtI5tBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720872040; c=relaxed/simple;
	bh=iEq4hTsrFfGTbieTameYcuSA/DAZG32Kq1bRZTpIBFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntUKDp8gD5ltyVzEIZ+GVSVbpRiuVaJ7c+q/Xm0nI7v/kOZf9iMNIKQAMPRXxuF6WDUnGll6kooZrRDWnpMzZkkHyiLu/qVJJ0nTp5euo32aiPxfd6GVros+7OdAGOGMj4pAkZ89JKWNgEhRBPgO6CZXassCyWRq9H25NFDMBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu8rXhC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A321C32781;
	Sat, 13 Jul 2024 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720872039;
	bh=iEq4hTsrFfGTbieTameYcuSA/DAZG32Kq1bRZTpIBFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yu8rXhC8OJeD1ormOIiwXYd+oF+Esx1LkSFAR1JKhPenOyG+1zci8FyOQKcDvB2Bs
	 hMRLZk6thpQWIJy5MKc8W0dkW2/HXw9aReE2M2TztN/5BnE2FUknzvCljctb9VZ4Sr
	 xYd3miqCbC3JSYcmxtoGCpPFfjmNjT8naCGSJNiGXACrCQCW/R2hoaUrmp4ByIDqU/
	 hu1gKSSnxY6yRHdhCRFm+nEo+Ylstc+OaJWQPpMRKSrxhVdL0zAbvrYJcDq08+Ovga
	 bQhXJKUdXULEVbBITPOd5qGtSDIy+Tsn4xnzy04obfOqyI37iIn9dov40QxPWDNuWQ
	 IkKSjOCnFjcVw==
Date: Sat, 13 Jul 2024 13:00:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, "Thara
 Gopinath" <thara.gopinath@gmail.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Kamal
 Wadhwa <quic_kamalw@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jishnu Prakash <quic_jprakash@quicinc.com>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>, Ajit Pandey
 <quic_ajipan@quicinc.com>, "Imran Shaik" <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: Add ADC5 GEN3 Channel info
 for pm8775 PMIC
Message-ID: <20240713130024.27b9d8e5@jic23-huawei>
In-Reply-To: <20240712-mbg-tm-support-v1-1-7d78bec920ca@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
	<20240712-mbg-tm-support-v1-1-7d78bec920ca@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 18:13:28 +0530
Satya Priya Kakitapalli <quic_skakitap@quicinc.com> wrote:

> Add definitions for ADC5 GEN3 virtual channels(combination of ADC channel
> number and PMIC SID number) used by PM8775.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
as I presume this will go with the rest via the thermal tree.

> ---
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h
> new file mode 100644
> index 000000000000..84ab07ed73cc
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8775_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8775_H
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PM8775_ADC for PMIC5 Gen3 */
> +#define PM8775_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
> +#define PM8775_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
> +#define PM8775_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
> +#define PM8775_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#define PM8775_ADC5_GEN3_AMUX1_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX1_THM)
> +#define PM8775_ADC5_GEN3_AMUX2_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX2_THM)
> +#define PM8775_ADC5_GEN3_AMUX3_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX3_THM)
> +#define PM8775_ADC5_GEN3_AMUX4_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX4_THM)
> +#define PM8775_ADC5_GEN3_AMUX5_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX5_THM)
> +#define PM8775_ADC5_GEN3_AMUX6_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX6_THM)
> +#define PM8775_ADC5_GEN3_AMUX1_GPIO9(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
> +#define PM8775_ADC5_GEN3_AMUX2_GPIO10(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO)
> +#define PM8775_ADC5_GEN3_AMUX3_GPIO11(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO)
> +#define PM8775_ADC5_GEN3_AMUX4_GPIO12(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO)
> +
> +/* 100k pull-up2 */
> +#define PM8775_ADC5_GEN3_AMUX1_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX2_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX3_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX4_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX5_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX6_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX1_GPIO9_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX2_GPIO10_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX3_GPIO11_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
> +#define PM8775_ADC5_GEN3_AMUX4_GPIO12_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
> +
> +#define PM8775_ADC5_GEN3_VPH_PWR(sid)			((sid) << 8 | ADC5_GEN3_VPH_PWR)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8775_H */
> 


