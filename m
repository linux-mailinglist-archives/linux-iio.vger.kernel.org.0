Return-Path: <linux-iio+bounces-12634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8019D8689
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA3163D51
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E6D1ADFE0;
	Mon, 25 Nov 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l9SCM4Sd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D84191F94;
	Mon, 25 Nov 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541764; cv=none; b=BtvlcwbNNoxIZCNcvjHVlZBFj4aDm6j+eQ0cSZwJSAl99Ww95QPCzNtNbrWI57PPhMoAASiYWf0hG4gw6605gqeRgeja1+7oDabHv11CtrHXynMyVG3mQLf19KppQYcpaJHtXYFI3e11trlzMNmR+gGa7WvDHWjOjFyu39ay2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541764; c=relaxed/simple;
	bh=DeS6JEneGDIVfZY5mOAWjMHgtWno+UVU6a1zm+o0aeA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXinc4Tc3pBAN+BmuvDa8BbP3XOwgfy9PN4bzhkq07annk2aWdxKscQAEb4O4JxrZlRkyJwbQmjhTMZm2rr7CEH7IQGurhg4IgrTsVQeSwKIDu7ekfph/1tktKEwIxfWCzASkz1u4ZQiIWgsG/R5Ypo+bxfHUWetaamo7j7omqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l9SCM4Sd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP985Hl014714;
	Mon, 25 Nov 2024 08:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WmrpA
	hDEj5raQU91pCwTrKA6mb0Tl1Y5Jqg1NOatAMs=; b=l9SCM4Sd5D+oLc4+Ua4gP
	UoJbPtK4z34Eycu/E4bOHzpL2IHLNgSw114jPyXlYAPSVffT02IfzOu2Cb2rgzo9
	nYLUb8CTWUxEZ3127z9V/9PCAFrMlFmOOg2lqLRqEQjH8uBc5JyQXsr28Uql/aSJ
	zL1CebhzcOEmDfE2dg6PBt0gCbLMCQvz++z583riNTMkzbHFjqLbkN0+c5geYKDb
	PMA3p0U/OV5pDvqoWpZ3tORC9CwGvrONjv9XkUC1xyzvK1ybguh0whw3jNjsbSsv
	h5SeGO60xyakdwRjUbNZVFG3p4rAEkUH3SsBv15aRogI7MKYLAG8UlcswEhhUHpk
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd10yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:35:49 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4APDZlJN030664
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 08:35:48 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 08:35:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 08:35:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 08:35:47 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.197])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APDZR2B031415;
	Mon, 25 Nov 2024 08:35:43 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 1/7] iio: imu: adis: Remove documented not used elements
Date: Mon, 25 Nov 2024 15:35:08 +0200
Message-ID: <20241125133520.24328-2-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125133520.24328-1-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: PDy7TmRnD2eCK8uS_RltStkI_aHIEepz
X-Proofpoint-ORIG-GUID: PDy7TmRnD2eCK8uS_RltStkI_aHIEepz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250116

This patch removes elements from adis.h that are documented
but not used anymore.

Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v2:
- added patch as requested in previous review
- signed of by submitter

 include/linux/iio/imu/adis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index e6a75356567a..4bb98d9731de 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -99,7 +99,6 @@ struct adis_data {
  * @spi: Reference to SPI device which owns this ADIS IIO device
  * @trig: IIO trigger object data
  * @data: ADIS chip variant specific data
- * @burst: ADIS burst transfer information
  * @burst_extra_len: Burst extra length. Should only be used by devices that can
  *		     dynamically change their burst mode length.
  * @state_lock: Lock used by the device to protect state
-- 
2.34.1


