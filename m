Return-Path: <linux-iio+bounces-23357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D025FB3B592
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB2C563ACB
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721629ACC2;
	Fri, 29 Aug 2025 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcMPcHi0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E527587E
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455001; cv=none; b=UArLROdYXR3ihPuvfck/VJ4masHY2DEz+J3BTmw/XdKinkuxpwIKNdl9gOlrOCV3Ij8gzFKLiZ3FA0P+dJtmaTXB/q71oy7Ng1bNEG/mYFPe7PKaHmRhqLw4WWblxFpjeyai+9qY2PGfrpJqJE62rUzJvA8sQzTMc8xKEWS/h1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455001; c=relaxed/simple;
	bh=z1h03GLNdXLleb5z+38xr8uADY1LeMbzAyZCQ9BdpzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/V/cJ74IYhOaTa5Qnmt3Kx92GJ1czEqQI4p7Ax8vb4jN9QPwBtwuarbbHzlBtNwoHreYYcmmqZ5SzyJLAlghaBxVPpyo852x/tDIplIo5DZ9t4S3WTS9DdsPJYp6bAl7tQ9PEb+X/N/y/J8EEIoyTENC2F05bDBNBqorBd0Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bcMPcHi0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85Lwa012107
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 08:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bsv6NnJRTxJOMkJMe1wyAAiF
	Gmai0uCSvzMJL+nXi6A=; b=bcMPcHi0eahG31DYTlJndkJKxsFmOJaQJjCfgPiw
	oRy7USpQH2G0MGhGU5YZKKaaVJ3vfXA3fqqofwPhwmx1U9Df4O4vt00xR8DXLYEL
	yCWAy9+fqOVRJ9jMjExYyBuq8Ng3f6sg7GNb6O9xLFlX88EUJk5bzbzyh45Ex4cB
	xyZV0IeywDMFfdqGfrM+VeHp+YXvKBPzuiLNlUarVK8gU1M6BRHD8vjRhRhDdVes
	npFNYg+cu9tBlNRqsMZMDW6IQ36xlGk6nQYjPI3/7trdnNA1wK18V8kiuhlo+MPi
	xMOht9UkYecWW5Nx/gPIkP8Rc5MkAo5C8P5Sq6cGCzLmEA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615u6vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 08:09:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109be525eso39740811cf.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 01:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454997; x=1757059797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsv6NnJRTxJOMkJMe1wyAAiFGmai0uCSvzMJL+nXi6A=;
        b=ZPZQy5b5WgJI++OqvFLZO6IV1T7ra/lFQwo1KUg4YRrN5iZqC96zxMzbY5dk6ck8AM
         5OdbP9XpCz/2j1l4aDOnKgwyhbxtctrftUr0VmrI/6GsIHtThR+GtCCTI5sXzVkrV2df
         ImOJDrZisfSXGB1awE3nnZJwXqV/RgfZidBUiEwf99eWCvsnPnL+mf403A20MJ5jwJdI
         +UO5geuy1AgQ5XVY20bEEDO5+qEsm6VU4oDFgOy/wqRCWpL38rHocdpGRo85onA6ndbZ
         OPt1FyOxxhn2EiTbH+dei/IvquY+r3RS7jHRqiyzm3X7r5WOyPi0cSjmajz3lNnI8MVL
         IrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXky0oefDDlqicz7zLxLpSj2GB2h5JqRS9ZNPZcYPJEZTqbrTC73LB+ZUsVMRkxnfnwvtTQ1eFpeDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVe4Vcu5wKnISBf8YtMr55D7PMeKs8gZYvAb0CtSjoTAMq61g
	jODNEAk+mPXS1G6cW4CKNePwaeiUg2dhuE36dEDOO8wPkCHzX2tIGDClPs2o1Q4rpClw7CHkggT
	MRC1NQKhtALHbbb9KWkVet8x9Fpl7gedN1vNVFbwfIEs6vGO72ykNyGzyKenz4oM=
