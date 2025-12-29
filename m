Return-Path: <linux-iio+bounces-27411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E7BCE686A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148DC3008885
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0E3090FF;
	Mon, 29 Dec 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JyJqRfta"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600E3081A4;
	Mon, 29 Dec 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767007742; cv=none; b=JIno71HHijQSzx7oihlLVXg1Uw6hVlC9c+1ApIm+J4xosQajVTAZyE4mLb5NTCMLSiL702OQNzgI3b2sF0GnXVH6yZyUVbvVgSFbppG6dq+jnkTLbvQI7Eh/hQ1aD7HRJxHEia9smBO2cag6OBI7sD7sXfa3Nsf+UCatoTRGozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767007742; c=relaxed/simple;
	bh=Vrnp3+9t9QGomuqSC9z66YdxV8/FFX1/LqbUfxTILvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpae3qpdJMN5n7bjSCmxuL/0qVlMm/pLp3LAA7C8bh+DhIpvq74QQplf99dh/xB1TkZdnU2d8hnw+f4dkfCfn/qfXw3kHhABb8j4FGgN+CqnzZSHDrLMneRbvAiZ5+ue1xC88dlcN+yX9rw/GqAg/RLzkQcCSXCiusAdD7KLDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JyJqRfta; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id aBPhvRhhv36oUaBPivOmj8; Mon, 29 Dec 2025 12:27:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1767007670;
	bh=as0Q48OrzNAwx7nSEc4aZL7xhVX1lYPBclH0kPM3rBg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JyJqRftaUlo3n9FJfF/MV2RpDlWENaCX/7/ODtyl5sVLnln5WyVWcJcQ5U4ThLgPR
	 xqXhJeTRtVtbFQEHjcVYHAf1MWQrl8zfCwPcrpQHLDZogdH6l1D9nvEJZ+d+wLXtkw
	 UGV5rEkpBu3me9AYbwV5S8Wykt4oH9dykWCIk3RNVTWlAb6PchLuYXGOUQAo1c9q9E
	 vebMBO0uIpIYSWgFusuWR31uGccWy6ZT/SyhS84+eXpAG/LjWvxS7TIHYYqk8ZVp6B
	 VXjUXsjfOKIgizkyL+YzhTIXjPT1J5D8IQnrAQAo6ySVvhIYW+SZ0FiWJWZmb5LByg
	 NPLGUowBOXeAA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Dec 2025 12:27:50 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: core: Constify struct configfs_item_operations and configfs_group_operations
Date: Mon, 29 Dec 2025 12:27:43 +0100
Message-ID: <6f327beea525e2b96724b0b395f1105ff7ccc305.1767007641.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   5037	   1528	     64	   6629	   19e5	drivers/iio/industrialio-sw-device.o
   5509	   1528	     64	   7101	   1bbd	drivers/iio/industrialio-sw-trigger.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5133	   1432	     64	   6629	   19e5	drivers/iio/industrialio-sw-device.o
   5605	   1432	     64	   7101	   1bbd	drivers/iio/industrialio-sw-trigger.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This change is possible since commits f2f36500a63b and f7f78098690d.
---
 drivers/iio/industrialio-sw-device.c  | 2 +-
 drivers/iio/industrialio-sw-trigger.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index cdaf30a3f233..3582524de0b8 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -148,7 +148,7 @@ static void device_drop_group(struct config_group *group,
 	config_item_put(item);
 }
 
-static struct configfs_group_operations device_ops = {
+static const struct configfs_group_operations device_ops = {
 	.make_group	= &device_make_group,
 	.drop_item	= &device_drop_group,
 };
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index d86a3305d9e8..334b6b10a784 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -152,7 +152,7 @@ static void trigger_drop_group(struct config_group *group,
 	config_item_put(item);
 }
 
-static struct configfs_group_operations trigger_ops = {
+static const struct configfs_group_operations trigger_ops = {
 	.make_group	= &trigger_make_group,
 	.drop_item	= &trigger_drop_group,
 };
-- 
2.52.0


