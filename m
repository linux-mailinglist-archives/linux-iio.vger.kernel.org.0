Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117B043DEA1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJ1KVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhJ1KVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573BC061570;
        Thu, 28 Oct 2021 03:18:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r12so22763550edt.6;
        Thu, 28 Oct 2021 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebcc9avtRTpOGo2lCBnYLZE7pkUmbgQOoD9onwZGysk=;
        b=dNHaeFDdvPLn9PQoGUXBgxwpnHqhtqXYazqu79s+OS27tNSRoOn97Rwy8h4mXGVGLD
         IRA9dHlM/s16x+pC16KswHRT9mQnUn26UOUUBjxSFdnH0n29Vgq4DxBUos38mgVGRf7d
         gKsghBcM9jRWW2Q6tF90Me4rojNyAKNni/EbqEYPa3pe1IpSHh0hNAnfVh42nukElunV
         kWRCS+WaqZnCe70sjSLAowsIfMI/ocWY51gQAVE1yPpWFEfJemUXS0QsMMOiPlRZTkeA
         egH3d7uqLe7tvOssJFa8Fsv4dw1OVGL87FhZ7NSB3Yh4ipTlDiLYZMbFoILJSf7xil69
         ZOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebcc9avtRTpOGo2lCBnYLZE7pkUmbgQOoD9onwZGysk=;
        b=jOTSFDpSNxaLZ4/yX2uBlh4HYXyZ0rT6x5/l3aVLHer8Rg0Exa0TLjnStuw6ISLVkS
         0ltHTEeXqLSzpoxggJdyLmiCTTkr4mlyl6n1VBjiXttfCq6OuGFHmzG+C//ZmIXSkuN1
         RzUDJdEoOgy/3ktFOS//KquhqQyf2PMNbFau4xWGO7/nTGMXc8W4VEyvQXn4k87T5FKY
         xuf9bbbE4mt3e2e6FYduYmFVRgq0bICILmNCrsbUrQAsKepXWAtOUGJItGzvyRHvo5gX
         e3KhjqGWiedpH+OyLV/p1+O+luP4nBkEpD8X7Y21tB/3RObZMVtaX1soNoJD5jIg+ZPH
         IfQQ==
X-Gm-Message-State: AOAM531f8sCB3uF3kvpEFI8gj6vreQpXhFovQFGUzg/d4hNjUxx8srKR
        qC/QQLYfOxlWMVBdg/visgk=
X-Google-Smtp-Source: ABdhPJw+W6AAq3P5JQH8v1/wywXlIBNtAFYX5fDjJekzb0K8uZ8pMiSMYpjGtFpmAOJODv7oIOTOAA==
X-Received: by 2002:a17:907:7803:: with SMTP id la3mr4284124ejc.235.1635416333802;
        Thu, 28 Oct 2021 03:18:53 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:53 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 05/10] iio: add modifers for pitch, yaw, roll
Date:   Thu, 28 Oct 2021 12:18:35 +0200
Message-Id: <20211028101840.24632-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds modifiers for reporting rotations as euler angles (i.e.
yaw, pitch and roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 5 ++++-
 include/uapi/linux/iio/types.h  | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a79cb32207e4..d2ebbfa8b9fc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -136,7 +136,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_O2] = "o2",
 	[IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
 	[IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
-	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"
+	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll"
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index db00f7c45f48..fc9909ca4f95 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -98,6 +98,9 @@ enum iio_modifier {
 	IIO_MOD_ACCEL_LINEAR_X,
 	IIO_MOD_ACCEL_LINEAR_Y,
 	IIO_MOD_ACCEL_LINEAR_Z,
+	IIO_MOD_PITCH,
+	IIO_MOD_YAW,
+	IIO_MOD_ROLL
 };
 
 enum iio_event_type {
-- 
2.17.1

