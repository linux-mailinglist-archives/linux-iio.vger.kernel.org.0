Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB82111ADDF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfLKOjr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfLKOjq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so10877412pga.4;
        Wed, 11 Dec 2019 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhXVAnhaL3dF2Pk0jAZjmHL842tdRou+nNjmrun5mDI=;
        b=GfB0dMl66LMji7iSDluDDgU95hFyrbLyBDa8g9R6tZQrYvzznr7sbD0EI+zx9PZa2a
         UPcDzuUIfU+mXjTqpj1nB/cZRBTziPKDINSxpV160A8qKLUskV7icNyoDpzGtFJ/W4WG
         2iBDG2uBtjRDggXzegIdkZ21vawseCOf6qaPFh0AlPaij/VqPMZ1PrqwB4igUsER3fw9
         MGwC4Bw2o1XiM61vnkvQn/3OuFljldg0RPznpVhmrQCbj2V20rgrMUe4mQ5FtASiBaVH
         t8gKx1S12ypjJZhGV6bC07NGCq71O6eQQkdVJ3Dpwjy0E0oVLRZkOjg1ya4ol/N4tXPC
         gHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhXVAnhaL3dF2Pk0jAZjmHL842tdRou+nNjmrun5mDI=;
        b=OYgwxc51CziZLzIjPtIP3tiFKoA+eSppIzupd9iGkYcQsYKTMSYNEBXllHqMJN1wgD
         U0LUmk2RSEHZnoPy0kGzF9wTQ2TM6R72ax3YqduEO4/10uzyh+ZOzEl9wY7cWUuZuT6A
         dGmUQMbNByDE6DllEyauP2d+aSY4sct18JTwe0ynYNkfg1cmWZ1+XUAo2sMqVZfp9f5D
         F7yqPD/RVwVMJr3gATwbJY8yT4zEoECAPgLhjrn/ikxfwM65YfWQci6xDICQZhkrZykz
         6MzfiWD7U/2RnXlNLRr9hP0uO/29vRY0+EYok5PFz+X2sl2hPoVEzWnP2h/hQeBRuu+N
         pgUQ==
X-Gm-Message-State: APjAAAVoAA2Ph83XsPeZ5PMuwkoVbTX2VFdpbbLIw8kPFct03rEYLcpn
        2UCnhjjii+YOW/v99i4K2V8=
X-Google-Smtp-Source: APXvYqwSkDQsttnam5DXc1gmHwbz0oD5Nrbbl83FHdZwnnYrsoV2z/G3N/ntf8aYY+yXSPtKkfWXnQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr4054521pfy.166.1576075186342;
        Wed, 11 Dec 2019 06:39:46 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:45 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH v3 11/12] thermal: armada: remove unused TO_MCELSIUS macro
Date:   Wed, 11 Dec 2019 23:38:18 +0900
Message-Id: <1576075099-3441-12-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes unused TO_MCELSIUS() macro.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

 drivers/thermal/armada_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 709a22f..fc6dc10 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -21,8 +21,6 @@
 
 #include "thermal_core.h"
 
-#define TO_MCELSIUS(c)			((c) * 1000)
-
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
 #define PMU_TM_DISABLE_OFFS		0
-- 
2.7.4

