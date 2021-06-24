Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CB3B2C0A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhFXKDW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 06:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231968AbhFXKDW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 06:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624528862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rzIFYAbX1OQ4bIQdeDioVYM8BAONDbVt0DgaCifv+NU=;
        b=KT6xxXZ1+TfEgooyWFzw8ArC20TnETTB5ycJq32AfQudJ1bGDh3MwCU4Kex7QqMtDfdTr2
        NVo6iiKYKSOgZb57L7WaEOeICA/uFC0obeSW87QrzYPdmuJUFezke/ftjC7V3POLPkOzhl
        io2/BVuMskaX9LS0nrHZMVNWcgfjU7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-W3dbYDRYPcCIqbxYQAqZ-A-1; Thu, 24 Jun 2021 06:01:01 -0400
X-MC-Unique: W3dbYDRYPcCIqbxYQAqZ-A-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso1439559wmj.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 03:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzIFYAbX1OQ4bIQdeDioVYM8BAONDbVt0DgaCifv+NU=;
        b=nyTsGt8j42cVvLaR29QgkaCWGHOKqZU0qCdmUFEbGrKoWtaURjijCsmuUgYVVW/Lqb
         1rhldIl/roTmnrXK2e/oyqK09cU94WZzKdsxibBA43ABtJwbFfYWfBV8VZQlBobJfcAg
         X0hdC5lILxSaypd7gBfGTZr62LDEJxnn1IUXLogWwymNvEr98artUVUIeQKYwwySieCe
         TngYwR5D8tNrINrfLiU/UnkSQx2szcFbGt9fDo2vWyxCAgFJc0C+wHW4l+lknlfeo06k
         WAAIHuOIrppn0yhqAk6P5MqTLDLP4NdxoH+th1pnwz6oow5TGyjnQmY9dIbPgiiwseBT
         n8rw==
X-Gm-Message-State: AOAM5325JJnRHBZqLleW8Ja2o4e1qpkJyjdU5nyfXUB+C99Vvjtoh+qT
        q7VdG7xJxp07DgERx4Qjy1MmDwNaa8HW/sJsTdzuL1y2X7Hqvav7i86IXZiIMPPP5ZjDQDboJGG
        vBTBzcitumEQuC4OpV7Qd
X-Received: by 2002:adf:ba07:: with SMTP id o7mr3439749wrg.160.1624528860264;
        Thu, 24 Jun 2021 03:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeimKsE0r9piJOMQLtnTnDHj81fVS/33+xCr49yJiQvgodxDeD/ZNvC3kb5P9+JgwFazpHYw==
X-Received: by 2002:adf:ba07:: with SMTP id o7mr3439734wrg.160.1624528860096;
        Thu, 24 Jun 2021 03:01:00 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id u15sm7986819wmq.48.2021.06.24.03.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:00:59 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, nsaenzju@redhat.com,
        matt.ranostay@konsulko.com, andy.shevchenko@gmail.com
Subject: [PATCH] iio: chemical: atlas-sensor: Avoid using irq_work
Date:   Thu, 24 Jun 2021 12:00:46 +0200
Message-Id: <20210624100046.1037159-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The atlas sensor driver currently registers a threaded IRQ handler whose
sole responsibility is to trigger an irq_work which will in turn run
iio_trigger_poll() in IRQ context.

This seems overkill given the fact that there already was a opportunity
to run iio_trigger_poll() in IRQ context in the top half of the IRQ
handler. So make use of it, ultimately avoiding a context switch, an
IPI, and reducing latency.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

NOTE: This was only compile tested. I don't know much about iio_triggers
(or iio for that matter), but while reviewing irq_work usage this showed
up and seemed trivial enough to fix right away. There might be a subtle
reason why this is setup as such, but it would at least warrant a
comment.

 drivers/iio/chemical/atlas-sensor.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 9cb99585b6ff..710daa169d57 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/irq.h>
-#include <linux/irq_work.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
@@ -89,7 +88,6 @@ struct atlas_data {
 	struct iio_trigger *trig;
 	struct atlas_device *chip;
 	struct regmap *regmap;
-	struct irq_work work;
 	unsigned int interrupt_enabled;
 	/* 96-bit data + 32-bit pad + 64-bit timestamp */
 	__be32 buffer[6] __aligned(8);
@@ -442,13 +440,6 @@ static const struct iio_buffer_setup_ops atlas_buffer_setup_ops = {
 	.predisable = atlas_buffer_predisable,
 };
 
-static void atlas_work_handler(struct irq_work *work)
-{
-	struct atlas_data *data = container_of(work, struct atlas_data, work);
-
-	iio_trigger_poll(data->trig);
-}
-
 static irqreturn_t atlas_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -474,7 +465,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct atlas_data *data = iio_priv(indio_dev);
 
-	irq_work_queue(&data->work);
+	iio_trigger_poll(data->trig);
 
 	return IRQ_HANDLED;
 }
@@ -677,12 +668,10 @@ static int atlas_probe(struct i2c_client *client,
 		goto unregister_trigger;
 	}
 
-	init_irq_work(&data->work, atlas_work_handler);
-
 	if (client->irq > 0) {
 		/* interrupt pin toggles on new conversion */
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
-				NULL, atlas_interrupt_handler,
+				atlas_interrupt_handler, NULL,
 				IRQF_TRIGGER_RISING |
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"atlas_irq",
-- 
2.31.1

