Return-Path: <linux-iio+bounces-21424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E7AFB54C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C001883A93
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9E28ECEA;
	Mon,  7 Jul 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NWbD3laU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A32BD58F;
	Mon,  7 Jul 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896364; cv=none; b=mJe8tBXEYuTwPHIhjU5n8HKaGLYyz+mWM+JuJqRyx1FActi3yA36Fbf3GENdbj1QEyNq/nebWaH/FNqmKqS+SxPvNqiqnXbK2rDHc+K9CP/pufpUbzMxynGMCMTZyzQAxPq/+t10UeKVMhs6qCkBZb1DLEMT3uY3Eqqll7jmnxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896364; c=relaxed/simple;
	bh=uaQ69Jy8F7cYe1tv252wZLz+6Q0M31KJkfAx8QLMhQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc8z3fbwX7H0+mib+GCveOupWlBxwT5YX2Wa3GU3uCoU6/19pb1nuHWqoT5P/WkvlRbcUdvg/3qzsm88WMWlrVaDWywD18QNxZYsSxC2q1i8AOgpmQWSdHdI5bkc0lv3kirWJs1a0JboBXPQ4NHBgdsoZWojNgtaq9leLAET/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NWbD3laU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567CpX6D026979;
	Mon, 7 Jul 2025 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CqwcB
	eRuMphf2ePXDOzCo4xWdwQnRMctXzNBq9izLFU=; b=NWbD3laUOhhzV7fNUM0i0
	nkjXmOUZdDuPJBg7zbJgCJKHYIGa/KvCbUMOYaruZsJ9I6F1XrrCcZx+niMpGtx/
	mF3AKAYDNhuhmz85y4uHOmmCzEK1Am8KwLNuDnttq3TOqhtv+1NlP3ZhMTmV4Agw
	fK+YFgx6h4p6nVmclqy8BGqzL/m+N4FFJIMqE6jj3Ftx+XEHr4ipIFhue1wbeUGq
	CLyCtZisOsP4EXitvDdm8Ojtozrx5v9q99+kzktlX6sdP/DepkcVQmC/2vz3nbGg
	nvMbRRfEovhY5xXMPgeM3D8gn0YyoorVe7ajGjdZRCSQN2YzET5RxAphpxuygwE0
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh6mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:52:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567DqIgo011592
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:52:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:52:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:52:17 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567DpxUA016146;
	Mon, 7 Jul 2025 09:52:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 05/12] Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available list
Date: Mon, 7 Jul 2025 10:51:59 -0300
Message-ID: <7ae9ec6da3a3f0c33206880fcba35a17531cf219.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd118 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=SbKw_mlo35DZte1DD3gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfX8lncNOfEN+Vt
 A6bn8aXCI09bK3tq6vQ8zDWICxEKa5tZQ+NJwAj/Z+yjhtQO5AkZ739QeNxFmySAbuidAtpCqfG
 3BKDf0iwJm+Fapokz3szZQncHRwfN9UeiQ+mozmGangN9RmKLYzI//GScp1iABvVGsBonHZT9ig
 VBpLzpmrx6v8Yg/aI+XjQKYRj+Uw2h44PZ7hIvmdokz7ACy1WfcrNwnB+iJOBeFQ41pz9oFJF0O
 FZqAqObNAX43MRfUtxHVCjhOUCL6xt8SNvsP+Bn8cao2skSrbL2Gqty4bfsshIHlyr7MdcL410g
 EuT3NVaoUqQekSxMwXTOJb2BvHEDbiyMiKNNhqtg8aku1ewWI8hm5L6rQaPIg49Mmx5ktJRbr6z
 VLJkn7Eeh5v4mda4I0YX14uywOugFmgzlSeAgBRrSuLJL7r5Rpgx/2pqYmqYPc6kKK7rje49
X-Proofpoint-ORIG-GUID: qF41MXViTmHNLout0C3Rp7Wdq9deQPYW
X-Proofpoint-GUID: qF41MXViTmHNLout0C3Rp7Wdq9deQPYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

Add the sinc5+avg filter type to the list of possible values for the
filter_type_available attribute.

The sinc5+avg filter type is handled by the ad4170 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v7.

 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3bc386995fb6..fcc40d211ddf 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2321,6 +2321,7 @@ Description:
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
+		* "sinc5+avg" - Sinc5 + averaging by 4.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 
-- 
2.47.2


