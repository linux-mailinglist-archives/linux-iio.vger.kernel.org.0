Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EECFD9E6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKOJvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:51:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41762 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfKOJud (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id h4so5719892pgv.8
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wWrBkewFqbPrqVa8Ew3nGEKEiQ7g+kHy7TXa1Tllc0=;
        b=WyYSJhHQKw+P1T8ZikUxZQVW1xA7prMWiZSXruvM1Wxy/B/7Hff2OF97gfUf/L97fS
         H57Ci7zkKesdL2sfqa421168II5E/AC/6f1oPOyZaga5yCC2Kr9aI2TslZFyByEt+85o
         bMVP0aDUEUV8COczTYKLO/xLqb3cdk6b99g5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wWrBkewFqbPrqVa8Ew3nGEKEiQ7g+kHy7TXa1Tllc0=;
        b=Yvzog2nVBGh5i6V66Q4SL55I3Ew9OisG1UWauaGc4eXYI7RKTeeXb3sBU5hMYB9wQe
         fU5qMjXcnCxVz47rAh7K9QgS2ssQ9UEqk2UCgpF2v+j4ncMTacnaiaUfZa+2DhuVzqMw
         SjHW7ZmIta4vvoyDYI2OzAK7+fj5xGRf4BRn/mJO9akxgmd9ELHAWLJbncRxqemP/shH
         tSSJ8SVdapAz0HvGrPG0wTicPS+mvaks6/GsiBiyB94dgr91xcKYI8QRaSWFFdkewNZs
         5bHxZQG4dfaALj4KReVoRiHnl/h/Ox++2JZZ44tQTk54t+KewMsKkiOSbWK8k1Qizfs8
         4CeQ==
X-Gm-Message-State: APjAAAWXtv/7ZtSqJc3teBTc2ErTM9WcbJhNjKoXRkZRLFfVHPws78fd
        3/kf86qAR676GCanTaMA4SNyulvlIAsebA==
X-Google-Smtp-Source: APXvYqwkOOXHb0x4JXSb9ku3gzQ2VvyHrclPXfVeyC5yCdeTLFgQsK0Fke15kh1Uh/ul6cVvAapEbQ==
X-Received: by 2002:a65:5303:: with SMTP id m3mr14439397pgq.400.1573811431747;
        Fri, 15 Nov 2019 01:50:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j20sm9310017pff.182.2019.11.15.01.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:31 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 08/18] Revert "Input: cros_ec_keyb: mask out extra flags in event_type"
Date:   Fri, 15 Nov 2019 01:34:02 -0800
Message-Id: <20191115093412.144922-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This reverts commit d096aa3eb6045a6a475a0239f3471c59eedf3d61.

This patch is not needed anymore since we clear EC_MKBP_HAS_MORE_EVENTS
flag before calling the notifiers in patch
"9d9518f5b52a (platform: chrome: cros_ec: handle MKBP more events flag)"

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v5:
  Added ack.
No changes in v4, v3.
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index a29e81fdf186..2b71c5a51f90 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;
 
-	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
+	switch (ckdev->ec->event_data.event_type) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);
 
-- 
2.24.0.432.g9d3f5f5b63-goog

