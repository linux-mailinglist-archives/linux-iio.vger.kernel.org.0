Return-Path: <linux-iio+bounces-9068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58DC9698DA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAFF1F25959
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D31B9824;
	Tue,  3 Sep 2024 09:23:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5CC1C766C;
	Tue,  3 Sep 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355400; cv=none; b=nX+M80tudCa9ZFdu45WECHKdqSGCITsLU/0pIBsUJMVHNoCMw2o0BLkoKs6JsqnfDkAOkiW68A/s0EzdMfZYzCPjJ7VSX6+1PuDaVLqhDHLgRNrCX8nujvdJSK+9bm7bBr4WhM40ejNW5MeRwhMSHw+jILhNDIdKOjjSogkaziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355400; c=relaxed/simple;
	bh=k52wpp4TMmcpmmwWLIORRMJMFGgGL58X2X5Kb0FYbPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBLWTjK85OpipPJmLFGDA58st+oW8drmp42HEWZD/3HXQYTOQDcekaK27UBG+cmSsYJtJfuMjapWxSHsNa3Lf7aVkBw2NeWzzMkHW0RNdbPiO77x8WxLokT+Wp0Rfgy1RTwkgFiD6f0bff//aMoshcYX55MSKfOwto+Nl+Zj/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d6d5810c3-ab9c5;
	Tue, 03 Sep 2024 17:23:15 +0800 (CST)
X-RM-TRANSID:2ee166d6d5810c3-ab9c5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666d6d582534-df3f4;
	Tue, 03 Sep 2024 17:23:14 +0800 (CST)
X-RM-TRANSID:2ee666d6d582534-df3f4
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools/counter: close fd when exit
Date: Tue,  3 Sep 2024 16:01:21 +0800
Message-Id: <20240903080121.5294-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

close fd when exit the program

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/counter/counter_example.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/counter/counter_example.c b/tools/counter/counter_example.c
index be55287b950f..37569208c235 100644
--- a/tools/counter/counter_example.c
+++ b/tools/counter/counter_example.c
@@ -57,12 +57,14 @@ int main(void)
 		if (ret == -1) {
 			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
 				strerror(errno));
+			close(fd);
 			return 1;
 		}
 	}
 	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
 	if (ret == -1) {
 		perror("Error enabling events");
+		close(fd);
 		return 1;
 	}
 
@@ -70,11 +72,13 @@ int main(void)
 		ret = read(fd, event_data, sizeof(event_data));
 		if (ret == -1) {
 			perror("Failed to read event data");
+			close(fd);
 			return 1;
 		}
 
 		if (ret != sizeof(event_data)) {
 			fprintf(stderr, "Failed to read event data\n");
+			close(fd);
 			return -EIO;
 		}
 
@@ -88,5 +92,6 @@ int main(void)
 		       strerror(event_data[1].status));
 	}
 
+	close(fd);
 	return 0;
 }
-- 
2.33.0




