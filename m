Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3672113514
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfECWCq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:02:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34294 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfECWCq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:02:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so3549026pfd.1
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1fjM9w2h70QiUrv+LoNu/lNneSjRxxrzXxb5mmKI3w=;
        b=FtEmcK2EAsDc4lbuEYIbz39AL2xpoQyeXHy70UQfD4vEaamR56r1fcjMjYeclr5ne+
         8aMYs0G65xWKu9T1R1ALpUd/xolxscn024lKVRLu6q8Y3XgjnqFezpNeaLw7iWT8YROL
         9SieAdZYRkUmvxrjX3nTBWP1rZhBUOQiklSdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1fjM9w2h70QiUrv+LoNu/lNneSjRxxrzXxb5mmKI3w=;
        b=fKLZsojolb4kcll+GCSnxVGUmLf52vdSgD19Y+zeFkKuLBb64VDTfZObVtcWR166w7
         YOnu2gGSJRphvYZBHQ9y5jz9CDPCfkm9Zf3N4eRC1gBHHmV7fxPBN5MkG/ZnxOza04ZK
         qkL5LiOvw3Ye3NnnaCs826RKjoRrcu1uv5MfIgDoXdT42HLqpUsGDUtUH/2YjgBAlFuR
         ECkkOgtgi4VyP5+Il0qxUN28VSQBhDLuHAquvo/fuwRWqdf/h7a8Ec/eerRVvqSnZJno
         Shv+nvqkPBcbSZYCbekSCe1v6aLcipiQQnLw8J5LeZq+/MQAZ3o03IQJ7jYvY6fa88hY
         9Xfw==
X-Gm-Message-State: APjAAAUPtRgwLWpNj5y073bywnYYl6GcP5lTzeMgQX5A20OGviOSAV51
        YdBNRCRK7bpcT8YNXCfAxSFP9w==
X-Google-Smtp-Source: APXvYqyBJeOEF7xV0itUAXuRjhzZi8P2TOqSE1YE4DuxpYkK5TmwtKSlV6hXJc5Hd0s8mGFtfiURxA==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr14167742pgc.25.1556920965411;
        Fri, 03 May 2019 15:02:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id v64sm4256040pfv.106.2019.05.03.15.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:02:44 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 02/30] mfd: cros_ec: Zero BUILD_ macro
Date:   Fri,  3 May 2019 15:02:05 -0700
Message-Id: <20190503220233.64546-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Defined out build macro used when compiling embedded controller
firmware.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 6fa508643da3..374f64caeb5f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -13,6 +13,11 @@
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
+
+
+
+#define BUILD_ASSERT(_cond)
+
 /*
  * Current version of this protocol
  *
-- 
2.21.0.1020.gf2820cf01a-goog

