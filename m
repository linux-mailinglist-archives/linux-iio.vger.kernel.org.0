Return-Path: <linux-iio+bounces-14976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A46A27556
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2C73A3041
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751A2153D2;
	Tue,  4 Feb 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UTfK2JQz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE6219A67;
	Tue,  4 Feb 2025 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681274; cv=none; b=e8pc8+r3q70863ypRNRkgAZ6lCTwT8mAac00H3MZhZ9hS1d4Yipye/3/NKDNWqpKx1mdM+s83xcsZM1UP0i+LUFDWJA5BR+EZNGONXk76NLjmhTJLEXH1+H1szwOGHBWSIwNxwDl/ciwA2SHhxLvgQ3wV2FDt/rhV8P8KQEvbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681274; c=relaxed/simple;
	bh=5MCWOALGSLukXzxUZIQR/W2l1RUpj6rB3lK4EWLeszc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY9u9NeEPdGX0yBKHShfaHuZQQZXm2H8ZAN00Ov7VJ1WF47MQb16yz8rTSOsj+dbHvggBjjxOMIE4RKJKf32fJZxgwHTnMQKWQtpqCcvVeJV7Dzz5KucQ9y/Wn46zyIraIfSmmwCRxzjJ57hh6laLDYLLlWURTnH9Fkca8OzbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UTfK2JQz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1rUE006925;
	Tue, 4 Feb 2025 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eEdP1
	pbOrQQx/KKRb4w9vCmvJ8dASGnyuZv7Wg7oWYU=; b=UTfK2JQzEcbr+D5ADPXFi
	m1QALTbqWTh35X07yrFWsKTeXRzHmfdtTum10ZA1kC5A7nt05ZU6mN+t1jU3rvKF
	BoOa2HOASosjfpymzjQ3PmD/voWhq+bprvjnaXxhO0NShkxFPmVSZud5Ah1wcRAp
	Zr7hWQgB/oDAF2PxFX9kFYMsen8TB1N8xSQStN97lSiDk+zJhGCKT6gqj/uxqK4T
	PhBIF2Vmmvyoih1dhPM/hHM4bhQP4RiIdTYMgO/pyPXs5iaurAKbWayydugw+53I
	eh+vbBZ/+N+f174FXaAcKTfzcWmhqEXL1wJtSb9qXzS+3O78kmV5KtWnQ4qMBHFC
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44kma3g89b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 10:00:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 514F0s2O020850
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 10:00:54 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 10:00:54 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 10:00:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 10:00:54 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514F0fdr005432;
	Tue, 4 Feb 2025 10:00:43 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 1/3] Documentation: ABI: IIO: Add filter_type documentation
Date: Tue, 4 Feb 2025 12:00:39 -0300
Message-ID: <a8dbccac909e8d11e7d47561935a5575b1354d3a.1738680728.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1738680728.git.marcelo.schmitt@analog.com>
References: <cover.1738680728.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Df7tqutW c=1 sm=1 tr=0 ts=67a22ba8 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=5Wjybu8Z64oMUeRhUkIA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: bxWUQR8GvJ-wXWPvO-OFtSTIK6T7cvS7
X-Proofpoint-ORIG-GUID: bxWUQR8GvJ-wXWPvO-OFtSTIK6T7cvS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040117

A previous patch added documentation for filter_type_available attributes.
However, the description for the value attribute (filter_type) was missing.
Add documentation for filter_type sysfs ABI.

Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d97c35057a03..ff9cc09360dc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2300,6 +2300,14 @@ Description:
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
 
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies which filter type apply to the channel. The possible
+		values are given by the filter_type_available attribute.
+
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
 Contact:	linux-iio@vger.kernel.org
-- 
2.47.2


