Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF51FFD9C3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfKOJud (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:50:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36233 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKOJub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so4310192pls.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfEOVKIJ8U0GfHedTM8uop95E6UnQcFBXP6PO2Xab/M=;
        b=m2EFgUMsdkyQYfBqNYpaO5s0oKfL1ugX3rEJQyR6V1NScny95WiRNhsA/pIgkhM6tE
         CRyBvyLsuKWFk6m9vb7ECHapzMYJBzFbYtCyNGu/f0ybVwgMi62LF48QEBPoqSbzN2Bi
         U/LX62BKdu5ckGKJLVx+AT82sogu83S90lNrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfEOVKIJ8U0GfHedTM8uop95E6UnQcFBXP6PO2Xab/M=;
        b=HYc50CxV2+c8d+mg2ukKxlpRUkeXNbW2e3EJYj+nqmyJXyKATu09q0ZwiubeXzAELv
         nrlKRxq0Zc3WmgK/5CCb/TCf6SCDaQhyTp/kvSjD4u5TJ9W8FDHcc9Q3wCWurpyH1mqj
         fdOSxk/WIRoGt/2PW29cstn+P9X5ELMyCVblJY8dGAnosyNAmg+e/rgWXPzPrnbq0bw1
         3JpyRVJZG99xEokc64e6HlBwa1fcFX+T3vnJb9ceNmZJE2zM4JMCGak8T0Xph9dn2RGb
         55JocRFQr06tqYKJf0H0B18MCvJ9xiDc0xfldF3yB0bXNrf4cS8oSn8+L31KzSZ+xJtO
         0dSg==
X-Gm-Message-State: APjAAAWYUB4EgSrLFw+ArMJ2jfmz0inx0qxaxmmBvB6w5iZBHoxlCQJd
        xjQRaJgTWmdbPxzwTEDsHPmW5A==
X-Google-Smtp-Source: APXvYqwMQarLqCwMW2+EGNqFNExtVLNkA66aqH0FntvLNMlxemfuDPhChGsPbPaT/XThVqCt8gfSJQ==
X-Received: by 2002:a17:902:aa42:: with SMTP id c2mr13953629plr.311.1573811430375;
        Fri, 15 Nov 2019 01:50:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id i32sm8317366pgl.73.2019.11.15.01.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:29 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 07/18] Revert "Input: cros_ec_keyb - add back missing mask for event_type"
Date:   Fri, 15 Nov 2019 01:34:01 -0800
Message-Id: <20191115093412.144922-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This reverts commit 62c3801619e16b68a37ea899b76572145dfe41c9.

This patch is not needed anymore since we clear EC_MKBP_HAS_MORE_EVENTS
flag before calling the notifiers in patch
"9d9518f5b52a (platform: chrome: cros_ec: handle MKBP more events flag)"

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
No changes in v5, v4, v3.
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 8d4d9786cc74..a29e81fdf186 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -226,8 +226,6 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 {
 	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
 						  notifier);
-	uint8_t mkbp_event_type = ckdev->ec->event_data.event_type &
-				  EC_MKBP_EVENT_TYPE_MASK;
 	u32 val;
 	unsigned int ev_type;
 
@@ -239,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;
 
-	switch (mkbp_event_type) {
+	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);
 
@@ -266,7 +264,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	case EC_MKBP_EVENT_SWITCH:
 		pm_wakeup_event(ckdev->dev, 0);
 
-		if (mkbp_event_type == EC_MKBP_EVENT_BUTTON) {
+		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
 			val = get_unaligned_le32(
 					&ckdev->ec->event_data.data.buttons);
 			ev_type = EV_KEY;
-- 
2.24.0.432.g9d3f5f5b63-goog

