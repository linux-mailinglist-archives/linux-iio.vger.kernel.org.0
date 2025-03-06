Return-Path: <linux-iio+bounces-16497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831DA5581A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F193A177F03
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB77277029;
	Thu,  6 Mar 2025 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JgBW0emG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1444207A0E;
	Thu,  6 Mar 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294939; cv=none; b=LCFPyNwrea05GU4h1rLEfzvNix508DH2f6V4XwYyE+TdfeVGSGlcGim2+HfksF65SitjzVbCvmNMLEfEouOZKzrxhcCOaIqQXa9f+1SKmt5Jp/t/ExOg5dfdfxBzPvOpKZnyQlFLNUyEI4HvNy5DSW3ujfTXxFiQ9HR0zSumj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294939; c=relaxed/simple;
	bh=v8BJC08GXtjjf//dxCicJr34YObEFvieWNllVKwSzw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9JPFH8gvBUC3ZBsZIbY5DDYTtvF+GI6BqHBff+gs2kIRkKNR6IW/8eTW0Ncwc8y9L/XpzC3EMppS9y75JaDIcMPS/T3eHIPho98KYYPMRUu4zn/FB1Dlv9kIM7puTRy7BRedFp+RqtplKxAGT3AGQU3mD7F2fu5/ql4bHFqtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JgBW0emG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfeN7032599;
	Thu, 6 Mar 2025 16:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=v4XBP
	VDlxcNz3kwUnclmLMw1y9L6LFvuvnOQs09sd6M=; b=JgBW0emGwePH/8+ZUmUW1
	yUnedFtWqRwkboNczGWhzWwnprPI7oJ/zKe+iBQ1SkDhCPHPpusi0IeLd0MU8TTu
	1vSp7gjr1zoBSC2evRNQny0kwXiDU89GyFSjDM2e7TQLPqSrmVHIKUW03boBzVT9
	+2kUIY61pjfguicRL6h9Mnn0dbvlTxELUYY17dIbKXEK7ZJmD3TJiP/c4uoNG5yo
	uYfubvZ7J/ntlNQZhnV3DCCnBAOHT3uYiDzxUX4qu506RtuQrtvs7LfsEX7Rb06O
	RnJPSK/wRScAkDOVoX5fHOPcNIVua3EobypYALzjnvXZr4AL/b3TWCFf5EZrfsjZ
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 457d6x1t1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:01:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526L1uiX034891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:01:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 16:01:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:01:55 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L1d47011506;
	Thu, 6 Mar 2025 16:01:42 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 06/17] Documentation: ABI: add wideband filter type to  sysfs-bus-iio
Date: Thu, 6 Mar 2025 18:01:37 -0300
Message-ID: <b390ec6d92dd742ace93bd8e40a0df4379b98e23.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: D42VYffZlJfNWszUg39LrVtvay6VwRii
X-Proofpoint-ORIG-GUID: D42VYffZlJfNWszUg39LrVtvay6VwRii
X-Authority-Analysis: v=2.4 cv=E4w3pbdl c=1 sm=1 tr=0 ts=67ca0d45 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=3Hb1o_MSCnf1oSB8FUQA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

The Wideband Low Ripple filter is used for AD7768-1 Driver.
Document wideband filter option into filter_type_available
attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* None.

v3 Changes:
* None, since we still did not agree on a better name for this filter type.

v2 Changes:
* Removed FIR mentions.
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..9b879e7732cd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2291,6 +2291,8 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "wideband" - filter with wideband low ripple passband
+		  and sharp transition band.
 
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
-- 
2.34.1


