Return-Path: <linux-iio+bounces-10648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCDD99FD45
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 02:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7341C20E71
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 00:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745510A19;
	Wed, 16 Oct 2024 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gJZTMpTb"
X-Original-To: linux-iio@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A49E574;
	Wed, 16 Oct 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039173; cv=none; b=JKhzQUg1kiKcMporHN33cAgXlqsPeMU1NAZA+aeKqqHzgi3J1swmjCRe+qOsUbj8I/G3eoxErwSQpXIRqQyBVYbz1aRqXwDeFZMlJ/VnwUqC+CcLJyb3l4hAnc5thU6DmBOWV0gUTBWLNaFCNaZ96psBYZsorAWS8FLFgrFApJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039173; c=relaxed/simple;
	bh=NWbY6OXSvcmHKbN3b0tntR9ySnQkm96XP+dKuWme7+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOikII9NmocEJCQZ5ZWTN7UsbLEA8tQdHqH31zP/1tXGELpQQNwRgCP3tsSTWD7NejxtObMCIwd++lBday9rz6EzuBODlKKmw/y4M6+pG9fucPAAt4W8QQOEjiH1sY3eW5gw/P+Yv6kSE+IoTTHQRS3/mcLTEECLLm1vFvvL7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gJZTMpTb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729039162; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EhULM1Y7gWC2aKBOupKX6U4ba4logDI2HZcOfsu36wY=;
	b=gJZTMpTbQyjRdVAQ7DXcDvk4fIQ/BHrgQ8w5Ak7OM2uJrFG5whHeELf6pF2WyWXoApmbiX78K2Vvyr5Da9MHmKGSlkl6PrCINig4X6t83ZoljEnmm1iDKH3YssPohPhoDLQ43D8pKXsnKMcz9QQiUyakbdIrj8Dm/YolQsMqG/E=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WHF.Nkf_1729039160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 08:39:21 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] iio: imu: bmi270: Remove duplicated include in bmi270_i2c.c
Date: Wed, 16 Oct 2024 08:39:19 +0800
Message-Id: <20241016003919.113306-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/module.h is included twice in bmi270_i2c.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11363
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index e9025d22d5cc..71cc271cdf30 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -3,7 +3,6 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
-#include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 
-- 
2.32.0.3.g01195cf9f


