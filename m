Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1122576
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfERWop (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:44:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46069 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfERWop (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:44:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so12129409qtc.12
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ucxkelR/HQP9bUpvsE26VSnR/v3o3kZTaDa44EE1c=;
        b=NSLlyVD+sot79DZNAp+7bapx2pe7mQWtHWl2n7rYW0aNAulOevYUObNVSK/WIj69Wm
         zvmy7eIdht+lswEINUDsOO8tgn1xSCWaRIcrBpyHxEcAikmye973KYkoO8zj/c7RRNLA
         kenAJ44zOX7+0ut94DG+/TfbhhC6hijbZxkh0PfwIkRtJ4mWwlD3W1D7HbDCl02592DO
         PW/lPwKpFHfhzQFcgRqcxdi/bqBq97suuh2xWsjn0RBOxnqfXhBrpSEoiaFKCbQ8VMNv
         frXCkj4ROZSBPRPgx+FMl4alrxTcI/iq8WP5jFrM36PZZz2VWkS85c1iBb6HLC28aV5l
         XcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ucxkelR/HQP9bUpvsE26VSnR/v3o3kZTaDa44EE1c=;
        b=MRtilgicdRGrha29qS0M4vnTxD96OAt/kmIe3hmBqiCSLCCEtMXIvYinuVAMlOv6pG
         qFM0Mp3IF5hyP6S9Y2XgUmGLP90ndfxwX3wciROoiJmZ3PIokK1cK8xcRca2GcsbKfxZ
         py0jUKumV2oVkGH5auByNYaC3fKSWeMdLeoi7ni7w0/SChsN7UnELERsPXM1rl2/bzwU
         u/OJQV5T//3+bDI/ypCy8twRROFPKI+eKkac3fux3QXbublf3M9Mfm1/pxIF9lBSWuiW
         iaNdrYdGNI2xFdIWkSvkVQNykn/qvkfyMzTZuBmR5FNd9YRSKfj31gRGBhNxijvHoZzr
         YLwg==
X-Gm-Message-State: APjAAAXfFiKAG2yjJEd0UayqRp7jaJh7bOJZthksKu7Tn/EU9T5pZWCC
        1/Yw8CRXMh6y9t5rFa+GTdQJ3w==
X-Google-Smtp-Source: APXvYqyD+ao6l0Q3bobEplwWIc3zM/JALZvdkkwNOg8qh0e27mVn+AOrOUl2njaNZVt4DsBDeCcYnw==
X-Received: by 2002:a0c:986e:: with SMTP id e43mr41615006qvd.78.1558219484113;
        Sat, 18 May 2019 15:44:44 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g15sm7225889qta.31.2019.05.18.15.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:44:43 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [RESEND PATCH] staging: iio: ad7192: create of_device_id array
Date:   Sat, 18 May 2019 19:44:35 -0300
Message-Id: <20190518224435.18266-1-barbara.fernandes@usp.br>
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

