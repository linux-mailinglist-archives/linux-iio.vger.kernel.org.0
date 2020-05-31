Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263CB1E9511
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 05:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgEaDCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 May 2020 23:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgEaDCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2020 23:02:18 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15DEC03E969
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2020 20:02:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so5950657eju.2
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2020 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfmTntAEPWRlQlCg5U4Mzgy/d8I2dp1hdtZBqlTws2E=;
        b=F3QSNltsZrT6qJJ7BiKFQDNnHVexqL1cxuXZfvugt6vmRoO39NnkLV9VU6pq540ldi
         Il2uV9E36zyw3Diyyocz57yTdYlScgu26cUzpgbn+N0XdDmQU27SwW+r6jmV6mPnmRGf
         ZQ79UMoCdCJ98+5e/lUgBSYQ3Xba13pqTdkFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfmTntAEPWRlQlCg5U4Mzgy/d8I2dp1hdtZBqlTws2E=;
        b=ua91YnTyS2WP3GbwJjZW9DqdDp+uo3jdsABJRqlmEbY/Bw8OZd6GL1UIEYGR1ZbExY
         lBZfQ5qyX2oyqpZ4KIerogii2fSVihpphv230czYnPtovg6hWgJpmnOVrJu8JPDu0lC0
         IZn3SSsLWdFqBvWeQzMSxBWbZvI5c/3QTG6VM10B3cL3c8ZGgR9pB1qRqVRmN/rM1Jkz
         +FAumeIII0B6jOndu4a4GnjUh3s5KyauiPRdKqOuSrcZBLv+j6JyseG1EiOh2fRsLNcZ
         JNXTK6eTpmA/LKJKf1kfr8p9iVnL9qWxEjSERjEzjejxpuaepITNGSJKFQ1aDd6Yg8+F
         o4dA==
X-Gm-Message-State: AOAM532HhLuaOGQCH3PkPb5VMK+mV8qiQxdRPTYrmm+Wo1sKUS5JrXl7
        eN79QqQrof9ITHGCbgNcPjw0v9PdPcNNpw==
X-Google-Smtp-Source: ABdhPJzf4YsAmc6ZvN1OHcHfCU4AStPBjZbPhXIBlp6L2usdVQ4gKVcwpjzb41G3P0tEyPDgSJsf0Q==
X-Received: by 2002:a17:906:b097:: with SMTP id x23mr13713119ejy.227.1590894134480;
        Sat, 30 May 2020 20:02:14 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id dd7sm11872805edb.19.2020.05.30.20.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 20:02:13 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-ezo-sensor: move ret variable scope in atlas_ezo_read_raw()
Date:   Sun, 31 May 2020 06:02:08 +0300
Message-Id: <20200531030208.12167-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move ret variable to the IIO_CHAN_INFO_RAW switch since currently
only used within that scope.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index f5a6d8ec6d4d..a94eb8a6bf32 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -69,13 +69,13 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 {
 	struct atlas_ezo_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	int ret = 0;
 
 	if (chan->type != IIO_CONCENTRATION)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
+		int ret;
 		long tmp;
 
 		mutex_lock(&data->lock);
@@ -110,7 +110,7 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct iio_info atlas_info = {
-- 
2.20.1

