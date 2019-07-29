Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3A7831D
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 03:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfG2BnI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 21:43:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2BnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jul 2019 21:43:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so27124856pfp.7;
        Sun, 28 Jul 2019 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LV39I9aLdwL8Ba7krSV4uBeXZ89IOyHpbCxzE7258B4=;
        b=gvWWSK0JytSMopVhFA0NawbhUPQQPNyzNxYAQY5G00eOVqDZsp1Ys370zU7aDPBbFl
         xz8/HU7B+7VUOD8bbMNLKx0/RGh6CVk8SomEfrbTI8MVnML3WIdGl/6sxgbSkDfsuJKP
         1NCV1aFIE746ubZOX8jn8EOHuxcLwFljuQ6TuZSXX7oSa5BafoBzbPH/5aOvwxHC5BZL
         Guh4Y+mCzhpYNnjl7vav69WJPc8xNCTkYwd9YuAAQpelRthTG8O1vDrELvg1epKzO9by
         hVHn22fBNIcgeMl0fxI6fwHRil5gcImSufsi+2kILwaJp+uE89nwRNth2ucvxLjG4cgP
         gCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LV39I9aLdwL8Ba7krSV4uBeXZ89IOyHpbCxzE7258B4=;
        b=B33BXczhRQ+8SNiEMaZrWIOCyphpv2XVjeThAbz3nrK5HsJAK1Lez2csTAgBwYeO1z
         1dOHZjAAzbyBTSVqyGMmgm1QyCbDmO2j/qRm5ZPhTmuMR3MMhPVfXnmNrz1LlyXJL+zQ
         m1snLfoacu3n19lSzBgu4HJG7dcD+JCp8zaTbx5sXHMRkHMNPSHjh0vX6Ci6EQwrCCg+
         DI26OWkc6hzefRlv6RJnkZDcJ8N6SgZ/UrN11tGs0wCG9VzexeWVhaUEwc5/gsMGbNMA
         NVkijnh2OlZUlfn2Eq9rSJPgVsQTDQgLDtGoNVCDOy9kaiN4N7N+QD5TDTiQQVBb6JGo
         vPNg==
X-Gm-Message-State: APjAAAW2eH8TAkU93Xp7j1f4xa1M5uKCICz051tK8z46ZJFBf++H2NbN
        Yht8XeXtp7GQYCblSlN7yB4=
X-Google-Smtp-Source: APXvYqy33T1WT3c2ceVt49IN+W8TfL9YaK4sBZZ5C+bItnu4spucVXkt+KxG/Gn+mGavkkjYCGawMw==
X-Received: by 2002:a17:90a:9bc5:: with SMTP id b5mr110329060pjw.109.1564364587501;
        Sun, 28 Jul 2019 18:43:07 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id b6sm52386509pgq.26.2019.07.28.18.43.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 18:43:06 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] iio: light: si1145: Use device-managed APIs
Date:   Mon, 29 Jul 2019 09:43:01 +0800
Message-Id: <20190729014301.13402-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed APIs to simplify the code.
The remove functions are redundant now and can
be deleted.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Split v1 into two patches.
  - Use devm_iio_trigger_register in probe_trigger,
    delete redundant remove_trigger.
  - Return devm_iio_device_register directly as a
    minor optimization.

 drivers/iio/light/si1145.c | 42 +++++---------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 6579d2418814..982bba0c54e7 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1261,7 +1261,7 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	ret = iio_trigger_register(trig);
+	ret = devm_iio_trigger_register(&client->dev, trig);
 	if (ret)
 		return ret;
 
@@ -1271,16 +1271,6 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void si1145_remove_trigger(struct iio_dev *indio_dev)
-{
-	struct si1145_data *data = iio_priv(indio_dev);
-
-	if (data->trig) {
-		iio_trigger_unregister(data->trig);
-		data->trig = NULL;
-	}
-}
-
 static int si1145_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1332,7 +1322,8 @@ static int si1145_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev,
+		indio_dev, NULL,
 		si1145_trigger_handler, &si1145_buffer_setup_ops);
 	if (ret < 0)
 		return ret;
@@ -1340,23 +1331,12 @@ static int si1145_probe(struct i2c_client *client,
 	if (client->irq) {
 		ret = si1145_probe_trigger(indio_dev);
 		if (ret < 0)
-			goto error_free_buffer;
+			return ret;
 	} else {
 		dev_info(&client->dev, "no irq, using polling\n");
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto error_free_trigger;
-
-	return 0;
-
-error_free_trigger:
-	si1145_remove_trigger(indio_dev);
-error_free_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id si1145_ids[] = {
@@ -1371,23 +1351,11 @@ static const struct i2c_device_id si1145_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, si1145_ids);
 
-static int si1145_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	si1145_remove_trigger(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
-}
-
 static struct i2c_driver si1145_driver = {
 	.driver = {
 		.name   = "si1145",
 	},
 	.probe  = si1145_probe,
-	.remove = si1145_remove,
 	.id_table = si1145_ids,
 };
 
-- 
2.20.1