X-Gm-Gg: ASbGnctM7jmtuI7WHd3Y9Spk2vfcE+Jxxrsi8mJliJH/UB66lkUbgbgisibCR/UeIy0
	/a4f6nVyGo7m3pJRb/eEKN8PYNBQldjBwFNEuXzTNr+m+0LjiYKvvh6jyoOIpbAG9R7hhOI7F7v
	BtD7ZPm0CHnKeZnA8aArmkpGSaSaExVjl+7tkgmRnXfSUF1z136C8PsSHvm9hB1HzkEL7y6TfUY
	kOuakrbmSAViD3p5ilMq6oX14ApKTPbBnarBxIORsrHqiq+Qpc718Y46ucI8v2O0l96j71hB9AF
	BaWGUeVIAWdZ6ZH1ZjsZn+UZIhb1TitJfmwDu4/GZZiJ06kqOFwbIkiJD6zSJ2qQN8nv4P0aNxB
	vwNjRtm+Ea+h5jJlaurNaLlS8CyKKG1Er1+XYgLbUwL2kpj5cOup5
X-Received: by 2002:a05:622a:249:b0:4b2:e151:a1e3 with SMTP id d75a77b69052e-4b2ea694690mr119134101cf.36.1756454997033;
        Fri, 29 Aug 2025 01:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQwcGrf8Uq6ErZTLA64qML9AZfcxsKmHVxxEtfjH1059x26sGs3RoBSkASHz9bNHu8//dSdQ==
X-Received: by 2002:a05:622a:249:b0:4b2:e151:a1e3 with SMTP id d75a77b69052e-4b2ea694690mr119133841cf.36.1756454996508;
        Fri, 29 Aug 2025 01:09:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm451242e87.8.2025.08.29.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:09:55 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:09:53 +0300
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
Message-ID: <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-demonic-soft-guppy-512c13@kuoka>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX/Ww9GwUPLrIB
 yFe3dCKdfUvHD11amG5sGnQr1UR4Gd970pzY3FZsl3RHNgny+AYLqtrgQei+3qJ1IMcB3drKJzd
 zsGZkqA3xIQMswl93kbAqFJs0Leu4pRZNDEPIA/GSfCvaxSMTBo9Bs6KjEnSXoyNQGd3MzeBMOF
 /MwuJvBBHsrQt6vpS47ncvcwbl18NHZPweUHit7p15pfdpE5qo2vtKs9e7dvUqtjz83xzDv5vCH
 SiaBjiaeDTqVVWqsia093Gxx2/8Nj+mycycGJhaV1EPbtsqtvlxndAWLMzGSrWaf9NxfFIAN3sX
 QqJ2qk/a7lqSTO0yyV/3le5CKWp2umg1KpLYT8iHc5yYsfQK2GvSI0v+Jc4RCzNt4MIdNmriORg
 t+P6AVwf
X-Proofpoint-GUID: UvbWunZ9KJab9uy0huDdue4lK3PfsyrH
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b16056 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrI73Fic2Yz_lu5inCMA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: UvbWunZ9KJab9uy0huDdue4lK3PfsyrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:
> >  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
> >  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> > 
> > 
> > base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> 
> What's the base commit?
> 
> git show 0f4c93f7eb861acab537dbe94441817a270537bf
> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf

> 
> 
> b4 diff fails here, so you are not making this process easier for us.
> 
> b4 diff '20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com'
> Grabbing thread from lore.kernel.org/all/20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com/t.mbox.gz
> Checking for older revisions
> Grabbing search results from lore.kernel.org
>   Added from v6: 6 patches
> ---
> Analyzing 53 messages in the thread
> Preparing fake-am for v6: dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
> ERROR: Could not fake-am version v6
> ---
> Could not create fake-am range for lower series v6
> 
> > 

-- 
With best wishes
Dmitry

