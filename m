Return-Path: <linux-iio+bounces-8839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD996237C
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B7E1C2324A
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860316132F;
	Wed, 28 Aug 2024 09:34:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9416158DDC;
	Wed, 28 Aug 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837641; cv=none; b=o37pi4p2vW3mh9DVRksREst9l8tzi+Nj3MQUp4ClrBSXXnwRaKS2WDzDkN9ZLtjqbE1ZPrFfM0ZACWFgIniyAp4HvUQpbYbv0ibeRy/Ofx29oPmMBX64OSpqe0Mo4tt2YMs/P5oyRLU6WRzuzIZTP+0UraQiJzZEq5qbfvQSiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837641; c=relaxed/simple;
	bh=aaHump5Ez603AvINyLLmEIe2gGnCkcovisCUNr6gNsk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VVpzO/b6/5A4TlviY/An3q2Z/AR4R6zwAyrfBCMZY0R/8SpNBXJnf4zGpkdHYEwlQk0HGmmMcnyHEilt1HsMk3isrsATQoObYmAv+J76qHd7xxIf56d27oJjH/5h+/JCKWk9suimnE6m6ksgnkNsvASezYr5O711wP/4Tv22n7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166ceee47a4d-7c34c;
	Wed, 28 Aug 2024 17:30:48 +0800 (CST)
X-RM-TRANSID:2ee166ceee47a4d-7c34c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666ceee47464-5f1f3;
	Wed, 28 Aug 2024 17:30:48 +0800 (CST)
X-RM-TRANSID:2ee666ceee47464-5f1f3
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/iio: Add memory allocation failure check for trigger_name
Date: Wed, 28 Aug 2024 02:30:47 -0700
Message-Id: <20240828093047.2993-1-zhujun2@cmss.chinamobile.com>
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




