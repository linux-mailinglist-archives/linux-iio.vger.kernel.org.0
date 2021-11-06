Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAF446F65
	for <lists+linux-iio@lfdr.de>; Sat,  6 Nov 2021 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhKFRmH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Nov 2021 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhKFRmG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Nov 2021 13:42:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEBCC061570;
        Sat,  6 Nov 2021 10:39:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v20so13038291plo.7;
        Sat, 06 Nov 2021 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYDP9ugQuQJcTY/clh1zo2X/w4ZLz6U2xXdQY6a8yeY=;
        b=WKZJXVC46t7n70FfDfrwYHxfFmfDQovZOnbtGq9K5qD00SdE6CUFlUGumzKSpv7QUc
         gi8TW8I9g58uxClrX5YrrmgXjWBQDN/I5753MgbhhxV1jNfOhms72SYJNlRHqoEAddo2
         l+lgVVweYgasIqDXIXputHmOp6tAhR0A8yx4x52gr7/xb7+9YKlZmHHR2t9qC4BjTojl
         Erwfu0ZipjIvSQVF/T+7N7EuizNiJRoF4jyUT7TughcVv4tNsnDRVh546r4MtMTxNQ5g
         q1BMzKenv0ugljKf2WDszpuEIMbwNEmhdaYFp0PQuT/U3FQrunMT2PLRBXGaCDVIOzh0
         RvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYDP9ugQuQJcTY/clh1zo2X/w4ZLz6U2xXdQY6a8yeY=;
        b=yPj4PdGXtiP17fA2U9ZDQZoNnrzs8Y0X06L/B/+GUHIhv/qUCMY8R8ZCyR0UgEuArw
         jSCEZclkhr2dq9IKq1vnmTCC610Rng02zMwiTQ5Xh3QVUmW6bmJD/YKxEh/NZnwicYZe
         rUzs/SvHiXOC7pZCRs6z0U9UDcgrq/6vC5dqwIFhIEPXSHaE0xxYnkvnUiAwpYqVdPKr
         9wHVXKf2Tj+dv5N/CAPN4Wp03ffb9f3JdHt6xaeCPgqswQsIzu2caFzS3ld6TQ/flxnV
         E/1QdbyCjn47Eu56GJTM8ZzzGRQjjN04KJd4GkYHLYITWN1+YI6t1h1ac80+972OxoOW
         1gLQ==
X-Gm-Message-State: AOAM530aa3oCNiS5utNLU6E2OU/RtFlimPOHjy9nHaWPqyisbGg/m/na
        Fz4kBvYHM3g4p8QZ7flXSQE=
X-Google-Smtp-Source: ABdhPJzbobi7gjTq+5GlTtLWyDHB+itR4KszZmrXrlCZiJkCJs8+bpi+BIebCvRqASITy8yCU/xFkA==
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr39174748pjd.81.1636220364855;
        Sat, 06 Nov 2021 10:39:24 -0700 (PDT)
Received: from localhost.localdomain ([49.156.65.8])
        by smtp.googlemail.com with ESMTPSA id o185sm4859724pfg.113.2021.11.06.10.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:39:24 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 1/1] device property: Add fwnode_irq_get_by_name
Date:   Sat,  6 Nov 2021 23:09:09 +0530
Message-Id: <20211106173909.34255-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211106173909.34255-1-puranjay12@gmail.com>
References: <20211106173909.34255-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The fwnode framework did not have means to obtain the IRQ number from
the name of a node.
Add that now, in form of the fwnode_irq_get_by_name() function.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/base/property.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b..627e4e6d3ebd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -958,6 +958,30 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_irq_get_by_name - Get IRQ directly from its name.
+ * @fwnode:    Pointer to the firmware node
+ * @name:      IRQ Name
+ *
+ * Returns Linux IRQ number on success. Other values are determined
+ * accordingly to acpi_/of_ irq_get() operation.
+ */
+int fwnode_irq_get_by_name(const struct fwnode_handle *fwnode, const char *name)
+{
+	int index;
+
+	if (unlikely(!name))
+		return -EINVAL;
+
+	index = of_property_match_string(to_of_node(fwnode), "interrupt-names",
+					 name);
+	if (index < 0)
+		return index;
+
+	return fwnode_irq_get(fwnode, index);
+}
+EXPORT_SYMBOL(fwnode_irq_get_by_name);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
-- 
2.30.1

