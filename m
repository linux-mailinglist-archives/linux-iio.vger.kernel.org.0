Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB05186F2F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgCPPvC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:51:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36557 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbgCPPvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:51:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so21918781wrg.3;
        Mon, 16 Mar 2020 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARobwbMkxpnKD/itXwOoAdtTkWOvbLodvJtLsq09FXI=;
        b=N2vAn/VqQjbs57AhGfDEn3ERSAFuemwBLrYdhCPOVaWBeZeAFyU5Z0ypB+H5SczB8z
         aecqNmCW8sZI2RVYRUFm75+2/D8opwFhh0gEfmy3BtHyAijTRtFgfovO1TtUDWhTC6he
         HZW0S15d8P+jSXz1H03Iubqd/+Anm8g2iQHo7lb9RF83dXRENzrJKBsZEVLqyQgP+kDA
         BrwHRMhEZF2Nh0rvt8K+b3KPJYJWzhsIyG0o9Ifww9PoKoZJ3GB2dPzy3hImVFNtp2rB
         qubiJHQW8fTcZJ9RYLVYloba0rXd3CrF/O88AAOFuDey2A6S3zCwKUW6DBP9W8eQRK3p
         41Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARobwbMkxpnKD/itXwOoAdtTkWOvbLodvJtLsq09FXI=;
        b=m7WDoZkPJuGwr1KUKiwH3R0hvLfF//hwaBEZCW83t62T9Q6tG2p6CZ9k/TFF/3/QBP
         Teq4Y3XngUpT4I+6+oD1UNYk0qU0Zoi05MFtDbtAXlBnIItXY5oWmScQZL9fsGmZ+yON
         GBL0dWrwIYCYaXmflxAO+Wx8gGUacwhq8BDeBKNkOUQjA9u9eQg82EEUZZ1hfzgUcc+/
         MK3VxGSJnEUQ1Z3feJQBSWkr8QnqbovemKVdq/DsEJvm1kGzSii8vXJruyCtwYIcAqpP
         xJ8RD+9UTixEs/uPsle/Jaco49cuocYueli34dJoJX1d/TkkmqB/wWLDAKDKWGQMS0XA
         t++A==
X-Gm-Message-State: ANhLgQ0TrmoUh4tS5Ucb3Z8rM/iPyaFPl0I7xl4OBBdOh6X5l4UqTPLP
        J7LpJt3ms5+GfrgNXEB5VY+aObUk
X-Google-Smtp-Source: ADFU+vsmPewO42KpiPcOa0lADe84yEUecpaV2WBwPc6111xNRqK7efvqJoGDIMXfkxx11CZOZtNJew==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr13691507wrc.307.1584373859159;
        Mon, 16 Mar 2020 08:50:59 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:50:56 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v10 4/8] iio: buffer-dmaengine: add dev-managed calls for buffer alloc
Date:   Mon, 16 Mar 2020 17:50:31 +0200
Message-Id: <20200316155035.25500-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316155035.25500-1-alexandru.ardelean@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
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

