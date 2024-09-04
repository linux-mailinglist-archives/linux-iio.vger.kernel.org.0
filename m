Return-Path: <linux-iio+bounces-9110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3851B96AE03
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 03:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE61A1F25F9C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 01:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07476BA50;
	Wed,  4 Sep 2024 01:43:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2310F9;
	Wed,  4 Sep 2024 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414183; cv=none; b=m/aPhR5Oew0I5+fdHYMiJo0K2wIwd6iMWzqoCE+bkjluxTnte3cEt5mrthIN/F303tf4EVRou45w4HqNcCgJIAuINN1C9je144XctE0i41H2lMUkzsol2rcyS4U2As/Pbd1/b0wEjm6pMiWxC4y5ccsBNi7Lg8NQPf2kR0R1ZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414183; c=relaxed/simple;
	bh=RnAmNjJ25oudecHmjW3/YgV5LxMV+dnwHeJoxUNDSKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=baqFKwbh7vCRmso+OMYPg4Xl3qaGqoynv7e+c95dKti9oZOGvI2g0eKXstpdTo35jQOkaUcAuUJk3ufox/vw5UqHDTC0sD4b96pU5b4DCmhm1lP4o6ZHAm8TIRmGK89Jr2sen7QvWug1gjIcvBHHkaHkMYmFByUhwrVq0xlpwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966d7bb1ff1a-e5f1e;
	Wed, 04 Sep 2024 09:42:55 +0800 (CST)
X-RM-TRANSID:2ee966d7bb1ff1a-e5f1e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d7bb1eede-0a786;
	Wed, 04 Sep 2024 09:42:55 +0800 (CST)
X-RM-TRANSID:2ee366d7bb1eede-0a786
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: andy.shevchenko@gmail.com
Cc: wbg@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] tools/counter: Close fd when exit
Date: Wed,  4 Sep 2024 09:42:53 +0800
Message-Id: <20240904014253.2435-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Since fd is not used in the messaging it's better to 
close it before printing anything. Ditto for other cases.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2:
	Close fd before fprintf.

 tools/counter/counter_example.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/counter/counter_example.c b/tools/counter/counter_example.c
index be55287b950f..37569208c235 100644
--- a/tools/counter/counter_example.c
+++ b/tools/counter/counter_example.c
@@ -57,12 +57,14 @@ int main(void)
 		if (ret == -1) {
+			close(fd);
 			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
 				strerror(errno));
 			return 1;
 		}
 	}
 	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
 	if (ret == -1) {
+		close(fd);
 		perror("Error enabling events");
 		return 1;
 	}
 
@@ -70,11 +72,13 @@ int main(void)
 		ret = read(fd, event_data, sizeof(event_data));
 		if (ret == -1) {
+			close(fd);
 			perror("Failed to read event data");
 			return 1;
 		}
 
 		if (ret != sizeof(event_data)) {
+			close(fd);
 			fprintf(stderr, "Failed to read event data\n");
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




