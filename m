Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84669E9F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbfGOWCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 18:02:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732848AbfGOWCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 18:02:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so8349064pgb.9
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=C0JCiIlkjIoM7dBBKQbe6jkeqN3H2ZMTHLhaaezcvcv+9PZy0VaubjEzkp2rbbJzST
         qaWNcI1DRyAbUFak0HyAN+86sVSo+ikIMQsTnLoQu+hZKfqb+0cs132am7rSVPzbcd1H
         oto/B4eZxJQcbxCG/Glo8RRIWhAMLQOSzub4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=bv1x4VsRfUZQ2NEMVOdiCwmAljH3b8AvDpPRR5WmMSw5lYuXG6FaOlOXbbC1xQKGGx
         f6qZmsVe+2DtVX3dcHPVMpK6rE++QCRRimeBFIYMUAhf+7blBUZFc5qWQVXaQCER0lbr
         8EjUeymLAd7cNcHuFMgDK7YY3EWhjRoxqr5ji6/KZwimn88ThNnVXLsinQESXe26u1t8
         D7B1/3Mbd/pjgQfdnUxRlj6the2a5YazKU173cq9Al5UOgZlmfsOb9H6NSH4Y9yx2UFi
         ruH9b4IXru57AypVdi+b5qBfARIgUhvyG80HSJ3IqrYG5dmkEX4pWADFP558JKEHWeKf
         X+/A==
X-Gm-Message-State: APjAAAXdGpp8k5UbvkXYeZ+nM0SqKFYyD+UBZj3NuKmK+0+5b+efWXdg
        IJM4D1bRZ/3mZsfc2nM5T16tEQ==
X-Google-Smtp-Source: APXvYqwf4ex7TGcS002tYox0OywvSfJi3qudO4YgAdUlSKvVZly9b6A40Gl82qLexfXyMHxTED9tIg==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr19480868pgc.248.1563228130536;
        Mon, 15 Jul 2019 15:02:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a25sm17117924pfn.1.2019.07.15.15.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 15:02:10 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel setting
Date:   Mon, 15 Jul 2019 15:01:50 -0700
Message-Id: <20190715220152.119531-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715220152.119531-1-gwendal@chromium.org>
References: <20190715220152.119531-1-gwendal@chromium.org>
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

