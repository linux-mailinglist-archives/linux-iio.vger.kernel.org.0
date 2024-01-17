Return-Path: <linux-iio+bounces-1720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA4830589
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 13:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F055F286B4C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69B21EA76;
	Wed, 17 Jan 2024 12:38:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B421DFF4
	for <linux-iio@vger.kernel.org>; Wed, 17 Jan 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495113; cv=none; b=dPP6ghPMJUhAx56v63ZPFUZye80Q+7CMebC01gCmlphxOZCP3rpilXe1/TrBPl9sjxdBtzuGvo/81rZbXusVeFh8Ioj6NjzhY0WJGqPZDRojs3bYCnHjHhjMQEX0SgjHvuPttrBSdyykjhvmmx6yFnHBeyNS81LOvpEl6RcGXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495113; c=relaxed/simple;
	bh=gW0giW47mSIdPK2iC7EzZMpuTWPJDZKFVyrgVmAl0bg=;
	h=Received:Received:Received:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=ps2sBZqvag1aIPS3gOnwTEICfN7XrOB1v4oAIncunWdhcsjMkiJlFXKM/NRR60qRpnZ5B+TPjPiPo5Lhk/9KI7CNAPnoYYIc+for2qxWfXhoh2S5ThI20N7tCx/urjucgianZwuVA94RNxKc9GjSAgG89bBnL5sLUU4uScnfJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H9k5nv016151;
	Wed, 17 Jan 2024 07:38:10 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vnm166kjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:38:09 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40HCc83w030395
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 07:38:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 17 Jan
 2024 07:38:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jan 2024 07:38:07 -0500
Received: from [127.0.0.1] ([10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40HCbu10023809;
	Wed, 17 Jan 2024 07:38:04 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 13:41:04 +0100
Subject: [PATCH 2/2] iio: adc: ad_sigma_delta: allow overwriting the IRQ
 flags
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-dev_sigma_delta_no_irq_flags-v1-2-db39261592cf@analog.com>
References: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
In-Reply-To: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Renato
 Lui Geh <renatogeh@gmail.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705495270; l=1682;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gW0giW47mSIdPK2iC7EzZMpuTWPJDZKFVyrgVmAl0bg=;
 b=NBiLbEnbR8IcxmGWK77WdbXSrjuIbDqO55RD8cEcCVSE6EX+znOHxzgwNqZFmYcGDzpxVjO1K
 /wsYaE6luE2BrsX7/FzYTErHNbS+MewoxCUwYZqJ5G6paqcw0Vyr1GQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: k_BSyqmIYd0dYb4r_gLJ7vhoaOsFJHfi
X-Proofpoint-ORIG-GUID: k_BSyqmIYd0dYb4r_gLJ7vhoaOsFJHfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170090

Make sure we can specify the IRQ trigger type from firmware and drivers
won't ignore it. In fact, this how it should be done but since someone
might be already depending on the driver to hardcode the trigger type
(and not specifying it in firmware), let's do it like this so there's
no possible breakage.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..fbba3f4a1189 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -568,6 +568,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->spi->irq);
 	int ret;
 
 	if (dev != &sigma_delta->spi->dev) {
@@ -588,9 +589,13 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
 	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
 
+	/* Allow overwriting the flags from firmware */
+	if (!irq_flags)
+		irq_flags = sigma_delta->info->irq_flags;
+
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
-			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
+			       irq_flags | IRQF_NO_AUTOEN,
 			       indio_dev->name,
 			       sigma_delta);
 	if (ret)

-- 
2.43.0


