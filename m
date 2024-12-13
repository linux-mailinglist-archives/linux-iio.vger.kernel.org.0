Return-Path: <linux-iio+bounces-13414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91689F07A8
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258E71883973
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B201AF0DB;
	Fri, 13 Dec 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YCzjrnSR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027831AA7B9;
	Fri, 13 Dec 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081657; cv=none; b=bsMGYJzqt3UNVEYf1WCpevCWce6P9qcIdjlZGq59zeFdNCKEzY11RzrerpRe43a+f7QYvrO5e8MSupYjLavmr7ZalWwaVzyZb53oic2377kCo6XYlyE+/KM8zAZsDavGdQ6sakaSkRvwOuQ8kV+FFzqWiKml+ZWlJ5832ZDaKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081657; c=relaxed/simple;
	bh=RKydHSliqwBi1XS8hs6ov2Q7ePZ/b05EhYL8sN+etCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRsqrLtiqDPNDVTmfjXZxZ4GySi4GW63F/dr5ZNQJ7v8NKEi7rBAGAh//muUflJBDa3UVo/sRgdpCUUUs0AnTku0azBqwuwEmMrCaz/jf1/I9ABVTJ6q4p/UTVSOjY/o4owAVX6pSXMfh9W8cm4SO70vP6rKYJ4OyaSl78Uf8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YCzjrnSR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81hDg022255;
	Fri, 13 Dec 2024 09:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jZAxqrw/xHxdKfC005ToSh1VAd8VY+EISYZK8FQL88M=; b=YCzjrnSRqlL2ARBc
	kBK/9y4nVRdVqv02aV8apMniiK1Am+7E1D24W9hRnoJYN46QaqtBdeAedImrYv7e
	VcpYHG9zmm8sucPFePCdX0QdeQd7iPP/Wg+toQIwCJSP+ACyVrRNQscFV8gMb9Qy
	t5Qxk2r1rsUnjJOYyfOWNztmdtAztM2E2x7h46uZS1Vb8EZFtWrIDj3o489PkUo3
	mEUXC6mcSD5u7lXyv6FFKUFdzgT7XVqbhFgdHo4Z7UcVC+E5xSRdb4GkurAoxHeM
	gNbX8VcFHkpnEAUUEwtUQDVym70J0P/Kz1J1iw7LfvIx6qV3LQYupJB7nXtJaN3l
	LKEZLw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh2707qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:20:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD9KYYH007719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:20:34 GMT
Received: from [10.110.49.139] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 01:20:26 -0800
Message-ID: <07c89c2e-1212-4170-97e6-e490480101a6@quicinc.com>
Date: Fri, 13 Dec 2024 14:50:23 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/5] Add support for MBG Thermal monitoring device
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones
	<lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria
	<amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jprakash@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <qq3cggafexwpdrv46eqijxfmrdbqusl2vpbuswqmcvshqueaiw@r4mrmap4nwkt>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <qq3cggafexwpdrv46eqijxfmrdbqusl2vpbuswqmcvshqueaiw@r4mrmap4nwkt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3kxuxIM9U-TAzn6tyCp8Zn8H9jFfJzyJ
X-Proofpoint-GUID: 3kxuxIM9U-TAzn6tyCp8Zn8H9jFfJzyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=924 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130063


On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
> On Thu, Dec 12, 2024 at 09:41:19PM +0530, Satya Priya Kakitapalli wrote:
>> Add bindings, driver and DT for the Qualcomm's MBG thermal
>> monitoring device.
>>
>> Please note that this series is dependent on [1] which adds
>> ADC5-GEN3 support.
> Where is the changelog? What happened here?


Sorry for missing the change log, please find the summary below:


Changes from v1 to v2:

- Squash the ADC IIO channel bindings(header) and yaml into single patch

- Add new patch [2/5] to add reference to qcom-spmi-mbg-tm.yaml in 
mfd/qcom,spmi-pmic.yaml bindings.

- Use scoped_guard mutex in driver, remove the helper APIs and directly 
use regmap_set/clear_bits() APIs

- Corrected the isr logic to notify the thermal only for lvl1 upper 
threshold violation.  Earlier logic was not handling this fully.

- Update the dt node names and remove the polling delay as it is 0 by 
default.

- Link to v1: 
https://lore.kernel.org/linux-arm-msm/54c3fdd2-f701-4a06-bb3f-41f5a431687a@quicinc.com/


> Why this is RFC?


On v1 I was suggested to mark this as RFC since the dependent changes 
are not yet accepted.


> Limited review follows (as this is not yet ready).
>
> Best regards,
> Krzysztof
>

