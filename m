Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD04BB87D7
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbfISWzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 18:55:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34745 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389376AbfISWy7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 18:54:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so3254364pfa.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WCHZ4EgHCAL5zELexfGXhWfZVpmNBw7TCzi7XYFEAZA=;
        b=WHSdhHkh432Tv8ZweP3g3GeTNy6neyxPJzPbZsL/D4/D8M46u3uk5lnneAHwzBMuB3
         6mK5k5Iucn9M0TPvJXl++HMP0If2WCJb4Jel9A6USstXuQPsgIvez9e8idpcX2KvxN3Z
         BXpjLS21vIeCd7GEEaPkMGhRlo0VxMvFj6m7DFfLm/CEgaXKinotgJ5E+0koS3oGIKXM
         eCrn2qX/0xi+HO926oGxR4G0ee/2AQPvF86+Lv5DUQBPp8PN0IDFGTCOv/0s9kw6Mk9y
         OcMXFaZe3KviuLYWrdoLdeiReeZOI6D6fzujN7vyebyphwbiJ+uxuvcxWc7alMUVpyxl
         K0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WCHZ4EgHCAL5zELexfGXhWfZVpmNBw7TCzi7XYFEAZA=;
        b=nBEZZbhtIDE0VQxSoa5veM53hVXURtxiL2JVZXWBXLWFhmTKwXSQlmboBCKyw6vxk1
         0yyNWL51ljK01uRLgu6lE3J5/DoZWfjCiWg+7HAStTmp5+axZRuK5i5HL1lohpJRqvYP
         LFKIuayhXA+9jrRsAaEVU5clytYds78YnVi1gotLf1NCQOiKtxEtwWAZqJoFXUZO8OiR
         BB93JAE5wjOTjMEerrdERtWzoY5I+bsL17mMK8rY2QKBd8SQ1aQSEjUIc5X4cQcSZuAB
         +NsJV4irx/G13UXcLRKW2GtZcC9yD4YuevytZrWDFwGiSBE4i9dgg6y14VOVwNeO1W1B
         kIFQ==
X-Gm-Message-State: APjAAAUyHEi2+plgMDnX8ekf/Cc1Jts2tScRDJZys0OcgOGLr1F/cIy1
        SRlvsmiVq0LNfoC8YlUfmNeBllfsEuSiRQ==
X-Google-Smtp-Source: APXvYqyeryc3StR/45KbfVTUKHvmMJ4jsgVhNiLRqGDAaY368cNCBd4bsdPOtczYUqNv+TfR9dlwog==
X-Received: by 2002:a17:90a:630b:: with SMTP id e11mr352743pjj.132.1568933698407;
        Thu, 19 Sep 2019 15:54:58 -0700 (PDT)
Received: from dfrey-arch-linux.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id m5sm3039566pgi.19.2019.09.19.15.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 15:54:57 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     dannenberg@ti.com, David Frey <dpfrey@gmail.com>
Subject: [PATCH] iio: light: opt3001: fix mutex unlock race
Date:   Thu, 19 Sep 2019 15:54:18 -0700
Message-Id: <20190919225418.20512-1-dpfrey@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When an end-of-conversion interrupt is received after performing a
single-shot reading of the light sensor, the driver was waking up the
result ready queue before checking opt->ok_to_ignore_lock to determine
if it should unlock the mutex. The problem occurred in the case where
the other thread woke up and changed the value of opt->ok_to_ignore_lock
to false prior to the interrupt thread performing its read of the
variable. In this case, the mutex would be unlocked twice.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/light/opt3001.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index e666879007d2..92004a2563ea 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -686,6 +686,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	bool wake_result_ready_queue = false;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -720,13 +721,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 		}
 		opt->result = ret;
 		opt->result_ready = true;
-		wake_up(&opt->result_ready_queue);
+		wake_result_ready_queue = true;
 	}
 
 out:
 	if (!opt->ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
+	if (wake_result_ready_queue)
+		wake_up(&opt->result_ready_queue);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.23.0

