Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F3765C3
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGZMbE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 08:31:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33635 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfGZMbE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 08:31:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so24665329plo.0;
        Fri, 26 Jul 2019 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sjcnk6lMICGMjh4+EDphilaJqk8LQ0VyQRkMW/aXn30=;
        b=Cc/Hbw0I/PSl6f3oJ5b/HzFORhZq1kAtBdFiPET37qrQOlIw2bpwes78/Km5QKaFS6
         s1CLYm46TfzVGQ1Ofn8AhemrIVcpvUbZFptEX069ZGSzU3s2SPGo86mq5PMGYMg0O9Te
         gJaElxGVUoTNeSquLNoBn36IZ1vSfY9Plyap0N6KEb1e5xc0OVEyl/7wDMqLDY1elThO
         5dQ6nppPtO4uUFBCMzzju8YpL8MotcciKWsCIt5eLKXfHpEYFV319KfxOpq7FXQAeztz
         SaKXT9iYESpX8eQ8rglPiAB0gMq53x7J+VyvrNuQfOyOoMAWiQjDD6cS7kDtBbCgSXmA
         zLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sjcnk6lMICGMjh4+EDphilaJqk8LQ0VyQRkMW/aXn30=;
        b=NC/54RG/meFIgAwJ2VnBarvnJtmURg1GkQYMAya1Wl0oUY0sfArgHMbib0NkZbKPCm
         zUBoiXULPDPgKO2Pe9j0XnT+7NSvX8vb+RdqIQXLAXZoPXgzbkbQjId/3LYWcLq+G4Eb
         bqxEAa0D7EbaUh/0vd5aU19j3bfRfRdjxl+wT2ejrrXL4dp0S2JkgkA6d9Tw/I8yUkkN
         DdCmWPul+DRZhky6Y7AAi6t8NaMtRH/rwIAPKlUEereuEaheEYQOPdK/9EEfCpAqpdRw
         MXZNq+bplQZNT5cG/1vLk3HfiwCuhw/Nbi0agzuhgUUbyyv567XYIXLiIgfyCL6JsbCs
         C1aQ==
X-Gm-Message-State: APjAAAUTY5YI2amXqMsGCwSNYalF4bvL1xlbUOAVufPwx3NgnFqB+hIr
        TRY2j3MVXfuRGL7wo0aoTkE=
X-Google-Smtp-Source: APXvYqyd7a1q1zc8g07R9Yn7QbEb6e5p6ALRDiEUowkMpZPeFGxwzxCjGZiKQFNwgEhElT/rBT616A==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr99217855plb.30.1564144263518;
        Fri, 26 Jul 2019 05:31:03 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h1sm67195089pfg.55.2019.07.26.05.31.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:31:02 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: tsl2772: Use device-managed API
Date:   Fri, 26 Jul 2019 20:30:58 +0800
Message-Id: <20190726123058.22915-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_iio_device_register to simplify
the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/light/tsl2772.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 83cece921843..aa5891d105e8 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1877,7 +1877,7 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&clientp->dev, indio_dev);
 	if (ret) {
 		tsl2772_chip_off(indio_dev);
 		dev_err(&clientp->dev,
@@ -1928,8 +1928,6 @@ static int tsl2772_remove(struct i2c_client *client)
 
 	tsl2772_chip_off(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	return 0;
 }
 
-- 
2.20.1

