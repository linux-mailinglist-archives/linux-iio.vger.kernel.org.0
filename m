Return-Path: <linux-iio+bounces-23359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B6B3B708
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08395189E8D1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F223043CC;
	Fri, 29 Aug 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRyib/iq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A73043A5
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459253; cv=none; b=JqH6WiNl4emr27InKS4TaU6acLGsyW+K3sivUWKTbE+5MAs8Wa7S6+rCHJr7284CplmBLRVolTrajUomQZzrHL1HvJErJSxGGQ+MStZesYZv1yCImRbMhPeBkRxqzaL+Bw3frAMU8Me3h960fLCJBLm8xirvXqcfQbVTaP1rCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459253; c=relaxed/simple;
	bh=41cPbZW2JuUamvHD0ni/4zW5qEt98VIFHzay0uJyE64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktkQ/TCazm3pTEbif3MA4g4Q101vw9vLTQ/4FT5gSK9vB6eLiQM1kwjtXbdt4+caZqIX8G2/YYBXZoFI8s7uBl7byJBnZ+7z6d3GrS+9YngPg/4OsmPMHXLq76+VQry17iCFT7m4GZ248u8bMR5hQh09mnB7lFQuzfdj0VSAJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRyib/iq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T862Fw000762
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 09:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VsGRi9TWtut80xRESvMijlEz
	Jj+9BIG8rviOsUN+Q2w=; b=DRyib/iqMVUgY+4U2/xa1PZEfrNYqH+CO6TheLAM
	f754gQa0ypq9f/ZcukNVmys08FJn+FxHy1J22okyW5Sb8nIUWpHGAjLDQoBaSNyz
	Kv/+IfVKWqKJMBfn2XtQMUIC/lj1JBTbjMudKe/c0HfCVJCrclLXhYwxIr44m4Sy
	cyyl3s1k3F+H47dD7qF4OHNWDkXq3KGkP/uj15XGoBit9PPFJSTpwnYbaJlP+Kqv
	TpVVCx8N0k0FHJGoSYDC7Xk6lJVFiZklYyvXo6qOCXfbynPAjcT0VUMuqqPmfOhS
	Ze80Ap2WaPsTEU6KQ1IeVoOdZPDjKLV2RztEoLrPWKEMYg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5u7k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 09:20:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dfbead769so19280786d6.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 02:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756459249; x=1757064049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsGRi9TWtut80xRESvMijlEzJj+9BIG8rviOsUN+Q2w=;
        b=JvBPSw2FgE5kWLOJFjz8qqrV2Hkmdf2VZ8rv46dQh9PIztT16CLWD2AmmfmIeoKMJF
         SCdPppp8miKlWVmy5PErSpC9m554FYAYMuBR7TLpd9zSPQRT4a4bmLm1OxGurprcKg9g
         /8p9QMuRk/PFv6T+GYKq81+e+G/BMuOxcwxYAQDVjNoAompz907rJMSUEh1QR0QHSdwL
         vABwvaAsZ7fvf07Ac2TSp5+WZusf68Jo8ihZtPkXEEQ37svxpNhoZZ5KN+buxNquE6px
         74AoOQPHDdxYLASggWICihgbc2VLIjzEVp07/t+2Q2Ui1KaFXolIbqGLynjCsU/V9Hf/
         VCdg==
X-Forwarded-Encrypted: i=1; AJvYcCXsKvIxNC4YaJUV3LC777+Z+j+1saeg48hCGs1HERNW31FvZLLAJSIjDxUZrLqlyHbpERnRXu+g89k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaTDlgqzvsr5Kn2Qe4u6OFy2K18UDpsT7sxIkRbyiluWkD0DG
	MXWeAu/FB2s4lgBgkonHMbQBPWeMWblysT2TZJJQit5G3sFHYtfOPj6WE6aEic8tpF3Db3XycbF
	rFdcf0KHTVoyWYcZ6oFKjQ0cD8QoR23GZNqnmyTIYVhjbukMN1SJB572BJp1IEfc=
