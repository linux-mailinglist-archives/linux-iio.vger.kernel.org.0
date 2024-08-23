Return-Path: <linux-iio+bounces-8741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8A95D970
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 01:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050ED1F236CD
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6F19258A;
	Fri, 23 Aug 2024 23:01:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5857195
	for <linux-iio@vger.kernel.org>; Fri, 23 Aug 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454069; cv=none; b=DgL7DBagz7FZCtJ27yBtfBbasR5MEAO3owCkomUVN4TJsNMOjmThBx0dtV+d9S5ZkIAFf6MDr8zsszu3n7FBXROz8/zFsr15Q83dCP+BIfnc54HABNLPkpd50ys9pscLK96bEqTad4mm3QgB1WQZDkJvbQf4Lbs3J8p5k6EJdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454069; c=relaxed/simple;
	bh=AVIpfvn849D1vJHJPPsy57XFDWFL8ivNTHcOwmrjbMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGeKFyUuq30ooKBNG8bqY220AnZiDYxgoPKkyyEqS+Plm0ZE2ycetzHPqxP05UBVrDdpMipVio1DwJV7nGOlpRmpds6ajCFk31ks5x0t/ZcXr9nual0IG0bQKDDbsxDXNkbJGvo1v6NLkvH3p3kA3sNzKUaWvYMLpPrGSZ1c+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 8fc8dad0-61a3-11ef-8ebd-005056bdf889;
	Sat, 24 Aug 2024 02:00:59 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: accel: bmc150: use fwnode_irq_get_byname()
Date: Sat, 24 Aug 2024 02:00:56 +0300
Message-ID: <20240823230056.745872-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
to get the IRQ number from the interrupt pin.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 03121d020470..14ce03c70ab5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -10,9 +10,9 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/of_irq.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -514,7 +514,7 @@ static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
 	 */
 	irq_info = bmc150_accel_interrupts_int1;
 	if (data->type == BOSCH_BMC156 ||
-	    irq == of_irq_get_byname(dev->of_node, "INT2"))
+	    irq == fwnode_irq_get_byname(dev_fwnode(dev), "INT2"))
 		irq_info = bmc150_accel_interrupts_int2;
 
 	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)
-- 
2.46.0


