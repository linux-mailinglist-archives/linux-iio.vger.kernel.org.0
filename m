Return-Path: <linux-iio+bounces-8838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043396236D
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 11:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D07E2849A8
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F1D161321;
	Wed, 28 Aug 2024 09:31:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFCA48;
	Wed, 28 Aug 2024 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837508; cv=none; b=ZsitDzbRbQJc0E5Ea/FtJRfQndFAtExu8wGjkz2yQgNO2tjgmkw5YS2Lrn1vBlVdpqaA89Yk4smac7C091LL0Y+hsO+Ly9iOOsQ3vjt9IKmuZLvjXPNUlAg+WhZwYqCbk56jb+WvIh6g8z5LDQi5EEIEm7rMsbsfA7C8HLiV2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837508; c=relaxed/simple;
	bh=aaHump5Ez603AvINyLLmEIe2gGnCkcovisCUNr6gNsk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=E20chEf9T3l9Lq8Ukz4GetKGAxEaRDD3+uVuIkI6gU8JBWPPSxHabh3azyLHwGe7h1ITHHCTQe7hHzjQmwMqWSFyG6NqlDU4FQME6kcGb4FrPEj1fHQ02dhsMFqMfG/qe633rrQNR1bRlBjJhYrVetsaaMrRYjllkuzOLLKv9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566ceee7852b-ac52e;
	Wed, 28 Aug 2024 17:31:39 +0800 (CST)
X-RM-TRANSID:2ee566ceee7852b-ac52e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366ceee79ce4-5d4dc;
	Wed, 28 Aug 2024 17:31:39 +0800 (CST)
X-RM-TRANSID:2ee366ceee79ce4-5d4dc
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] tools/iio: Add memory allocation failure check for trigger_name
Date: Wed, 28 Aug 2024 02:31:29 -0700
Message-Id: <20240828093129.3040-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

Added a check to handle memory allocation failure for `trigger_name`
and return `-ENOMEM`.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/iio/iio_generic_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 0d0a7a19d6f9..9ef5ee087eda 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -498,6 +498,10 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 		}
 		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!trigger_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
 		free(trig_dev_name);
 		if (ret < 0) {
-- 
2.17.1




