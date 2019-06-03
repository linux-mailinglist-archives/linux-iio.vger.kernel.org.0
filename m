Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8AE33830
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfFCSg4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:36:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42626 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfFCSeK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so7509523pgd.9
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yT42r3h0cAw/2mpRzLZAzdkYnaKrCVtoe9m/CkNDjI=;
        b=luThx1kXsf4yDgGgnPNd2OH8HzsCff6ZKCEi+2VCHrJ75re5/gzXXHR9iqMrlk9zc1
         syVFTNJw4a6mb1UbFwCOJfq9ojOWzOyDtXQbqDG03auwMlQqIqZTYsXlrPq+WshXxsCb
         eB0Z/bSYyuBnzsUHnAPYN7ieIK2jRttxDmhLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yT42r3h0cAw/2mpRzLZAzdkYnaKrCVtoe9m/CkNDjI=;
        b=FJVKkZHAErXvPMq4qpRdU1UxWB7PI9VjK4NjJQd6DL1YbHd5IwoNXAmpe+UqsPHYN7
         pvZJj5hNTxoIh1V4k8/q8zjWgBFAxMdmraiudxnfO/S+LDh4yjboMhjC61SvTUIJPCOq
         pPPtuVu8UP4Ys7O3UuxRAqAlPXTha0NCT2ytQE3BwmJrti0qd8eOO4BacM8w/CNrBVe4
         4/L/cdS+Mv44++RB6wLmPlBybhCIDp8LVL7u/zEgC6iBuWYnhfjaht72H2gc2t8EOF9N
         rP1r+t33n/TliMweV0HGv12kSVamkd7YvEA+HzTdJBntY/dia4VuA/WFCYUbHOzEPayw
         NLmg==
X-Gm-Message-State: APjAAAXJsW2Oz3Tgaax7G+2Ldu+XUpraGtvDhyMRijngyq7l9n8EOeiT
        3KD41ustEImE2CcyZ386y3GSbA==
X-Google-Smtp-Source: APXvYqxfndY6StSeMuggFZiuQpa7Krv2RQ7QOAYlgAtsZu5E1HbYKA0/gGTHCbhxTxblEioudV9blA==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr30294938pgl.103.1559586849654;
        Mon, 03 Jun 2019 11:34:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id v64sm7234518pjb.3.2019.06.03.11.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 02/30] mfd: cros_ec: Zero BUILD_ macro
Date:   Mon,  3 Jun 2019 11:33:33 -0700
Message-Id: <20190603183401.151408-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
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
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
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

