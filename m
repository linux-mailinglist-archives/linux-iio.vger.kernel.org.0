Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441837A09B
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhEKHTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhEKHTr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C70C06175F
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m12so28262416eja.2
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNwmkBzZYIFL26toATaXnA6vBIR2hsJAqgIvqXkXahc=;
        b=rL1t/OA5iFqAAVFaUgqU8/qOC1fXTXetUit2+dCzeQIA5XA1NVIekfZtrEYG/hoyJd
         mDea5W2GAF8iR2yctLrIoozosqwvfeV4pqjdFRlEF6anphOoMy3znY6g1Y2Vb/h3SpTH
         S2eXKdHY6SppmdmnNhJJ8tMSj3iDpG2jmgeKNkRLk9D36jOLecnhBqTuCzEgrypiQt8s
         fhzw/DIltX4L00ECrQaCXqan9+ZUrlzk32S3a8Aj/Z5YgAB7njCOOsLZ0Y9E0aKeE7/p
         KXgbLoD6Y9qVafKE3eIGfz9N44NTZxjwFeFncpbY03VXZsskh/ZMXxk9huy4bd3XBYRz
         TKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNwmkBzZYIFL26toATaXnA6vBIR2hsJAqgIvqXkXahc=;
        b=NVnNe9j7ptyKEimCAvH5M+KedUj+lOacsnZIcsnTBWvht+XcXXB+6uxZHSZQXiLC3h
         w4MgRh5fUFBXw5aG2vu9Vhrxf3w8SF7TI0ylYQ7bkEhNYa1SlWFdiGBbeyvfE8+1pVA9
         RApMwk2RzIp9dEwkNf7HRIe4BkHln5Yed6SDDkOea6ec9WTaCQNnpjTGkf1nMEf0iCXS
         g3Oj8lUQgXOAaX9WinYIBLwk32yd7eN6z2i4xcTSfTirYNKDIuSvkZknpHteNEm+wtR9
         1fSSp1RIzNE6rPSLHlWElsS0l6QGfDb+Mm1NhPFJEtmuvlukoyfiIRN+2/f5UOUHvk2Q
         818A==
X-Gm-Message-State: AOAM531BjRn5R5Ojg8Gfpp6QUDNyxWchBYqADjqsyPkFYkfceDqybnFq
        WUoh9V50ys7KpMzbFlzhV8Gr4gpqCrGCt7rZ
X-Google-Smtp-Source: ABdhPJxHbrZV8hZ/8iaLTB7WZ3Q7l6Ac+0VRGx//5bIi9r1LNA4GC0lH6yqE065mFKC7gi3wuNnG3Q==
X-Received: by 2002:a17:907:2117:: with SMTP id qn23mr30099405ejb.48.1620717519437;
        Tue, 11 May 2021 00:18:39 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:39 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 04/12] iio: adc: ad7192: handle zero Avdd regulator value as error
Date:   Tue, 11 May 2021 10:18:23 +0300
Message-Id: <20210511071831.576145-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change fixes a corner-case, where the returned voltage is actually
zero. This is also what patch ab0afa65bbc7 ("staging: iio: adc: ad7192:
fail probe on get_voltage") was trying to do.

But as Jonathan pointed out, a zero-value would signal that the probe has
succeeded, putting the driver is a semi-initialized state.

Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d3be67aa0522..79df54e0dc96 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -950,6 +950,11 @@ static int ad7192_probe(struct spi_device *spi)
 	}
 
 	voltage_uv = regulator_get_voltage(st->avdd);
+	if (voltage_uv == 0) {
+		ret = -EINVAL;
+		dev_err(&spi->dev, "Zero value provided for AVdd supply\n");
+		goto error_disable_avdd;
+	}
 
 	if (voltage_uv > 0) {
 		st->int_vref_mv = voltage_uv / 1000;
-- 
2.31.1

