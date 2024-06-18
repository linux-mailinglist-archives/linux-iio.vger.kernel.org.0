Return-Path: <linux-iio+bounces-6482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0590D371
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8F3B29D7D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D714D29A;
	Tue, 18 Jun 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vSkpV8E/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CF14A60E
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717332; cv=none; b=HRW2INgMrI8CtFJSenQDQhTTbn6/YHOpSbnL6hieHujwNJKDGrJiWHl6FJ3sj45FgYYehgAH1NGFaNqmocnFXyFIiKjyyWdu0oXePaS6WCgVzOjMGo76sZxPNfds4cMSDSyKvNoNQlWrsL5ugCqZSMWF6hnmSmWTHh2lQn0yYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717332; c=relaxed/simple;
	bh=ictE7EKhFUsyfERy5UBmUm33CZz57NMPX10oU3NCddU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YxdGe2WaekFL3lskcTKMbgdm3UD1Svhbi40vyE918tvrXWhS3Dgxed2nEawKhiTalG824cVrpdJ5wNdt9dtITowBjgzAF6jq/GZqLbucPAAyuRlKdyCix0dE/TPLRqIyHEzvgalQW2STTuKor20QVFl9XMWMXzT1fV9a7duDrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vSkpV8E/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I99qYc006678;
	Tue, 18 Jun 2024 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HIE/D
	hUECd6/Nc1vLARNA3TGz9XjqJAA9TCC6MbOyTE=; b=vSkpV8E/rdbu+sX+jFv4U
	ZXVw97qBu0bCKKpZcB/JtihMthTUghLvHr0+awO46mp57MqyfkNaDVE/ljdq1eFt
	65E8H+AjjGG/+KMUWuC8lfZ6j+noW2+6EFhcNQriKyhJ2zE6Gj8sVwu0yCxAYwzn
	JjPjEj1i04VVYkgUsoVPk7hKGgAkNyzViGjYqnqPayQHsYj5dSyFMwx03r6je26U
	OnXAfiiTJr60GBGYRL53q5T3zf5avp/Rsb6U+QzROraquBSSvrRdeIXRZevzEvBQ
	+VhlhQmjDTKh2s5ZntJWrAXVzaFXYhG+e0On4Y7svacrx/8qK1EbAmTlPhZ9TIzT
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys4t33by6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSbtl062015
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 09:28:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:36 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWN025769;
	Tue, 18 Jun 2024 09:28:28 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:06 +0200
Subject: [PATCH 3/9] iio: imu: adis: add cleanup based lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-3-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=909;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ictE7EKhFUsyfERy5UBmUm33CZz57NMPX10oU3NCddU=;
 b=LC5RqiOooj9eFqNcR/TmmB0QYmvWdbWqJAsVl29or5bniAgSR9zf7GpJPF9IdUFHsTdnK7P4G
 DrgjACSKEq3CrJq7FJleLrHlV/tjKgu3X7RyPkxtQU+KZm3X6d8J7Ml
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3lZY0v2S344Y5PL4pVaYb0jtlKjnQXTR
X-Proofpoint-ORIG-GUID: 3lZY0v2S344Y5PL4pVaYb0jtlKjnQXTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=485 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Add two new lock helpers that make use of the cleanup guard() and
scoped_guard() macros. Thus, users won't have to worry about unlocking
which is less prone to errors and allows for simpler error paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/imu/adis.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 93dad627378f..bc7332d12c44 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -403,6 +403,10 @@ static inline int adis_check_status(struct adis *adis)
 	return __adis_check_status(adis);
 }
 
+#define adis_dev_auto_lock(adis)	guard(mutex)(&(adis)->state_lock)
+#define adis_dev_auto_scoped_lock(adis) \
+	scoped_guard(mutex, &(adis)->state_lock)
+
 static inline void adis_dev_lock(struct adis *adis)
 {
 	mutex_lock(&adis->state_lock);

-- 
2.45.2


