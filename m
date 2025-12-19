Return-Path: <linux-iio+bounces-27208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB2CD05A9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 138223009FD3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C8032BF21;
	Fri, 19 Dec 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="flCd99Wd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rk794HgI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542DA2D876A
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155635; cv=none; b=DGBWp5Nu9MPqUtaLAM64XF6JdbACwpMErYWcYbg8bJ5lOj6ZfE6HMnjeY/G46U8E/GUcAZEiFE/ihK5QbbYc3zStth+Uu+xw+obGQmS44ZS0V9kc4shK492EvhMN8/L9vNJVMTWFqPrnF+P9GOqZ7CdXOD8+TvrFtmEsYXRSeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155635; c=relaxed/simple;
	bh=5XjcOwMBg2ujPqV40PeKRngJIvkzbjW5EfjSJIsg1AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRv2niJud90Q3UNATfVoAPMc6hXdbhCW76o8Vm005Gm5vsc9Zk/Qa0EgyKvBGj/HVmXdQzJ3mn9S1O1ceCv2dz0RAoFLJUYb58qdN4rgyooX7ivHp+9QXoRI8ed7bh4y6JcYbLGOnbA9qVyW5PagaJ3tr6OSLV3OPxq++sLmCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=flCd99Wd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rk794HgI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBDhbG3559086
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=; b=flCd99WdIB49zGTc
	An1q1Hdk9XGhbN7baTxHWBodnU9IW1OuTO4Ri0dNVIe8iKl7+QAxfGOpvzuCuLEy
	xutFuVjEyrqw13VgdUvVFv/TcsBADcZ40zRSGu56JCSh58KPtaX2B8Zqa5wSJ3dT
	4QNz3wM7Ej+VVrSQg244rwJ0Vw048cNys4KRXIQjG6w5u1PeVzz6WSn8qLflojB1
	JlEIWc3hcVgEKy2lZwJ6hWJouHkUytIFY5KwMWr+GVd1+YiAaXWBg3lHj/+Ak8Zq
	+mBm1TjcUcEm0SnXRB7dSKGsjp+mO3B4MpXuM+moWgwrG0kO++3MO2VScncdD5Jh
	1Fgk+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2cb15y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:47:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b1be0fdfe1so68203785a.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766155632; x=1766760432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=;
        b=Rk794HgIa/rYdvcj0kc2FX7eDTrHg4rkNdP7YnKfmW80JOdFledU/1kA7/DYvtBbXN
         VcbxtszbJDr1DQzMx7dhjW8zuPrvog7pthrI5T9WvSH93MjDKCjcqT9ULOVgiFnCbVDg
         MzQyikr/MCfhTYo7Z3TEVtF5nnyt4ExB+eMI5TGAGPhyacQKOh/m+Kd8zI5gF9v5My6d
         dk/VFjXSJDw2WELqmdtOREIAnDlFR2gyOgxEzIT1bvq7ByUpbNjYFMV2rgosz73fCvuf
         +mhEEqY2cttLvZJABlDAqTUt0ZWhB/EW/4vNvZSXQz3ufsXrO3a0xSzW/Cw04ltCQZj5
         oMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155632; x=1766760432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=;
        b=XBH6h+4b74CMGAZ3rsoIBorwzPNBMbLvNsc0EWrJmL5aWDt4ZHi6T99Uv96SL5rmJL
         vIqkDQPrwgkH+S9KuCDJgPQyRpwJLr3jlQheFsmXPrjAZ+Ev893NRKI1AsPSCiV2ZGqp
         emnsbfsvBjdQUoVGL3ON2tw0OTHosEAxzZZFWCag3+vAMZCVmHVJWu0Milv4nTH9AyIR
         Muf2MJS3fm7gLPVGySLyRrKkkOwDtBgG2mVOZKFzDkNHtT/1SR/+XUtYlMKcc+AHKEGo
         S1kJ+VHPxY99KtZreSCJd0wxFDq0xl05gguHJjQE/B4Ok+vE2LhsqlARfxU7mn2pQiyz
         yW9A==
