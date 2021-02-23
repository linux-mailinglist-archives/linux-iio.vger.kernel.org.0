Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28B7322664
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 08:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBWHaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 02:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBWHaS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 02:30:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B7C061574;
        Mon, 22 Feb 2021 23:29:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m1so1433837wml.2;
        Mon, 22 Feb 2021 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vW4voyafSIkso29cJe58XwAz7vVwoC6pWC1+Hau2qGo=;
        b=o+R1+IFCxlqXWyDtsnfHkXSsupZH2YZgB1e1fiviHNy1iiE/srhTRU10dYaiLayBna
         ZyN0l619ylBpghp/pD2db7robaingdvuPUJAxgXBqKvgwCttT8ZCaNK0hbzlKCBHAWZ4
         knqpPR6lA55i3d3n+C/TyaHxNRD0JVA+hn5F0SF8CkaqzlrzD2qDa9AxfgqkBWpShY7t
         dS1kYLx/tyuuJX0iKbldoHMFOBD5urJhXXwNm04nQB5tTb3moniomW7wOq+TYDfmXW0j
         lliAxfNev3MKo25zIPb6diD06UEhk0q/ATsrPkgjgFMuExbdJklu07x7EMN7TVT/IN58
         aAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vW4voyafSIkso29cJe58XwAz7vVwoC6pWC1+Hau2qGo=;
        b=AxZSjdNXKcg+NKw02kxuqz2O6EQ7yAxDWj0pi9W0jAZfJxGVWRV9XTlkf7EXI8M6Uh
         zf2N+nTwnARHPFWxHNhauvLnD93CGG7aX4RuyrLQDmIU8R7OeguHGzNn32TbvHSwzq61
         2HvI9G3edT+iMap5BEjWTR3BCwAkflF7Kviv4oUb1mAI2P0abVI6YLeJriSqjvA5PzJy
         eGXyu9ByQwzvSd4SuthDGUJxNkcSuXK1k+NE55BMeG7ZcBQr3A4ppxDcJvQ+trVVdq/Q
         73xUKb0Kd0uSl89CWfGL8gO0ic5EHHL9a0HB3xH5hL47WndhEJk9N9PKUHo3riltNpdx
         123g==
X-Gm-Message-State: AOAM531wmYNG5IVodxHrzALg759cgxxfofWS8X0DW+zOjWBc41WXSuFy
        InuqimHbSaLcUjGmHxrDy5B1mOt+wAgJ6w==
X-Google-Smtp-Source: ABdhPJwZi0JO2r/llNeqzivhIpD9IsJal/3MF/JZc6w9nk1hyTSkF0TQSw8TiIHYrrLwuM2p6u+kUw==
X-Received: by 2002:a05:600c:2158:: with SMTP id v24mr16522147wml.151.1614065375903;
        Mon, 22 Feb 2021 23:29:35 -0800 (PST)
Received: from saturn.anevia.com (ip-149-62-159-73.naitways.net. [149.62.159.73])
        by smtp.googlemail.com with ESMTPSA id y16sm30516790wrw.46.2021.02.22.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:29:35 -0800 (PST)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: core: use kstrdup_const/kfree_const for buffer attributes
Date:   Tue, 23 Feb 2021 09:29:26 +0200
Message-Id: <20210223072926.79590-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219085826.46622-2-alexandru.ardelean@analog.com>
References: <20210219085826.46622-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the buffer attributes were wrapped in iio_dev_attr types, I forgot to
duplicate the names, so that when iio_free_chan_devattr_list() gets called
on cleanup, these get free'd.
I stumbled over this while accidentally breaking a driver doing
iio_device_register(), and then the issue appeared.

Some ways to fix this are:
1. Just use kstrdup() during iio_buffer_wrap_attr()
2. Just use kfree_const() during iio_free_chan_devattr_list
3. Use both kstrdup_const() & kfree_const() (in the places mentioned above)

This implements the third option, as it allows some users/drivers to
specify some attributes allocated on the heap.

Fixes: a1a11142f66c ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 1 +
 drivers/iio/industrialio-core.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5d641f8adfbd..ac882e60c419 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1306,6 +1306,7 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 		return NULL;
 
 	iio_attr->buffer = buffer;
+	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
 	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
 
 	list_add(&iio_attr->l, &buffer->buffer_attr_list);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0d8c6e88d993..cb2735d2ae4b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1358,7 +1358,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
 	struct iio_dev_attr *p, *n;
 
 	list_for_each_entry_safe(p, n, attr_list, l) {
-		kfree(p->dev_attr.attr.name);
+		kfree_const(p->dev_attr.attr.name);
 		list_del(&p->l);
 		kfree(p);
 	}
-- 
2.25.1

