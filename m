Return-Path: <linux-iio+bounces-13415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAD9F081E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 10:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CC2188B216
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA651B413F;
	Fri, 13 Dec 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gOe2qCcZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469681B21BC;
	Fri, 13 Dec 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082791; cv=none; b=JyX2HVKg08QacQ++exZtBXGWKBjSJ24J5MMH45YkkBAhrCAPN3uRC1kHx8Ii0XH/Er/tQmvCrLThr3Eg1xRpBYgbnOk3h7vZvmHB0Vvs1Z+Zj5Fo3gx3zQV7av52EvUFvi5PerXc2KKXqQBZqJNHgJzm/Qt9qg2uODt5z6LRlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082791; c=relaxed/simple;
	bh=+/e/OocckrVV19cEXqF5r7GuDQAEFYBXfsNyVbOnZR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D6r2ZXtAgrjEXOunxnhAdYb4fw0T5mlt4rqBMDaHOtNQJoqNOSXJc9kEF9qMtrRJsAx8TnyxayL1OSa0WTCQUnsW0J9XBtXE5pB+kr5hwmdU81qWNMP1SxvKpyE0cxn2tmcHkxkqbxKnznJRXeI1we8U9xGdlE/rEJI9GzGSNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gOe2qCcZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD98OZ6023348;
	Fri, 13 Dec 2024 04:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=8X4OrsNZtOgF7QE9e8ELPr3PX7d
	kSp9fZQxMSaLJWjw=; b=gOe2qCcZWMjb+YWaM/lDM4ez/RllQ0PSUtBpcnUzewk
	NP6UT0uW5qGlYjCSXkbYm4qQSXDpxi53Wrl1aNShe+8mbps4abxLOO5vqi5VqUUX
	tueP9hwU9QKBTklkBXAqV16kX2kHmfbwWPB6LbEAsvA65kNeXh8nfLqpmOigRFE5
	ur6kJ4v45tM/Xv1JglBP5HXZJDrz/tM8T/7iWUL+tt/urz6qdWl3GdoFR5suPUkE
	frSsKFKZlbb7ZgRwViuGsRnkAssseCLTvwZTj7L4ltWZ5mitQZ5q3mvMFRYIUpH9
	IZQPfmN9rS9TMmTvv6qzA5MxaJb4kz+njlXLDSfwIhQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43gj1fg407-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:39:32 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BD9dVsN013975
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 04:39:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 13 Dec
 2024 04:39:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 04:39:31 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BD9dLXY028481;
	Fri, 13 Dec 2024 04:39:23 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v1 0/2] iio: accel: adxl367: add support for adxl366
Date: Fri, 13 Dec 2024 11:51:59 +0200
Message-ID: <20241213095201.1218145-1-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8CQIHfNBKnSIkjK6HWfyZqaouDrqSIeL
X-Proofpoint-ORIG-GUID: 8CQIHfNBKnSIkjK6HWfyZqaouDrqSIeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130065

Add support for adxl366 Micropower, 3-Axis, +-/2g, +/-4g, +/-8g
Digital Output MEMS Accelerometer into the existing adxl367 iio
subsystem driver.

adxl366 supports all the features of adxl367 but has a few
additional features for which support is added in this patch:
- built-in step counting (pedometer)
- non-linearity compensation for Z axis

The part is not yet released but it will soon be released.

Darius Berghe (2):
  iio: accel: adxl367: add support for adxl366
  dt-bindings: iio: adxl367: add support for adxl366

 .../bindings/iio/accel/adi,adxl367.yaml       |   1 +
 drivers/iio/accel/adxl367.c                   | 233 +++++++++++++++++-
 drivers/iio/accel/adxl367.h                   |   5 +
 drivers/iio/accel/adxl367_i2c.c               |   6 +-
 drivers/iio/accel/adxl367_spi.c               |   6 +-
 5 files changed, 243 insertions(+), 8 deletions(-)

-- 
2.46.1


