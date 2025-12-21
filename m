Return-Path: <linux-iio+bounces-27270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F6CD40FB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 15:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D802B30084C2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432C221290;
	Sun, 21 Dec 2025 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3KIxPl5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gL4doBx9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9217A2EA
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766325947; cv=none; b=UjHiHrX+iRAB0FeeLUjYM/CaL+xzZvQKICCVVsYE6jacgPieMDsxpyl27yE4gzDzs2gPOQBb0TtiH+ab+mvHkqLiWy6OAtUmIRH9w67O+z3MNoVQX901pO1rMerLlMgJW6Tb2Y2ESGx0xmQXfCHsIi+tt3TRFal/a43HKjNXAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766325947; c=relaxed/simple;
	bh=2uYmkEPKGuiADtXD5Tit4rB3HxyeRaz24ds3lrdBBGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj1V/z2v1kI+jnsXJuUxzRmYYR80O86RwqVLpMRgtKMJ1mhMdyCD+1P6AqXwOdo4x94CpVXMilQwZ+Vi+kj6KMwUVWLimbF8mrLVCVTm/nj+Z3SWMW8DC1ddutotZBknqfNC5G+nYXOAXBVpaCDcA+oIQTxXg0RdljN0tebnB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3KIxPl5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gL4doBx9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BL9m9Xj1847203
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=; b=l3KIxPl5kIN4xNib
	myQ4HNQYCI5ceHdtPJpnvoXePGxZ2ALz/v36TDFMiscfK2cleq3yWzGnv4yA1sFz
	XzVlg00q+fnP0eOssShHUZbtAyANXY0sTxsf45OiR8JHuq7YBh4iVuLP4MvLZj61
	LG/rmLO/tsthe9Zz/dyeM57m8s3JY1ktS9dBgJQsRWKdKiU4a3TgUvIkZ4LG8XBx
	3F38pHhC6QePZMfGY6dtM719T7/4/22pIk3nqeskQ6XofIQAoGDrq5TidY2Wlhsh
	rNRzIM+WbSWJrCL4GngMPsmpTWGT0SczvJllVHHqwKsTx5oKQvCp4rtSDE+Z2v4D
	tJplqg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mtqjd1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:05:44 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-789535a89aeso43092037b3.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766325944; x=1766930744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=;
        b=gL4doBx9zRFgYcfkzIg8P//kXRE/b7pPJP1YUE0aTH6jKqP8NNGsn7GYVNNlwEca38
         EHJB1S81mPrRiVoUqzR8nQuWUzsAbZ3dnU/TU06q48pa6Ve/EyFVa94KTQapx8Cfh2++
         WbjcAmxjsEpM614ZG6cqEzkkINVRNpguyIWl5mYbXXbSCmc5Ubr8YMFnSuMAy/f/G+Jv
         HzBXNYzq7Gsv72/WbCoszAN2fRfcdMovL1X2+b2jXWY0UWR1g3nZB26kAUCEQCm9tDaN
         hNI1pyIMOHEadt9C97eK4pSDuTHjIT0F3wyn+cGsR5AzcKK8W/Qkfio/t0SNfQL8gfZj
         A3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766325944; x=1766930744;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=;
        b=mbuJtfjftCGx1/RyBFBBTAgQHKx+JvV7l4rv4YM+t9Rdn1hyUCY2UEX1q5cbz4eyDH
         qjdNyCKQszzSAa6R3/8xJDxKRiG2Df2fXUNjBJZXm0S6eCEjE+U7m6pD7ylMxR7FSNjQ
         w/hx5YwbgA3KNpqagHq9uYmnyf99jM66Z1iomXOrGTmOhHO0pq+yLGc4qoybqWHvFiCy
         XglNXw02QG3n2pTiJ1cnbnafWy5io/IvKInnLW9Ds2PrMuBBQQakUuNQTlDEjIGGRaEs
         LPVjf882uXD/0YCZHv5E0BI0BP/rSHwLqRl7E5jK17Dm0Mx4S4LuBO7TJ5W9X+o863R2
         khfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI8IlMJdVcjsgJrj04lr0V6KOw5b0jQjLxbLH1gQrGwd9XTOFPpKxWNgFC0b1Nvzscji1xk3Oup7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbGqp5isV4/IeTuHo0aEhhGwbg4X6jlafQO+PEGaUBVv+gc7l
	0ufltSPhmuJqbMTWvae5vYOogJbtoDdJZBVYlYUt+czcw2qmNFyQYVjT4beJlIZBgcp4DguMExX
	p+a/Dwpq765DtSK63wHJjoeJGIp9jrFX9AEV5LuNU7xDsze2+9lAbLKmzLsGcsTA7Kh7criE=
