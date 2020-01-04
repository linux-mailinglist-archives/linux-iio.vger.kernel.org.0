Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DB1303D6
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2020 19:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADST4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jan 2020 13:19:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35468 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADSTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jan 2020 13:19:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so36760692qka.2;
        Sat, 04 Jan 2020 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhyegyI0NkF5N69Gtsc0eHuClkM19ers8sxdq08wiaU=;
        b=fz41azXVTutL8yWhRDakZXb8RpRAJDgWRLwmxcKmG6sDMx2Apak2y2qaodHQsGzZDm
         3hUfJmiRYjEIl1LxssJrC7xtaEQSM0OLif9cKJ96ikyLcqVZnwmiwKbhbSW3eTTUJsTR
         1nr8Ft5L0S7yAtRh/9RAy8oq8j1l6xnQHcNZvjEvDgqFUXGCEAhj8xydVzYaIgNbM7Ax
         k4chErxTrWTMWUPYGStYBZKUmb7p5yPgeJR83lzBcNWAzBFRE8x3GQ/NOvwpZU/2pAih
         dUSSfJ6J5r69Sk8Bl0fTzhM5fVxKRGrFJoPATaHIaVGLIvW5bpkp/PpbI4FkFumOACRl
         63EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QhyegyI0NkF5N69Gtsc0eHuClkM19ers8sxdq08wiaU=;
        b=sn8N4AajTii08InUcoN7Dn8YvL6napTV58mUU9HlMK0BnbVRIojhCsjwce18Kmb4+o
         AMmmOmvs6tqdJH869DPUbVJPj3G8Uel36Sgi9kRmOyvhVAarwQIGST/SDXx0C1kPjmgm
         QFQVw64ORhZBhAjqXFdccdFBEptduSR3DxCgyLeo8+g020DsRuv0l81a0HuNchjp+l/O
         BwxXHe/42G3N45IlhOxg1zUe0jtPc3nFHG+Pg5HRIz7ti6LZOLPW+IOaSxwcxIYF3mWM
         zdvt74Aokqa3is+dUM2zEDSMKfV0y2iYcmMedzlKkAitKr9NnfGxRmkJBZZS5/YU19U0
         khuQ==
X-Gm-Message-State: APjAAAXBeldVaEkFaXCLhjUYjvYf4jnHHNNDXKeFJ1KWXUIxR51prNwR
        88KvLj+a3kcyGF9ZUZx3flU=
X-Google-Smtp-Source: APXvYqyvI5wVYVPCrglAM9bZR3yiDfm7t7jGPRCU40rm8PVA6VtVUQTkTtmN1tJpY1F/G6QKVmViPA==
X-Received: by 2002:a05:620a:a5c:: with SMTP id j28mr66434037qka.218.1578161994824;
        Sat, 04 Jan 2020 10:19:54 -0800 (PST)
Received: from localhost.localdomain ([194.59.251.176])
        by smtp.gmail.com with ESMTPSA id m68sm17910801qke.17.2020.01.04.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 10:19:54 -0800 (PST)
From:   Kent Gustavsson <kent@minoris.se>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kent Gustavsson <kent@minoris.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: dht11 remove TODO since it doesn't make sense
Date:   Sat,  4 Jan 2020 19:19:29 +0100
Message-Id: <20200104181929.1505510-1-kent@minoris.se>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DHT11 isn't addressable and will trigger temperature measurement on any
data sent on the bus.

Signed-off-by: Kent Gustavsson <kent@minoris.se>
---
 drivers/iio/humidity/dht11.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index b459600e1a33..d05c6fdb758b 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -174,7 +174,6 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 	struct iio_dev *iio = data;
 	struct dht11 *dht11 = iio_priv(iio);
 
-	/* TODO: Consider making the handler safe for IRQ sharing */
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
 		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
 		dht11->edges[dht11->num_edges++].value =
-- 
2.23.0

