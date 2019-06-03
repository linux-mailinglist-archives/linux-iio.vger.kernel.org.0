Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A575E33833
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFCShD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:37:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37257 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCSeI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so8776238pgr.4
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNrf8Jnz97UuIym8j3dBQYRGR049MkRgE0BVyZwE5HM=;
        b=YsPyRLSkMm4zYPE51rbZbCHmfcIrNpbAXG1rR/QiOUreF79d1eERchC3FUKgTHziRO
         +lfs8fLTApFM4EabtSExv7Y+OgtT2Fc1hfNfkcdo2nvvth5H+mwseymOcmLsjK5Lkb0C
         C5vQMk3EDJU7oMVDG71D2fp/HhWIvgwfOuLRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNrf8Jnz97UuIym8j3dBQYRGR049MkRgE0BVyZwE5HM=;
        b=Yfjyoip+OLaF23EscSjS1T/tzTN1bXl3HZDUhCuZM44Nyx3XnaE5l9IDFksF879fwL
         0Cc4w87wkcSg3t/kKS5fYG8ih3SMPyVaOyV/JhjSOHF5Aw/VI70P+weXASPH8ucrEGUF
         +0tc/J8rZGR9/Iy5eok9Egxki69Uf5za3VY5Xha5jBahdHCw6BDyEWTLWvXikTqr6AJR
         tpnP7bwNUz1uJXom56iRmtiG+glRiOLxueqFVOt+6NpZ56TzQdDIeM10C1xubzwTrqwG
         rRsqPwwz2piqSG9oYVwNiwsNNxo18/OCocU/PTLnAIvPyjxQLbH4ZLhKkc/FOZwAO0AF
         KGaw==
X-Gm-Message-State: APjAAAVSv6OfWfAOLQYnf/PikZKFT/kkgcecbAhy1hjtvYHOTpFXJdhq
        +kvZjytwEl8XAVLzHjTGabWShQ==
X-Google-Smtp-Source: APXvYqw6sXgo4NuVVy+bI0kBDsz/jNQ4q6SS66NHT9cYdkOFi8i45sJ9jIkrK4Pm4AbME7JEpHfjxw==
X-Received: by 2002:a63:c104:: with SMTP id w4mr10115534pgf.125.1559586848333;
        Mon, 03 Jun 2019 11:34:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id e6sm10590853pfi.42.2019.06.03.11.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 01/30] mfd: cros_ec: Update license term
Date:   Mon,  3 Jun 2019 11:33:32 -0700
Message-Id: <20190603183401.151408-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update to SPDX-License-Identifier, GPL-2.0

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index dcec96f01879..48292d449921 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1,25 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Host communication command constants for ChromeOS EC
  *
  * Copyright (C) 2012 Google, Inc
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * The ChromeOS EC multi function device is used to mux all the requests
- * to the EC device for its multiple features: keyboard controller,
- * battery charging and regulator control, firmware update.
- *
- * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
- * project in an attempt to make future updates easy to make.
+ * NOTE: This file is auto-generated from ChromeOS EC Open Source code from
+ * https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
  */
 
+/* Host communication command constants for Chrome EC */
+
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
-- 
2.21.0.1020.gf2820cf01a-goog

