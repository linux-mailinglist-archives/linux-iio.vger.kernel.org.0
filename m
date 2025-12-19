Return-Path: <linux-iio+bounces-27198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E431CD00A5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A45304DEAE
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3732D0E2;
	Fri, 19 Dec 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwPgOcAa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6wbTPhx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0D32C92A
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150147; cv=none; b=PfuF+sOx7O+jmNfZSFoRHwCGfieFEursKhgKN90lVf8b1pzpeseQSxQMzjkDEEIKZutsvIUU3mWHky+Qk4PnMrL6dCGDpc4Xff5Av/udNOCI7Hj2EpnmT4dJRS5WKe3sfzpuHlamWm+idWZo2gmOgKnZ1o8fGPio9vMet/KxUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150147; c=relaxed/simple;
	bh=mtVvIUS/JaJUCoLQVXSOzz/8MiesNRzguGmPjaF5OIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xye0089+WHRErzEiduWqslCR7KuV0a/BNzeWXqekE4A5rjvT2E4aAI+GBxsp8iSJOtevbjxg8VIQBxbdvZ9rzK4Qr7NxSTt/DE4d+WbeAPStbKLxKECMXr8wOEbY911JpAovhvxrqXqvoIh5KjJPf1ztmGSLWlNLxpfj5wrox/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwPgOcAa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6wbTPhx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJB41PL3939222
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UpN1l31PtsvvDzVVzcUO81N4UuEt2F++NIEqhVqZxkU=; b=VwPgOcAaZFwHecay
	WVwKGTlViyarYjlj0bZgxWoqkOsBLYJ6mdP17LrBMetlkdSGNhIfv+0x0E06zfMl
	uHuePSmbky9nqHkcEGMBqV+SKZCtNluD/9bF43U3/sAX+44AKSO6drHhJuYNKxyL
	ikkeJJU8Tt8/g4mR0hj7cjqgz8UTSN3sRa/c3uBkBwdlg27otK0TaaacJL4bZKsb
	19UdktJ/BXsCsZt+mjN3HHoapKQgXEbPhKo1uT7undUZ01EYr5+yAt9ARXYHjET7
	Wy40XlvPT4cCKXyFPL6VIXzPrvKFvCWXz3lphEzLjSvL/k8dvBPrDBJYrDr/7nLZ
	sahnHQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c2re0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:15:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b895b520a2so2144481b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766150143; x=1766754943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpN1l31PtsvvDzVVzcUO81N4UuEt2F++NIEqhVqZxkU=;
        b=d6wbTPhxeimSNmfo/zqQTnpJtmnE6Qs0g1lydF2FRvD2eLzDoLPtt4MNOOt58ZRcL0
         pKZGbQzuroVSk1AxLPefuGZHrrYJ8ZIAHlEChFhariRVpG4PRIifkJIS6TQuIviSyvHU
         M1mpST/cPEDnP3Q3GDNEyp4WJ3pNTjLLdZOpf0spkYMWJzfKN8xcK47w+qIJeO58EMlS
         MMRQawOi2N28UkCeosLqqPbmgbf3BWpFpTBSnaMqSoaHQAwzCENALnQo9V5FlXAGvGgh
         XnBS+cmQQHQtSsdrdSvcgPJJMAh+DEyV/8E8caxee7Nq7GxKVw01SseZtF+fhNYuBScc
         s2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766150143; x=1766754943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpN1l31PtsvvDzVVzcUO81N4UuEt2F++NIEqhVqZxkU=;
        b=s9PuMAg+7/MxwF/pfQ1eZ1RwINqJ0J+TY4v86fckKaHo/xIPJLd/wYwK4jcBIbgdaj
         L8DZzryO6aKZ1cwNL5ED4v+bXkEhw2HbfUCqeFV7BvITm90z9hE4USwOqGbFd3xlSB14
         rwj38G/WmksBgRNq1lQNLhLy+F3EZu5xCTSur+U9q6lRTE2g049aT+RTWhe0qY9pIKlb
         qHLCaSotmFRidKCoOVwBcCqTfNC9+sss6Ews8juTWliY4vlBBOmHhq+X5rxFe9rZj5Ae
         RHnb2YNrxxKC29t5YLim10Y3FaOwLSxzii2c7wonWFuY1Y7mloacY09Vq01LUyntfXnt
         53fg==
