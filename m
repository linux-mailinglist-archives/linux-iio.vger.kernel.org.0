Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3918EAD2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCVRY0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36617 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVRYZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so4848200plo.3;
        Sun, 22 Mar 2020 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Krx2PNpOiKc1mA54l0I3onUfFElu/EGLxiOWDjWy06E=;
        b=t1++tm0eML5cs8hohL+CrKoIo8MsGQbGNxMBJSrYyniaKJelGjfC08PCmkzpRoAc5H
         Vm4rwZHIbY5btYWsHg5vlCm+iebQCr7pdmCF57745PkB3uPPUixSsi7obwhZEZIVOZQJ
         Bvpl8CSD5OWrrbFh3mKqtuX9x/qZOI7cZu3EXW3H1OnwbNG2bRgdDrw7yZforRKpbJKL
         MKxqEfirg6o8cOCaMhm+FbHzldk0JoUaN8nBA2u9+h6GwP/TKJsGFtRy9DXCpXEQgq2c
         2GVhxn3jyVg5Wg4To3Lg1mWTNG1mf1F1vfT1mgdewF4iJMdPlQLm4nMy7/TsJB8mo6bO
         fzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Krx2PNpOiKc1mA54l0I3onUfFElu/EGLxiOWDjWy06E=;
        b=M1jw5ng1hIiY3wcX0f57caThDaI7muVpuis8T5r6nAF0lp/aZeWqFO3lKH6HulOWw+
         dXiIalUCSJ4rAAQ+uxxSo9bnFalx+A8lva46jG+Vti8ZEAi+2DzjH8nn+P3g+ZZmjt7W
         rz1jD3Xct//Knar9MjDYCmY1dha3BXiwuM3fMd9vooMKxOm8CKhRWdEKOG9jSkbN1qDv
         Dqbg916PCBfnvWcjSYAH0EZJizOGcw9GxrcRhM63FFFnSQpo9RJ6Z/fDvOAZ1hKH5EsQ
         LkvEMEu42agFpMKMnJdes5g8pS9EqAmr694/TfVbVO7eRHXZ6e8CKptfT04GqcSlslLQ
         fnYg==
X-Gm-Message-State: ANhLgQ1NFWpKDSx9W/HRRNM9kl87h/H5Pdo4caLEkykhrgDUVzfQ7mS7
        GZ+seuoMFQNjvkHlNRGpRd9DX40GSVI=
X-Google-Smtp-Source: ADFU+vvriGUJVzsQgeERmOmIQA1NZRWpuQ2s6hAiKzpCGa5l2HD4oqxZfkYPzUwEqKTVehoMph9LfQ==
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr3309015pjb.71.1584897863842;
        Sun, 22 Mar 2020 10:24:23 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id o128sm11422418pfg.5.2020.03.22.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:23 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] iio: light: st_uvis25_spi: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:14 +0530
Message-Id: <45d5a4bf468c490522d55f5c763061976804bf67.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Utilize %pe format specifier from vsprintf while printing error logs
with dev_err(). Discards the use of unnecessary explicit casting and
prints symbolic error name which might prove to be convenient during
debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v2:
  - Rewrite commit subject line outlining the usage of %pe.
  - Add a separator between regmap and its error name.

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/light/st_uvis25_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index a9ceae4f58b3..ae57e80a2e8f 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -31,8 +31,8 @@ static int st_uvis25_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &st_uvis25_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

