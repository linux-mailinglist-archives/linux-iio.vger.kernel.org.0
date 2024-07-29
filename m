Return-Path: <linux-iio+bounces-8014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1593F1DA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A671C2147C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4C1448F1;
	Mon, 29 Jul 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K+tMnX/h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72013C69A;
	Mon, 29 Jul 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246696; cv=none; b=ACBmnHzSdk0NKhB4Yt7KD8zo3kvUMA9pDgq7t6KfL4fIT++TFmfsXO/Irj5u92UIFtEHLxpZi5Ouj61uSwX1zugi7EJ3AmMAZ0ib0GMpJ7VlrYgYPQwMdax7834V7leL+qrgD/9o6AsmKb0O+PQqQ9Qfefmy7YYoE9a7v5TDpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246696; c=relaxed/simple;
	bh=2kGsOd+ZwJrV7UsrgURsmloJIJIXbumlQwR7uJ9i/k8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ujqEitWr+mJNS2hSZiDCrT53yksDzjjaTguhiprOghWRhBL0AyrUnaj1DdgBRie1/61VWYDHL3h7bGRSkx9V5ECSvBnkNdrl8F4OqLBoaZlgnyaF5fpRr50OHNKUipsnkyf4a73y3F+OSiLnSNOb+7LSgDnHobJhwNRKTRCCnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K+tMnX/h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T92RpN023245;
	Mon, 29 Jul 2024 05:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZB/kns7KnoBYOA7us37Us+BiYr4
	OwWgyx2Jl8wKA6cA=; b=K+tMnX/hw9OUdWB59pPsG6/n0eKx0xlezwOF1R0wUNb
	7kcLz4ts5h8e7uMvJUkH9/CyhYmzalBgXr2utAlScK5bhLg0Ce5WBPSU2CjLaucG
	8oggNtZpu9+EiLaEMRG1MUrIyiuQP7iz76EUBQxLmc56glazjeE/pRRG94O7KjWK
	pB2lAmDoeoc0DQkPwX7KpEfZItUFHM3LTfKsDQk+zVJEkglxkXsRadzm+tU4OxCL
	jx1rqsxhY0WTbjteo5hUvBQb4d2cGp5HsGQxtZZDMpGyC6AyIGCG3vx285xHTCFd
	JCSu3YBZf6d4hKjxROz4LsDN4SUPEuaCMymWOfd4N3Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40ndy4kp49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 05:51:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46T9p9m1019209
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 05:51:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Jul
 2024 05:51:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Jul 2024 05:51:08 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.170])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46T9orqV024934;
	Mon, 29 Jul 2024 05:50:56 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] *** Add ADF4378 Support ***
Date: Mon, 29 Jul 2024 12:50:42 +0300
Message-ID: <20240729095047.25040-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: WfTrWBVtyBvav83w-7AhZCiZttAJMHcS
X-Proofpoint-GUID: WfTrWBVtyBvav83w-7AhZCiZttAJMHcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290066

Add support for ADF4378 high performance, ultra-low jitter, integer-N
phased locked loop (PLL) with an integrated voltage controlled
oscillator (VCO) and system reference (SYSREF) retimer ideally
suited for data converter and mixed signal front end (MxFE) clock
applications.

The main difference between ADF4377 and ADF4378 is that the second one
provides only one output frequency channel which is enable/disabled via
one GPIO. 

Both the driver and the bindings are updated to reflect that difference.

Antoniu Miclaus (2):
  dt-bindings: iio: adf4377: add adf4378 support
  iio: frequency: adf4377: add adf4378 support

 .../bindings/iio/frequency/adi,adf4377.yaml   | 10 ++++++
 drivers/iio/frequency/adf4377.c               | 35 +++++++++++++++----
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.45.2


