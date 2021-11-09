Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F157544B3C3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 21:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbhKIUME (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 15:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbhKIUME (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 15:12:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C423C061764;
        Tue,  9 Nov 2021 12:09:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p18so528195plf.13;
        Tue, 09 Nov 2021 12:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsGpWx2S/87DVdjoCuYbitNOZpUNewFNueNRMEfcO1g=;
        b=jLv9ggw+MucFmn8PHQE766gVFlv/br7ZayIMW8qBYBsHR8mnPC78dodPelFuGaPShA
         RJ/2kFIHtHHrgr2PPTPrtB0xDqaWuaAFrejURfRW7hW9wEnI09ZxHjF4dI7XQL4fnstd
         hJ+B/vqonqQHxu/dGIuddi5YRIoBMlLe5EadVhW0y9G3h2AMor3q64Zl9hdAFZi+DdzS
         m6cV15y6JHBEu64mhYZFHT26y98M7UGVt/w2Fg3d2c81Fe8E+WK1WCQ86ZXqyV0V5OQS
         FWgScIAEChA7vTRW8xyKrxGqwbgkQ6pVI+Lh7wJ8N4zaOLhyL3y6KBDtnCAIQYZSRkNA
         4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsGpWx2S/87DVdjoCuYbitNOZpUNewFNueNRMEfcO1g=;
        b=FB4zHfcaE7iu++KrIX8LfJDPu4wbsi1n4pNL2P9O4F/qMwxlxnbYD2qTrMaMZ41Jdq
         yGvx1H8t81FrvS31ySpo+/wfoXk96qKclR3fg+nMc0d04juEQD+Az0wJsZensTRUB6cm
         oQPBPNbRQ3WrSni8mtIAqrR9PTMeKN/JWMungSw5NvuMrpYR6QVxtjluXepG9DETa5NC
         eqR2s1d3yHtncTc+NBsb/ukV5ZkJVc0CnOgFC3gG0MfyQHoCG15ree8bI0d/FtXzjMYL
         FN5yJXjCxOk6VkimkiPi6fzxi9gs16UCzz95aYeftKhH+H+PnCHdjwhus3/yL+ozl6Tg
         A9DA==
X-Gm-Message-State: AOAM532ua0mbFGzB4c7Q3You87XbGKvWW8DK2TKJcejhYVF87YqViHtt
        oyhQUJSUqrAKtBSjJPuyQbs=
X-Google-Smtp-Source: ABdhPJwWavTOcdMBbMKadrTWZEdxmxo7onhGZXQ1LvqS4LrsAx29Msa/6j7wu+9ZNDuI4oE5tPUA7A==
X-Received: by 2002:a17:90b:1b4d:: with SMTP id nv13mr10509336pjb.234.1636488557514;
        Tue, 09 Nov 2021 12:09:17 -0800 (PST)
Received: from localhost.localdomain ([27.255.248.134])
        by smtp.googlemail.com with ESMTPSA id q10sm3103095pjd.0.2021.11.09.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:09:17 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        kuba@kernel.org, saravanak@google.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 1/2] device property: Add fwnode_irq_get_byname()
Date:   Wed, 10 Nov 2021 01:38:39 +0530
Message-Id: <20211109200840.135019-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211109200840.135019-1-puranjay12@gmail.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The fwnode framework did not have means to obtain the IRQ number from
the name of a node.
Add that now, in form of the fwnode_irq_get_byname() function.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/base/property.c  | 23 +++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b..0d685c79b0e8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -958,6 +958,29 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_irq_get_byname - Get IRQ directly from its name.
+ * @fwnode:    Pointer to the firmware node
+ * @name:      IRQ Name
+ *
+ * Returns Linux IRQ number on success. Other values are determined
+ * accordingly to acpi_/of_ irq_get() operation.
+ */
+int fwnode_irq_get_byname(struct fwnode_handle *fwnode, const char *name)
+{
+	int index;
+
+	if (unlikely(!name))
+		return -EINVAL;
+
+	index = fwnode_property_match_string(fwnode, "interrupt-names", name);
+	if (index < 0)
+		return index;
+
+	return fwnode_irq_get(fwnode, index);
+}
+EXPORT_SYMBOL(fwnode_irq_get_byname);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 88fa726a76df..9c6177597ba8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -122,6 +122,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 
+int fwnode_irq_get_byname(struct fwnode_handle *fwnode, const char *name);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.30.1