X-Gm-Gg: ASbGncsRJnLbSTHXvBf0e+z9heEN8GvR9KB2eNAUjesmf2BDYBLNnHTYfgU20XuoGKP
	GtYmo2EhrLmOoynMJE7jrG6VEqUs/QfYJj8phBh/EWWkmTUb8Uou6zsl1wHmGnPogKNb3BxhWhm
	d6v8rZLVrsakZdRJXqVhmAHo12gPE1tsJf5pRh543HhVPHfx8KF2MVPwZoYkXXO+VMQL+xqu3Kk
	Bb+5p330ND6IcI14RjdpBoZyDzwjCQfpH36nSfTprXbIHZo2wQcEPvsVP518BjRKdV66bjj1NdJ
	NNMoe+Sd+oPE+h/GBoz+jGipUMkOa6Ym2DLBSf3tcwpJEJZDev8/AyEvFyJtPfi21MZ3z94bzGU
	8F6OZrHECDoQ1puSGIWJExlJ2bLvlg7qZrPZ6ece5eIRxiHtoh7we
X-Received: by 2002:ad4:5ce4:0:b0:70d:d5eb:cb09 with SMTP id 6a1803df08f44-70dd5ebccafmr134046256d6.20.1756459249024;
        Fri, 29 Aug 2025 02:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+l8+GZuUy+NaTPLiPmyXfppCCrSzXfTWjiiARcq2CiwkxvRqPIvCjYJyzT2ulw8LGLrwHQ==
X-Received: by 2002:ad4:5ce4:0:b0:70d:d5eb:cb09 with SMTP id 6a1803df08f44-70dd5ebccafmr134046086d6.20.1756459248542;
        Fri, 29 Aug 2025 02:20:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336b9462e97sm2472451fa.11.2025.08.29.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:20:47 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:20:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <nsyhau4pnn2nbxdf35npwq4gvjiphocrftrwi4seirxqzurww6@6jgyzzmjyg7q>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
 <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
 <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6Gve2fwnwnRE
 2MQo9v+J4eU2NA5uforqdqRJmO+J+VffjC3RN7X233Kh6/87ZZoEpntgcyJjut3UJ7zKZCsSZa1
 34hsybYvac9QLuO4M6ManRE03O/QPMdo83Yo9ta4W3tCGG85WqFFkxD4+0wvxPP/H0V4B4PZPUN
 B1fbtQdRTtZV86xy7IFjavrcc3O++0nACIZf9NuQPazkM18WVRQ9Qi8zaJJxC3Nr25pGl4ZMScl
 6+dfqdiRQo8dYaZD3/aqbw73ElCqXd3aIZMrJZ89lp8EdBmke+o0q2/Xhbf/KUwjUTev3GMuhWU
 TIDR7Pa9DUf05Dey8LAFpe6VPF8AepCi71jhA08Om5KiFewNMzPDBuxHkNgGl7YwJy9jMWck3ge
 AqhWYO22
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b170f2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=cXZZpXjwJqeueyEXUCgA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: -ZQEyD317WiEZG0xjn6IKEEvfx4J9XRb
X-Proofpoint-ORIG-GUID: -ZQEyD317WiEZG0xjn6IKEEvfx4J9XRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Fri, Aug 29, 2025 at 11:11:48AM +0200, Krzysztof Kozlowski wrote:
> On 29/08/2025 10:09, Dmitry Baryshkov wrote:
> > On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:
> >> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:
> >>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
> >>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> >>>
> >>>
> >>> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> >>
> >> What's the base commit?
> >>
> >> git show 0f4c93f7eb861acab537dbe94441817a270537bf
> >> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf
> 
> I see:
> "Notice: this object is not reachable from any branch."
> 
> I guess you think this is 20250822?

Well, it kinda is. It's a commit by Stephen, it has proper contents,
etc.  next-20250822 is not a branch, but a tag, that's why you observe
the warning from gitweb. You can verify it yourself by manually pulling
the tag from the repo.

-- 
With best wishes
Dmitry

