Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1A315D8F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 03:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBJCwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 21:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhBJCws (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 21:52:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7AC06178A
        for <linux-iio@vger.kernel.org>; Tue,  9 Feb 2021 18:51:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my11so2228812pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2021 18:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVS/BuBivcXTuFCgiwVRy4BRsx2EGMVlYR8Dmva3m30=;
        b=fm5FAe8uJoHztb8gNI5xr1OQmn/oIp7NRDMA/CQacI07FmE4FpQO/oMxTC63wybBOO
         BEQ0NnMv3/UUkZ13JYq6kc0B/F85cPqDOLQeqfue2jS2rFFQdlLnDPhf79jCKSoBjRUi
         Du0l9+uMx8INR3qMbUCpCWjSdKnp8ZLct4QJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVS/BuBivcXTuFCgiwVRy4BRsx2EGMVlYR8Dmva3m30=;
        b=BEplVU0SOTC3IckFZrx/+hDS8vt6NuVC0t1LUhJfjAZNbf6ixFXGyM1I/RBtbaj80A
         PkYm8xHziw9wWlofArfZpXx0PB5d+oYM6WVRpBboCdIILTkQnkSQez62vLlmBl/+W3Qc
         K26RwbueA+5pRzBK0Av5vDSztdYro5v6WRnsDLi079BhULTAxJ7thz9P5KWZsbBOvoDo
         9KpdryNGK3s3Ydk18789ItjXgBJHu0S1a5kQhos6QglRh90sKrrdm6oEkLMtsWNmSYWv
         SfAWbl7XLOBy07hxVOMPcVb/9YQ44eFSJn9HC7NMQCA1pdrpRh9mDRyUU0XyZ5Uzxy1B
         g4yg==
X-Gm-Message-State: AOAM532RxE7arqHQzLpSDP0wyFUtRZeivjcJ96qIHCsuFcwPf3+gEDx3
        cAqDwydSq0Xpzf58/DIrpuedqA==
X-Google-Smtp-Source: ABdhPJyQFz4+7shcJJFR7v7rKe8qerhkJpK3m228ziCU/kv+qW80wQcvqyEg6YSsTSpfhyUwZ6XNkw==
X-Received: by 2002:a17:90b:1108:: with SMTP id gi8mr958284pjb.129.1612925505805;
        Tue, 09 Feb 2021 18:51:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:58e2:748e:a316:9823])
        by smtp.gmail.com with ESMTPSA id r13sm139420pfc.198.2021.02.09.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:51:45 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v5 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Tue,  9 Feb 2021 18:51:40 -0800
Message-Id: <20210210025142.3609708-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210025142.3609708-1-swboyd@chromium.org>
References: <20210210025142.3609708-1-swboyd@chromium.org>
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

No changes from last time.

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

