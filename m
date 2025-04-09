Return-Path: <linux-iio+bounces-17877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B22A8294D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C9017464B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A926B2C5;
	Wed,  9 Apr 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmByAWa+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA326B0A2
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210456; cv=none; b=E9SP+zqcaHCTIK4BPVX1LjeynQeCk/pInMHHfwIi4K3YU5piR8iwTr0qr7MCqXhHwOU6xk3wvlhBbjw9U7cgZoy0p62CoTXU1gBHedYAQNYe2ZnKY8HegYKhX2CSZX0N7SjZwATjzw3lAfWwoUKzYA3Dy1StcKXfUa/G/xuC9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210456; c=relaxed/simple;
	bh=6g0TfWDuvigbnJLDqJYb2R4PL8SRBJ82ihr5x2bmHek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwYT4g/mA++HOdSrQ0ofxKvsFy7CqkzgrNKWzoVZa+0oQ/Pjq6AdrNiUKKD68DDSyNERSS3Ld1WXjB5btS/4giq0QMp+lAFX8IiBzd5OdP2exlbUrrSAt0Pfza66WLgNxUVYQSvMbxRgnK+bNb06uZq+uoJMgiHMkW2J+Pe8tl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmByAWa+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398mwsQ006884
	for <linux-iio@vger.kernel.org>; Wed, 9 Apr 2025 14:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2e+zhortkq1PPVBPRYcJak6GvfMLkq1x12up5ZcdsG0=; b=SmByAWa+1AfXtVKW
	kW7NxtxG4xNKWwjKtwsoXDRknfKrd0cOocRlx/ZRWIKIALZyUZO6ev74eZtaEz8J
	xHSw3qj7m0wyc2QaL/KMHZaTzMiFg321kMfnnwqPqJ1IGG51YE58+cc1wNmdTfGR
	3ZBCbW/h9f00z2qK+UwPzT1U+8vG0Rf2WiVQkTuv3IoCenouGJOdl9V5rAX5MvlP
	H/f99YsjRpjz6r971m7juzNyEPQ23qICulBfVU/MiiR/gvvzT+CgrOSrySFjEJWy
	bNHaAzU8A1uKsKhT8Q18IiX3YOzn8gHx5Jh6SZbXnNjJiMv6CesYI4A+qjc60OZD
	MfNUUA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3kqbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 14:54:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54734292aso162346785a.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 07:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210452; x=1744815252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e+zhortkq1PPVBPRYcJak6GvfMLkq1x12up5ZcdsG0=;
        b=ICGcl7aLL14v5CKiQcdQXBrZlDQuYqgKVXt3/ygqLYV1iSMIkS0NoP9AIcMu65alUH
         YEQIXfyEAEfD8VwTP1OeXF/NbRT4we+krC7LuC/9+NKehXbC9UqRvxPY9RmO1pylKzW3
         JhJKcxbSFw6mwV1UDp5zWjnKEeyoxn3z6TB2DJwa053BSX3XIF6RJJc66PFEmR7/ulKl
         zLfMEqymdItsRcuMF6IBxY7Wi+ocfZFi4+HmrHlamxTw8M4Nsk4rpa7CrVNMLw4z5q2D
         hNePj/X5EPs5tMbanbPERMZw3zdw5qOlHl+WvW3IBqDfmp0PH1LcTGeEFtOYL4GXFdRW
         reXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVu5AoOJrlGs7Yl0XesCNeMzMW9MELf+fAMSYsnYsxFc9RqEljebURQ6ozonnf+CANNgZZ+jrAEgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWDgL+itsJQJuhENTz1gnaO5RCSSVz/z2rOmHGt/qn8EwqiCG
	t4tZYikUd4lbltucnt4zR9ZHsCyQfzATHlpxSzdrLr1p1yyWgQxI5FRgXNn4pK+poJ9YAuJ6JRl
	ADw/KsA/Te/sRjyzlCaa57tUOgoGgjbt4ppA7qql5+1d6UhB7f5AINEDtWkg=
X-Gm-Gg: ASbGncvsGq6VxuwZIlqj3wmYwl3K9LPGfnmA4ctnRRbbqPXhI7JvWPTUg7FKU/wT/W2
	uWLeo5lfcdVBHIf/HoGNuUkKu7HJikHzPduIQAga7i4C/dxAKzTuaze/strMTMb3P334I8AoDys
	zwNFssk8kfVXsLCLhvuq+sFmTu3IzjTmgmyAHJXtz3JvDchVx2DeEEHkzusPu8w2PlwVsnTr4Qu
	T3ezQU5+zTe4oLBsdkIhsKDlhRgQP80V7wXxk2W5RO6t9G5mpxQX7GVfpNgq3kNe1LqqTYtSJWv
	a8guMf9QQF5CtfsezB8EjEqlIRMRuF3Xd46/c8BFnfvv8pHIXpqxlf5/51cMgcJy+A==
