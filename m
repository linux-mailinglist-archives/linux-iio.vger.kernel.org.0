Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741FFAD97E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfIIM60 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:58:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36200 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfIIM6Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 08:58:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so14590628wmh.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2019 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SWqvjzW03Sj0Bc8IBNZOEFlg8tVyen3Z5dSXhOfAqDY=;
        b=ixGLBe7ft3m0iVwf1bRhY5kwUkd33lcsebEXHbG9pA4T+FvKtHZdKXByBHnOYgbFwY
         DvN6vKoR7bRKxhZhIoltwu23QPxNX4Rvoj1Gj8q9R6SzseOvo9A+jOPpFgjBBSQBmH47
         9wVs3Sv+VtJFcmWcD2PPtPv7GUXJ7nkHPrvWlaowAaS96FDUWzkYUoRq+/gy5LTLNtNQ
         GM6+x5xXS8DG722Jncn6hiQGDFRVuo4FqBKzraiNNCXs1f+GO3x8FGljx8gGiPBkj5BA
         cAvOrznYq9Gmiu8CZ7L5jVK/UPvijhDoukrTf5iilm3rHPuZ2jWpHD1KHX/gT5aYRnHj
         0neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SWqvjzW03Sj0Bc8IBNZOEFlg8tVyen3Z5dSXhOfAqDY=;
        b=f55NqXa58T2ZVBpNTvgwCezoz3+qEnitDFvA/B5jEVKQG6jubuXSekUL/edOeE1rvD
         JrH1/1FbHDm5jnwqjCdtzdgz4SJXsotBkkfphzKX8IChJ6syQxqsPzfm2CWJYQQgbZHq
         6pRoM1Z5cTNrr/Uo+phlHrBHrII6d4aDooq9DvOZH/ALleTTQsTAl9bHuikJtz5pC0mO
         6NRdutVPotzw4wB+16bf3VGUJyb5+iSLVkeo4E+Zn5XS81mt1AD6FbL/OSlS4WzKoBon
         sCegNI6SpIcg7+dic9nfPqG8JyUnSRqnBZvSsycXPRYdF7lEEfhw+YgYxXZsKV0sQaVI
         PQ+A==
X-Gm-Message-State: APjAAAVejM8AYU+lVdaiCofrCs10GA3zGmMk2CzxGTBwtZwWqdv/MNFy
        02MeynlW5A9EEa62SR1b7o8=
X-Google-Smtp-Source: APXvYqydOmS9bM7b5gs9fmkTnWXtle2VE2P68bQTC1Zg+o4nUldAd/x0dcyxQlKWtrSZdYiVa8VjHQ==
X-Received: by 2002:a1c:d183:: with SMTP id i125mr20203585wmg.1.1568033903700;
        Mon, 09 Sep 2019 05:58:23 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k6sm29953330wrg.0.2019.09.09.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:58:23 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     paresh.chaudhary@rockwellcollins.com,
        patrick.havelange@essensium.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH] iio: max31856: add missing of_node and parent references to iio_dev
Date:   Mon,  9 Sep 2019 14:58:17 +0200
Message-Id: <20190909125817.17882-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding missing indio_dev->dev.of_node references so that, in case multiple
max31856 are present, users can get some clues to being able to distinguish
each of them. While at it, add also the missing parent reference.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index f184ba5601d9..73ed550e3fc9 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -284,6 +284,8 @@ static int max31856_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->info = &max31856_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max31856_channels;
-- 
2.17.1

