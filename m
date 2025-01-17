Return-Path: <linux-iio+bounces-14408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4066EA149DC
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 07:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D516B2DF
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42621F76DE;
	Fri, 17 Jan 2025 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dZRRt/UW"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675B1F75A6;
	Fri, 17 Jan 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096958; cv=none; b=aftkSFMVdT36RQNSia412Vzj0JHj7BC2lVedvt9NCQ7SnxXW33drqKnq6JrynTFfViVlz110C/fW2TYrmMzSQTgjBVKmMEkHhslma1wpZC6Q0LlLFDVMYgXnaHbdZYCjD+WEBg5ejE9EaQo2Yct8903rb/bgy98fOD2RJgvMQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096958; c=relaxed/simple;
	bh=kXAC9jkUX2Ye0sJT9qEmn9BcZlbeBLBrx8zObQdTXSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ig1EGruHwFWJuADGYk7lkl2wBVJ8uTg3QZahxR0pHriemfUIAu9wf3pioumgTyWGZ3R1RjRsGc3HVuz0J7h27ERKwe5GfqtWOnTXjbX+k3rXKZeLCPuDGvVHzOl1nzFcXfgiYbVcbXAIr9Ra3VrS00CLNJRtjclh5GtMlTK54Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dZRRt/UW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1737096957; x=1768632957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kXAC9jkUX2Ye0sJT9qEmn9BcZlbeBLBrx8zObQdTXSI=;
  b=dZRRt/UWtjFygVlt2DPWUOiU+L3vMjdwGdWjajniN8DtfYKUOcuErh1T
   28I3MFXOa10jE00NjlvT/iLf2gtTKqedfErJdSEnrkwBjU9R8ourQTB/N
   5jiFXFeR2J+HW6gl7zsBKrgfQNaVBdt48Gb/5io8kKMb3MWUWcPACz71o
   9dpbKDdedpC1l0moZHhClFnFsevx3yIgCSB7ir0FBFK9ORHnu8Pp5Umgq
   Ft+Gt3QbuUzWFWnncWyXgr/9HTC+E2iM0Yz2DOSIbUwZccoPOjTDw6K9b
   dnujUNX9p1fQnawQrhcvMC7Uo8AfZ2F38Y9ZfB3NdVhCJZLwZL2+6cNXb
   A==;
X-CSE-ConnectionGUID: 8x2oqUo9TpCXhaquL6I0Jw==
X-CSE-MsgGUID: mJK4OGvZQsWUedZx65+dCA==
X-IronPort-AV: E=Sophos;i="6.13,211,1732604400"; 
   d="scan'208";a="36637665"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2025 23:55:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 Jan 2025 23:55:19 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 16 Jan 2025 23:55:18 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <andy.shevchenko@gmail.com>,
	<jic23@kernel.org>, <lars@metafoo.de>
CC: <victor.duicu@microchip.com>, <marius.cristea@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] iio: adc: pac1921: Move ACPI_FREE() to cover all branches
Date: Fri, 17 Jan 2025 08:53:14 +0200
Message-ID: <20250117065314.4431-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This patch moves ACPI_FREE() in pac1921_match_acpi_device()
in order to cover all branches.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Fixes: 9fdf1d033316 ("iio: adc: pac1921: Add ACPI support to Microchip pac1921")
Acked-by: Matteo Martelli <matteomartelli3@gmail.com>
Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---

This patch ensures that status is freed before
exiting the function.

Differences related to previous versions:
v3:
- add parentheses to function names.

v2:
- add Fixes tag.
- remove unnecessary blank line.

v1:
- initial version for review.

 drivers/iio/adc/pac1921.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 90f61c47b1c4..63f518215156 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1198,11 +1198,11 @@ static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
 
 	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
 			     GFP_KERNEL);
+	ACPI_FREE(status);
 	if (!label)
 		return -ENOMEM;
 
 	indio_dev->label = label;
-	ACPI_FREE(status);
 
 	return 0;
 }

base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
-- 
2.45.2


