Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BE21BA97
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGJQP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgGJQPZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jul 2020 12:15:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D2C08C5CE
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so6553401wrn.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6VeY2q2ARwtwhxTnriPNqujWGB2wBtqSPVx5GyBvhlc=;
        b=HPME4aFfN5DAGO/hNKu8shxMBOKpjiUHJbJOGhTo99xKJ62hrdqOCo/1gYMqtetwLI
         joIHG5DbBNPLurDw77w69rKt2TzzTHMFPef7Ae9YSPcdFckr7QDEwgkiZSeS4B4mZiG4
         Aye0brfxunFa1P3lI0bGf7BUjcvDs5NNH95uxOXPNNQ5uWE6yXFQW35oy5RmGrkaXj3W
         XT6uOuXIJnTF8VBQGfzVTwbqDOAC6IeVDifSeblH7eo4eSXXeg9RYJ36eMPX14bSLbpY
         28NWQ+9Wf7ij9n9AdZsXnM7MJLn6IUHpsq1r7gEoEGKjKZwAfhB5p5uKOWdGmEep1g3A
         epRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VeY2q2ARwtwhxTnriPNqujWGB2wBtqSPVx5GyBvhlc=;
        b=bE87MBM66xnh8hsvtJQzaAV6RClWv0/HDDYjL5GfNL0F++R9ngrCPLKpOUhyGqMt7G
         4jubb841OXFNe/YIb7XlZueP2a6uYqGN8xozXR0gFspZ5KMPevvfy3QE2shRG3Xnv+LM
         hmmKvgPkj3iGVOR/2U8MFMEWujD2guKbHkv9oyRIt71YkiYWFKUQ72Bc5SfNDm9TVWwH
         REV6xPukkCk+97EDnDE/kbDnTN/v6AfhQVqECsCb2ilkTH6daxhkdVgfMsW0e/i4+S0m
         YBcku92hFwpfkv3Frx0jnydxglH0gzPYZ+sTOnKVhHGMR/uM30ji9ZhX1wkobIgMtzbB
         4O1Q==
X-Gm-Message-State: AOAM530YDRLMTdmffVnwD4/ql3YKRv6pAYAGsFJ0z/GJdTIHlXHMLAk3
        DoW5IZosFGqOFQzjlct3cKUbB0L1R7w=
X-Google-Smtp-Source: ABdhPJwOtOzdkUiP2GCCTb1YJ3mjOhhSDr/YjLUB5Z33mCbFNZoBuRBbEqo72XYreuJPsOb9S088+A==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr38646926wrt.24.1594397723839;
        Fri, 10 Jul 2020 09:15:23 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id e8sm11179359wrp.26.2020.07.10.09.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:15:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/3] devres: provide devm_krealloc()
Date:   Fri, 10 Jul 2020 18:15:14 +0200
Message-Id: <20200710161516.11625-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200710161516.11625-1-brgl@bgdev.pl>
References: <20200710161516.11625-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement the managed variant of krealloc(). This function works with
all memory allocated by devm_kmalloc() (or devres functions using it
implicitly like devm_kmemdup(), devm_kstrdup() etc.).

Managed realloc'ed chunks can be manually released with devm_kfree().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 50 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 53 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index eaaaafc21134..aa08f5162524 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -353,6 +353,7 @@ MEM
   devm_kfree()
   devm_kmalloc()
   devm_kmalloc_array()
+  devm_krealloc()
   devm_kmemdup()
   devm_kstrdup()
   devm_kvasprintf()
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ed615d3b9cf1..4b8870ef6a3f 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -837,6 +837,56 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kmalloc);
 
+void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
+{
+	struct devres *old_dr, *new_dr;
+	struct list_head old_head;
+	unsigned long flags;
+	void *ret = NULL;
+	size_t tot_size;
+
+	if (unlikely(!new_size)) {
+		devm_kfree(dev, ptr);
+		return ZERO_SIZE_PTR;
+	}
+
+	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
+		return devm_kmalloc(dev, new_size, gfp);
+
+	if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
+		/*
+		 * We cannot reliably realloc a const string returned by
+		 * devm_kstrdup_const().
+		 */
+		return NULL;
+
+	if (!check_dr_size(new_size, &tot_size))
+		return NULL;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (WARN_ON(!old_dr))
+		/* Memory chunk not managed or managed by a different device. */
+		goto out;
+
+	old_head = old_dr->node.entry;
+
+	new_dr = krealloc(old_dr, tot_size, gfp);
+	if (!new_dr)
+		goto out;
+
+	if (new_dr != old_dr)
+		list_replace(&old_head, &new_dr->node.entry);
+
+	ret = new_dr->data;
+
+out:
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_krealloc);
+
 /**
  * devm_kstrdup - Allocate resource managed space and
  *                copy an existing string into that.
diff --git a/include/linux/device.h b/include/linux/device.h
index 7322c51e9c0c..f64f40843159 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -206,6 +206,8 @@ int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
 void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+void *devm_krealloc(struct device *dev, void *ptr, size_t size,
+		    gfp_t gfp) __must_check;
 __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
 				     const char *fmt, va_list ap) __malloc;
 __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
-- 
2.26.1

