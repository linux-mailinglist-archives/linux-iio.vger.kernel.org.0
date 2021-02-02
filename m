Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5441D30CA67
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhBBSrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 13:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhBBSpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 13:45:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7B9C0617A9
        for <linux-iio@vger.kernel.org>; Tue,  2 Feb 2021 10:44:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y142so6960368pfb.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Feb 2021 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcZ1R2Cs5It07ydhR+GP1wIlvAE/kw9u2Y/CgRT66lc=;
        b=VYmTz07wp/W2T6AIHBch50I7b80rgK6rPLISYoCX8B3qrjfct5m/pHGTM8ZEFlRWxP
         JaNBNuqO3M/npUgadCUE3eiDBQMaljZwouou+O/CnBYwkJGkZ2QEq9sBmY3wSHtUIyNZ
         XJVcOKvBpIKGhpM9PVFlwm2V6igS4yy9d6YBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcZ1R2Cs5It07ydhR+GP1wIlvAE/kw9u2Y/CgRT66lc=;
        b=GpniR+aH8qnkZDOqm0Fb2juigVo1nuC6rLi8e5f9vaASH4Wb0gMGGj/ZPJrFSnPYXz
         A9DDibzlobrRjrKM1d6G2jJ/IP9jpkd3OLByLjjJ3j0lFgB/iFGFPxslFxMLzfVDjrbh
         0wnIjfo4MvVZGwJZ0ofpUTWsNex68P1GWB/rQJ8A6+G7pviwBlEPW2AZzUdlEFq/a1QC
         Q9KiRKriiZ4dvWnvrY6N5aXJcVyt1pp3Qu92XbPBMnR46leNqV1/hDVXNHXphK59DsNR
         vo7rjLrZ4GsFicCcxBukmyM9pkduxwgpL1aAf0Qxx1ztdaWhq1xBEUWWgckPjNPq53KW
         +P0g==
X-Gm-Message-State: AOAM533esILdwyxhcXaauVh+9V5ndIEZpNUqGktXmR2zy11WQySYgil6
        V+nvfjfcfX4jEdGPmrNBfM1MSw==
X-Google-Smtp-Source: ABdhPJwbtDki9ZfM6WAIJe+GVN6ePJCho/tH/9JtbnD5mVkJCrlCF9xvjq4sRd7rlHXAzKPtY7bl9Q==
X-Received: by 2002:a63:514d:: with SMTP id r13mr9963835pgl.287.1612291477491;
        Tue, 02 Feb 2021 10:44:37 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id b21sm23159859pfb.45.2021.02.02.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:44:37 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Tue,  2 Feb 2021 10:44:32 -0800
Message-Id: <20210202184434.42644-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202184434.42644-1-swboyd@chromium.org>
References: <20210202184434.42644-1-swboyd@chromium.org>
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

