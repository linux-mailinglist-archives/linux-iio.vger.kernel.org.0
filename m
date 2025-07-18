Return-Path: <linux-iio+bounces-21760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8C6B0992C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 03:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF41C4594B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 01:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14631552FD;
	Fri, 18 Jul 2025 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wUKZNIye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59C13DDAE;
	Fri, 18 Jul 2025 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802425; cv=none; b=Kj0VhkWXo7xHQ4X+c6BvfnV69j0q+jVpnt2QKEA+lH6o65XOu1DB5QysJZu7gRjKTYOr4EqCbUwiuDFKawjt9ozxfQ4xwYJwoUIXckWSA4Fc2KuJhF43afe/vIouw6vbSbgeHiLHPO9u8hfxGuDXwUY2c/W8vls3pmFlRWxFF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802425; c=relaxed/simple;
	bh=fSv2wrh0fgJV3Ivb9jHZuVJNMai581B9bX+/SqV79ic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VXO8l5K+gSajtJ+Hd0ckI8po1L40aD0egvCfFUmSS0PRVxnNZZe0UmmcIgpO70pT0Jt4ZiZs7bfQQRfu/1M3vtKP8anUIYyxSV3d/hCRMKI5nMsEnqJZ+jZRvfn9TewdSlUjtM/OEt5wZKhavCnP0EwVjEPYtyWu1hZsRZXUrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wUKZNIye; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HM4sxV022146;
	Thu, 17 Jul 2025 21:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=J+1RzevwhFWai0XmrCjYTDx3Pr2
	oDhOBIvFzkIJa8fg=; b=wUKZNIyeFkiViZDU2KEWVsIiI4QXlpWTp+CkZ1j4g3d
	e1Us+gadbGD9mnnw0VwAot2zSsihtaMnJ876E1CenibeNCu3V2uJLRROW0JG+moR
	B5kgxWkYi9FynuCFuZAM6hMpBGxJx0hOU8FRn7pDZ2/lGaLJO1ObCZhGHy5V3Jub
	fvqmWTNQFCs2cW84sFb3Hs6AWQInInIlg3yy02+jjJvxfEM8JQh7aF4yoNiUv8Ha
	eFWSsRkPJCQ8Kmtlfvm32RmC1EUVjJCzjKSo6imXrcLm2vChENYqhFJMBN2bJw0x
	Q914YWWm3YMh5dkHvu5wRttKGMB6aTLcvNlp0YerRpQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47xxuyv3gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 21:33:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56I1XPwY007517
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Jul 2025 21:33:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 21:33:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 21:33:25 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56I1XAlq008897;
	Thu, 17 Jul 2025 21:33:12 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH] iio: adc: ad7768-1: disable IRQ autoenable
Date: Thu, 17 Jul 2025 22:33:07 -0300
Message-ID: <20250718013307.153281-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAxMCBTYWx0ZWRfX5uQwG+DMjCwy
 Xb4uC3WsHLVh8O7+PQPK6rywVacT3pDu0+eBEB5fasmkERQw13FkJ91b2uh4hT1lpVpEpiFu4ud
 eA0x6bhczm8ZzNtsUD1pc1hi4W6gaKe6STujzpoutZHAqwZdY3RyjjeHPpkqFoRKXXDOZ55ZGSN
 xVLVjQcFQAjG+L0QY7bZiA2CLwAnHp7wM7SgEtvGZvPLwbkHdAfdFM/nWzDRAkwCA3f1sFNZA+Z
 evFX2BFlEruaic2yF04umymDcKD/RMrK+g+C6Yve1SUMa/Pjljye+zHPQPZJnIAXERYx58yXGKN
 Hgkz/LLei+VSjb1HFyVLt0PIbQT4MPEZAccOqlyczih428TfDs3kZYiJeb1+V5MFd2FWsHhx6NY
 y11STbjdR36OOj7OH2TMjWO0StHprNdKmpL/4Hl2WR8562BK4UUX9f+0vdwvQZ75TZi2INBc
X-Proofpoint-GUID: mO6xstIdxHvuC1mh10ZOFWm1bNu38tpf
X-Proofpoint-ORIG-GUID: mO6xstIdxHvuC1mh10ZOFWm1bNu38tpf
X-Authority-Analysis: v=2.4 cv=ROyzH5i+ c=1 sm=1 tr=0 ts=6879a467 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=HQyUy-T_lNtrtNsvsjUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180010

The device continuously converts data while powered up, generating
interrupts in the background. Configure the IRQ to be enabled and
disabled manually as needed to avoid unnecessary CPU load.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index a2e061f0cb08..3eea03c004c3 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -395,8 +395,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
+	enable_irq(st->spi->irq);
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
+	disable_irq(st->spi->irq);
 	if (!ret)
 		return -ETIMEDOUT;
 
@@ -1130,7 +1132,21 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
 	.predisable = &ad7768_buffer_predisable,
 };
 
+static int ad7768_set_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (enable)
+		enable_irq(st->spi->irq);
+	else
+		disable_irq(st->spi->irq);
+
+	return 0;
+}
+
 static const struct iio_trigger_ops ad7768_trigger_ops = {
+	.set_trigger_state = ad7768_set_trigger_state,
 	.validate_device = iio_trigger_validate_own_device,
 };
 
@@ -1417,7 +1433,7 @@ static int ad7768_probe(struct spi_device *spi)
 
 	ret = devm_request_irq(&spi->dev, spi->irq,
 			       &ad7768_interrupt,
-			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,
 			       indio_dev->name, indio_dev);
 	if (ret)
 		return ret;

base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
-- 
2.34.1


