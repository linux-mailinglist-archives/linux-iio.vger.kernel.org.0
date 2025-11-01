Return-Path: <linux-iio+bounces-25780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E43EEC27ABF
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 10:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A27234A4F4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870732C0282;
	Sat,  1 Nov 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+X20k/p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iuAjDA+s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3155270EDF
	for <linux-iio@vger.kernel.org>; Sat,  1 Nov 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761989156; cv=none; b=a7m6zh0GlvoHLFcGBY07t6p5fo7j2NK5VzjrrSQpshpGS7Jk5E1vfohx3t6hyQxZAvUAO0stjxmhrRF8VF/IAPA1/FLPfUShDhQvnUaEnX2O08GgLUDIDCbU09k21DWiRYlPdNu1va85aH61H5m4I6bsoeJ83uo5ihXqGlZuuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761989156; c=relaxed/simple;
	bh=GwwnpboYaHnudYykCGugPFlSi8Smoy3YJMcmhihCSgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjYisrEuQoB2auySh2jkCXgJUwGWgeHQcF0LW6Io1cA8wKKzWsv8mloCdjA3Mf4iVTF3+tgq8GUQllCtKhKAFCd8LCCm7wp2qcbcgbatLgqQMCg7uUdX2+V+GjBRvCOitEevfULPSfE7HTxLH4tv2a+5Fbld8IJr1d/vU06fLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+X20k/p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iuAjDA+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A12BmpB471740
	for <linux-iio@vger.kernel.org>; Sat, 1 Nov 2025 09:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jnkXSMepRXkY/RZL11HCIAs0Yv0GplpodbD8vz5uXYc=; b=I+X20k/povF1hHPJ
	l4nfZq0I75XUcY1hzy52o8Wr0dssM/8IBND4Cz9o1d2lgCO4ANADyQhMJPg6xSQt
	qaIx7onOL7piDQtRLfJFuohs/q6E5cs1hqmxLG2wbBAjbB7iwQwONgXUNyzi8cPq
	oP4pd+qjqbsNYvnUtSF4rm2OZWKFNWhCBPRwk9ibHlFDpYbSvbxp1+JJoGJmV0m7
	Z9JS8oIIfcfkp3lbfQds00E8vCsyEqWijnfngB1joUeqsmhwY1yp5Kyo1LFtIMJC
	Aq7f98aCyL53aI7XsSKPvgnEO8oYA0YTXBH/SnIgnF0IGvdzX2jpUZGRhVPo2Ir4
	42MVcA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a59778h3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 01 Nov 2025 09:25:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eceefa36d0so73347621cf.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Nov 2025 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761989153; x=1762593953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jnkXSMepRXkY/RZL11HCIAs0Yv0GplpodbD8vz5uXYc=;
        b=iuAjDA+srv7ALubH7zvDCjmC4HRp3g1KfmetIa56od2xPwhxjmYQ0tJfJMXFSMFvOz
         Ll61zh7i/O9xn9ibRNFnq1qZbfUZ2mRqRg8woA+c2TUpPyfNjm2O4B3oVSDdT6FYHw9l
         24Fc/519ADQQZnWd9FMiOau1VZFXdFkb9hsSBZJNGaEFWMOnFKB3LvxwYV4FIYuZT0gi
         KvmUR/ac+HMzcldmp353HqjOWb/DPaDjiJtlPb+IegMTtp6H06JqJs9Df6keRk/G3JBz
         JiZBYzkv3SQLD4F8iQM5UNWUCJxzMk3414iH6zax0jA+5MoUTzgoID55jvCfemS2wyIS
         wraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761989153; x=1762593953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnkXSMepRXkY/RZL11HCIAs0Yv0GplpodbD8vz5uXYc=;
        b=SfMVYsFkBMz7DD67+kDffK4pMwL6Q6wlJju62yzk8YzMI+dvDnXFGMghjVC9YRl/Go
         /f+N2ZxEMX9QbCbYhTqwrlo+OcQqFFzs1M6o6lkNDeNpw2T+iG4wqn/fuBSAoLTP+Q2I
         80qIA/iOl7JUrv15+3GXYYLwfP6bpVsAc1y+VJFIONUYJRyy4XN9zTtCuYfpxVGzbdfI
         K8BylLWa/s0/cwxiYdNVxZVLIIg4aoCWqgNvQccyOOfJ/UOw59/c0h7jzjZJ0sTM/jJu
         4WPN1Q+KxgKLb6H9EWprIFsNzOjJ7oqdrunbeF/feWISWF5R7OcQUkJDL1zuK4aG+qd3
         xh/w==
