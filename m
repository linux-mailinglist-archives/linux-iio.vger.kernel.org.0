Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE35310046D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 12:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfKRLke (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 06:40:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45053 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfKRLke (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 06:40:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id w8so1414574pjh.11;
        Mon, 18 Nov 2019 03:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIpBjUI/18c4759KVfvkhxpy/Q1dsRRq2xntCSfnsBk=;
        b=Dj3CWbDeUCRt1jHqDYcWbMFWjDqd4MyQmzl+Y28Z0yF4vyLdnFbat8UA4JwQYpPrW+
         iLrKmPqb1z5O9b4CIym2eNMRVZjf//dju0/O5BP6M99PAQAEw664ccC4xwXkaAWh3XLa
         Tj6o8VTybCYVHNQ96hHK39BgwmsLVjbV9PfEsvaAw/B5yIYNXh+Amgize6xqieiKRGNN
         759u3CBwWqudYFacxr6wmlBIONb+0iEfO6ckmufeZP2vK8xWlhbmXruY068JxTMCJqAW
         /QtK/lJsTBlRjuKMk0LN7coPnkSrBPppFNOROTZ2kzCiWUYhFN+UHBQmzgGKQx2OQZ6c
         7OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIpBjUI/18c4759KVfvkhxpy/Q1dsRRq2xntCSfnsBk=;
        b=kxoO1UFd7WgXC5ra0Xhrtgt87IkznjfnVR1wKCqXzD4S22cblGEsng8Sw7T8y1Ynsa
         ZqL+mZKIUN3Jv1qVNzIfae3fxc0gKdi8s/ItCQkmb2iH9AFf+j841Qm63uEWPgJ/ensv
         Jmaf+ajjxPqecyLpXVSfV2gRInhtI+dp5ZPe6KZ8pYM/9G9l+RxnmU7gd6pvjij6sIC/
         xWz67YhmBumRYpp/MYVLXJaz3nMEZE+HM0NAiXHwzl/1+NpjC8d52YQ0Zh4RApAiLko7
         mIJYEYTHAPI2GRwHVFEoGyH5fNe928Uor300OpuXVp2mxcRt7m8mfQxY9uZhGE5JliZR
         YhEQ==
X-Gm-Message-State: APjAAAUVv5lqwG9aU+M7YCV5rDaUW2cAJlrSEyOe8y+v4XQTQ0t3j3Eb
        o6UwZ9iO2BTRUdJny3Iv4yc=
X-Google-Smtp-Source: APXvYqzLcRKwvXVsJ55yLiaDFZPfmM/lasS/G8K2CN0NMRu5/c8SlfIzI1/6wu7ddAwsVPc2GDgSvw==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr38058971pjb.13.1574077230683;
        Mon, 18 Nov 2019 03:40:30 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i13sm19839717pfo.39.2019.11.18.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:40:30 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: adc: max1027: fix not unregistered iio trigger
Date:   Mon, 18 Nov 2019 19:40:18 +0800
Message-Id: <20191118114018.25431-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver forgets to unregister the iio trigger in probe failure and
remove.
Use devm API to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/adc/max1027.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 214883458582..8caead7dffa5 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -446,7 +446,12 @@ static int max1027_probe(struct spi_device *spi)
 	st->trig->ops = &max1027_trigger_ops;
 	st->trig->dev.parent = &spi->dev;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
-	iio_trigger_register(st->trig);
+
+	ret = devm_iio_trigger_register(&spi->dev, st->trig);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to register iio trigger\n");
+		return ret;
+	}
 
 	ret = devm_request_threaded_irq(&spi->dev, spi->irq,
 					iio_trigger_generic_data_rdy_poll,
-- 
2.24.0

