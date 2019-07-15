Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC469F62
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 01:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfGOXPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 19:15:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43766 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbfGOXPC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 19:15:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so8423160pgv.10
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=A5XGb1C/TSinuAe1zfk7UExKA3J35xN0BfF97rVRF43VNbo3zr6qpvMF8zZVSr0GUc
         m6FavsQAjyxbFZQKB8+hXBKAHggXN5AidzDWtGGykPlnsTUCbL2sEXFNDTZPnf1woSfN
         wi/QsKeZ/soaz5EDJAqOaXm7EynwRt93148QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=CbCuOBXtDSB2poG70hwp6PV/HI6k4k+f+MeUf4+rl2P8qdq0mgkdRJXikGxV7xcaqb
         yLs+0wB3MsKwIIjjC9BZ7D395kduG9Htc7zOspyrzdSR04nK6+4upejha9a/yX/8oLVa
         auXEtTl3tPYGeW6qv8+nXvzMtiOU8G6sXaXoJo5H9BGMUJWafJKGKaZ+6JtLzLr7m1EM
         40eBhqaJx1NxHxkFIrxU3oJxJQ0FG596Bt1ui5F33Bnoh1De25Gm80X9M8gHoJpGIG/m
         xfI37rp666lZ/5xjyzxYzcZ5m6DDtaW3PkhbtGRyyXdxv/riZLaxfXfeC2Gwq7sjk9Sx
         JC/w==
X-Gm-Message-State: APjAAAVVARqHXi55xQlWjlxbQ6bCBGO2pwvO2xGACZ2PXSzyv5IX94op
        pU1GaSP93R/4/Eu0YPv8V3SiXQ==
X-Google-Smtp-Source: APXvYqxuWm9+wghenWJCt5B5nPmj83WxzbY6f3N14RcnDevhAzqpobVk9u+nwzI1eQPV0HIKeA63Bg==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr32530182pjr.78.1563232501601;
        Mon, 15 Jul 2019 16:15:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 97sm17539388pjz.12.2019.07.15.16.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 16:15:01 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel setting
Date:   Mon, 15 Jul 2019 16:14:52 -0700
Message-Id: <20190715231454.189459-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715231454.189459-1-gwendal@chromium.org>
References: <20190715231454.189459-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

INFO_SCALE is set both for each channel and all channels.
iio is using all channel setting, so the error was not user visible.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 46bb2e421bb9..ad19d9c716f4 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -319,7 +319,6 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
 		.modified = 1,					        \
 		.info_mask_separate =					\
 			BIT(IIO_CHAN_INFO_RAW) |			\
-			BIT(IIO_CHAN_INFO_SCALE) |			\
 			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
 		.ext_info = cros_ec_accel_legacy_ext_info,		\
-- 
2.22.0.510.g264f2c817a-goog

