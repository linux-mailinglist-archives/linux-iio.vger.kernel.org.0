Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9DE6A12
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfJ0XKD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:10:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37437 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbfJ0XKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:10:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so5383730pgi.4
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17VXfSKYZQzbP4YelUVgRIk9dpr5Oa0vQvqhXwR8nzA=;
        b=mDUrWiuq19RTwVgaoXS7SNL1c9FVSOOD1nEH/oJgMwHgoBcJTXS6cRSBtNrr9JCp6+
         Wl4a5gtZdBFLvp+k6nisJR90NF1JKzTnsSxR7AzFUCmuCVI+hQJdDS/z/v3iRQAEx+Yp
         JDidsW2+PklPsrSr8zHgSQzgxCW5IzUDwEL0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17VXfSKYZQzbP4YelUVgRIk9dpr5Oa0vQvqhXwR8nzA=;
        b=UEQXHCjxKmzXHpErSca4kSy8FKoktXzSygdoJB/tKrz1FRr9bsheZUO6F/StTYYopP
         GLGI/PVuIUmUebITkDmRnSTgnjA5eWwt8Afy5Mzr/Dke7ckf3j16jQvRbxy9datXsKcx
         r+2fxCNAsBI189Kd+s3hXKqslMTm5qNI5VqYlOPcZu1rIMURVx3QVtNyJ+aUN7dIGRPH
         RQ91qNYHhur48ELQ09MaHaKmLmoHXPGOPu325EbbVVM8F7Qe3V9HAex+wzVMjdT1pJ8D
         OgFlVGeuLiL5ylJ9d2vyFqRPYaYKsMZeyQ1bPV07k06F6G5Dtv+2HTXVsbLTurkXSzpw
         +y9A==
X-Gm-Message-State: APjAAAUtqZHepnTnUqITnYW6tk+E5LqvI/NZj+hJO0GqWo1KJ/Pt1jfo
        I/l5BlSrzd624z7SPUuCQEKIgQ==
X-Google-Smtp-Source: APXvYqztWGys83usJcAnWsSsXSLPFur850GnCXfa7eEOG8ZEEyMWStikMNyLNoc7FLWHp4ANCpAn9A==
X-Received: by 2002:a17:90a:234c:: with SMTP id f70mr18336779pje.109.1572217801287;
        Sun, 27 Oct 2019 16:10:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id w25sm8260438pfi.60.2019.10.27.16.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 08/18] Revert "Input: cros_ec_keyb - add back missing mask for event_type"
Date:   Sun, 27 Oct 2019 16:09:11 -0700
Message-Id: <20191027230921.205251-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
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
---
No changes in v3.
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 8d4d9786cc745..a29e81fdf1861 100644
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
2.23.0.866.gb869b98d4c-goog

