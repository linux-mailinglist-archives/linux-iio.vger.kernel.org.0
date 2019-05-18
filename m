Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2539C22578
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfERWri (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:47:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39908 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfERWrh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:47:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so12189262qtk.6
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHjKUwLAo859x2qa8l2Ned7NAR7EtunrUsrKKRhPIKU=;
        b=zyCbluClALswad88NgfOr1p1BseOf7ybjSc4wkjUWPzfpVHZ0mq1pctuzFPI/HZKQz
         H4/LKV+vB/hVob0m4v73yCL6h38gRoaaQAsUQRH/5BoAl49AqPDOkSpBfs654uU9SUWc
         VoxiA5BIiBKA2PaPWHz6GDevqYMugzie4UXH0aGV3X5EOl0CTBlHeKiATWKX+J6dlYP6
         VI+cSaf3AuxrbDByWmkTtD+7ko+lQZVafQMqU9BpD3HPcWynZ9TfTfLvsqGqplVBr+YO
         mPSVOVDR+sO3a/oVcPYl5W3kTel3Fgv2tzAIJnyoD/iT7OZXUYEuZIMqfXnWxdhp/uJv
         m6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHjKUwLAo859x2qa8l2Ned7NAR7EtunrUsrKKRhPIKU=;
        b=fjkyvBKUXGJ8EHDGnPOoKECSt0re9l3KfZtlrPKBcfqjIIPd15ufiHbMGNuYIs1HOP
         KYLi5pQvoy3ZARAqs3otAISJT5Ce3G/KBJY3pwhAHClGFvnSbKN9YbVNomhjNIIxMrr5
         CUscbNo3faDfm7FRsWxN/ctSOOUIlHdqXPJQrL125ShLf/f7DPpD+aNk3UBesSCYqKlZ
         OaQVIXjI6lnRMa0jPFszafsJZ38CDuL42e9XEsGetmbSQc/xfzpEcXHZAwfZ08/rKbav
         dDfQxJoUkXUwKx2qSSIWz+VoJXhiI7gB2uHaiVThTK4IyIjrGH9GPOvtZiOqBnSGXehA
         rBqw==
X-Gm-Message-State: APjAAAUC/CTIs+xdLbynTDMtzHmLyAeBqFyHRMWm9R4EYDc9ZC+BfAwO
        CaIaYl25Rs9jsNteZp9plAzfZQ==
X-Google-Smtp-Source: APXvYqyXXskoWq+bQQfwFQVGZAuLOWrfAX3Eiyap7hG8gCEAj3ysL058e7biD8lDeu0/I7VXUshmtQ==
X-Received: by 2002:ac8:2e3c:: with SMTP id r57mr56606614qta.57.1558219656607;
        Sat, 18 May 2019 15:47:36 -0700 (PDT)
Received: from joao-pc.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y13sm9221004qtc.21.2019.05.18.15.47.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 15:47:36 -0700 (PDT)
From:   =?UTF-8?q?Jo=C3=A3o=20Victor=20Marques=20de=20Oliveira?= 
        <joao.marques.oliveira@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        "Thiago L . A . Miller" <tmiller@mochsl.org.br>,
        "Osvaldo M . Yasuda" <omyasuda@yahoo.com.br>
Subject: [PATCH] staging: iio: ad9834: add of_device_id table
Date:   Sat, 18 May 2019 19:47:20 -0300
Message-Id: <20190518224720.30404-1-joao.marques.oliveira@usp.br>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a of_device_id struct array of_match_table variable and subsequent
call to MODULE_DEVICE_TABLE macro to device tree support.

Co-developed-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
Signed-off-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
Co-developed-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
Signed-off-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
Signed-off-by: João Victor Marques de Oliveira <joao.marques.oliveira@usp.br>
---
 drivers/staging/iio/frequency/ad9834.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 6de3cd7363d7..038d6732c3fd 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -521,9 +521,20 @@ static const struct spi_device_id ad9834_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad9834_id);
 
+static const struct of_device_id ad9834_of_match[] = {
+	{.compatible = "adi,ad9833"},
+	{.compatible = "adi,ad9834"},
+	{.compatible = "adi,ad9837"},
+	{.compatible = "adi,ad9838"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad9834_of_match);
+
 static struct spi_driver ad9834_driver = {
 	.driver = {
 		.name	= "ad9834",
+		.of_match_table = ad9834_of_match
 	},
 	.probe		= ad9834_probe,
 	.remove		= ad9834_remove,
-- 
2.21.0

