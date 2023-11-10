Return-Path: <linux-iio+bounces-17-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DAD7E86AD
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 00:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B581F20ED2
	for <lists+linux-iio@lfdr.de>; Fri, 10 Nov 2023 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52B3D97C;
	Fri, 10 Nov 2023 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mir1M6M3"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3611D681;
	Fri, 10 Nov 2023 23:48:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8DA3C39;
	Fri, 10 Nov 2023 15:48:17 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AANMOLT029711;
	Fri, 10 Nov 2023 23:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=nPqLvqWSNzXaiUzUGDsBCTpfqHwVD2HejTtYoZlTink=;
 b=mir1M6M3BRYIoTn3uk0nZU7tgMQRFTbeu8pQ/JwDO1cAK3ljK+9l8dJzD5ldJr0YuWPe
 CinPYVMVE3PTr1JT74acqu0ic9gFPNnTSBlWjB4mH7HGT6PgmZzVTUFHW+/VKSGdpfgw
 P39rxJDsC7THoRCaY5FhRdH/8e8Vlr0luf6QwsTQa+dvsqCCszl31BnKeAbpULwgTfU6
 ++Ci8W8VJ4bgaP5JnGtYg5YIGhF/nNJwlRkV4/qPaTHrucsGTVzX3lRkZK9bePG8OeyP
 CqCz8/bPenFA7EWxofzWR1ZwBxTxKDrv8AP5sOlA4NwiYSmZ79acH8WBEq0ub0ugFvQV Lw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9rgwrxda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 23:48:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AANm0wj011811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 23:48:01 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 15:48:00 -0800
Date: Fri, 10 Nov 2023 15:47:58 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <sboyd@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_kamalw@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 10/11] ARM: dts: qcom: Update devicetree for QCOM ADC
 bindings path change
Message-ID: <20231110234758.GE3553829@hu-bjorande-lv.qualcomm.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-11-quic_jprakash@quicinc.com>
 <59ea565c-93ad-e8e3-10db-ae3ba481ebe9@linaro.org>
 <706d3b7e-a9b5-081c-52b2-7cce4f0d5f10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <706d3b7e-a9b5-081c-52b2-7cce4f0d5f10@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6AJ9hk15vPowi0gTtV63OjTn3Ge_Ojzm
X-Proofpoint-GUID: 6AJ9hk15vPowi0gTtV63OjTn3Ge_Ojzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=800 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100197

On Mon, Oct 23, 2023 at 11:48:13AM +0530, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 7/9/2023 10:56 PM, Krzysztof Kozlowski wrote:
> > On 08/07/2023 09:28, Jishnu Prakash wrote:
> > > Update ADC dt-bindings file paths in QCOM devicetree files to
> > > match the dt-bindings change moving the files from 'iio' to
> > > 'iio/adc' folder.
> > > 
> > > Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> > > ---
> > Your order of patches is incorrect. DTS cannot be before bindings,
> > because this indicates you broke ABI. Please keep entire patchset
> > bisectable and split DTS to separate patchset (linking the driver and
> > bindings).
> > 
> > Best regards,
> > Krzysztof
> 
> OK....so you mean I can move the dtbinding files and update documentation
> and driver files for this, all in one patch and then make a second patch for
> updating devicetree files for the file paths?
> 
> I'll make this change in the next patchset if it looks fine, although the
> two patches would need to be picked together to avoid kernel breakage. I
> have asked Jonathan about this too in my reply for the previous patchset 9.
> 

1) We need to be able to use git bisect to identify regressions, and as
such the kernel need to be buildable and functional after each applied
patch.

2) DeviceTree source (dts) changes enters the kernel through different
maintainer paths than the DeviceTree binding and driver changes, and
therefore at different times. In some cases the .dtb file is also
delivered separately from the kernel, which means people might be
running an old .dtb for a considerable amount of time after your change.
As such your driver changes needs to be compatible with both the new and
the old DeviceTree binding.

Regards,
Bjorn

