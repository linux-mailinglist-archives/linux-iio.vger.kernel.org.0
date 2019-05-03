Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16C413513
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfECWCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:02:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40178 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfECWCo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:02:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so3309122plr.7
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8u/UWICJawrzrjLKRsjDtgT8+fxH2ub2bD/oCUZO04=;
        b=cTF4y69jR8iirJqdEiwoSqUcywThQjw2vb0JCsP1mctYrZCJv5Ih+xn35SbKEH0Hyd
         WAcuDt0ejpX2FhZNdNuFA00YGUpifRHNmuT9OPuqEMPRIbRcTlq0W6P/JFIIqRdBvIix
         tjZl5edO7sgX3JBMBziASxysSGMnof3aORxaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8u/UWICJawrzrjLKRsjDtgT8+fxH2ub2bD/oCUZO04=;
        b=GORyEVRKehZdJzr2WQI+czx5mD87C/TIyTWjhU9VJT1sgMiSjnEQrLfhLuL9rUSH0c
         vQ8aGVlTcLc0WJI+FgIpWaBltTHiVjvZjPWyyOmqWps+dQHjm/sqSRdLupA3qXBg0c77
         VBvZYdWgmnc+Z9hn4SJETsIvYQvY+VtVtyzj2FGiDkuLHzlu+mcwUbM6IW7DRWqYvgLu
         Yx6I6xXuGcg0JBvDt8Taey0HaZY2KBhmyATde9brPPk6ACUjqxak9lJ7cvn1joy3u1yS
         BZGj+nFIxhEl1GIoXjfp7ooy8j9WF/EnXkMmRCkKHtv0f/3aNwM1NWFQVSjQ2VkUXckT
         sMWw==
X-Gm-Message-State: APjAAAUb0scWoYv9k0CCGKksb3paNMdzU1bT6gASvkSm8WMxf62+fsoV
        tiVMhJymgvt3IpW9KQQVDt8rQA==
X-Google-Smtp-Source: APXvYqzIL9rRB4s5BW2jSsZP/BhewykiNVjhhJoLhPb8KanB8NbjVFItJh6KurKfr5QeygFKixUbGg==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr13896864pla.271.1556920963689;
        Fri, 03 May 2019 15:02:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n11sm3403981pgq.8.2019.05.03.15.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:02:43 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 01/30] mfd: cros_ec: Update license term
Date:   Fri,  3 May 2019 15:02:04 -0700
Message-Id: <20190503220233.64546-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update to SPDX-License-Identifier, GPL-2.0

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 43bee4f7d137..6fa508643da3 100644
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