X-Gm-Gg: AY/fxX4FTUQDX+hKGy9hqRrAGtqNOI2Tb3ABb/NaD9gVYKE65HxRKR2ouLq7VBHqFrM
	uwMIAIsX607jdkCl5GA6s5RnQkGueDtJfi3NSURlpYMi9meq4f/kFMiLPRvQcrscfYKvEZ93bGp
	Jnx/sCsDSdj5to9LMsQP1NSnZaGJKFmhYNrYK7EmmFN7xhCr3By66dP2hJVfKy3NE0mSwXWTXoe
	dMzdAn4FiDcQgxSY8P1gatdfepXvmFNN3/l1PvYkMvauZ8qFEsf3fTk4ew/MjA8ukyRQQ1cQVBL
	cV9NjFJoFEKeJ9hUQV34HwTzsuK+6nvLTRGnpT0o36milPV87L3XJAy7MQNk0gY5fLqS14xyYuK
	8xQ798Yi0DqQd4WgPuX4trBCPHMggX3QoCbEKpLRo+LRO8h6tI8V5nMmz13shDJ/tOMAOcxPU
X-Received: by 2002:a05:690c:6511:b0:787:f72d:2a5d with SMTP id 00721157ae682-78fb3ec5208mr65067777b3.2.1766325944096;
        Sun, 21 Dec 2025 06:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENen467K+vyMFnVky42xzDMgtlkejuduc7jpwaaPmkE5REAaPMsWT7W1gXzapvi894bzqQ9Q==
X-Received: by 2002:a05:690c:6511:b0:787:f72d:2a5d with SMTP id 00721157ae682-78fb3ec5208mr65067297b3.2.1766325943596;
        Sun, 21 Dec 2025 06:05:43 -0800 (PST)
Received: from [192.168.1.27] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c16sm7312426a12.1.2025.12.21.06.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 06:05:41 -0800 (PST)
Message-ID: <9b363736-ac88-45bb-a428-7d3bccdc4d12@oss.qualcomm.com>
Date: Sun, 21 Dec 2025 15:05:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: adc: aspeed: Simplify with dev_err_probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
 <20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
 <20251221120413.7f1fa877@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251221120413.7f1fa877@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A6t67YYIjyiYjm9i4AgBY40iwEWOK1T5
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=6947feb8 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8od0x7llD9z3EFROJlsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: A6t67YYIjyiYjm9i4AgBY40iwEWOK1T5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzMSBTYWx0ZWRfX5kpXlHGEpse3
 IQ0p+52dUhfp2rBc8EXZKPHGfsJMxfiZZMl4bbInhwKzMmWjWAdNsCfUzcJCVYz7TKHbapzFuYC
 xOH72OMh/p8UHO19RaOo6IWwVqQ6nVCUCAIYWXahZz5z808AxmKr2olXsuXJjndw3FRQYhPofCS
 iOOlIwQRw0/7mYW22wZSCERpX3nn+rJGe0cBSvJmkLV8DED0iJ08a6SEmy9eLyAx9sOKdwG9rfl
 Vwnks79iSKtF/XlaDHIOCQ2+UAkjL6rv/UVcW1Ytu5mMtqQON1WPsrIYCqfsuwRgBX/EUvrmPVc
 NCZhPBlDOsZwKEUNDQWuykuq6uOD2UxQj7Rv4WeqcgGKKK3QOUisDQc3wzhjHHxV9vVuU2pA4k9
 NgGunaLTWCIyJSpwHz1DIf7FUEvHv6eZRaz4e5LnHprPk6qR7HkdlSwyfZiJMDF+e2sDlW4F8mm
 vqwel1DgNfPcja+ZLkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_03,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210131

On 21/12/2025 13:04, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 15:31:50 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
>> Use dev_err_probe() to make error code handling simpler and handle
>> deferred probe nicely (avoid spamming logs).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Not a comment on this patch as such, but this would benefit from a local
> struct device *dev

Ack

Best regards,
Krzysztof

