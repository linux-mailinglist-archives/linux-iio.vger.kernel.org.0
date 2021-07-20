Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB63CF578
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 09:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhGTHGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhGTHGV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 03:06:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F3CC061766
        for <linux-iio@vger.kernel.org>; Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ca14so27366562edb.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Jul 2021 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ph3XEUc88z5VPxCMsIt7VVIKG5XsfAQWJvNfdBNntnk=;
        b=GSTaoJFveI3Rb2+0ZQ6fgPBXGkscL7rtZZa1WmNAqD+6P5PH9OjPSC0QbIbCAkNEzH
         m0puof917wFKNqXecyS9zF2FU9Q+Fv9bjeofbyHT/eZr5V6G8D3aVHjf2PClX+GfUZK9
         CFUvlC+83kgYr0r6gF8CnN/1b4JVai6Tptsbv75ixN1E7T5D5m361gUyIqh4d+AnV1IL
         iLG8f278PRItWIgHBukh8qohwa6kbGjfweHRikQx275U71VYJdgLFgIMm0xiJhYCeAjD
         aOJpfhkK04sM8aOOcZ8TPYc2a1F5Jkvi43MLvFa0cRvdTJh3dwBM5zPI9MXKJDIdbKsp
         Z3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ph3XEUc88z5VPxCMsIt7VVIKG5XsfAQWJvNfdBNntnk=;
        b=UC1sUfSUWaBjUNpItJBiet1nxreO/kRefwkPLL+/QgepUw7z1V+ua5SCt7GlXb2qPS
         2NiO/Ipi42S9EMn9/MJ+Qg/d2SpFsfCMyimoOU683TMDPcufqTs/oL/cbI17nW4t+Bix
         L3Wd40VvkE3PVMXpiTecUOM2KiMYsTllcj+TSZSjp4vSw2mjSUny5wxZQ7P6cTiavHKS
         Ty+afP7UdHJgvUBj71FiArXWauZvcwkk7Zz1Apxr/BVlJum7YmEwBgZmgnSuH0cuwwwM
         3M800jHP3P3lvWcNSE4A52r0AtunRWfFvIzkqkXTwzBnSmn7dMqnU7m0I+HqOJbO1c9x
         qhww==
X-Gm-Message-State: AOAM530fV1V+a/n2/HvEhN7MzKbQpHJX1Ks2ulk62XTxYrCu57/8uSJq
        dNM0GzP/X6J54KGA9C2mDqQCBjmn0xDex7m+ww0=
X-Google-Smtp-Source: ABdhPJxtIED7exLgQ17KR5hySSV24mU/wgy6LrPsIp4OwZFNH7GrOqKdIH1WH8RrAahE6BUkTlZDhA==
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr38582633edv.315.1626767218392;
        Tue, 20 Jul 2021 00:46:58 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id b22sm7530940edj.24.2021.07.20.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:46:58 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/4] iio: accel: st_accel: use devm_iio_triggered_buffer_setup() for buffer
Date:   Tue, 20 Jul 2021 10:46:40 +0300
Message-Id: <20210720074642.223293-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720074642.223293-1-aardelean@deviqon.com>
References: <20210720074642.223293-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The st_accel_allocate_ring() function calls iio_triggered_buffer_setup() to
allocate a triggered buffer.

But the same can be done with devm_iio_triggered_buffer_setup() and then
the st_accel_common_remove() no longer needs to manually deallocate it.

We know that the parent of the IIO device is used to manage other instances
of the devm unwind, so it can be used in the st_accel_allocate_ring() as
well.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel.h        | 4 ----
 drivers/iio/accel/st_accel_buffer.c | 9 ++-------
 drivers/iio/accel/st_accel_core.c   | 6 +-----
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index f5b0b8bbaff7..8750dea56fcb 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -64,7 +64,6 @@ enum st_accel_type {
 
 #ifdef CONFIG_IIO_BUFFER
 int st_accel_allocate_ring(struct iio_dev *indio_dev);
-void st_accel_deallocate_ring(struct iio_dev *indio_dev);
 int st_accel_trig_set_state(struct iio_trigger *trig, bool state);
 #define ST_ACCEL_TRIGGER_SET_STATE (&st_accel_trig_set_state)
 #else /* CONFIG_IIO_BUFFER */
@@ -72,9 +71,6 @@ static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
 #define ST_ACCEL_TRIGGER_SET_STATE NULL
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index f89770f251d9..fc82fa83f1fb 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -62,13 +62,8 @@ static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
 
 int st_accel_allocate_ring(struct iio_dev *indio_dev)
 {
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
-}
-
-void st_accel_deallocate_ring(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+		NULL, &st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
 }
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 365e4e64ca18..f1e6ec380667 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1377,7 +1377,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		err = st_sensors_allocate_trigger(indio_dev,
 						 ST_ACCEL_TRIGGER_OPS);
 		if (err < 0)
-			goto st_accel_probe_trigger_error;
+			return err;
 	}
 
 	err = iio_device_register(indio_dev);
@@ -1392,8 +1392,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 st_accel_device_register_error:
 	if (adata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-st_accel_probe_trigger_error:
-	st_accel_deallocate_ring(indio_dev);
 	return err;
 }
 EXPORT_SYMBOL(st_accel_common_probe);
@@ -1405,8 +1403,6 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 	iio_device_unregister(indio_dev);
 	if (adata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-
-	st_accel_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
-- 
2.31.1

