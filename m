Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78A3471F5C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 03:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhLMClD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Dec 2021 21:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhLMClC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Dec 2021 21:41:02 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75DC06173F
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 18:41:02 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r5so13303973pgi.6
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 18:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2jZlZULVy0+ZHsiTVYOv8MGC1AiP3IKlJHE0nPyOsE=;
        b=JCexWe8AMyF1sbwE9fGVWiosatU+Ea7QryikX5yRYvMr9vi4yINjGUsahdSmWHKeWj
         Ux230wc2q0g+2SlCgkkhjsqyFFbAyeNGQ8HNCIKblkGxxAT2h6oBMosSbnMNXM7qrHnF
         O2J6NPHEBhxCBcC96Z5cA4DWt94szmXt4OuTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2jZlZULVy0+ZHsiTVYOv8MGC1AiP3IKlJHE0nPyOsE=;
        b=4o3HbPKLJS+uw46sP4jQaI26q2dtYSAEXkOZChgwuJ2+dwLFCgt5/fY1xLBlqYWEnG
         fYNsXhifFzaMIYhE8st34ARtSN7Jy0Y9uKc8FLY8UdXEctD4rMg9maUUaxw9JdgrWH0G
         jSVIgZzPmnbRa3GTIdG2MMw83VqlVnR42f09SC6SY/4TBvy3A8MXwBOAPYiVqNlHWAkd
         6DCdffpuhNbd6LrHEfWwuMhoW8qjr/F3ymB91iTjjqmCMI/AcbG35OD6gDtjzLLaniyZ
         heOIVrtRbm6ypBAOrTl5rUpZjZk2n/PPUvqNyaSdliV63qpVcBNVp6G5qMFDYp9I/ALJ
         YHvQ==
X-Gm-Message-State: AOAM530F9qfcVIQnUKpyLTYSnUy2BcTbEA+xB7MdjQRQqtEmqXuIO4CR
        TCUEGbmBJ8s9qDA5J+OCd8UrAA==
X-Google-Smtp-Source: ABdhPJw8hCrYC5eLI2nwzTOUKeRvUQTGfwiJ1o5uZoEHE0XUWtBQ3KY7uI/aFqMI7yIi8Yl9onTBdA==
X-Received: by 2002:a63:2a95:: with SMTP id q143mr51071390pgq.45.1639363262197;
        Sun, 12 Dec 2021 18:41:02 -0800 (PST)
Received: from localhost ([2620:15c:202:201:9cf8:7f4:ed82:2d07])
        by smtp.gmail.com with UTF8SMTPSA id l9sm10585438pfu.55.2021.12.12.18.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 18:41:01 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/4] iio: add IIO_MOD_REFERENCE modifier
Date:   Sun, 12 Dec 2021 18:40:54 -0800
Message-Id: <20211213024057.3824985-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213024057.3824985-1-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add modifier IIO_MOD_REFERENCE for reporting sx9360 reference
proximity measurement.
All modifier must be defined for libiio to recognize
|in_proximity_reference| as a channel.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v3.

 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 20d5178ca0739a..2b272f54de8ae9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -134,6 +134,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ETHANOL] = "ethanol",
 	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_REFERENCE] = "reference",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 48c13147c0a870..aa83a9b578502a 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -95,6 +95,7 @@ enum iio_modifier {
 	IIO_MOD_ETHANOL,
 	IIO_MOD_H2,
 	IIO_MOD_O2,
+	IIO_MOD_REFERENCE,
 };
 
 enum iio_event_type {
-- 
2.34.1.173.g76aa8bc2d0-goog