X-Forwarded-Encrypted: i=1; AJvYcCXU9tcY7cdkTBn43f2tokXLXsk0g+7YbHDPMhVfzbpqeH6188Xiikt3OHOjiVjX7d9z9otTZrIVODM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQeik6+y0RdDa7Loqtr0FUloae4rn9A5tt4QLRKQ+pcYvGhRk
	Vfw25c2AnADe04q3MfpBfLs4S9xNR2rYxt4xT5RzxG0838m4WlHVmZotd8+l5L9coQWzPacW3ju
	Sw+jFDQT4Ymt3aHxPaJrI6BPyJrvTCQweQjWzEv4XK+O5MSW2FxgNODMidGw/o8g=
X-Gm-Gg: AY/fxX5djoVz5ptC6+zrSRIEfIm81KUrM4liM4u7vWVSHqQKQGSqYEE6GLbFICmuhxv
	+IV1XQY7KNGturm8rymyVJExUCZdUNQSyLZpmAnEOepxdTClHfshtveTUL2lMhfFD2ag7F7mwtz
	2nl3bQa2haUVfqrNAqbXCdojHq8B5cuyZvgjMFequ4IbdgafNe+SwePL9k4LVoVeOVkuUNfT55b
	ow9pfDPxwoSIhcokIFo/hLKkHfsfuo4OWMXsRWFK/qKBXIKazlHYsysFI8SRWgrJn09YyhZAglX
	4IaNwaGCMu1+kN2XljFDrt3GnY69dFqTpWmmDzZG7HExpJrjNm+pw7Wk5/OuzSSjOZFXWj2KmzG
	M5lcGKJuW2HAYK1L6XsPtMDaLJG7Guy703tZTKt1RnQ==
X-Received: by 2002:a05:6a21:6d98:b0:364:86a:46b2 with SMTP id adf61e73a8af0-376a9ccbb0bmr3024516637.57.1766150142711;
        Fri, 19 Dec 2025 05:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsxyK5lHLg3u33gOcm5o66CK8suco88/56FRjoiS6lVtwAhOZVk1W29HbjNE5Gu3ZcAxPv+w==
X-Received: by 2002:a05:6a21:6d98:b0:364:86a:46b2 with SMTP id adf61e73a8af0-376a9ccbb0bmr3024453637.57.1766150142120;
        Fri, 19 Dec 2025 05:15:42 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac06fsm2002400a91.11.2025.12.19.05.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:15:41 -0800 (PST)
Message-ID: <6afcb26f-6f6a-41ef-ac45-976e5e2f17ae@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 18:45:32 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
 <20251207165349.72f80659@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20251207165349.72f80659@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t1zKe9PV5RilvVagLMudQiI1RJ2mFHyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMCBTYWx0ZWRfX0SsJgecySjlk
 96OVjCVvP+XdjLhv00giddja1YLSJLNFVYp6FhiGzygcoqyHTEnvIBXqMs7z2HYwnU/Gw7IKJyP
 elhGrQ4MP6z2y7ktikIRVAHo8UH3LrttRPFksyG1PERhISeDvH/GUc32JsvMHIE/nVX4Au7+4c9
 Sc9iGMB+fL8NQBjyqi8uAoGapNMlVgTaEUwTrURKH9SIkB4FeckjGKGJ28/RXYGh8QqVfLrFdSF
 onJTqsPbQLaugsBl2hiHaPfBrIS6Ll5bXlJ3MaeO2hdB5qTBZh2JftP9PHSwrQzuILfLdzuAJXq
 MCaHQQinNX8BCSAJ7gvkr7C9j/Rmr5eCIWGinnXLu+oZZb8T5W0Z0fwvD/GAH+dBE6Ey+hdF2L9
 7n9WjGova4ziSc1wnvzrDOoTli2RCPJl2Kw2ZMevDA1wzL0eq7cuhhKtE2ATeUEcdy1IT2cVLCn
 zAcYhqHlBszLGho7MbA==
