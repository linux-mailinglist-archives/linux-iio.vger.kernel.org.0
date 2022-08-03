Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F7A588B97
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiHCL5h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiHCL5g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 07:57:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024544B0ED
        for <linux-iio@vger.kernel.org>; Wed,  3 Aug 2022 04:57:36 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i7so12723305qvr.8
        for <linux-iio@vger.kernel.org>; Wed, 03 Aug 2022 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hFmeYfkeCSrty689B9fUPynyWtCrDfhQlGUnKxqdjIs=;
        b=nZUGTLVHZAFfm+7AiXTtGbdRyAlM4H2FFJrLmsAsdJILoqDZg67akx0zGXeWOWbnX+
         /Zk8tCgKeQCr/iHX7Vp3zmAekaMnK1UJFTMO8C7H2aQVwUG3jlDdSfRv9oxS9ZOv/eSl
         k+BtLm4ahi/ctddmUwcABqwg14j1v6c/UtSBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hFmeYfkeCSrty689B9fUPynyWtCrDfhQlGUnKxqdjIs=;
        b=mc022DWlzkG/TG3/WX79HDMQi/jg8aLlB/xxK8Po6SsTYlEl3dkOJa5NyrVnNpukR6
         L/xQn8hQHLAIdCBBQ+f/Lr4C4x7/bCvMZnX/STla2N9j7ysKLlmJOAGQd/DSZuNayLtT
         KlzuFFke4EulM/TTI4GeXC5zNpT4E2zTTN6vkCMOcO9a8hUAwOLuQYS3kp+5261p5+kI
         /axgWVd7buc6hHQea1b4kh24/ud76yu7gHD0mIgm7Jwked6qYybEUp0GlJMAeg+Vwgit
         oxwp5hZlzJY8LfEwlvouaPieUEddNLXCm/M5FFdS2DauLPvC/BTaqFPX2SwCpes3Mfpg
         vX3A==
X-Gm-Message-State: ACgBeo2FFgKUNuadvGJd9zD1YvasKP4t8IyMhdTxiAg+SzGIOGXrlEXA
        kGkXLWGjuqThztaszRmAhSGl/Q==
X-Google-Smtp-Source: AA6agR6MXhdpFD5T0GDFoLYZbL1dg2NXJ9GnfIJuiGB5UyR9uoGYCl6C92LIYOV32hlhG3STFYfI3g==
X-Received: by 2002:a05:6214:624:b0:474:7ec6:feea with SMTP id a4-20020a056214062400b004747ec6feeamr21886441qvx.0.1659527855166;
        Wed, 03 Aug 2022 04:57:35 -0700 (PDT)
Received: from localhost.localdomain ([159.65.38.31])
        by smtp.gmail.com with ESMTPSA id cc18-20020a05622a411200b0031ea2328edcsm10736348qtb.82.2022.08.03.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:57:34 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: add NULL pointer checks to iio device additional/removal
Date:   Wed,  3 Aug 2022 19:57:20 +0800
Message-Id: <20220803115720.89848-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check if __iio_device_register and iio_device_unregister indio_dev
parameter isn't a NULL pointer.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/industrialio-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0f4dbda3b9d3..6071e52903e5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1896,13 +1896,14 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_dev_opaque *iio_dev_opaque;
 	struct fwnode_handle *fwnode;
 	int ret;
 
-	if (!indio_dev->info)
+	if (!indio_dev || !indio_dev->info)
 		return -EINVAL;
 
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	iio_dev_opaque->driver_module = this_mod;
 
 	/* If the calling driver did not initialize firmware node, do it here */
@@ -1987,7 +1988,12 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_dev_opaque *iio_dev_opaque;
+
+	if (!indio_dev)
+		return;
+
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
 	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
 
-- 
2.36.1

