Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F23183B0
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 03:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBKCqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBKCqp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 21:46:45 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E3C0613D6
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 18:46:05 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r38so2719274pgk.13
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 18:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcZ1R2Cs5It07ydhR+GP1wIlvAE/kw9u2Y/CgRT66lc=;
        b=HknY8FTP3y3jVvqn6UoszlhPs9w32uzOIDWfOW+KOJpY/pElDLhc0aHjjkLNONT2Uc
         h7jPps8AP5BtbSFxkplTxNVabAaXGF3LOYe+DE4cRfRusnKPnIZ9/GrzGoOQRuXPwDnP
         uvdMFifwz92NLSFU/K9dZX1G46h2NvfmmOQ1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcZ1R2Cs5It07ydhR+GP1wIlvAE/kw9u2Y/CgRT66lc=;
        b=p8yafidgQxvs8b5Tdy/CV97674zY8y9x09xw8DXsxmJ2PrSV9IgiosaE65GBJPvZDj
         /QAw4WSvOsFO4XUuV/Jy+NDYzgS/+4CTUTXA3UnADmpDARgBvH7oXxaBJMJ+m5/heqfN
         zVPdk3GTx8b67+bM3lHxDDKZHFxKQOXOxXNlhNmQ1+pmNJz2mV9cAgrmgkEf/0FzwgEF
         IMy7nUj2W3yYOkpRkl7Jcg2w058dWMD2Y9p480ac9xvXfQCYLkpmq8Wct5MOPmax7kBm
         0D30Ig32i0412Si4ts3aYmYbytF0FETU0sJYDStuqEY61GL8WhSqwxSYHOxpXJ1HQMaK
         RRCg==
X-Gm-Message-State: AOAM5328nrVzcbBBtzLA9NY58ws95eVn8yCNc4RBjIHEk5nb9qKSI5iD
        SKYTQ4QTle6NERCjXkEF7AjOnw==
X-Google-Smtp-Source: ABdhPJyF2y60ilyDWvj5GQI3WiVnx82mRymBgQgXYnAfHzaorvP6xOUq6twCLMmw0P7ahKqAY3hGMw==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr6043875pge.156.1613011565204;
        Wed, 10 Feb 2021 18:46:05 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5533:1106:2710:3ce])
        by smtp.gmail.com with ESMTPSA id o185sm2615920pfb.196.2021.02.10.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:46:04 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Wed, 10 Feb 2021 18:45:59 -0800
Message-Id: <20210211024601.1963379-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210211024601.1963379-1-swboyd@chromium.org>
References: <20210211024601.1963379-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some cros ECs support a front proximity MKBP event via
'EC_MKBP_FRONT_PROXIMITY'. Add this define so it can be used in a
future patch.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 86376779ab31..776e0b2be0e9 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3457,6 +3457,7 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_LID_OPEN	0
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
+#define EC_MKBP_FRONT_PROXIMITY	3
 
 /* Run keyboard factory test scanning */
 #define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
-- 
https://chromeos.dev

