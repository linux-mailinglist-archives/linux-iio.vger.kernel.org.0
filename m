Return-Path: <linux-iio+bounces-12954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93F9E07B2
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8BEBA7DEF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F120FA95;
	Mon,  2 Dec 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAhxCH59"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C220E32E;
	Mon,  2 Dec 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152306; cv=none; b=eyLx3XXMuqoWCJa5zTVjf+iFv7zgPTe7Wow8OEuLCYalLRj6jL7p8YqfvdkQs8yg6Wf6sukO+hTNqtSHv/BZUYBJjdlPd37PM92GYO9e+ciO4N3ErxNbjpPSiMHnM+r0h9Ty+OUFxxJa8pxltLEDntZZmpweYpnOvZrVF/6Mce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152306; c=relaxed/simple;
	bh=NfcZdUCLxpBvLjKg8gBIysrlCbsp7eHgSGw1ARszsJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVoGPuZSkxf/M8xJxDxgFRhQG3bCAcmowm8JEQfc4x4EHJuDL/4Yar/5BfPKFHnMUnLRcCPFYHW8wM2d96xqFK9nAqOWpk/Jj9YppwDR5KqCc5RSunTX5LcDfgXbHFrCIha9HeJrN725jeBbrgqP6qyBur8Q8j0rQpfE+ocwdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAhxCH59; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso40384085e9.3;
        Mon, 02 Dec 2024 07:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152302; x=1733757102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDEN2wA9x27SmjgM/ds1sGUcE8EH3J/NUqXM/kC7PUw=;
        b=OAhxCH59dccroLZCIuLOdc9yCQZia1kv4k/AkhNew/r7abygtEEaHn/oYhqTWG9pof
         5qthfc5GKMZLRC4pyyUw2ad08yNinkhQ2XB6KyB3rgMxpK7h298KV+igMAEfrYGaZth9
         2yQFWZ8qtEmVrqZ5wJckbeWzo9kmYe6qVSgfoUX4P+kJxmYQsrp63kTwYMFeFy6yHKuK
         iWU+kWPFnWDKyU6pXy0csHtgnUHhRuZpFuuDm/2bHFvyUN4jb1EotCmzmg2qJ37ecKLG
         eAfdENyJ267wb9/0nap7MHm6zY5sHcCPzbYVXW3YR07cyGUMCIrxIYHKu9QAPH7W1EXw
         r1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152302; x=1733757102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDEN2wA9x27SmjgM/ds1sGUcE8EH3J/NUqXM/kC7PUw=;
        b=RHRcnaoybqR7g64QtlbtIoL/jLqwQcUL89WVEvYsHgoT83rMOJF9i4B6067LBBCime
         EihyoWT2uAgR23VAhP2h/sthPhsBR24SIN+dgQMAGM7Od5+uW+QaFPzes8z4NS78acd5
         Eq1BbrBO7/YkvFbApMubkIUnW7l/SV2TneXQsBRf0Ck5SVJ3+Jf5hSztLkz5u+tiKVn4
         jE9tjj8de2gdY0SCBG6QHh0RGmjYXRUxfoyks6EMUvv7fAUtcH9o1YXvpEjBtfE0IC8P
         lcfalWbCUwvnASVkq4Y4UtElnNNJ+Z6ZSqJb+KDNtOO6SvCGbQw0xZ5rNTsBk2wb+yGM
         yOvw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZQmFIKUf7tNeJp73iRYhAlvTLekLKH17V+s5tstLIuBwg6AYRB8sFbXXjBpu4HNavctEwcz0Qf/EllY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNnXNf6EClFMem3fpPAiolfrj+KvMMtiQ8mmOcoDy/n4d3cq7
	s2ViLC7EOi+8W9f0sfN9djYJ8hGWH0acxmjuZOPbc/DHJSBhyFDn
X-Gm-Gg: ASbGnculJHwT87G/BoaGzYrBJF5GnBzGjKE/34vLRGEyGumU6CVJQpbjUPLd7VJbNyl
	u8T4BCluczklpHBt/6vG/pl7DKeZfJm+8b7yUFeE/YuSkcWGK6C8iQI47/5C8un4W4Asf9ltU2X
	8lEyVWnAdp5MCwXuVBhWgrpD2RafUXUTDQv085ODIdOFiyY/wWYoF6+7KJh0ScBWoH/oyr77jX6
	6NznuSn6jsC+B2GuqySVDAzLuwaZUfdzr1/rR7KZj7F7AH5qP4iNLV/WagwmL6LAzttgGwc4qWd
	E/iIm+Ube0IHU8C3lRLe
