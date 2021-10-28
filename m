Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEEB43DE9C
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJ1KVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhJ1KVV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A251C061570;
        Thu, 28 Oct 2021 03:18:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s1so22708243edd.3;
        Thu, 28 Oct 2021 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+QFzjiOgZlkTkCXooTGKu0LNv93OJOH/5M4+aQNGloA=;
        b=eYvJv7jSeHtayGXTcpptwWrjEUI0SikAoklswFnshW9ED91ae7SOsZBz8Sw475kHBT
         rafZFRR4bzOfoFQrrc2gPHvOwGc9iJkJnabjO/7vX2/f/kr27E9GXd370uQQUcK29SLT
         l0jyjp4PANFOfJC2mwVaRMlmjREnXvpc8lN9eagPen9GgzsZxDHy5gRpz/bz8w6ChXiC
         dS+zliBOuUBbFq04Ck/HUHq2q9fNulvLr6atvpVOu6OpBSBWHIVPjNgb5esfWWoc/9CU
         BQmGVIiJZXoBXKeK5U8iwQle9jzDRSHuNqO5fmSTebr9s7i8zbXUJzodzkGp/MAEkQBL
         oozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+QFzjiOgZlkTkCXooTGKu0LNv93OJOH/5M4+aQNGloA=;
        b=X2kTBkrgkDGs8qDjNjLxnbr1kVOqDIWadk/F/9EvGAwqqNfrxjr8/bTv4GaB1f4c1k
         ewek8yEQaRXO/DAbrc1tR2EBkHuT+ERY5Ccfu4Iqm4WMxTeHZuY72Jm6rWys3CmdjUJH
         sizNaTysZbUkSW8Qp1lJZpMD2nKaVBrSFEDNbnmcsjsHkW5Di/MEEb76yR4HQIFYGYdg
         7CE3cXmhkOoSZsasQlzCGAvfS4STuN0bmT/VtkJibHROgEWZsv54635jgantXiyD03wx
         eolsBdtJlUMzrYOHxKGbP83XVUPIDbTfaduK3KWL+ZLlT2lImSKFMhXy3m4G6ecTigmp
         3mqA==
X-Gm-Message-State: AOAM531P2v6/J+Gyz2cDzSM3k6NrxYeZvwlSZSc4wDYQi7VU6/8pR9Zq
        t/tk7m+e0h7x+OmT+pZGUyk=
X-Google-Smtp-Source: ABdhPJwT8l25YZIpOIXicJcEtJmj5J9o66PzaoPxfoVzRPhg6UmzLUMBUc7bf6jAkRU5SwNg/KX5xw==
X-Received: by 2002:a17:907:e8b:: with SMTP id ho11mr4331419ejc.300.1635416332774;
        Thu, 28 Oct 2021 03:18:52 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:52 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 04/10] iio: add modifiers for linear acceleration
Date:   Thu, 28 Oct 2021 12:18:34 +0200
Message-Id: <20211028101840.24632-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is preparatory for adding the Bosh BNO055 IMU driver.
The said IMU can report raw accelerations (among x, y and z axis)
as well as the so called "linear accelerations" (again, among x,
y and z axis) which is basically the acceleration after subtracting
gravity.

This patch adds IIO_MOD_ACCEL_LINEAR_X, IIO_MOD_ACCEL_LINEAR_Y and
IIO_MOD_ACCEL_LINEAR_Z modifiers to te IIO core.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2dbb37e09b8c..a79cb32207e4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ETHANOL] = "ethanol",
 	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
+	[IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
+	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 48c13147c0a8..db00f7c45f48 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -95,6 +95,9 @@ enum iio_modifier {
 	IIO_MOD_ETHANOL,
 	IIO_MOD_H2,
 	IIO_MOD_O2,
+	IIO_MOD_ACCEL_LINEAR_X,
+	IIO_MOD_ACCEL_LINEAR_Y,
+	IIO_MOD_ACCEL_LINEAR_Z,
 };
 
 enum iio_event_type {
@@ -114,4 +117,3 @@ enum iio_event_direction {
 };
 
 #endif /* _UAPI_IIO_TYPES_H_ */
-
-- 
2.17.1