X-Gm-Message-State: AOJu0YxpaW0QIUWpgfIc+xqroymBCVy+0L12l48NiOWGGt8FP89leWf1
	lbHzu+Ubt2RhIshPXr9taq3RgGUO7d9wiCsGrvyO6mZLA04qX+ZOiow4fAaeNqhizPZ8AC+1052
	fy3Q1XLoA5DDj2p0N/Dw7FiUIcLMKeFqgUx9+0KnudoyVQF0zO5YdOIhxgT0+JMM=
X-Gm-Gg: AY/fxX5pMIZgHAaIDDkQi6WtgSuvvoCAy5zh6nruYmmUo+HGjW6xkummS8W//34EulF
	m0oR07uUAtfnNFUpaHTB5RoMT7ZaSgjRjM5G2ZKl2YHysSmwoyMm8z9Wp6Nthxx71XYroW8G8tr
	cVmFMtwRePuNjmeRoaymrXIROlORl/mCQCN8NGt5y1ekJ63usdHV9ETkPRYiNdEILDamYcoVZuy
	dxDg6dK6vQVleSCAA4iQH+CqUhU4qvdcOqXfxH61kXy3NLXNi9UVdXdprloWLNZgf4PZZiybCSU
	ZJsDaagcYogP3MLFsOB5JLIiFlZTxQ+3vKKXO49HIOtQCvQWhDi5038s3pAVnxip8ODD7qZClkc
	hqsJzTx4G09wVpKpyfhTDy8/QlXUdp+Lv3DHOnMcFQMaeon3umXjWJE+lGV0mthxvOQ==
X-Received: by 2002:a05:620a:2911:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c08fbbc3damr339356085a.11.1766155631504;
        Fri, 19 Dec 2025 06:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEve108+vsMnz6uQvHSLsQBNpRTIRrSI8CXrS6ViEziIGCv/1+cO2DfuCTVgDsGgQRx9jhOg==
X-Received: by 2002:a05:620a:2911:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c08fbbc3damr339351385a.11.1766155630854;
        Fri, 19 Dec 2025 06:47:10 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105b31esm2309173a12.13.2025.12.19.06.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 06:47:10 -0800 (PST)
Message-ID: <528cf0f7-6025-45de-a061-2d4f6fcc5bce@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: adc: qcom-spmi-rradc: Simplify with
 dev_err_probe
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
 <20251219-iio-dev-err-probe-v1-3-bd0fbc83c8a0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-3-bd0fbc83c8a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cpSWUl4i c=1 sm=1 tr=0 ts=69456570 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Y9TzTQZwL3x8CsvTrzoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyNCBTYWx0ZWRfX2U8f7/W81pJU
 wVO+m8F37AwXhgPreoc/Ldv68gkUmvBQEukV7EuEqae7QNN1FaiprSD4Ip2Sgz5NgDOpxb6uYk8
 Uo2xWsZ/Hk1ww+WqG4ChqwtTj7AjAE2WvN/b9FXfTSXk2TRw6RD+vjq+bbnHiWWn3u2JoFAI4pQ
 fc8enFwf010ixOnYFJ4EHve4L+lIpE3g4snCf21QolnsFzqrKNdq8K/KeeTJnnpB4YCGRMSWL/4
 Ntuzm74JjicL0pjv/LlxaGKp2hUmG5ZPfAefFc1hs96WYB1zE01Pb6aie4lsDQwc/5S8NmB/ttb
 o1Gi8LkvTFBPSTzIg8EvQaBUXK91Y311tP8VU/VFDG8vrmQffuvbZ0n4gJBTYsH++yfbPeVPRV5
 I/E44sM+6qnCeN/nXJDTHYpIue+A/8EC+aCaSdBQJ+7utcnBNuPujDPeiAge4jAHRar3AE39gNo
 uoHR40OxhAg2A00dfcw==
X-Proofpoint-GUID: zApI6EfdNfnmvc5iEELFwPCNYSrBn6bX
X-Proofpoint-ORIG-GUID: zApI6EfdNfnmvc5iEELFwPCNYSrBn6bX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190124

On 12/19/25 3:31 PM, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make error code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