X-Forwarded-Encrypted: i=1; AJvYcCVfDlt95a71XrUHdk4UoYQlJufRpiW0UrgI+m0mnU9c8H5r+B/gAexRo4aXJtOM3hGlTn1AEbLMzxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTaUqKEkpkdhgrvIlCuSpFTTZKdmhr9LIAWAHXoasDnrwQejP
	bBF8C18nn5nVRtSqrM93csU7fwT7qjcQhUNEmO4Fpy/ItI5/TWUe6ZxPUXODT2opDoiEum/W0Dn
	VCobTeX+gPci+Iv9zwTgdz3QmwglDYLX23Mem2IAsNC7l6HQeMTE4ivz1cSUzb6U=
X-Gm-Gg: ASbGncvT+EywbSmkRzVZTQBbmqGOK6xL4U8u9rctO1zZp7MgmLebCz5rj6SYMkLu+D/
	Aw+zC+rB3qR/aPbpHMWB3etu1a6a4Un8VMuweVgj6xucAJjaFOGOq3wmuspxIoS95AH0tbdZEvG
	c7GM1e/vr3y3FmlkBYT7BZA9c2MjPBtkMQx2trVZK+rPbDfA3I9qShruoGca/oZsvNO1dlgVvYn
	wXL5HK7q/1NSWlVnIqPl4mOBlEWVj5CJYeQqrBUF3ofRiIn3vlUmTRpE5aKkciHb53wyQ9QNHQz
	1twi9jM9bdJm9dYwMG2F2K7HbcluToVpH+3hqmQPTyk4b1jBJuoQMrKHyo/RxDEeYPoWT66QnZh
	xMUKBB0zOFgfW+9uxvghU3yR32uUU/vXetVRO/9ys4gwILuer0wWc2s/JfxrgO4C/Jd2akxH6M7
	387DYHc8MaH/Pi
X-Received: by 2002:a05:622a:229f:b0:4ec:f654:8523 with SMTP id d75a77b69052e-4ed310a32b7mr83918121cf.72.1761989152756;
        Sat, 01 Nov 2025 02:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4NwLj5l7cffz8hfyugLHnlEbWc7oaVMrxGH96mxEp3id/NDhHkd8phffHygM+DrxSBRZWLg==
X-Received: by 2002:a05:622a:229f:b0:4ec:f654:8523 with SMTP id d75a77b69052e-4ed310a32b7mr83917871cf.72.1761989152277;
        Sat, 01 Nov 2025 02:25:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f39a6a7sm1085270e87.30.2025.11.01.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:25:51 -0700 (PDT)
Date: Sat, 1 Nov 2025 11:25:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Antony Kurniawan Soemardi <linux@smankusors.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
Message-ID: <drqbd4yzvpcj5mauyees67a5vyfr4pt4lgm7npsye45smn2f3o@yyemg6qho7ut>
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
 <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
 <6f68327c-73b2-4684-bc8a-156714b6e3fc@smankusors.com>
 <b4a86788-fe0e-483c-93ff-fe993edb3181@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4a86788-fe0e-483c-93ff-fe993edb3181@oss.qualcomm.com>
