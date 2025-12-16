Return-Path: <linux-iio+bounces-27115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1D7CC45DC
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 17:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E2C1302C718
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE4357A3A;
	Tue, 16 Dec 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTuuKQx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brUftz0u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A937357A30
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886588; cv=none; b=MktjJLTWkUn0MNbmZSxg/Tf7eSl43B0OiNrDIZfjXQRBFipb/j9TSYOiMJjrzwq13w/FhHxA2HsTUk6R0iyMDHHv7weP2G0wofBk9fKHHxILj3cv6sJaz026Qscs5irOPVHErBrO7W5QcHFvBG1hiUIJr45MlK64E7agygHc2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886588; c=relaxed/simple;
	bh=1fqkqkNEzTSWAwW3B+qpzd2aY6yMg5j1xLcgYYtCn9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFnr5jPFHcwqnOCeOjhSxbje3Jt/M3RAylnpWruWMBiiswJ5lnMTI3T+itRxBhHua5NAzAzrO5xzzOSeYQJQkDIMh1h77TUWHWIcqu1UmQKGxFB4CFNUBKmLyr7CIIHica3CXNfiuDzAqRfPAWfx6SdhtQXgNU8dWPPHfljpuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTuuKQx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brUftz0u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGC2GdU2810368
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=; b=WTuuKQx8zjT7yA9n
	RcbkvqABZwczl032YJYNNIyEMQQ0tM+vIYIzu5g3Dn6Vu8y9nSVDA/pHjGy0I+DO
	kf15TiqGU4+zNGPYK06xCKaXZJ7qclWs1jao4YkvXbKIZ+pyozusvyzYCINi6/br
	lzPLi01djXZzGrCWTp/xAGD0biZWoAwBN3OsG6oF/2MURjRalhKBPSMz+q37jOOJ
	ZGEoNU9XbiyPLo0IR26nMlkTduTn/0lQvy11X/NvYy+zjberHj69u4tyOk1aPwTS
	9jI8WWAUDGCRH2jNuU0sknu4VMLaz4s2VrnNfRIrO6wuKogI4/A5TufHPHXhPrLf
	BdTovQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b32gas7eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 12:03:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bbb6031cfdso67003085a.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765886580; x=1766491380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=;
        b=brUftz0u9slhPLGiWz/UOVN+I2nfhpd3OK9UEFORSoD5YK6CInrMQz0rD0sItRzt+U
         itk4Sk1NmOqqRh2nPrMUbyQVs4a4nTzM0XUxxw7tgjDGA072nhi/rBJpXvXsNPmO4qbj
         bYN5rgewjYB8esFh+CWnKkK1POpp19QSpbohWOTdb0H7PsMx5zY64XzkQ/rt2lNbTxIW
         NPT1ldNGLqmf5E0dfpMGWYKcLa952UNe7IOlrKLulfi9W5UVsItBB8AYe2FJ77HjL/0k
         34/GbNTaLt/pEcjW00kii+95cFMOUVgsnjUx3sBPJ185n+tBUMrkhixlr3k3EasjSW1g
         dhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886580; x=1766491380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=;
        b=vsjAEFeFssHxBBLle+ooJ0/tB4X5f0J2MgkKSRK6cI5afVWRV8QlAE6gwXlxXYpoAr
         Fzr42+f86byxk4woplMe4DNt5sQCftgQXQVrrj1brx0VGTj/lqGafvsjGdPvyN0nibTV
         l+mm+a05VxlBgc3n8SWc29ZaQJrLsef8MIhD7TWPhH3+bIpbj3BICYgbdHxGg+Fq8y+z
         wbLjWfjbNu/sxcl3DaNimx8eW6DQuiYjH5bYVH+Q/M9otbGrR+yDE8lK4QbqFAwZ5Eg+
         xx6UW592BGK7gXiRlvYguXouEtenoD0E5Bt4xqAE0paaeLRJ9etItqsWYMCebBgsTBMH
         L2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3v02In/Bnt9izX0cHfG0YadRZp/LLXB/GFpgyKAl4wF3CavK6bq/j9s6ev+fZVjbBu6IZZurGS30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaADdhsSoRzDbw8+j/SsilFu6KJikS8YAbsmx9/n057TXCqZyn
	5uAtayvjhpQz3UhOnFda/AZX63w+HVG/MwN+vqE+eLDRgxW7Sbi3S/yxqJ5lBhF8RLwycYPdatm
	hOATFuD/C95UTMgDb2Hp1Go/kr4gHk4zHO3aeKPfDnmyw2gQgcNm3zkaUerVYIRI=
