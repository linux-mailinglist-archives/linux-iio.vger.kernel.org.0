Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7624A226FA0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgGTUWv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbgGTUWu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 16:22:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925DC061794;
        Mon, 20 Jul 2020 13:22:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k1so424914pjt.5;
        Mon, 20 Jul 2020 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KRP2YYdI7T0EhHxiCZP03QeZpOTCB3357aMOLsKRCT8=;
        b=YQ1fimAkktpJg8SdUGFqufOAvdTM8lkuxH89v+ZkBZk7Ll/7dK8KevMeDNByIXJNc8
         i/Qp+1Y8Yn1WkhDxCb+6SnHYYdj+OrEURiHJHVEMc5ZY8vmBZBOJSSXmFSsxY/pDtJlP
         USqP6DQ8bDYlHJBvbWIcs9IBNXd/jlcapQMAjQYXNGSWvVDrbCHreYlfjbASS8SRQoh/
         Mgj68oJqSpKf0UyzjCISIVHEL0TCfwVQVinZfr2Hf3xtHfBOoU61OEkWAyIpJJEVvYe7
         0i91/h3ePuyyLxXBPEOmx5AuIVsHeiezOugmWc1MEvXqvdkMy7PiujcT/2yA8wqarNDf
         xL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=KRP2YYdI7T0EhHxiCZP03QeZpOTCB3357aMOLsKRCT8=;
        b=eMgYeeLxHbzB8Qr6KFF9a7KwqV1FgzPDgn88Ei0orCH2TGoTf5K+SHUWvkUUXtQQSB
         tJ/nI4mg/Hy2NMjYR20zkIYaDzA94OiblsOVzvy3iQTTVoQ9e6Zz8R6WD/snTbkfgqxS
         usIgA/kbvODB4RtQS78JIcQsmNRhClLVgJ7xq4AIFkn6BHgMw2fiT7c/P7/RaBqiG0Mx
         D+R2Jz4j/dhpwT2qxOrav+j0nb7aBVmkJmH2Py/erFXxyWxRirDrKUoI7xsvDBHt5/lF
         SPgcIU0h9qkemFgvkUlIOi6nopfAtZOOPDpyxSZ63osH5iOsWTcirSEilJ33+5iDBRHC
         NG9Q==
X-Gm-Message-State: AOAM530ezYjuGHAkuVClpeNmhls8LR/1IQdGY1SYdvs3f8vSDtqlN1nO
        +FB7ZQbIWzec0RnjQfZdWEE=
X-Google-Smtp-Source: ABdhPJyx1Ai0r+hOFgm8OQmv/zGlCKrZorLSQ6321OwETwHtfNvMLw2Jnve2BSJLd3oy/UV7pjlCzA==
X-Received: by 2002:a17:90a:ad8e:: with SMTP id s14mr1192363pjq.36.1595276570174;
        Mon, 20 Jul 2020 13:22:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2sm18216769pfa.110.2020.07.20.13.22.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 13:22:49 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/4] iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
Date:   Mon, 20 Jul 2020 13:22:40 -0700
Message-Id: <20200720202243.180230-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720202243.180230-1-linux@roeck-us.net>
References: <20200720202243.180230-1-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A follow-up patch will extend the number of errors reported by
cros_ec_cmd_xfer_status(). Specifically, the function will return
-EOPNOTSUPP if a command is not supported by the EC. Prepare for it.

Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index a66941fdb385..e3aff95493dd 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -73,7 +73,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 		st->core.param.sensor_offset.flags = 0;
 
 		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
-		if (ret == -EPROTO) {
+		if (ret == -EPROTO || ret == -EOPNOTSUPP) {
 			/* Reading calibscale is not supported on older EC. */
 			*val = 1;
 			*val2 = 0;
-- 
2.17.1

