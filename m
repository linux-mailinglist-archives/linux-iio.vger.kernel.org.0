Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8A1F4977
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgFIWkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jun 2020 18:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWkR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2020 18:40:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D31C05BD1E;
        Tue,  9 Jun 2020 15:40:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q8so225373qkm.12;
        Tue, 09 Jun 2020 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAUXZKtBQZj6B5Rk9FG9z3WffsCtrNY4aCuD4cUBdPc=;
        b=YJflalIkp0KvIL27dtyF6mJD8QQVEqO9eeK32hEzzrhc8R4XGR8zDIgNYhe8VBAFr1
         QTqZwF7AiUHee1tIkA6rcCjrc/Cw3JH/k8s6KsW86D49fqhCf7pIklHfgVRMZcUVSUc3
         qkXh807NBKX98Yq8Heqr8dhKk8fgwIMHXsWnzuLxHkdlMqtPtSYINZ+xopFGu08R+ABJ
         OajJ0AXZkA7g38Iu8m7ucC4WQWI90dbbo8jCBvjRA4JSHt+wYIIqO6N2bSIBlMZxkyR4
         CgIthjnT7BmDw+GBQ5z5VTJqF7eKW6VC6YpSxf+Rm+joTYNILEnSSOs8BaFF/4tbY9Py
         +0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAUXZKtBQZj6B5Rk9FG9z3WffsCtrNY4aCuD4cUBdPc=;
        b=HUFvKaokN03vg2vJqR5OA2q7xif9Ld8CEgPEpwXj/b6zw5MtjXp6h9CT4iUpetjcwS
         fXAVnvNeRplHx0jLZzCyzCFWRL1sR9feJL6Bh5NyOayHO9ikTEQQunlzgipFjbfTbC89
         pWuiKZTIrCpfBl+sDTndgtYUfAWLnU7IDmbGxlEFIWsl655EZsY+1WsvQYvHJ8qlDTtw
         SZtkZ+B6JtNjEanLQ/3kWRAUznJpT4Z7C7ow9Vy/s/lsnb35eBrjqxO5vmvDJyeEY9kR
         38sRwwghvKPrIoVXT8MO8IJj6dPqpL2V9BfQUv1eJoKdoreTNYl1fEWP8ldexLbS8Lag
         vDTg==
X-Gm-Message-State: AOAM532H+MbH6x/VTzKdmv+H+mo5k6VPNVS4oEPTAPWLk9uTJQAGkkev
        UdcyI9F5kWQW/f0eF8/1/Q==
X-Google-Smtp-Source: ABdhPJxLUvoEA0NFM0tB152OFCyhMpvWeKW4QTmDwJliy056wjYh0HVDJ8Hp7CgxnkyaKyjsPUhtVg==
X-Received: by 2002:a05:620a:4e5:: with SMTP id b5mr168395qkh.341.1591742416350;
        Tue, 09 Jun 2020 15:40:16 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id l69sm11282893qke.112.2020.06.09.15.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:40:15 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     Keyur Patel <iamkeyur96@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cros_ec: fix spelling mistake
Date:   Tue,  9 Jun 2020 18:39:52 -0400
Message-Id: <20200609223955.107506-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix typo: "tigger" --> "trigger"

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c831915ca7e5..4888fb23d801 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -352,7 +352,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		} else {
 			/*
 			 * The only way to get samples in buffer is to set a
-			 * software tigger (systrig, hrtimer).
+			 * software trigger (systrig, hrtimer).
 			 */
 			ret = devm_iio_triggered_buffer_setup(
 					dev, indio_dev, NULL, trigger_capture,
-- 
2.26.2