X-Received: by 2002:a05:620a:d8d:b0:7c3:c814:591d with SMTP id af79cd13be357-7c79cbcad39mr181548685a.1.1744210451968;
        Wed, 09 Apr 2025 07:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkhEFX9jW2lxjwZtZRt5wSID+lKfDUWjDhK7POIeIFuD1YPW0A5mtnATcnc6+c78jlhAPyDg==
X-Received: by 2002:a05:620a:d8d:b0:7c3:c814:591d with SMTP id af79cd13be357-7c79cbcad39mr181545185a.1.1744210451558;
        Wed, 09 Apr 2025 07:54:11 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4142sm108209666b.101.2025.04.09.07.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:54:10 -0700 (PDT)
Message-ID: <fb61323b-aabd-4661-a202-02da7da557ea@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 16:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: qrtr: Define macro to convert QMI version and
 instance to QRTR instance
To: Yassine Oudjana <y.oudjana@protonmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        shuaijie wang <wangshuaijie@awinic.com>,
        Yasin Lee <yasin.lee.x@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc: Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
 <20250406140706.812425-3-y.oudjana@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250406140706.812425-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T2RNBrP4ySyIOwo-7tNSDIg1jLAlaTzi
X-Proofpoint-ORIG-GUID: T2RNBrP4ySyIOwo-7tNSDIg1jLAlaTzi
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f68a14 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=sfOm8-O8AAAA:8 a=PIWKGJPQcB-H7wabpAUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090093

On 4/6/25 4:07 PM, Yassine Oudjana wrote:
> Move QRTR instance conversion from qmi_interface into a new macro in order
> to reuse it in QRTR device ID tables.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/soc/qcom/qmi_interface.c | 5 +++--
>  include/linux/soc/qcom/qrtr.h    | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
> index bc6d6379d8b1..cb57b7e1f252 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -14,6 +14,7 @@
>  #include <linux/workqueue.h>
>  #include <trace/events/sock.h>
>  #include <linux/soc/qcom/qmi.h>
> +#include <linux/soc/qcom/qrtr.h>
>  
>  static struct socket *qmi_sock_create(struct qmi_handle *qmi,
>  				      struct sockaddr_qrtr *sq);
> @@ -173,7 +174,7 @@ static void qmi_send_new_lookup(struct qmi_handle *qmi, struct qmi_service *svc)
>  	memset(&pkt, 0, sizeof(pkt));
>  	pkt.cmd = cpu_to_le32(QRTR_TYPE_NEW_LOOKUP);
>  	pkt.server.service = cpu_to_le32(svc->service);
> -	pkt.server.instance = cpu_to_le32(svc->version | svc->instance << 8);
> +	pkt.server.instance = cpu_to_le32(QRTR_INSTANCE(svc->version, svc->instance));
>  
>  	sq.sq_family = qmi->sq.sq_family;
>  	sq.sq_node = qmi->sq.sq_node;
> @@ -236,7 +237,7 @@ static void qmi_send_new_server(struct qmi_handle *qmi, struct qmi_service *svc)
>  	memset(&pkt, 0, sizeof(pkt));
>  	pkt.cmd = cpu_to_le32(QRTR_TYPE_NEW_SERVER);
>  	pkt.server.service = cpu_to_le32(svc->service);
> -	pkt.server.instance = cpu_to_le32(svc->version | svc->instance << 8);
> +	pkt.server.instance = cpu_to_le32(QRTR_INSTANCE(svc->version, svc->instance));
>  	pkt.server.node = cpu_to_le32(qmi->sq.sq_node);
>  	pkt.server.port = cpu_to_le32(qmi->sq.sq_port);
>  
> diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom/qrtr.h
> index 4d7f25c64c56..10c89a35cbb9 100644
> --- a/include/linux/soc/qcom/qrtr.h
> +++ b/include/linux/soc/qcom/qrtr.h
> @@ -13,6 +13,8 @@ struct qrtr_device {
>  
>  #define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
>  
> +#define QRTR_INSTANCE(qmi_version, qmi_instance) (qmi_version | qmi_instance << 8)

Please use FIELD_PREP + GENMASK to avoid potential overflows

Konrad

