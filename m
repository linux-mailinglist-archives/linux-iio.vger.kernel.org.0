Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D41182B47
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLIf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:35:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39726 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLIf0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 04:35:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so5224960wml.4;
        Thu, 12 Mar 2020 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARobwbMkxpnKD/itXwOoAdtTkWOvbLodvJtLsq09FXI=;
        b=k2uP5wv/2Qe0LrhneaGqd1IgaQussNqx3+/4zBLBQ0RE6M5vy0D6ewDX81Idg+560S
         AwU/B8sGusiIyniNrft/RE+50CjmKpD1P2d3FQuTS4+IC7x7FY/fEPZg5uKWAjcNb7cZ
         47Srx5wC/n/lz2q3cp9ImhRaxJcUv0zPcobmyDCjTHN5bdCHixzvfMOmMgl2zpd9kgjv
         PgRGap3UaIDNx5UHcLJmNwW+zGQ2J+2rWJBUmOVmrwK9nEpJU5gxsQDBIoOVZ6oqCbIw
         ABbQ6Pe411cB8DBuUVB1hBSD7z4desm88GYhEcdibIA0dfUW4ABdBcnhzecisdedlTFp
         StVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARobwbMkxpnKD/itXwOoAdtTkWOvbLodvJtLsq09FXI=;
        b=Q7O2Wki3ubWN/DqTbC6BkmI3hFw2u2vGCT3LEzRyGeZIezGcj3KjRlP01Ouqn297Fe
         KzxjpU/Tv2CptRHkLu2F4J1sLqoDc1C3BNwI1O78grIRPDJI41VEt0svfrnbwmaEW8/E
         wOpRm7D+ocdrLnkezs+6KCeaqEb9FS7ht1XmHNa8nRNjta5o6TL/gMBR0hRmDwWCqYf5
         h5jQwKdGdlY9W1UP1ujuFE5aJU/ytdQtYS7v9YsMu7aOh2mFBT8gGX+iFfvJ0Gz29J8j
         Sl5gOHGK9IPFenPn/QumjKbQV0egnB+hINtC8rF7qd2bYADZLXEaJUjcoOwQWLeGnHbE
         ZYig==
X-Gm-Message-State: ANhLgQ12E1k83GbeNkfK1oRq2uYT5CZNabmVBAZayUJZ1AJeOonnbnCx
        apLgmoqRWO40fH0QpUON5p9LtY9T0vs=
X-Google-Smtp-Source: ADFU+vtVP246Omyt5nTVFgY1mCw+1MGuf7W1xpHpwQA1ZuzJUZSnwCgjxSaD6kHPtmUCISFdXY77bQ==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr3531936wmf.35.1584002124308;
        Thu, 12 Mar 2020 01:35:24 -0700 (PDT)
Received: from localhost.localdomain ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id 9sm11543334wmo.38.2020.03.12.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:35:23 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v9 4/8] iio: buffer-dmaengine: add dev-managed calls for buffer alloc
Date:   Thu, 12 Mar 2020 10:35:07 +0200
Message-Id: <20200312083511.28832-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312083511.28832-1-alexandru.ardelean@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, when using a 'iio_dmaengine_buffer_alloc()', an matching call to
'iio_dmaengine_buffer_free()' must be made.

With this change, this can be avoided by using
'devm_iio_dmaengine_buffer_alloc()'. The buffer will get free'd via the
device's devres handling.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../buffer/industrialio-buffer-dmaengine.c    | 39 +++++++++++++++++++
 include/linux/iio/buffer-dmaengine.h          |  3 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 94da3b1ca3a2..6dedf12b69a4 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -229,6 +229,45 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
 
+static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
+{
+	iio_dmaengine_buffer_free(*(struct iio_buffer **)res);
+}
+
+/**
+ * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_buffer_alloc()
+ * @dev: Parent device for the buffer
+ * @channel: DMA channel name, typically "rx".
+ *
+ * This allocates a new IIO buffer which internally uses the DMAengine framework
+ * to perform its transfers. The parent device will be used to request the DMA
+ * channel.
+ *
+ * The buffer will be automatically de-allocated once the device gets destroyed.
+ */
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+	const char *channel)
+{
+	struct iio_buffer **bufferp, *buffer;
+
+	bufferp = devres_alloc(__devm_iio_dmaengine_buffer_free,
+			       sizeof(*bufferp), GFP_KERNEL);
+	if (!bufferp)
+		return ERR_PTR(-ENOMEM);
+
+	buffer = iio_dmaengine_buffer_alloc(dev, channel);
+	if (IS_ERR(buffer)) {
+		devres_free(bufferp);
+		return buffer;
+	}
+
+	*bufferp = buffer;
+	devres_add(dev, bufferp);
+
+	return buffer;
+}
+EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
+
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index b3a57444a886..0e503db71289 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -14,4 +14,7 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel);
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+						   const char *channel);
+
 #endif
-- 
2.20.1

