Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D89188460
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 13:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQMgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 08:36:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33899 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQMgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 08:36:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so25403289wrl.1;
        Tue, 17 Mar 2020 05:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3qXPaTU6PrsJxaBR+W/miPqJdXIPm3n5FrZLJ/cohk=;
        b=aII4WxDC2xPoJw6uOldC//Wh7pC7AuhV8vqxZjipKLGzQVgPN8B//5CIxStHerKRVx
         iHo22AxANVinBFsI+BUr+gpqalB1s0ESHlWZqnoVEQpNPCANZVmQC7K+3X/J8ls3mBk8
         eWVhZY7A+XWvvVgl99TUxhyOpCP1qKfWcFnCD3v6onHtyqDTwXkKlDv/0nnrPrv1FACm
         dADRmY3AolNspK/vCAsLE71krGiBzQj5Yd6Tmx4Jadi0GsCd40gyHQEH+j6KIItL8lLl
         bxH1m8bQy7WUHD9GMVANFv/eb1DQg5aE2VvFpZw8wvyH06VXK5GJ8JmdHLMb1SmMdalD
         lPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3qXPaTU6PrsJxaBR+W/miPqJdXIPm3n5FrZLJ/cohk=;
        b=oZ+deYdNlaRdfQpNyjNtFEJDsPHxMkBVCV4PHCLTJejM8se1o9JHPe2rUv/rwlzflK
         oT8MP/ZxGznMrVY/D5NPB98wzOpr716tWwv1NskhRyB5HfRIpjuGAdZSfcyfXoy8XTgC
         QkiqN1mJhNUFw4gqNkYLOJwVAhOJXiXZIX9LOVF0dl0DkA8rtw1lUxfqABRoM/b4829R
         81Reba77MxOrIt01p5Rffm6Dh0TydLjmsf+aT08ncbqkw7806sGAFZ1AS7oJBL/WIWHQ
         RZynXN60zdlbThOJtrAJZ8RDuibFX7kbd3lp/P5x4c9iuMb0uBHOIJkw6W5WQ6ziRbxY
         lwtQ==
X-Gm-Message-State: ANhLgQ0QY8+wQ0QF7VAAfZ54PdRWaouOy3MbnQLhV2+sLSXymzSVOTod
        gQfwczOhgCfKZ4oaeaDf4HK8fzFL
X-Google-Smtp-Source: ADFU+vs1G4RxuyQdAwdPDAYcwg0CpbROQCXwC93f1yUlLtoWWfR7HwqM40WwmRmfUDEjloqYdmijAQ==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr6351863wra.157.1584448589815;
        Tue, 17 Mar 2020 05:36:29 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id a184sm3961194wmf.29.2020.03.17.05.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 05:36:29 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: re-introduce bitmap_zalloc() for trialmask
Date:   Tue, 17 Mar 2020 14:36:21 +0200
Message-Id: <20200317123621.27722-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 3862828a903d3 ("iio: buffer: Switch to bitmap_zalloc()") introduced
bitmap_alloc(), but commit 20ea39ef9f2f9 ("iio: Fix scan mask selection")
reverted it.

This change adds it back. The only difference is that it's adding
bitmap_zalloc(). There might be some changes later that would require
initializing it to zero. In any case, now it's already zero-ing the
trialmask.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4ada5592aa2b..5ff34ce8b6a2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -316,8 +316,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
-			    sizeof(*trialmask), GFP_KERNEL);
+	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
-- 
2.20.1

