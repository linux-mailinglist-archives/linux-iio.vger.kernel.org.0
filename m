Return-Path: <linux-iio+bounces-26451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6BC848B8
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 11:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69DF44E973B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31131283D;
	Tue, 25 Nov 2025 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObItG198";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIVx2GY0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE43126B7
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067529; cv=none; b=HbFeVB+0lG/UzwYBZcSIrxJvxiiLc4IsGV5+EDqPwCKAXmToaZlUs9R5krEufv5TbzCE08R4u8Z+pyEJZQjCglOrxIHho2iAKszQzhHDeFi/fKpU/Q6HwHPBtHMD8cR0eDCB6XB2G7S53VYFiyAXRKfRbfq+iE4+GF96hIkVh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067529; c=relaxed/simple;
	bh=VCq+O1s7382hys/B9SmoYilKyWtXfu1me1mpBF+J/kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvTPfhRBBOSU+uPUT6nBD8bw881bw7c1o8yCn63G+qHmFCWG5v/wcO92ZtDnYgNXEyUnCXba+ePvz9ywL64152ASLv6InU0EGEWS1FVZsdRICtbyC3H/H/whJ/P2u27unnxTj+o721z5N+h59TlRj+pUQSj2aaQh2iqloAQRl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ObItG198; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RIVx2GY0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APA9GqX1979152
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 10:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wn1SxpEKcwo4JCd8zTQuVpo+QZZl6aFrR2Lf4TtVpMM=; b=ObItG198kJWPWmj5
	sU0sxiBjog/KrpBUW0Sj3MlbNsfbng9b2MTBkU5UO3DfzmCl7E8xPYArXmAslufX
	gXajqOD+kQ/4dsg3n0uqhhFxwelkLm81ouH8rMRH4golMmBPpK6/SQGBqXmbdrjQ
	0sHefqgf08E5uvdhsLovRlZDw1/nyd2NoWM5L7Uc3s3NwNPiCc9q3O0aBg58MVbt
	DHCPDZz6ee4t/dpk87BeMPvqf0CGzEaI9XwlrMkZBNmtbX2sCXPGXr+o7q74a878
	fvrAj1NOn4+5DsxGxrV1hFbT5TN6Pe+kI89UP1X6KbhS23Z3YHQtDwFC0/Qzm7Wo
	8QH4VQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amw9gtb3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 10:45:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b222111167so142983485a.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764067526; x=1764672326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wn1SxpEKcwo4JCd8zTQuVpo+QZZl6aFrR2Lf4TtVpMM=;
        b=RIVx2GY0EZRRVIm/sXLr/lfHJq0TS3vfMJXp/lZb3sCQnrGr5dom6VTUD5ER8e/6AZ
         1+Pt9gys4Sn1jnvUAYPVhnYTXa6xLhBZDrBrTHD1JXjk/Z7Wni7oNy0UNFinjWs/NvU1
         1pBbQ6JhyoVSRQg7yv7pG7CwwzoBpjiPNQ2EfrhKKQqOF9mdgO1dOjVnl/gJGvw69cdY
         3Dv2r/QENfN+9hM70gpve9FBtAjlZco1nsihhAn3KxBt0n12CASSCBVNMSMHY0oy5V2d
         MbPMgiHjkBAlnwHCoIeUbENuGiiC5UVmVn0iKwmWxb8a5sVexZ/F+RWQDZe+u9Dn6VaF
         LxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764067526; x=1764672326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn1SxpEKcwo4JCd8zTQuVpo+QZZl6aFrR2Lf4TtVpMM=;
        b=M208vQodzDnKfkutfkvR14iHAYwGk2NUZ0IUFraWVlt52MsW6Iq37vBgLeoY5oOTC9
         PF1J0k+NUGsSdjGjTR7b0LK4G56U5F2Om3uGngYVqubszYTy4MFGkzx4jh7kFfx90wCK
         RZpgob//kjubovviNbxUIEkziD90wpaeTQwiPZiFVvfcVLa/c8eq7flonOrgnsewnqzW
         FvnHgPEyLtBCyeEjh4IEIeTF/W/sfPMgI/YtNMPwXBoLUnZPpNXbFqz8mssYeRngcdj9
         z5NNbxihLIkg4m0hmUki+96jMtPfMRjP/En6Uj6Nq0JCLNAJDWgOM5YFmBmoz31l90U1
         RsJw==