X-Authority-Analysis: v=2.4 cv=feSgCkQF c=1 sm=1 tr=0 ts=69454fff cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fLtpXVqzqxV2lCxwsoQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: t1zKe9PV5RilvVagLMudQiI1RJ2mFHyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190110

Hi Jonathan,

On 12/7/2025 10:23 PM, Jonathan Cameron wrote:
> On Thu, 27 Nov 2025 19:10:35 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>
>> One major difference is that the register interface used here is that
>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>> channels, which may be used for either immediate reads (same functionality
>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>> (same as ADC_TM functionality).
>>
>> By convention, we reserve the first channel of the first SDAM for all
>> immediate reads and use the remaining channels across all SDAMs for
>> ADC_TM monitoring functionality.
>>
>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>> driver.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu
> 
> Biggest thing I noticed on a fresh review is that you include
> very few headers.  This only compiles (I think) because of lots
> of deeply nested includes.  General principle in kernel code is
> to follow IWYU approach with a few exceptions.  That makes code
> much less prone to changes deep in the header hierarchy.
> 
> You can even use the tooling that exists for clang to give you suggestions
> though search around for config files (I posted one a long time back)
> that reduce the noise somewhat.
> 
> Jonathan
> 
> 
>> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
>> new file mode 100644
>> index 000000000000..46bb09424f22
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
>> + * of type ADC5 Gen3.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/delay.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/regmap.h>
> This seems like very light set of includes.
> If nothing else should be seeing linux/types.h I think
> 
> In general try to follow include what you use principles (loosely as some
> conventions exit for not including particular headers). 
> 

I have a question about this - I'm including some header files in my
newly added common header file too (include/linux/iio/adc/qcom-adc5-gen3-common.h).
Do I need to repeat those in the driver files where this header is already
included?

> Sorry I didn't notice this in earlier reviews!
> 
> 
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> new file mode 100644
>> index 000000000000..effd4bd49989
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> 
>> +/**
>> + * struct adc5_chip - ADC private structure.
>> + * @dev: SPMI ADC5 Gen3 device.
>> + * @dev_data: Top-level ADC device data.
>> + * @nchannels: number of ADC channels.
>> + * @chan_props: array of ADC channel properties.
>> + * @iio_chans: array of IIO channels specification.
>> + * @complete: ADC result notification after interrupt is received.
>> + * @lock: ADC lock for access to the peripheral, to prevent concurrent
>> + * requests from multiple clients.
>> + * @data: software configuration data.
>> + * @n_tm_channels: number of ADC channels used for TM measurements.
>> + * @tm_aux: pointer to auxiliary TM device.
>> + */
>> +struct adc5_chip {
>> +	struct device *dev;
>> +	struct adc5_device_data dev_data;
>> +	unsigned int nchannels;
>> +	struct adc5_channel_prop *chan_props;
>> +	struct iio_chan_spec *iio_chans;
>> +	struct completion complete;
>> +	/*
>> +	 * lock for access to the peripheral, to prevent concurrent requests
>> +	 * from multiple clients.
>> +	 */
> 
> Whilst checkpatch is dumb on this and complains if you don't have a comment
> here feel free to drop it as the one in the kernel-doc is enough.
> 

I'll make this change in the next patch series.

Thanks,
Jishnu


>> +	struct mutex lock;
>> +	const struct adc5_data *data;
>> +	unsigned int n_tm_channels;
>> +	struct auxiliary_device *tm_aux;
>> +};
> 
> 
>>


