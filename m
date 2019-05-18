Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02622544
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfERVjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:39:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44653 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfERVjM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:39:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id w25so6586739qkj.11
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eO6mO59GQBmOS/DlZnxdkxlS21xeFUZXbaBYNCMZMIU=;
        b=l9tTMK5GGpIEGtV0Bh5GDEvs6dOrQgugWzUDlw5C7bjyfEyCzrgVUSP5CRJ8c2Ob0l
         rAKZaxAoIzbYn67rLDncf4ZMWNsnTeCOvQpV4+Ldc5dllTFmd92tpq1y0JnaBMuhX6/P
         g0jk4T68La9QZ5axFnnHUMtu9+WzRKJfdXYB4+28sska4U0txGHyVI4In/sAcoM4uzZf
         +yckiCMZQWq0SmPti/bAQOxwd/2QTPYOkBEhKxNm8GwHOadrJKOExHR4/HzGl3rcYd2f
         ELPV3VkiQjjXMkMvo3hDwLpfMlIE2b/Hr2nDACOYzngPJlpCoxjUbsGaBh3qAWTHM+6n
         acvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eO6mO59GQBmOS/DlZnxdkxlS21xeFUZXbaBYNCMZMIU=;
        b=A5jdIJbi284JVTZY0cdtRa/EQNLSvb35YNKwFOGjQPJhRT2q6EI5/s2HdDKboz8g4r
         NMT7L87WjaLpWGDuTHJ5YduP/HVgmd9sj/HnbTwhQ/9DsWUx/7cePW9idXNlJ3ODVULT
         ucCaAlDXEkYNY2eDvHrzBLv+NBHOvwhw95u5gT59NRUiiv4r9NFkpEWM+IZmPVN6QctK
         oQLO+RxFuGM2HFeb/GTqYuD6O+UXXSmkjtIA+vcSC8DKdo7ihqb4HD1cp4PkMmXFCosj
         ovxHqMLVCIuE2vk7Dr4cwNQnYvF8GWPm9ohG6/34fGwlmnwATVZgSseyvX2eMjtXfNJ9
         pcRg==
X-Gm-Message-State: APjAAAX0XE3ges81xMmZO/E422W+C0heCjI8CVk/9Qg0bm1BJ0SO7Itn
        1sl2eLdr/fo2vRQsr6bPuSlAY1Q3G+Q=
X-Google-Smtp-Source: APXvYqwB/OEoHmi4pMX4gk+oK7ji+yMbtMTpJI3kjKwmo1xKW/ZEMU8J3Yy+YlUOCb/rg0OULdb60A==
X-Received: by 2002:a37:c24a:: with SMTP id j10mr52029861qkm.140.1558215551145;
        Sat, 18 May 2019 14:39:11 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o64sm6775170qke.61.2019.05.18.14.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 14:39:10 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH] staging: iio: adt7316: create of_device_id array
Date:   Sat, 18 May 2019 18:39:04 -0300
Message-Id: <20190518213904.23478-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create structure of type of_device_id in order to register all devices
the driver is able to manage.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/addac/adt7316-spi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 8294b9c1e3c2..9968775f1d23 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -127,9 +127,22 @@ static const struct spi_device_id adt7316_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
 
+static const struct of_device_id adt7316_of_spi_match[] = {
+	{ .compatible = "adi,adt7316" },
+	{ .compatible = "adi,adt7317" },
+	{ .compatible = "adi,adt7318" },
+	{ .compatible = "adi,adt7516" },
+	{ .compatible = "adi,adt7517" },
+	{ .compatible = "adi,adt7519" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, adt7316_of_spi_match);
+
 static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
+		.of_match_table = adt7316_of_spi_match,
 		.pm = ADT7316_PM_OPS,
 	},
 	.probe = adt7316_spi_probe,
-- 
2.22.0.rc0.1.g337bb99195.dirty

