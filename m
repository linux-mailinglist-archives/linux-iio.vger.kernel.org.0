Return-Path: <linux-iio+bounces-9128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6E96B708
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7131F21D17
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064ED1CCB5B;
	Wed,  4 Sep 2024 09:40:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32018784F;
	Wed,  4 Sep 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442834; cv=none; b=k5JQQZGf8ZD4P8WjvljmW6s1BkEUmRqfDs+NlOkCSqcssPgrGbKPsQdtj+s9mUscUOdJRKP6E7bjGhLr5VD10ecRyrDIJdxO7nq0aHMnwYKDWCbY+FGEysvxUv9eIEGqUtw/EGRufQoF/D+yJIILK5SaEO2wVGykefV3FaPSc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442834; c=relaxed/simple;
	bh=yEZAi3PPGeQQ5kqNWhLHDSpcZqLF9wXEtsG/2XNXLT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jCUJax+2zYFJyh8uJ6cOz0Br8J/U/nOwQZGWGcfPUq10F1CuTVYP6GPoKaILZH0bxtGKzvB0SYIDu84Z0hvOtg6fRYFP5AfbdSQMcCda5hPjVPm/ZoI3XgpzaCUmMMhQr6orRrFyoLSynFBFMFB4aARhfNLq/s45/yKr1nIhI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d82b069ae-b52b0;
	Wed, 04 Sep 2024 17:40:22 +0800 (CST)
X-RM-TRANSID:2ee166d82b069ae-b52b0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266d82b05f65-27856;
	Wed, 04 Sep 2024 17:40:22 +0800 (CST)
X-RM-TRANSID:2ee266d82b05f65-27856
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] iio: event_monitor: Fix missing free in main
Date: Wed,  4 Sep 2024 16:05:33 +0800
Message-Id: <20240904080533.104279-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Free string allocated by asprintf().

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/iio/iio_event_monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 8073c9e4fe46..d0b8e484826d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -449,6 +449,7 @@ int main(int argc, char **argv)
 		enable_events(dev_dir_name, 0);
 
 	free(chrdev_name);
+	free(dev_dir_name);
 
 	return ret;
 }
-- 
2.33.0




