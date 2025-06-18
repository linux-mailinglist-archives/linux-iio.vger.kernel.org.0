Return-Path: <linux-iio+bounces-20779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301A2ADF6BF
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 21:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810F2561D68
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F3720E00C;
	Wed, 18 Jun 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b="a7HkDahI"
X-Original-To: linux-iio@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF71A2632;
	Wed, 18 Jun 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274393; cv=none; b=fH+8ZhcnV0GVfD8WQi75GzDVIm8vajiXVxck7NndaXbODnEZqnhGpSeKoXaaDsvSaIC26X+jGvo/di7Dl79Tts0iBwJVOt6bgtkcEXLDBlMwiQ+M64QkfsAhn0qTKrToOAA291GuaXZM1XCLyKGlStaep7JkQBihmDqc8HsFrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274393; c=relaxed/simple;
	bh=l+CGLaIk4eVguzrZZFsUdEtSHXK3ZjcP7ggXpAQ0o8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhpTFSNppSOwVAHwuS5NX1HTOP9hZQyMlLB6/7o+Keii12yK11ZlBOiJeThXksuMls4a3onv5LgKigHReTbT8cFP/vmUFaYHlwNF0w/ASNC2VyzVZTilwlXevuwVSaTTj21tsvCSgAAqEYkyuAjhOCI9S/wPQnLFNn7JnEcxwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucaweiss.eu; spf=pass smtp.mailfrom=lucaweiss.eu; dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b=a7HkDahI; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucaweiss.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucaweiss.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lucaweiss.eu; s=s1;
	t=1750274383; bh=l+CGLaIk4eVguzrZZFsUdEtSHXK3ZjcP7ggXpAQ0o8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a7HkDahICdgPiRTpNg1HTPNq5u+XQyHBc8SKqAd/jak7dPWPOY0f5KQXCP0JF9LkR
	 406IVwmhHOjhKffoYccr40dotXqjdddNrw+xg5DKmjqEvT+sp3GHYu8dTmsbf3wB8+
	 xanZWfpue4k/l74iwyWnPFICi9MaTQYX06Oav0Oc=
Message-ID: <ea183f5a-b4c8-4dc0-960f-dba0db5a5abb@lucaweiss.eu>
Date: Wed, 18 Jun 2025 21:19:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] iio: Add Qualcomm Sensor Manager drivers
Content-Language: en-US
To: Yassine Oudjana <y.oudjana@protonmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Sean Nyekjaer <sean@geanix.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 "Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Petar Stoykov <pd.pstoykov@gmail.com>,
 shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: Yassine Oudjana <yassine.oudjana@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
 <20250406140706.812425-4-y.oudjana@protonmail.com>
From: Luca Weiss <luca@lucaweiss.eu>
In-Reply-To: <20250406140706.812425-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yassine!

On 06-04-2025 4:08 p.m., Yassine Oudjana wrote:
> Add drivers for sensors exposed by the Qualcomm Sensor Manager service,
> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> include accelerometers, gyroscopes, pressure sensors, proximity sensors
> and magnetometers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

<snip>

> +static const char *const qcom_smgr_sensor_type_platform_names[] = {
> +	[SNS_SMGR_SENSOR_TYPE_ACCEL] = "qcom-smgr-accel",
> +	[SNS_SMGR_SENSOR_TYPE_GYRO] = "qcom-smgr-gyro",
> +	[SNS_SMGR_SENSOR_TYPE_MAG] = "qcom-smgr-mag",
> +	[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] = "qcom-smgr-prox-light",
> +	[SNS_SMGR_SENSOR_TYPE_PRESSURE] = "qcom-smgr-pressure",
> +	[SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] = "qcom-smgr-hall-effect"
> +};
> +
> +static void qcom_smgr_unregister_sensor(void *data)
> +{
> +	struct platform_device *pdev = data;
> +
> +	platform_device_unregister(pdev);
> +}
> +
> +static int qcom_smgr_register_sensor(struct qcom_smgr *smgr,
> +				     struct qcom_smgr_sensor *sensor)
> +{
> +	struct platform_device *pdev;
> +	const char *name = qcom_smgr_sensor_type_platform_names[sensor->type];

On msm8226 lg-lenok I get NULL here leading to a crash with the next call.

I get sensor->type=0 for some heart rate sensor on that watch. I've 
added this patch on top to fix that (excuse the formatting):

<snip>

> diff --git a/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h b/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
> new file mode 100644
> index 000000000000..a741dfd87452
> --- /dev/null
> +++ b/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SSC_SNS_SMGR_H__
> +#define __SSC_SNS_SMGR_H__
> +
> +#include <linux/iio/common/qcom_smgr.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/types.h>
> +
> +/*
> + * The structures of QMI messages used by the service were determined
> + * purely by watching transactions between proprietary Android userspace
> + * components and SSC. along with comparing values reported by Android APIs
> + * to values received in response messages. Due to that, the purpose or
> + * meaning of many fields remains unknown. Such fields are named "val*",
> + * "data*" or similar. Furthermore, the true maximum sizes of some messages
> + * with unknown array fields may be different than defined here.
> + */
> +
> +#define SNS_SMGR_QMI_SVC_ID			0x0100
> +#define SNS_SMGR_QMI_SVC_V1			1
> +#define SNS_SMGR_QMI_INS_ID			50
This instance ID needs to be 0 on msm8974 and msm8226, so I assume we 
don't want to make this a define but just add the 50 and the 0 as-is to 
the match table?

Regards
Luca

