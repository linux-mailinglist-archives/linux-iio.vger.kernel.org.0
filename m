Return-Path: <linux-iio+bounces-13419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B668A9F1159
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E48164573
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2E1E32CD;
	Fri, 13 Dec 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldGQ9MtP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101C15383D
	for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105047; cv=none; b=dPsAKlM4EC9qpD+oLUgnDmPgGx8jAof3NrH0I6kK1SDrhXZJ1eTXdV8UQH2PU4pHyPoDi/ZBqCC6EBHUTPCbewzuhtv9Q3BnYlgAcQ/Qli9aXei75KzfBFwNM1T2bPuPTkoBqbMxZQQbyrO8gDmAbVe+Rl1ToLQVCQWrFIzT1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105047; c=relaxed/simple;
	bh=AH4YC3G4oAqm/Dy3ioJZ79XaboCBCeJ5Sqlc8mVdEvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0ATgvawxC3B1x15giuOxCanQ6ArVxjdDkbTqML+bMLKuPAkCdAeRVF/gzEgMOLhIJcFw5KIyNENPkFNeThIfZN3n/1zOrMNqZQcs4K2IPqLD0RPfn+Cf7uWMMOqJVavkSmZ5r7iXP6OvA2oGZXeHxuMcSDKKASSvv+SZNgKkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldGQ9MtP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9nYXA017413
	for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 15:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4lWamNQAIDfM3yyUtey6LSacCJIPjLImwXtS4zXm6hU=; b=ldGQ9MtPJZ2QCo2F
	RrlTV+WYdn25DDHsj2e3mZI049VVUyl1EIgquJhPbXwWBnVw30GQ8SpqpOE0tjfv
	OxFLtcJ1iJs9a0qTp8Xxr6R6DCfdld+o+mkLV0dVEe3wrazbbzkJ6WSnIu3V1+zY
	PklmGuuL5g/l5gQUlkyD3R5xM6nvswao9FTVG0sobvYQPj3SEQKlans3hhJFpNA0
	qrKS2qBbots7YBYRduiD5TPOtkF4ghQ4uapPBDVvcw0yYcYfFjDav8Oh4BJDtyzK
	1GMHo90qrqd0fM13cR2x4SHy55CrfF/8CnsUsh565zCFzdHSgjKsqJ44QeFjXlDt
	Uy1oYA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjmt10pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 15:50:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8a3cb9dbfso4322036d6.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105044; x=1734709844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lWamNQAIDfM3yyUtey6LSacCJIPjLImwXtS4zXm6hU=;
        b=RrafSyitWK2x0eGlqk3shff6yqxtC9Way7oZYlwZMfXfmtZ5nXp4jYDUUl2q9chfKu
         t+JGFD45kB7VNP66ILxkA2KWUnrdDOPUUIoclWs0hgpanbLb9b/fwaB+7N7sHN2OwrSO
         D6XfJyudM+Iv4YV4FQ1jZ5o36+qFz+pcYMFrhH5NY9F7Kl2hflt8WVjPT02PdcIDRhUP
         NPm+qnWc6ij++0dHxmTqFGmf09kH8BCRATUCBU0pN0WP2x2qQrGfAVb0RfdUSdVFScL6
         CbtDcXvXNBmrJXiYYlnfWHQbCfbslvjHPz0Jp+pqBMsMUVGEB7BmaxpxS0klYZFNxaO9
         HUTw==
X-Forwarded-Encrypted: i=1; AJvYcCXzotTbAHEVB/BYY4sOtHC+XuKnnAeBJ3ac22pItS5pLsnwnSRW1UBCTF7t55vcaN0pXNmx44Tx1uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWT58oUMdau7l/qOYskXps3Vy/9Pop36IWtied6hkeX5ia+8ah
	uAQI4qJGq/Q3ZVt+Jni+1CSwJs+0wvxPMoIbYB38ZvyiKt4YvwYST81CTSkXfkTv4gR2MJDEIj7
	XIbGR5vaDSg4tKZ4pBbDqTU100Q7b9Yv4Fehyu/lqWQOrX6ZqIS2EQWX9Kv8=
X-Gm-Gg: ASbGncvN/EBx2x2C4uJbXIQw2iA9HJAiejG+HUTdD117XS5YgzjUhq74UUlyMPZLpyq
	6OwPEEWTGjdVMr9JN5j0gFACsrEAxBRP1RcBlkaQAP3Lprcl/UB2BwAdAp2XHPJtkkbONX4hAH4
	Afl/v2rfy06kQQ2GXUGSD6NBt5rC4T7jw2CpP/lU9VfMTzV/uote9jDRh+XkMjisCJjIidRgd6M
	Ts1/YS1CPleqQRpyhScY/Vbu+lTZ9Vd2QORmSayqpVlO3gAwwSIHacpbKeBJZWk7pKPU67CiEfA
	mWSuLue/aRaB03xqoiqj8oBPe1I6G1Kr57UD
X-Received: by 2002:a05:620a:4593:b0:7b6:dc5c:de2 with SMTP id af79cd13be357-7b6fbf402e6mr165105285a.13.1734105043600;
        Fri, 13 Dec 2024 07:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm8l6zBqCg8QGl9x4UXubkofdFN5ahIp8JE2QujG9aG5B1WdYVDkhDOOL+l9SSQJV+oU85hQ==
X-Received: by 2002:a05:620a:4593:b0:7b6:dc5c:de2 with SMTP id af79cd13be357-7b6fbf402e6mr165102485a.13.1734105043193;
        Fri, 13 Dec 2024 07:50:43 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3df2fc65bsm8769201a12.54.2024.12.13.07.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:50:42 -0800 (PST)
Message-ID: <2911fa29-1ecb-4d2d-a89b-2068f6fe3022@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:50:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5qe-g27PEGSFZOczMERFisjFUzl54cIp
X-Proofpoint-ORIG-GUID: 5qe-g27PEGSFZOczMERFisjFUzl54cIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130112

On 12.12.2024 5:11 PM, Satya Priya Kakitapalli wrote:
> Add PM8775 ADC5 GEN3 Channel info and bindings for the MBG Temp
> alarm peripheral found on PM8775 pmic.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 86 ++++++++++++++++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 41 +++++++++++
>  2 files changed, 127 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..909373eb758e4a8b7c2bbd0022c56ab2e823ca13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SPMI PMIC MBG Thermal Monitoring
> +
> +maintainers:
> +  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> +
> +description:
> +  Qualcomm's MBG(Master Bandgap) temperature alarm monitors the die
> +  temperature and generates an interrupt if the PMIC die temperature is
> +  over a set of programmable temperature thresholds. It allows monitoring
> +  for both hot and cold, LVL1 and LVL2 thresholds, which makes it different
> +  from the existing temp alarm peripheral. The interrupt comes over SPMI
> +  and the MBG's fault status register gives details to understand whether
> +  it is a hot/cold and LVL1/LVL2 violation.
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-pm8775-mbg-tm

The bus the chip is connected over shouldn't be part of the compatible

Konrad

