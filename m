Return-Path: <linux-iio+bounces-15639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00133A382B0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470D016CFDA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539321A444;
	Mon, 17 Feb 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r/TJt5II"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBA21A425;
	Mon, 17 Feb 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794457; cv=none; b=OyhaHiSMwjzhgehQCKuWZjG3VUKHPUSGnvO/fEv58fI59rzbAEsTfxl4SPgpWZjvXJ1K/ud+RX2JfeOqHdnrkez2WOIPwIPhaza4oWc+5NImkOAbFvY8P2NqHqZ2rBxXptNeWkiDg9jf1yTxCOWv3mb2lVHxZtLRj715DvKkfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794457; c=relaxed/simple;
	bh=Wi7Q09nZbP6PYA0nN4MtoKjYck5Qwpzr7AVv6cjpUHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4bKJf5/JxqTRvg2+LJ5MzHQGLv/DLF5VEDsjmELTfzvOulviCgafqIf777TGFjo+1DJIqG49g09LNjzoxIu0WMYiUgNCx6sPJoCfHVWUvnzyknjDXd9S09GpiPK8eXI3uFJYks4TTl/YQSbnrcmc5gYjyP2mEwpzbN4PIImAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r/TJt5II; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H9MYgD013720;
	Mon, 17 Feb 2025 07:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V9oEi
	2wPDZQA3mIZnW6sbgrARZGGTxNCALa1ROcrweo=; b=r/TJt5IIT0/uzM7UBQrJS
	WHsb1MBEp9sQmonBLIThZaNlzx58UzdoJMsIxnc+JZyGqa5MTcz0AidDKvbewalH
	dgd20U3EIfbko6ixhMLKac8xbNFdYJU096c5D1PRJpR6ZoR/Jg7z+JX5yQpF6tz3
	7oZwMX9kAGSvMAEZGkWO5owDZz7dlS3dywbR63ts9as76GdD2RgTEijsq2aQynWd
	O14jzD/LsM7bEJ6yB86WdOZMBgdqLrK4WXiTRir3MCKFhNaYCos9PrJ3eSHE8mdN
	47vDWNibLFI7eiN8x8oCZPCX0eX/StuDSGccNsQlKAsegCGVE1Z2pDrkO8gyuIGo
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44trqcyw2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 07:14:02 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51HCE1JK017794
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 07:14:01 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 17 Feb
 2025 07:14:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Feb 2025 07:14:01 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51HCDZMQ016764;
	Mon, 17 Feb 2025 07:13:52 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 2/6] iio: imu: adis: Add reset to custom ops
Date: Mon, 17 Feb 2025 12:12:15 +0200
Message-ID: <20250217101221.600898-3-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217101221.600898-1-robert.budai@analog.com>
References: <20250217101221.600898-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=a5XK9VSF c=1 sm=1 tr=0 ts=67b3280a cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=65Jcde3H-U0EgxZAQXYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Lq0aAXxcDe89wZWtTDul:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: LRCVqFgLesRdMo9XPsBUN-u3HDWknsPV
X-Proofpoint-ORIG-GUID: LRCVqFgLesRdMo9XPsBUN-u3HDWknsPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170107

This patch allows the custom definition of reset functionality for adis object.
It is useful in cases where the driver does not need to sleep after the reset
since it is handled by the library.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v8:
- no changes

 drivers/iio/imu/adis.c       | 5 +++--
 include/linux/iio/imu/adis.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 54915c7a3..84344f052 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -491,6 +491,7 @@ EXPORT_SYMBOL_NS_GPL(adis_single_conversion, "IIO_ADISLIB");
 static const struct adis_ops adis_default_ops = {
 	.read = __adis_read_reg,
 	.write = __adis_write_reg,
+	.reset = __adis_reset,
 };
 
 /**
@@ -522,9 +523,9 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
-	if (!adis->ops->write && !adis->ops->read)
+	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
 		adis->ops = &adis_default_ops;
-	else if (!adis->ops->write || !adis->ops->read)
+	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
 		return -EINVAL;
 
 	iio_device_set_drvdata(indio_dev, adis);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 89cfa75ae..52652f51d 100644
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


