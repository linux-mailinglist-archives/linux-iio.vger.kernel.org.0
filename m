Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2363CA06C
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhGOOUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhGOOUq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 10:20:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D6C06175F;
        Thu, 15 Jul 2021 07:17:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso5358513wme.0;
        Thu, 15 Jul 2021 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=euuNJ4QYLqPQyiZ3jGVxRpNge1xVHhts30tJq3NSewA=;
        b=iP9CnI8hw5AucGUo4ibuV7X7+IOeU8Wz+IyyUELpEbqXZwRHL6AcgMDhawMKXHYK/a
         A4VbNiBdfvvPSsiB7x8w5TKMSNzg4Z6rmn+DoawQ37tAyGMTqN6xuhnNK8QDYfEesBNX
         N31JfgaId6hJcFP1yj2ci3tYKQ+U1tJDpQcPY8E+NJSoL2UYsTNO4RYYzKaCA7ahPpOK
         QKKgZsiUNhZzzfC32DBORQnH+4QoNzZh6qQEb1c340LgT+TsaHllPkpjtwIsNMOThy0N
         PxWzdaEndJ/rxio/VVEmcJSyksJHETquLxj8E9SuB3pO41FLYmLW6Vfv6nAvvWarbFzC
         WKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=euuNJ4QYLqPQyiZ3jGVxRpNge1xVHhts30tJq3NSewA=;
        b=kq2m+feGSuBXKXlKH7RFlL4FYc5kxkL9nLDbcwbxagv1I+cjbiI2UoqDwO/7MMLMqj
         lSzD/V2n84rdEasdTYSCvK7NSfYLNeJQ7toqGLIbk2mzPnG5tY0dZMc12zsEKkR4eCCM
         xxR3Us3qnRI1bz0hdR5LjJqLWD/FtjTzCrMDxOBCYM1U+QtJsRkgIcXU2sZ/GSieauUP
         rdnKjxqCa54JV7Cep/vkNVmghh6EQn/MG6B0uKd5n+PvHcmoQr2eI+Lr1xu7OTZNpDYz
         KtiXgyg03Z+fg6Kwmc8f6bkAXA/BmDsSh74Xyhn0/rTdhIdPgjfOzekhyCZqW7lWnKlA
         QTLQ==
X-Gm-Message-State: AOAM530AzOZVxv6+ysWy7YgUydAMlRS6a0+7Wcn7xXKudQTf4L03tX+W
        Mwqw40MPacYohI2kaxAdVT4fe6T7qqV4GUx4vmE=
X-Google-Smtp-Source: ABdhPJxN9ozidyCRDgOmdDS23wabGlt/+1rL2H83PSoDSjhV72hSL8NWqSA/kv7Y3gBIxSTBvnPvPA==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr10397911wml.17.1626358670207;
        Thu, 15 Jul 2021 07:17:50 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id u16sm7989094wrw.36.2021.07.15.07.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:17:49 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     robh+dt@kernel.org, matt.ranostay@konsulko.com,
        andriy.shevchenko@linux.intel.com, vlad.dogaru@intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH 1/4] iio: add modifiers for linear acceleration
Date:   Thu, 15 Jul 2021 16:17:39 +0200
Message-Id: <20210715141742.15072-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715141742.15072-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
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
Cc: Andrea Merello <andrea.merello@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6d2175eb7af2..e378f48240ad 100644
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

