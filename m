Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD91F81C3
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jun 2020 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFMITY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Jun 2020 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMITX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2020 04:19:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F0C03E96F;
        Sat, 13 Jun 2020 01:19:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so4694254plo.6;
        Sat, 13 Jun 2020 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cKZcMqArBz9X4rHGW4KhCsa5aMipNmtz0BtqjL31pOg=;
        b=HY64l0bHbuLUB4rEv2+YOeiTdTwoa7FNhGB7qTI5yZR+Cjrqstc39WEHhIrNk+VFeu
         Q+ZgZQswm7Aeuc6/00c3ybDLkrukuXouazZkKOAZTfrZong3Gnoo4qOjs/U3tD/E5+IX
         211CW+0du2Ol1aGBFxE4J+jt+OXiFDPa5ksk/w6vpGwex6E8Feq+Q+5zVVEjkQjcg1iJ
         2UuLI1Ta05PJmdfuaMMqXI5eTcWWkLuObcof/m1eLR/1uKnf/Q5DFOuYGJkPAfhoQGZO
         aNge5COJvtCp0Gr6Rp83s3oUf+hfZkaLlbpHpn7JlMst84LDIamZEnp+2W40k7mBwJyk
         y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cKZcMqArBz9X4rHGW4KhCsa5aMipNmtz0BtqjL31pOg=;
        b=NzkRMtUmzm/N5UAHFCqWMXdyo/7odRr7t35uXJCPnnSt7omW7G+Idi5riDr/iv7mwd
         Aax7C4m4yMbuKxsIhJHxFhij0d50u5HK069qHILcnAqTOak1hZAilDCvqCWucHG6OlgD
         xJc/TfpsZur86LsAbYwn/peHI5JSW9WAdDvrwIeqGGZvSxz/ksxAJerzYL3RbMiUGi1b
         j2ErPLD7CSIe60R9bGy8pTqcB+QaF0LFRI/Nj8xJfBy6wLvqCTt+G6hegfknhEYDmBSo
         ynSgyDZC6BI5l+kGQy21ZaS7ehJxaHOgtv0W9+H8gOtWtA63Em3mUUv41rKUHI/Pb1lV
         jOdg==
X-Gm-Message-State: AOAM532ovU0Rxvd1fCMOH07hyNjnKAFWi+xiwWICJIHhLxWQ0Z3wG5XK
        RE7BcYzWC3+3sIczZnHPl1c=
X-Google-Smtp-Source: ABdhPJyGmQrKnFQWVG5fMTU5uipONzIFT84K/obEhdoOMHU44yyZFYfq4TbyU3sS3LLIOCT+Gof1Eg==
X-Received: by 2002:a17:90b:1108:: with SMTP id gi8mr2615297pjb.144.1592036362086;
        Sat, 13 Jun 2020 01:19:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:5:6ac6:29af:f9d7:e4ec:8901])
        by smtp.gmail.com with ESMTPSA id nl8sm7633203pjb.13.2020.06.13.01.19.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2020 01:19:21 -0700 (PDT)
From:   Mugilraj D <dmugil2000@gmail.com>
Cc:     Mugilraj D <dmugil2000@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: Replace symbolic permissions with octal permissions
Date:   Sat, 13 Jun 2020 13:49:01 +0530
Message-Id: <1592036351-10166-1-git-send-email-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Resolve following checkpatch issue:
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
using octal permissions '0444'.

Signed-off-by: Mugilraj D <dmugil2000@gmail.com>
---
 drivers/iio/accel/bma180.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 265722e..b716347 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -531,14 +531,13 @@ static ssize_t bma180_show_scale_avail(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
-	S_IRUGO, bma180_show_filter_freq_avail, NULL, 0);
+	0444, bma180_show_filter_freq_avail, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_accel_scale_available,
-	S_IRUGO, bma180_show_scale_avail, NULL, 0);
+	0444, bma180_show_scale_avail, NULL, 0);
 
 static struct attribute *bma180_attributes[] = {
-	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.
-		dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
 	NULL,
 };
-- 
2.7.4

