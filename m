Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C913CF57B
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhGTHGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 03:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhGTHGY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 03:06:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292FC0613DC
        for <linux-iio@vger.kernel.org>; Tue, 20 Jul 2021 00:47:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so27290166edc.7
        for <linux-iio@vger.kernel.org>; Tue, 20 Jul 2021 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yws7s4TXHWQe2pKmn33RrpTgITzoOEmoytMF72afsZA=;
        b=iA11nX9aO55Ub5rAjlydHf16P+FeqYzwVKEDAuGGA7+AIj4Cx86fbhFwd44ItAZx3o
         ppQv6xbyPdtE1wwiDsTWI3nKs3A43twiYuzErrhS7O5GFrRP+qyX+d0gSChBrJKA2kpI
         JUt13Z4U4jIGhPfop/9RxmHzPnyasyXX4nDdV76uyIZHXsM5JaJkyeIFjBRJS1qn+hsi
         mY3yhYgCatuJLm+VSNuYvx3mcUE796FOFJljyhlXcFdaHERCefVklw/0zVcFjn4dtQrL
         X50PMD72lIwFyqvtb0Fjd7irYTgP84j7HKGU188uOzmBaFAfbNadzdnqj7+S+L7ea3Si
         gUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yws7s4TXHWQe2pKmn33RrpTgITzoOEmoytMF72afsZA=;
        b=RxX5yoh8mTwanUb4lZfd5d9NoX85/vPZXdOni0kBTMvvKS+Fa9k2Dk3gGwF6L0pPBD
         f635nVkVXCETxuGP8zwf/FgrAa8XCBJK+DtJ2wr3THC8am8ZbtICtNGkLTO6eF3j+eEE
         F0DiYLrjhGkUTzYhpkYKRzKgbmbdKjB4n8Wly8Yhwpdmw8Wxmmpb6M7bayBmEGfGC01g
         tHckEwkkWos9SnMb6gmXk70DEZP5fu3ChAXlw/Gyg8EZ6+mkhLglYvviP8w4tLgrWU5M
         PBv7I0t35kqveXG8Et9gbfLWP+ItsXVurZKr+dutjpY4Z9ajnTE6GWfir/46NMTH/s//
         h14Q==
X-Gm-Message-State: AOAM530V7ui83tbZMedl5JfrrWREonacP0SFPclWHHNBihuS5+K+hFEE
        fGUP5J3TyX5KXAJZuLzkYEcJXQ+B5zob+h1loms=
X-Google-Smtp-Source: ABdhPJwr+3oKQ9L+qo0jwHjaqZ3HD1KElQ5R2NnqVAyyw96iK0WZ6Ubs+sq2EHVMFAhrph6zcC+P0w==
X-Received: by 2002:a05:6402:29a:: with SMTP id l26mr39209861edv.207.1626767220356;
        Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id b22sm7530940edj.24.2021.07.20.00.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 4/4] iio: gyro: st_gyro: use devm_iio_triggered_buffer_setup() for buffer
Date:   Tue, 20 Jul 2021 10:46:42 +0300
Message-Id: <20210720074642.223293-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720074642.223293-1-aardelean@deviqon.com>
References: <20210720074642.223293-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The st_gyro_allocate_ring() function calls iio_triggered_buffer_setup() to
allocate a triggered buffer.

But the same can be done with devm_iio_triggered_buffer_setup() and then
the st_gyro_common_remove() no longer needs to manually deallocate it.

We know that the parent of the IIO device is used to manage other instances
of the devm unwind, so it can be used in the st_gyro_allocate_ring() as
well.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/gyro/st_gyro.h        | 4 ----
 drivers/iio/gyro/st_gyro_buffer.c | 9 ++-------
 drivers/iio/gyro/st_gyro_core.c   | 6 +-----
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 6537f5cb8320..f5332b6a02bc 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -26,7 +26,6 @@
 
 #ifdef CONFIG_IIO_BUFFER
 int st_gyro_allocate_ring(struct iio_dev *indio_dev);
-void st_gyro_deallocate_ring(struct iio_dev *indio_dev);
 int st_gyro_trig_set_state(struct iio_trigger *trig, bool state);
 #define ST_GYRO_TRIGGER_SET_STATE (&st_gyro_trig_set_state)
 #else /* CONFIG_IIO_BUFFER */
@@ -34,9 +33,6 @@ static inline int st_gyro_allocate_ring(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-static inline void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
 #define ST_GYRO_TRIGGER_SET_STATE NULL
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 02b5562b6585..4ae33ef25b9c 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -61,13 +61,8 @@ static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
 
 int st_gyro_allocate_ring(struct iio_dev *indio_dev)
 {
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
-}
-
-void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+		NULL, &st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
 }
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index fe227ad400f0..e8fc8af65143 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -512,7 +512,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 		err = st_sensors_allocate_trigger(indio_dev,
 						  ST_GYRO_TRIGGER_OPS);
 		if (err < 0)
-			goto st_gyro_probe_trigger_error;
+			return err;
 	}
 
 	err = iio_device_register(indio_dev);
@@ -527,8 +527,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 st_gyro_device_register_error:
 	if (gdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-st_gyro_probe_trigger_error:
-	st_gyro_deallocate_ring(indio_dev);
 	return err;
 }
 EXPORT_SYMBOL(st_gyro_common_probe);
@@ -540,8 +538,6 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 	iio_device_unregister(indio_dev);
 	if (gdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-
-	st_gyro_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_remove);
 
-- 
2.31.1

