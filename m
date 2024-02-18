Return-Path: <linux-iio+bounces-2739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29D859831
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706AFB20EF7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D636F060;
	Sun, 18 Feb 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvv8Q1u2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AA6EB7A
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277620; cv=none; b=fphqwQsJGNh3Vk0NwJz99SY/joBiMQWfa6LNgcwfZKQP8cb9HxtRQl4KuuP4SErqfzPbdCDDIKV2z6ct2YlU1FNTcs7H+YD3WvJSYkZ56q/+l8gUBbMHuIkhxB2JpIqkoN4cSV0SGYyoRaZWCDBaMk8nffVp03NOSa8lI8dEf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277620; c=relaxed/simple;
	bh=P1TUIxPZQ5lpOqBJUJm3jTlOHakrJ/xM+utJEl+0ghY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+F4XleWL70XMvHnDCmTW9p3R+LpukXZjIjHjhSiTP0Rrs5tO3zN594WjbNQhoL0RkBRxWwgWqogg2zNAMCXajit9rnzs4Jtfhvhc0vCnmLgJBPWyFZz0/W7Rk3ZOIJ4etgROVvufBxy8td1+xjT73PYmnbwsZG9F7cKnmvIOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvv8Q1u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6FFC43390;
	Sun, 18 Feb 2024 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277620;
	bh=P1TUIxPZQ5lpOqBJUJm3jTlOHakrJ/xM+utJEl+0ghY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvv8Q1u2Xs9/knOftSM+bUblYgy17z8VBdj1O5bEym3FIMG8ZKc630f/RSCZRfMcV
	 6twiPKZbxav6Sw/lR++9RLlSarpKw+FbRm7VupGDqgWkVVIcpNbwVlz4+xjTFlRysN
	 H4TNox0hxLmESQ5ZKjTMl4jbVF4ssaKIDLInIzHoQaHedyDEuwUmh/zyRX9vzCie6J
	 dAYReXZHboXrCP4gUS6S0ryRh4tXPmxK0jhPspdANQPaefHTW3odBKSfdgT5h8X7vl
	 js6Jl23bVOdGLGJxm2QF8s+rCpqlUc++XQ6jyq+EGTaoGcevoSBotYb64Wg03AGIH0
	 /SzdRwQ35NrCg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/8] iio: light: al3010: Switch from linux/of.h to linux/mod_devicetable.h
Date: Sun, 18 Feb 2024 17:33:18 +0000
Message-ID: <20240218173323.1023703-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The only of specific definition used is of_device_id table and that
is found in mod_devicetable.h not of.h

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/al3010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 8f0119f392b7..53569587ccb7 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -17,7 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.43.2