X-Gm-Gg: AY/fxX4bCbI+B2p0W5Y3a6JGHyDmF23JOo/XO/q9W9KhbFwN9VfySpGCPH7TOfI9kc7
	lKadAETQM6QRRGRNu0nFUy/PXvWPyrlsV++Cg2+7yeIbOqTrKnqKBCeYU47+0ttrO0c1j1kHQ7E
	njkBdzUDGUZjEU/mc0QPs8ID/FOe2k80wkdl2/Qm6QuCqTaiKlsxS8m/4HT+b8GU1mMcSaI+DV6
	I7ZsvKoewk6gIldPsrc2ON3KahsN2lsxUNBF8i12LgAmYwMxb0d0ZGb5aBXwyXPDMSofB9tCw+p
	AzOjtyLzlo7NWahT2sAzqd0L8Jsb8o7cVra/mezr36fZdkLTtCmP0SOY8ztHOCNXA07EWx9YF3R
	iZbDPufLCwlr/ZB6+PnFWCTiuSmRWTxspripQmFcnZ77cRWB3QmAgmpat39xzqWGffw==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1437508285a.3.1765886579705;
        Tue, 16 Dec 2025 04:02:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+LwGQhgX+HV6xSu98Kp8PBKIcLhjvja7byx1nEf8nekydl7DDS37zTtoZtPzNHvCnZUEeTw==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1437499185a.3.1765886578963;
        Tue, 16 Dec 2025 04:02:58 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820f77e3sm16041066a12.18.2025.12.16.04.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:02:57 -0800 (PST)
Message-ID: <695ca5d2-b713-4838-8427-a9d31751c0cf@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:02:52 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Remove unused includes
To: Jonathan Cameron <jic23@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michal Simek <michal.simek@amd.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Peter Rosin <peda@axentia.se>, Linus Walleij <linusw@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel
 <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
        linux-sound@vger.kernel.org
References: <20251212231203.727227-1-robh@kernel.org>
 <20251213165949.4b51f7cb@jic23-huawei>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251213165949.4b51f7cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vcb6/Vp9 c=1 sm=1 tr=0 ts=69414a78 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8
 a=UbNXja__m5_aMge2JzcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: CYsaRPErmqrA9mmOenpLxbChwOoeE-Ju
X-Proofpoint-ORIG-GUID: CYsaRPErmqrA9mmOenpLxbChwOoeE-Ju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwMiBTYWx0ZWRfXx8kcbA6S1KVg
 6+VD5f+aTiAxgjD40b8YTfPOHYyukPk50pBi7H2jOsesteFrk6kFOZ99FKZfGvMOXitXX42xUeO
 CO4FKn300xmsyCyCvPTfrLTpDCb5RNOIY9U0WYZpTvnBhfoKbtMGv/lbVOEF0pdlgAdH4ErbAXS
 /aWKt2bSpqcML2QY5jifZ3++x8QCbrQhKOCYZgcCWwCrMxYLHmvBTe+ApV6wx8At5FJiwgyLwYp
 a2yEpO3wgm4xmgkdYswy9IUp17ZvRKveipAWWF89r4lK62t6SRJtZkToq/XvXtBn/LzHixTOvqK
 nVhEg8zZtJUpQxoxaSlBQE5MtpWPSKrlTBFZX06qP6jxXX6ciB4snV519RMTJjnv4+kYAlc1fAw
 4ESqAFEzPv+RPA2P8u0Juzhwnl94qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160102

On 12/13/25 5:59 PM, Jonathan Cameron wrote:
> On Fri, 12 Dec 2025 17:11:52 -0600
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
> 
>> Remove includes which are not referenced by either DTS files or drivers.
>>
>> There's a few more which are new, so they are excluded for now.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> #for-iio
> 
> Ideally we'll get a QC ack on those as well.
> 
> Jonathan
>>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
>>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --

Those are being moved to dts/qcom:

https://lore.kernel.org/linux-arm-msm/20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com/

and will hopefully be in use later in this cycle.

Krzysztof and the submitter agreed on that outcome since they represent
hw constants and aren't "real" bindings (connecting sw to sw)

Konrad 

