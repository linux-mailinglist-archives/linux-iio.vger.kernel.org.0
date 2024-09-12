Return-Path: <linux-iio+bounces-9452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A17975FB1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 05:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29ABE1F21F79
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D81422A2;
	Thu, 12 Sep 2024 03:28:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8F136338;
	Thu, 12 Sep 2024 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111737; cv=none; b=rKHPRuFQLy+TV/FvJCnC0frKqVZIHBnnW5O59vHNGBEEZaLQpll+0ITikO2f70aVHjrZsD4yD4fu1nocBQwILExMPFujnlQeIHMTRxnnCK67DlFjdOprNW6/11KVM31mW7qixV4hUodRW1y0gSjHI1kFcXt4Rgr6lMHqMMx//aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111737; c=relaxed/simple;
	bh=aaHump5Ez603AvINyLLmEIe2gGnCkcovisCUNr6gNsk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eay9RMyqIlBr/EMR7REwp3z2gzxjHo+h0Nvc7vQWU+wWu5ltreEzFSVvbpppPK5lB0fuSazVMzlPOuu7URzRzKNARQGLu/A/vAUZDeriK9aG7cw6z/11jTjg0EuetvesMgfeUEtwAfar/QHaC8pKF1Nii2JIP5DFYkV3E/tscIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866e25ff4613-5f647;
	Thu, 12 Sep 2024 11:28:52 +0800 (CST)
X-RM-TRANSID:2ee866e25ff4613-5f647
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566e25ff20cb-fdccc;
	Thu, 12 Sep 2024 11:28:51 +0800 (CST)
X-RM-TRANSID:2ee566e25ff20cb-fdccc
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] tools/iio: Add memory allocation failure check for trigger_name
Date: Wed, 11 Sep 2024 20:28:49 -0700
Message-Id: <20240912032849.2961-1-zhujun2@cmss.chinamobile.com>
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




