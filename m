Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDF33B4B7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 14:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCONhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCONhi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 09:37:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF79C06174A;
        Mon, 15 Mar 2021 06:37:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d23so12106121plq.2;
        Mon, 15 Mar 2021 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiSNz4Bld/PQvfFvdTn55/ssLR/DWX7rfzFxr95WxDc=;
        b=eOv37JZH0OP/C/ioUhVtLwq7FJAL27YlfPn6YNIrDEqXc+Q8bS7NQn40DR1fAHdvwn
         uoxTKoUA9IsT9FcrTFq34tPRCQnw0qU8lQqqELwNXk6cPZKilRGcTSDS0Msun5k2uGiC
         AXidZ8Uxu2Q1aDy06pFPX8+EJIwbmTi5KKjNG0ZSmi21AA8EbvUYmekUD47Lh579G74M
         S6bX7yK3EhxASOBOS5WCleSZ5L7kHcZdBw9yMwYeCiyA68Ggtx7noGi/c/9OASxc1kev
         YrpPupYrV4w/P9rOHhoyzsXAkoCcx6bbiP6DKA6f2CLXUL7rgTGQhXhz26B9ePMG4wKE
         yVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiSNz4Bld/PQvfFvdTn55/ssLR/DWX7rfzFxr95WxDc=;
        b=lI4YD3HSSQYg1Zd7wVbqX2LJX83BAqtt2x1+xOo23mlAJplra7Ct04FF6bM8sntTVv
         8GZMaCB1bC0f6QvP+/3Pj3IVXMnNzWMW3zJKsN4/eq1E3RiQbth1B74Bz0VD7w6KytAU
         HtKnRYfNJT1UiOvnMCog4waoq44lfQ8nfpLpoNrFlRH8M0y+AnUAOBOACb9ws+drZc++
         Q6iAkCzj8/JUny+Kr8TB5Fbsi8F3Aq/XjxjipqFTvAjyhkrazEUfvSHbcCPEK0JecpY6
         f/Zngx7D8tK1g91Lao+uQAXbqjFaum8/Lt1cM6eg24qj+TK/E64hCkhczfzNpkajtxB7
         0/kA==
X-Gm-Message-State: AOAM532c6rXyPm+8A7yyqFfHAgcZfu6EiMaL4EW3EIHa+MLL/3LHstkf
        7Nkhwq102acJhwAlbFBR7nc=
X-Google-Smtp-Source: ABdhPJwYElLS4W4P9UWY2WllTnYNoyDeMolaoAwDW5b7WyepJGoB6xBbtGk2c8sNknfglK21kPEaeA==
X-Received: by 2002:a17:90a:4104:: with SMTP id u4mr12639092pjf.81.1615815457605;
        Mon, 15 Mar 2021 06:37:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:89b:3eb5:a73b:575c:3e6f:f296])
        by smtp.googlemail.com with ESMTPSA id z11sm13925851pgj.22.2021.03.15.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:37:37 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad9832: kernel-doc fixes
Date:   Mon, 15 Mar 2021 19:07:11 +0530
Message-Id: <20210315133711.26860-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes a W=1 warning.
-Added ``:`` to lock parameter in 'ad9832_state' description.
-It's a reference comment so removed /**

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 74308a2e72db..e31ebba47a3c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -86,7 +86,7 @@
  * @freq_msg:		tuning word spi message
  * @phase_xfer:		tuning word spi transfer
  * @phase_msg:		tuning word spi message
- * @lock		protect sensor state
+ * @lock:		protect sensor state
  * @data:		spi transmit buffer
  * @phase_data:		tuning word spi transmit buffer
  * @freq_data:		tuning word spi transmit buffer
@@ -248,7 +248,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : len;
 }
 
-/**
+/*
  * see dds.h for further information
  */
 
-- 
2.25.1

