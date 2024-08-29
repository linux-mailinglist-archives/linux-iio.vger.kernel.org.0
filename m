Return-Path: <linux-iio+bounces-8856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A52963CB9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 09:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B63B281740
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C1174EEB;
	Thu, 29 Aug 2024 07:23:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131D15B543;
	Thu, 29 Aug 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916214; cv=none; b=umQ0603NsqL8KQRlcFZ4c9loTyDqxg+NlgGvaUjy/7l0Oqab70efDADeyxbunl8z8rkV705nYy/gVG/xfO1Inc7FfJVa2+fCuNAc2vu96lbVMcTo6Y7QhWtkOQXXHn9kuJDpXGb0Yi45GcOW6flXjoiWGNy5UCqGJX7B2eXsFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916214; c=relaxed/simple;
	bh=DVjN3LGUILE/MRUodq19NYUGVkyq+yGHSN1oTZ/dLDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8+OgALEHzOI/IsWGcrFxs0/1rmk4ilQ1JEYqnmduStUY+1/vOy6RoEA+f4HLNMizK/oqP7752unCT5fGEtcFPnA/FJilWT8RxwihYf+qXNXXzd1fK8AXkrrKHL66civySwvS/BWHZGHgDY1fen9YLaD+NxULAguAkubfwnblpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766d021ee0b0-b40b4;
	Thu, 29 Aug 2024 15:23:26 +0800 (CST)
X-RM-TRANSID:2ee766d021ee0b0-b40b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d021edb7d-963da;
	Thu, 29 Aug 2024 15:23:26 +0800 (CST)
X-RM-TRANSID:2ee766d021edb7d-963da
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangjiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools: iio: rm .*.cmd when make clean
Date: Thu, 29 Aug 2024 13:33:09 +0800
Message-Id: <20240829053309.10563-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangjiao <zhangjiao2@cmss.chinamobile.com>

rm .*.cmd when make clean

Signed-off-by: zhangjiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index fa720f062229..3bcce0b7d10f 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -58,7 +58,7 @@ $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/linux/iio
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-- 
2.33.0