X-Proofpoint-GUID: JyK4jVHCjZ6f85RHTYm6nanyZb_qEHld
X-Proofpoint-ORIG-GUID: JyK4jVHCjZ6f85RHTYm6nanyZb_qEHld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA3OSBTYWx0ZWRfX5ch/T6eo9Xr3
 tOzwhOycyDDQCl+MJveLFgS2nFtIqpL9i1kubby0wX3SRFHPUztxKj4TNwak45y0xMUo7Elpyos
 ye9KeQaXKxGQYALk1U65fz2q++UI+cFuw6bmtkphY7Zwpf+jZWxDWAe73+qL3gO9z2Iji0I0lLS
 1k9GVILNA85w9IJTlXXbo3oWjfG0nA0dTJJPAT+zCfk5hX278VKE/L7m/NJ33XGCR7kMten7xVn
 yo3RiY9EkRbIBxE23yqOIZXD/f5XJNERSOyxDfWR6S3PiiAX4P7nDQO4s4mc73GRO+tVgwSH0wh
 daA8VaIJ6tA6Kq04cTGf/PjBVG636I7QG3xY6LXSdEVgOG+yXN/2nIQ0OuVZ2RiZqRNmZdN3c0T
 jxxY44709aC3dJA6LCb0fUDgShIIuQ==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=6905d221 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8 a=bEFHJ-mLbTNbAtBp84QA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511010079

On Fri, Oct 31, 2025 at 10:00:25AM +0100, Konrad Dybcio wrote:
> On 10/30/25 5:57 PM, Antony Kurniawan Soemardi wrote:
> > On 10/28/2025 4:44 PM, Konrad Dybcio wrote:
> >> On 10/27/25 6:29 PM, Antony Kurniawan Soemardi wrote:
> >>> On msm8960 phones, the XOADC driver was using incorrect calibration
> >>> values:
> >>> absolute calibration dx = 625000 uV, dy = 4 units
> >>> ratiometric calibration dx = 1800, dy = -29041 units
> >>>
> >>> As a result, reading from the IIO bus returned unexpected results:
> >>> in_voltage_7 (USB_VBUS): 0
> >>> in_voltage_10 (125V): 0
> >>>
> >>> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
> >>> from the predefined channels. Additionally, the downstream code always
> >>> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
> >>> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
> >>> those bits caused calibration errors too, so they were removed.
> >>>
> >>> With these fixes, calibration now uses the correct values:
> >>> absolute calibration dx = 625000 uV, dy = 6307 units
> >>> ratiometric calibration dx = 1800, dy = 18249 units
> >>>
> >>> Reading from the IIO bus now returns expected results:
> >>> in_voltage_7 (USB_VBUS): 4973836
> >>> in_voltage_10 (125V): 1249405
> >>>
> >>> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
> >>>
> >>> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> >>> ---
> >>>   drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
> >>>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> >>> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
> >>> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> >>> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> >>> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
> >>>           goto unlock;
> >>>         /* Decimation factor */
> >>> -    ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
> >>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
> >>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
> >>> -               ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
> >>> +    ret = regmap_update_bits(adc->map,
> >>> +                 ADC_ARB_USRP_DIG_PARAM,
> >>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
> >>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
> >> The PM8921 datasheet suggests a single valid value of BIT(5)=1, BIT(6)=0
> >> for a "1K" (1/1024?) ratio, although a comment in this file suggests
> >> BIT(5)|BIT(6) is also valid and corresponds to 1/4096.. I wouldn't be
> >> surprised if that is the case
> >>
> >> The previously set bits are a field called DECI_SEL but are otherwise left
> >> undescribed
> > 
> > So, do you think we can leave the BIT(0) and BIT(1) as is? I have a feeling
> > that if they aren't set, these changes might prevent the APQ8060 Dragonboard
> > from reading the cm3605 sensor? or maybe not?
> > 
> > I mean this one, since the driver was originally tested on that board
> > https://github.com/torvalds/linux/blob/e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts#L67-L79
> 
> +Dmitry would you have that (or similar) board in your museum?

I do, but I sadly I didn't test it lately (nor do I remember if I have
sensors board or not). I can try testing it next week, if I have time.

-- 
With best wishes
Dmitry

