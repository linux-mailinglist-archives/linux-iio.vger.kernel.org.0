Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0C224E9
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfERUoe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 16:44:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32926 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfERUod (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 16:44:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so12065609qtf.0
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ucxkelR/HQP9bUpvsE26VSnR/v3o3kZTaDa44EE1c=;
        b=ON6uo1bw+ET/PyUWYmc+hLE1PopU0xxIuMNPfiHk4Sg30DuBt/UDdPosCsccA6BQns
         JW6JieUAvK0x4k4C8t+fuTHiCMV1qR8aGcGRZrxFU8zwpzkeXJ24ohC4ndkzaxgGXIfT
         2g72OBxA3qdgGBJjJxRv+toI/1baW/puaUY/11T46zHHneJV6fhszAn7QHEeFgzwM/XK
         opRApu3GroVH8InlIhv4OzevBegnqCHwIIutzLJxj9rcBM8qrDxQO+De1ykJdxw0ZJzz
         r+JTE2+cIG+PGvCKXOwZylhPvzaKVgjAHF8NN9IlYXWSNshw1Rl3oxdDan6lJFfSYUaR
         q5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ucxkelR/HQP9bUpvsE26VSnR/v3o3kZTaDa44EE1c=;
        b=fVKd98XSeVJ/6QEsv3oENCmIyVAwfMexfSRQClW7fB6eFVRMpFB+K8lQRR4rWU7xXy
         I0TifY4TgHlH491cVEcxDOpiRQYprpqiplfaZNt59nDTXx9VwxXOoW49CpQZUb9uu7q8
         Ivd8AKBNgUD2Q0M7TPEQBTpQxKIlFGlndhSG/ZUoecoP+oWCrvy9MMKhVLFb8mLkAFkg
         dNkm0T34GSz1kizSM7xNZC3/NCsW/EBhtzR+J6QV9uIsFjIrhGmfu0fGQO+He7qawUDl
         RsphXvGIMi5nD1tBjd4SAXbPl7k90N36iGPUcLFRY/eHZs8eZqViwmdbDLMKSx48Vs36
         rb/w==
X-Gm-Message-State: APjAAAWQbEBDlIZxtMm4pDYU8DpuZD2MERmj8Es2liEGYeVNCzVvLMHq
        ZTjiKO9HsebLAfMutlVtraxMSGfdEbc=
X-Google-Smtp-Source: APXvYqyNXly3zNshlkxFWo9pdW363slsAY6ICkTQqQZyA4NjYb9fyNv1xP/N9JZR4KTqH7YX3ybqRQ==
X-Received: by 2002:ac8:19dd:: with SMTP id s29mr55369287qtk.353.1558212272493;
        Sat, 18 May 2019 13:44:32 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c32sm9252327qte.2.2019.05.18.13.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 13:44:32 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH] staging: iio: ad7192: create of_device_id array
Date:   Sat, 18 May 2019 17:44:27 -0300
Message-Id: <20190518204427.8883-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create list of compatible device ids to be matched with those stated in
the device tree.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/adc/ad7192.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 3d74da9d37e7..cc886f944dbf 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -810,11 +810,23 @@ static const struct spi_device_id ad7192_id[] = {
 	{"ad7195", ID_AD7195},
 	{}
 };
+
+static const struct of_device_id ad7192_of_spi_match[] = {
+	{ .compatible = "adi,ad7190" },
+	{ .compatible = "adi,ad7192" },
+	{ .compatible = "adi,ad7193" },
+	{ .compatible = "adi,ad7195" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad7192_of_spi_match);
+
 MODULE_DEVICE_TABLE(spi, ad7192_id);
 
 static struct spi_driver ad7192_driver = {
 	.driver = {
 		.name	= "ad7192",
+		.of_match_table = ad7192_of_spi_match,
 	},
 	.probe		= ad7192_probe,
 	.remove		= ad7192_remove,
-- 
2.22.0.rc0.1.g337bb99195.dirty

