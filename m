Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA6AF257
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfIJUiS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 16:38:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36217 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfIJUiS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 16:38:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so1014877wmh.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2019 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eR/0axm8zLFl0YVtPR86evFcdT0WPG5rKl+atSE7D6Y=;
        b=p+xBxcw21SMbvQ2x1gBwgaOuUJ3vIsBl+Vlfhdm7itIlD6Fp1X80OeYkK9ohbsSv+P
         5Fj/jzPtJ23H/3UvaupSKomLbaYg72bsVxhPQAXwTOvqbnOHffeIw9y5JhlhWyS8+Frq
         7imRpiSR62MCGfDz1gwbAlz4R1mdHcWjHBpHTi+R9AYxphz9tbxT8+ALdYPJb7oi8RO5
         kDATJL8agCeqZ40u0ikrdJhA+0ARs7O8c4DhlO5JuFvWM7wo/QFyiJBqBqlPAZ1vkbWd
         CpuF5v8AX8kM7l7zP8krxYHq8elMN/ua3QHOQM9CeuEC3gr4jN+v7XT85ZWbidGi1wqi
         ibjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eR/0axm8zLFl0YVtPR86evFcdT0WPG5rKl+atSE7D6Y=;
        b=mA+RVKKHvAFPLimzKy0XH0fi0JQqHl+XqR5+EtcIWvNbN7Bz+S/FxOXd/JXJ5+i3tE
         3Svw3ym5ow41CLNdHk0OLUgLqJ3xKF2MxKQnEpZrP354tCk/+mhGKMosvFM7yVM9Ez2r
         JlJobrkuQLp2MOpDYa4r7C8Gx0iIxvNNN7U2r7O5bf8QOOdvQzHgCvov3wKHkVTYb6B+
         5mQSNhRIEhp08pu6y6WtL3D0zKKKoue+EsbMExbRwuMzmm3VNQcluvzcfSK8izW9CqVR
         7H7/AzHZMUCopj0bQSYb2db6aLCK97xr9h+c0lmd4eta4mtxZd5wd1Af5YG1x/yfBeU6
         Ye5Q==
X-Gm-Message-State: APjAAAXNBq2A+lvDNnV0xXhpV6e2KJYVuGocku0C7JO6IzxuxpmD38Oa
        aH9YNVQrlzJvevOIxE+GWj4T3NkL5Xw=
X-Google-Smtp-Source: APXvYqx6c8tjuXEe8CXLnpv/Djq6IZXfCddKcSg69m7/2S5v9oc2H3xv8kyfY0rHTp2jIxTkq/lEHw==
X-Received: by 2002:a1c:c589:: with SMTP id v131mr998213wmf.163.1568147896395;
        Tue, 10 Sep 2019 13:38:16 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id w12sm28820220wrg.47.2019.09.10.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 13:38:15 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: light: bh1750: Resolve compiler warning and make code more readable
Date:   Tue, 10 Sep 2019 22:38:14 +0200
Message-Id: <20190910203814.31075-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902113132.26658-1-kw@linux.com>
References: <20190902113132.26658-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Separate the declaration from definition of bh1750_chip_info_tbl
to make the code more readable.  Separating the code will resolve
the following compiler warning that can be seen when building
with warnings enabled (W=1):

drivers/iio/light/bh1750.c:64:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v2:
  Made definition of bh1750_chip_info_tbl separate from declaration
  as per the review feedback.  This also makes the code more readable.
  Updated wording of the subject and the commit message.

 drivers/iio/light/bh1750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 28347df78cff..adb5ab9e3439 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -59,9 +59,9 @@ struct bh1750_chip_info {
 
 	u16 int_time_low_mask;
 	u16 int_time_high_mask;
-}
+};
 
-static const bh1750_chip_info_tbl[] = {
+static const struct bh1750_chip_info bh1750_chip_info_tbl[] = {
 	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
 	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
 	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
-- 
2.23.0

