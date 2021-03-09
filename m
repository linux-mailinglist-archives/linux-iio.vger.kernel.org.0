Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5333268E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCINU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCINUm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F05C06174A;
        Tue,  9 Mar 2021 05:20:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fu20so886473pjb.2;
        Tue, 09 Mar 2021 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNbuVcZgloeyR2LVzHohVrUsgceqLUUAvFiu7EZYLL4=;
        b=OiDLg/jNmamc1mtL3gaPFwjt7jTKbMZ+aqomYModCj29Z1bpZ82+RHODdUZKFDVcfR
         z9p7UcTX5W5PpVCGnqmRT/MQB+mR1h31g0syjgDDZRIVLGMBI/1OJmfQOTwsKF0GQ8jx
         2bYh9ALrtmpTRmnyABFOEuVjb2fDvLPI418tYkQmF0qzu7vR5vNvHnWp4FD8scgEkixV
         8slgACiMoWoTxY4dm9l1tNn9lFZh8a7vjL/FfW/XcbnPzLoxEF7cgFphI1RKH6tSNTPi
         KpovAM357vJ5wm8k+24tqNJw6aZqevtzJF4hVMK4EcErGsX9t/GFhttmAtlZpVG+sahZ
         gMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNbuVcZgloeyR2LVzHohVrUsgceqLUUAvFiu7EZYLL4=;
        b=DpGVqGyqZRMQpzbiir2FgLUtx2YWEOoNXWpHqFmFcqFIzrjoq6v10eNM0s6uDbWtLU
         Tp4BUhxUfyRuYPnNZL6AqDIzOeatRmPKib4aGayOolr3IrqUsey9971Xz0tlbWzme7Q0
         AXvR0uaXNz4u5vQAAIeXHNEZmagnkFfRaKHMOHEfXgAVpNAadQvZJGcyOEG5VHvF8YYp
         tWF8OziTKTMpvPQpPAZv4PU6m7whsQ5puijzIGtZPnJXLYhk8QwMgl3C5ehv/vi1Aklh
         V7Ae+yldpNpg5bYEvh0y0DwLuPej/EgEoK7GGeahoGHCCHyVG+gXDvLuYdVKXTgEkSgd
         zXkA==
X-Gm-Message-State: AOAM530SsjtdCYPU0x5VZyoCewuJVk/XiSHEmNkGui2VpSq5pps/VD2J
        s6sFeqWAKLQe/w4dtIaWNxw=
X-Google-Smtp-Source: ABdhPJwEpv8MPkJndDfnJHfd27hFk1fPpQhJPLsyGIytQ7HNvZsyMi2HU3uDDtSNepF1K82XCBwm8g==
X-Received: by 2002:a17:90a:a63:: with SMTP id o90mr4795577pjo.90.1615296042338;
        Tue, 09 Mar 2021 05:20:42 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:41 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 06/33] counter: 104-quad-8: Add const qualifiers for quad8_preset_register_set
Date:   Tue,  9 Mar 2021 22:19:19 +0900
Message-Id: <67c6b42f44015b24eeb8136b2efda28aa41cd055.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some safety by qualifying the quad8_preset_register_set() function
parameters as const.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0fd61cc82d30..51fba8cf9c2a 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -632,8 +632,8 @@ static ssize_t quad8_count_preset_read(struct counter_device *counter,
 	return sprintf(buf, "%u\n", priv->preset[count->id]);
 }
 
-static void quad8_preset_register_set(struct quad8 *priv, int id,
-				      unsigned int preset)
+static void quad8_preset_register_set(struct quad8 *const priv, const int id,
+				      const unsigned int preset)
 {
 	const unsigned int base_offset = priv->base + 2 * id;
 	int i;
-- 
2.30.1

