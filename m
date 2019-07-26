Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41131763DE
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfGZKt4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 06:49:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36440 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGZKt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 06:49:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so24343235pfl.3;
        Fri, 26 Jul 2019 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QKp71tQvI7iZBNA7DNqsUKPGMxUoV7lqv+sxtTM26c=;
        b=Sb5wA6P+FdCteyCR+H6uEoRF1upvBfduM15VnKvzZGm9OCWUbQSsqHj+0XlsTJAeqZ
         jt8cAlisoqm5jpJRtjVp+V2pIOXl9G9XT2Q570eEsjYntUEoqv22toZErJQhoXKes+88
         7JeZvMt5vMthjSFWNJ+5V71vVM+PWogjmwLNS6wTd/FJdei1DqQlCFaZvw/lYvKJ9Njq
         DN+gpLN31I4Q0aghrt0Y0AgL8J5qz8tEplHMX8A+5z123982gH1qDHZrrGPc2TnguZYu
         7Dh8W5O9OIfcoW1eZoU34Se3OMMWWKq2dNLpuc716uUaCKfFMAxsaoPepokbwomYasW4
         nIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QKp71tQvI7iZBNA7DNqsUKPGMxUoV7lqv+sxtTM26c=;
        b=IIabbB+k8FKn7Ii8obzJNSE1v74jb8VTm0kf6FsElW1xJIfNh71tV2iuSdXkbiU9Oc
         tm2wb7pcotZoSHU9pCbVkmnQScQNsvJzAV3kUcBnBuwl1qevEl869g+sJdR01TigQhSx
         08pxH59XaJTxV23/SnuTXK3FZwbMBviwGn25ZJP1/+wbTuvJf/B4Kn7izJIsQ2iRcpuO
         gdes5jsEpTesTn7C4zFfm8NS5/qXb8pvclj8SaAw/hijf4JsMXcK5lFCTRrLH3sH74ga
         zzwKfB4ZP6dvQKh4ZBTK1ZZ7hTmvRKZXRw7n7APNuLSQwJJKljgRHWxEMR+k/kPGZ2H0
         U8iQ==
X-Gm-Message-State: APjAAAX6nOOD0mEbbrsuH+0nCsO19hdlMDn8k9Ydsnts9sRSf4AF/8d4
        OwvojNaJLpgXt+OI8fG5uVs=
X-Google-Smtp-Source: APXvYqyjj3vNrLQHvI4xllpxaoF4KCKbF+kpxLvU/otphz4njoVxEcpx4Mmn5oSlQbTYB1uIgpdJgQ==
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr97229750pjq.36.1564138195940;
        Fri, 26 Jul 2019 03:49:55 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q126sm9137008pfb.56.2019.07.26.03.49.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 03:49:54 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: maxim_thermocouple: Use device-managed APIs
Date:   Fri, 26 Jul 2019 18:49:50 +0800
Message-Id: <20190726104950.19171-1-hslester96@gmail.com>
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
 drivers/iio/temperature/maxim_thermocouple.c | 23 ++++----------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index c613a64c017f..314b6e11e386 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -230,29 +230,15 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
 	data->spi = spi;
 	data->chip = chip;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&spi->dev,
+				indio_dev, NULL,
 				maxim_thermocouple_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
-		goto error_unreg_buffer;
-
-	return 0;
-
-error_unreg_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int maxim_thermocouple_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
+		return ret;
 
 	return 0;
 }
@@ -277,7 +263,6 @@ static struct spi_driver maxim_thermocouple_driver = {
 		.of_match_table = maxim_thermocouple_of_match,
 	},
 	.probe		= maxim_thermocouple_probe,
-	.remove		= maxim_thermocouple_remove,
 	.id_table	= maxim_thermocouple_id,
 };
 module_spi_driver(maxim_thermocouple_driver);
-- 
2.20.1

