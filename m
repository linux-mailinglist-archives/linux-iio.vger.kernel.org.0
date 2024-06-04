Return-Path: <linux-iio+bounces-5769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DEE8FB6B7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBAB1F245D6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9F13D635;
	Tue,  4 Jun 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a2lRL/KW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A251C3E;
	Tue,  4 Jun 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514051; cv=none; b=V6GRsDtVNntuwvCsz9zQKRNdSF/egNF7nYduXldlh2UQTTn6b5BYFJNO7aT3N1cigvW1yB/JuNWyftKBmvfY7anvhpHBPYTnszQCzTSWthOnVzjFTfrjhOqdgWRC71OsmzVAxQOq9wi0OUDteGTL4NXAAeaZo44Nr4DboryDrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514051; c=relaxed/simple;
	bh=ubHT1yvxT+TG65TxqQCilAEI8gM/A9Rx47eLVY61hlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V2y61XfFQnlB5vEUHd8NQQ01ByObXkR2BS99BRgcUt+wt9Tc39YrkG1MeqO/fkMC1t/NLm0H4Ld8j79s8kWbzZGl/dBXhS3h/cPXJEjcOHzScUK2xgHYkjmuIXMuIRzZuzpAa1YQAg1vLD4RvC7Awzc+3vxSEtHZDK1BWbp1npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a2lRL/KW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454Dc0Gd020269;
	Tue, 4 Jun 2024 15:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NLjsq/0snfIaASAxpDpQ0/rkJk8rDsizdyP+ST9KbI4=; b=a2lRL/KW+3965RVU
	HuDNHvG2ujieYE46pLpxsruRf8lSfmltTBpIZOEHeDpTe4Qj4xm0UjXNNEomwcKN
	ESxFeMBatzzJG14U8Kv0Hn2l7MtGNhYl0n/mUTPcNR31Zw/QpflMm5VtebaT+usB
	IBJax730n+2xJTQxFhKidmVrWuvMVMxFG54nAwfWhxzsVZNEkUw6q9gxJbd+QAdD
	V5skM1CUAMRREb1T6/Gyd/i1ppTN7H7V6MTaG3fZ2xMem9cMLA3YmhIcfBbsWVdb
	HreaUmHcVZYychnEB5x7WM5zMui1CVmoHtZbEWmi1tt4JYt2jVB1fQpg3dSRFOCQ
	dzqIDw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw42y15u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 15:14:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454FE1O8002826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 15:14:01 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 08:14:01 -0700
Message-ID: <d425c1e9-5e75-4369-a397-990820bb5628@quicinc.com>
Date: Tue, 4 Jun 2024 08:14:00 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ftm-quaddec: add missing MODULE_DESCRIPTION()
 macro
Content-Language: en-US
To: William Breathitt Gray <wbg@kernel.org>
CC: Patrick Havelange <patrick.havelange@essensium.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-ftm-quaddec-v1-1-1bbdf705ad31@quicinc.com>
 <Zl8s-uujP1lXBAQY@ishi>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <Zl8s-uujP1lXBAQY@ishi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s_0aC8N3mVY1z-jQoCgNsrTtP643eTtn
X-Proofpoint-ORIG-GUID: s_0aC8N3mVY1z-jQoCgNsrTtP643eTtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=909 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040121

On 6/4/2024 8:04 AM, William Breathitt Gray wrote:
> On Sun, Jun 02, 2024 at 03:05:20PM -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Hi Jeff,
> 
> Would you add a Fixes tag as well so we can merge this into the stable
> trees that need it?
> 
> Thanks,
> 
> William Breathitt Gray

There are a large number of these, and they only occur with W=1 builds, so I
don't think they are taking these into stable trees.