X-Forwarded-Encrypted: i=1; AJvYcCVw0UGuOP4pTMHWz8kfNdDh5ThqPsYDHd8G5gc2+j2oyZwknpPT61sJoLvQbpduqlmZ3FKBJuvSOGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4v2As3Mj+HKQsZ/HI0N2733ERJnx1oTmngYYRIOMtuOeqnj9
	mTgjMUJDWMKsts2M4si1LIglGKfxFlcAUih7JFBkWVsgmC7JaA+ZvEDQk2m+3BbQpH1DrTF3LU/
	mL7OO2K+LmnBPnu95hfM1nv5rBx6LYe4IAJxRxQsSS6ceD5F2/IuzvBBanShiVok=
X-Gm-Gg: ASbGncv1Nf0kzK+DS7HVI29wU2sZOjIzbixyWlOvrUAf/uR7hwxhDH6S+VqE/j0gWJL
	2udYUx8efJWQtoXovsU3PUNPrrepSPDHvVtoys1QKoh9gaoWncM+EdLAYfTemYtQbZ3Ec1/Zl5I
	/T5IyqJuiwSVsV2jzMYgkwuczePhKiokT7FRTEReVCQMWrqqZcfYAHZnjoEa/64Dru7Zdb3Z0Ze
	/rn+I1kxXzVZ6smzIom0uAzN4/oOyosNftpr17iaOBb5Qmg5i+/4d42K0Cviikeu1fpYjPHOj67
	2kjTi4jOYufhXJhr4JT5S1Uh5uz8gxwm6Vye4HTVd0l9aHnn+FtMEnyq2bgbkVj6xx0OEQKQe3P
	kQrJIiZK1ysbb2DDT4TETY4cP0GLToSyLfTDm+ZGM/hoNzVFo4+uHNrEecDOinRK1/ZI=
X-Received: by 2002:ac8:5dd0:0:b0:4ee:1f0c:c1aa with SMTP id d75a77b69052e-4ee5b74c2b0mr137857241cf.7.1764067525681;
        Tue, 25 Nov 2025 02:45:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFza8C8YbcTHUSzQ9MsUfOfDbV7bpXNGIVx3J9Vz5JDGtYEYciUtpiYbEpD4fsxLqoXIPyqnA==
X-Received: by 2002:ac8:5dd0:0:b0:4ee:1f0c:c1aa with SMTP id d75a77b69052e-4ee5b74c2b0mr137856991cf.7.1764067525104;
        Tue, 25 Nov 2025 02:45:25 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3c40sm1560776066b.47.2025.11.25.02.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 02:45:24 -0800 (PST)
Message-ID: <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 11:45:22 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
To: guptarud@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
 <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4NyBTYWx0ZWRfX7EIIsGmXRUfG
 tyQS8nzygeIxrQM40YcUgK9C7nkmBGpDnRSVyEO32rf4PaLhS/VlgLSzeAFokFpd0BV0i+1p+2K
 Pues3g91vt4/3E/fXAuZUGTyKqUepw5wt0yvhwzqNA7VDMZFpHJxCIiXc1kEJuWkmEOqMSigsoF
 41Np2v0GgaKpibdvE01ppRwszYFi0DThdbiHFwHafvsQ3sjI3rD3/2A4oxdVqjIsz1V3MS/HX2v
 qsnYFpBWS9vhlDpb6nsyLPIdvqKZIgRVUkdRpQ+uwTc86O0wGYLqZkxwiTpzJR+VzbS1FwqvSfS
 1LGsXx6i2Mq/1Mexe5X3xN+9TZLHJQlcrKxHFaCIdRJKJ/04+XYpoI4M52iWufrcmWtYGhK3AyA
 6kayR25miHEnGaQENgj46LYPif4WmA==
X-Authority-Analysis: v=2.4 cv=H53WAuYi c=1 sm=1 tr=0 ts=692588c6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=W7vXZdNd1IZ0taGBaDcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: prxRC2p3VEI93yEb7lo7sYYx1Leypjhl
X-Proofpoint-GUID: prxRC2p3VEI93yEb7lo7sYYx1Leypjhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250087

On 11/25/25 12:35 AM, Rudraksha Gupta via B4 Relay wrote:
> From: Rudraksha Gupta <guptarud@gmail.com>
> 
> The bmc150_accel_set_interrupt() function assumes that the interrupt
> info is provided. However, when no IRQ is provided, the info pointer
> remains NULL, leading to a kernel oops:

Hm, are you sure your device really doesn't have a pin connected to
the IC's interrupt line?

Konrad

