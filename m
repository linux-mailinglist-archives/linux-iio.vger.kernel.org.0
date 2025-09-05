Return-Path: <linux-iio+bounces-23761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A170B452CD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6DA3B40D7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE130ACEA;
	Fri,  5 Sep 2025 09:11:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECAE3128A7;
	Fri,  5 Sep 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063500; cv=none; b=GiZ1qDOmwi99M8YL1pWSsmgCRTYAz6SKRYCjRCi4Pauq943GDlLLJJQEVYBvGkqq1LDT0fRd8KWwpXBBt3OrOV7KvY3bKE0sqComhC4vxVF7pXXwNLBR8iFG2xZTyTD4m8dsXei9j2GLXlF85UqUqEkyl2bOVKqdfAZJcNNZQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063500; c=relaxed/simple;
	bh=iqBuzZAF2nEz4850KgvmvYAL+9DL55IoCoAwrWddBTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQFsRkyA53UGOp0RxQpxOjpo3arHKHl1UYd8Z/1j/bvcZ5ysgsibjU/fI6Xitc/CplFv5wh6/Q3M72olFOCxKHSNFKEwQSB9GdCEQaXKVqMTkMvRiMA47xmTpLD8/ZZF2fjJsz3969bqBtboKl4x6+SfBaupOZKQGJhLdDjeKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee168baa93c7e2-691c1;
	Fri, 05 Sep 2025 17:11:24 +0800 (CST)
X-RM-TRANSID:2ee168baa93c7e2-691c1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee268baa93898c-c8d49;
	Fri, 05 Sep 2025 17:11:24 +0800 (CST)
X-RM-TRANSID:2ee268baa93898c-c8d49
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools: iio: rm include dir when make clean
Date: Fri,  5 Sep 2025 17:11:14 +0800
Message-ID: <20250905091115.2687-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

rm include dir when make clean

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 3bcce0b7d10f..15c2f472666a 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -57,7 +57,7 @@ $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -rf $(OUTPUT)include/linux/iio
+	rm -rf $(OUTPUT)include
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
-- 
2.33.0




