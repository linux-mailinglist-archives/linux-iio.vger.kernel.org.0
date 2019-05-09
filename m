Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E019471
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfEIVQu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:16:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33101 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEIVOG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so1846645pgv.0
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7P5q4QlYjlB1PoaalbGvh8L1Fqv8yMUpPNP9xHcgwI=;
        b=mKj2Cgfps3G1zkXLP/TIIcygJDNMHzTg6Im1Me8vkc9Tt/pT5I3JuoMevxlhdjlXaP
         vlcQwc3KzzYMSbUXV9An0OBLQ9UIyV07iY9hhxhJV2UqDrw0rS16/AoF0aF59mU0dUKA
         y56TmbTurVjtUNNP1jvaKkxMZAUfZRLEwQHHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7P5q4QlYjlB1PoaalbGvh8L1Fqv8yMUpPNP9xHcgwI=;
        b=Mxl9g8C3jg073fwjY6Y5WKcRp6v8CFpqEt0Nhk/Bp4RtI1sFbaYnVOuhVQy0rOFg73
         go4dJXyJAuTzyZhEHNmmG8QKwMLI4NGiyC9oLu/9e+ikU9uBedS+jCu2A9NqnbHRMTSk
         vsYDQhH0sZTdbpUGeTB56r7ATpdPyQzD5BvztFMeZCblf5IqoaSFslsh1AYO6rk3rbR0
         UWCi9MUx1Ec8Z89mqm1AKVXqxJWaeJJQZkN8nc3G5dkPOcRZ2IopQaz0g5hzgwPKjsyh
         AkrxUqrzWyEFJs4ycNSR74Wp7Q0hveEU/Y3cmnZdTuy9fnLzYIkRAgUJhLNpXfjZo+Zf
         dBfw==
X-Gm-Message-State: APjAAAVlth1afwBMWZ7qCTpY8PnHlvAzFFUtOhuu00ysarQhNypshOG0
        rDM9a+2AldBAXb3spxhaWZmeig==
X-Google-Smtp-Source: APXvYqxsq242WuHcF8/Wt0+0fgOWnGWASQJ3tDGCiBrsZLC4ZM6LkVI2F+ZEyqL/TfDx1mm8LexPxQ==
X-Received: by 2002:a63:b706:: with SMTP id t6mr2570714pgf.305.1557436445625;
        Thu, 09 May 2019 14:14:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p2sm5140870pfi.73.2019.05.09.14.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 02/30] mfd: cros_ec: Zero BUILD_ macro
Date:   Thu,  9 May 2019 14:13:25 -0700
Message-Id: <20190509211353.213194-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Defined out build macro used when compiling embedded controller
firmware.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 48292d449921..7b8fac4d0c89 100644
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

