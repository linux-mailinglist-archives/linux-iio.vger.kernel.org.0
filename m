Return-Path: <linux-iio+bounces-12636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E699D868F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D9816AA8A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DDB1AF0B8;
	Mon, 25 Nov 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PQKQzEkP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F21ABEBF;
	Mon, 25 Nov 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541788; cv=none; b=gM6r8rgWCrj1cEqzkdPiWF72+Jn/voY3ZH2XxasZuEwESMNbqOoh6TKJBVHIKCOppNFvF58Y+ojjn5zk7jYbkR9aUx82dtNuYscdghVkpaH+XUvdhL5reAZUXXl1oTE275LNLBAUqE7hScBjYBGeqwAEDyNZXZsINCMvvQbK1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541788; c=relaxed/simple;
	bh=hJSfGrQUBoTfXtYbD4uVAztsA1pywly7g8hk4h/n9s4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx/MZfc2ZWGkK2Cxcsyvmk41llpXfRTbNYtNs/nI1LZ93rYKdIJ+y8zBpz23l21ROeymi3yqrwWufVF5qehOc6XPrHACpq4lsH7XOVHodccYGCQEVvTQXuQ34D1R6CueAGXYA3A4tLBbgOltKikhMoGAMWCMIsAtHDZdUKZC3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PQKQzEkP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP97oIi005194;
	Mon, 25 Nov 2024 08:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gh6tw
	spJKNrJ1uM4677uAOJ0uB3tlYFo49uusnYZBOw=; b=PQKQzEkPKVSbfv6tlU0VW
	gnYJZo8uYI23ad3LSEGrEFMkWxqzmkibwfzOISNuCRoimw45gtkMEhoKPkhP1jQH
	m4nEqKFJaNBeVhB39/5Dxjxqb3B6abPb62uXbXUzJySt5B6lZHMrYzNJfAuzDRQ3
	1UiyY31Ew3G4Q7sBPn1cMnPqu9jKqT3z2/Sfm4IEwYy7ReP+LL3cFwVCpWIUbxs7
	k+RPT6+j9gEZgaULq2GkyO4n0W3ky7MIQRbxomUYynk+BLpIlWUfjaSXY2GctvSr
	TTRDtq796QVVCYgF75FYFqXq2iVsGk0OdlrlkMx/PueY1mmkZNnMEfGYk+LovLS5
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 433cu6rr8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:36:13 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4APDaCkL046350
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 08:36:12 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 08:36:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 08:36:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 08:36:12 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.197])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APDZR2D031415;
	Mon, 25 Nov 2024 08:36:05 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
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
Subject: [PATCH 3/7] iio: imu: adis: Add reset to custom ops
Date: Mon, 25 Nov 2024 15:35:10 +0200
Message-ID: <20241125133520.24328-4-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125133520.24328-1-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MvdAhsVYE1LaeJV-q7oq-6A2zX2MNVS-
X-Proofpoint-ORIG-GUID: MvdAhsVYE1LaeJV-q7oq-6A2zX2MNVS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411250116

This patch allows the custom definition of reset funcitonality
for adis object. It is useful in cases where the reset does not
need to sleep after the reset since it is handled by the library.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v2:
-added reset ops as a different patch
- signed of by submitter

 drivers/iio/imu/adis.c       | 7 +++++--
 include/linux/iio/imu/adis.h | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index fa7a817b7d99..865f7c56717a 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -339,8 +339,11 @@ int __adis_reset(struct adis *adis)
 	int ret;
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
-	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
-				 ADIS_GLOB_CMD_SW_RESET);
+	if (adis->ops->reset)
+		ret = adis->ops->reset(adis);
+	else
+		ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
+					 ADIS_GLOB_CMD_SW_RESET);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
 		return ret;
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 89cfa75ae9ea..52652f51db2e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -98,12 +98,15 @@ struct adis_data {
  * struct adis_ops: Custom ops for adis devices.
  * @write: Custom spi write implementation.
  * @read: Custom spi read implementation.
+ * @reset: Custom sw reset implementation. The custom implementation does not
+ *	   need to sleep after the reset. It's done by the library already.
  */
 struct adis_ops {
 	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
 		     unsigned int size);
 	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
 		    unsigned int size);
+	int (*reset)(struct adis *adis);
 };
 
 /**
-- 
2.34.1