X-Google-Smtp-Source: AGHT+IFN2/NKX/DJ3ApNnyH1wsE//gFyKiHyCiweX7Gvdgtdk+l/BLKcIpAIQxHOJRXU6n0VbPbV9w==
X-Received: by 2002:a05:600c:4e8a:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-434a9dc3e80mr241845915e9.10.1733152301730;
        Mon, 02 Dec 2024 07:11:41 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74ea95sm187069505e9.5.2024.12.02.07.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:11:41 -0800 (PST)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 02 Dec 2024 16:11:08 +0100
Subject: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
In-Reply-To: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

During channel configuration, the iio-mux driver allocates a page with
devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
buffer points to an offset of the page due to the devres header sitting
at the beginning of the allocated area. This leads to failure in the
provider driver when sysfs_emit* helpers are used to format the ext_info
attributes.

Switch to plain kzalloc version. The devres version is not strictly
necessary as the buffer is only accessed during the channel
configuration phase. Rely on __free cleanup to deallocate the buffer.
Also, move the ext_info handling into a new function to have the page
buffer definition and assignment in one statement as suggested by
cleanup documentation.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/multiplexer/iio-mux.c | 84 +++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..c309d991490c63ba4299f1cda7102f10dcf54982 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -7,6 +7,7 @@
  * Author: Peter Rosin <peda@axentia.se>
  */
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
@@ -237,49 +238,18 @@ static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, uintptr_t private,
 	return ret;
 }
 
-static int mux_configure_channel(struct device *dev, struct mux *mux,
-				 u32 state, const char *label, int idx)
+static int mux_configure_chan_ext_info(struct device *dev, struct mux *mux,
+				       int idx, int num_ext_info)
 {
 	struct mux_child *child = &mux->child[idx];
-	struct iio_chan_spec *chan = &mux->chan[idx];
 	struct iio_chan_spec const *pchan = mux->parent->channel;
-	char *page = NULL;
-	int num_ext_info;
 	int i;
 	int ret;
 
-	chan->indexed = 1;
-	chan->output = pchan->output;
-	chan->datasheet_name = label;
-	chan->ext_info = mux->ext_info;
-
-	ret = iio_get_channel_type(mux->parent, &chan->type);
-	if (ret < 0) {
-		dev_err(dev, "failed to get parent channel type\n");
-		return ret;
-	}
-
-	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
-		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
-	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
-		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
-
-	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
-		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
-
-	if (state >= mux_control_states(mux->control)) {
-		dev_err(dev, "too many channels\n");
-		return -EINVAL;
-	}
-
-	chan->channel = state;
+	char *page __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
-	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
-	if (num_ext_info) {
-		page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
-		if (!page)
-			return -ENOMEM;
-	}
 	child->ext_info_cache = devm_kcalloc(dev,
 					     num_ext_info,
 					     sizeof(*child->ext_info_cache),
@@ -318,8 +288,46 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
 		child->ext_info_cache[i].size = ret;
 	}
 
-	if (page)
-		devm_kfree(dev, page);
+	return 0;
+}
+
+static int mux_configure_channel(struct device *dev, struct mux *mux, u32 state,
+				 const char *label, int idx)
+{
+	struct iio_chan_spec *chan = &mux->chan[idx];
+	struct iio_chan_spec const *pchan = mux->parent->channel;
+	int num_ext_info;
+	int ret;
+
+	chan->indexed = 1;
+	chan->output = pchan->output;
+	chan->datasheet_name = label;
+	chan->ext_info = mux->ext_info;
+
+	ret = iio_get_channel_type(mux->parent, &chan->type);
+	if (ret < 0) {
+		dev_err(dev, "failed to get parent channel type\n");
+		return ret;
+	}
+
+	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
+	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
+
+	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
+
+	if (state >= mux_control_states(mux->control)) {
+		dev_err(dev, "too many channels\n");
+		return -EINVAL;
+	}
+
+	chan->channel = state;
+
+	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
+	if (num_ext_info)
+		return mux_configure_chan_ext_info(dev, mux, idx, num_ext_info);
 
 	return 0;
 }

-- 
2.47.0


