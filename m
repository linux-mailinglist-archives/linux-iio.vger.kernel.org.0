Return-Path: <linux-iio+bounces-16312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8AA4D365
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 07:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139247A7827
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC61F4264;
	Tue,  4 Mar 2025 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I7muvuz2"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990953AC
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068382; cv=none; b=SS6BkyCyhp1tlEmPg/H9oIPt1HmAgYOCNxbbmNEH4ai7vuu90HFMcvlvqLspUZ3FSnC835vZpNidwCCyidqlRxBzTvzwxAADxoODjvD7suMx97Fn6zYZ4Jqw/86HsUorEg4BXwK36f3OOhf1GGombMscSnDct8JblljSgrmQ7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068382; c=relaxed/simple;
	bh=QtEa1zq3/mNdAOhk1rn6asgWWsdKjD5zozOj80+BDFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ahTuh7cpohdstyx7K8w6sjiFbdkncXKs6Q06S2l9eDfHEy+AjDaJh77Sg9XCudnS7eIsI1ANNIqltEydcJzr17Y/al8XSKXvXz2a7aCm2Sv2N743xag5V6rDoR8T477aWTle5WVl5/VyPzl1zK9gSrWiroSJqpv1fY48l/okgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I7muvuz2; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741068367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hNtZKMGCFYNKNfdPUddVscJWUmXlLMRCxoU5HIaNvO4=;
	b=I7muvuz2G3D7+JDF+j0a4x+NgZyhG2lznmZ+QSkl/KODhLEbQkjR96tW5X/cNOhZQqcTo+
	FZVsDX8btbpajcQN2iBGk+k8p8IXZFYy5KrJUFHvym3t9g65uP51Zd80Wq06Fz+/ERWLUP
	zsWtv3thl1YyhROvaCt9O+6yHvcgi4E=
From: sunliming@linux.dev
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] iio: imu: adis: fix uninitialized symbol warning
Date: Tue,  4 Mar 2025 14:05:18 +0800
Message-Id: <20250304060518.1834910-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below kernel warning:
smatch warnings:
drivers/iio/imu/adis.c:319 __adis_check_status() error: uninitialized symbol 'status_16'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1c646c36aeb1..0ea072a4c966 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -306,7 +306,7 @@ int __adis_check_status(struct adis *adis)
 {
 	unsigned int status;
 	int diag_stat_bits;
-	u16 status_16;
+	u16 status_16 = 0;
 	int ret;
 	int i;
 
-- 
2.25.1


