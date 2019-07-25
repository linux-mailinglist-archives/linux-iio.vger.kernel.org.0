Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F73758AA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfGYUIb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 16:08:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36649 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfGYUIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jul 2019 16:08:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so37398003qkl.3;
        Thu, 25 Jul 2019 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gi1xORrbzPoL0P3xPYkOl5Y2rSsp/Jx6024caSGqLbc=;
        b=Y2rRvE5ML/E8Tlq84Z1huVevhH9eQd35xkxh5VpYtwFN1GRP10UJPdKNoIWHgG9NTs
         pnWqXYULMSpdnsLqPFb9J6/8Ufr/h73V4lMr+Bb+w0U8PshoeJP/rGMqaV6HMaT7yQaZ
         734g1NfpQYXL/Ae0Np/+pkbLC5bedj8kyO5Tb4hYVnqpT2Z6U/mnxqz89Ab+U0cQFQN1
         P073EZf8ZvsieTXyA/Y6f4iEGGXZXwtnODuCsSb+R3a+RGNttupIjqfSstgcrCoQMGRX
         Ye9q5Z5+DXVcJqT5BwMszpFWzMUek1dCicCYyssryRAX39fcZDfi2ODUh9bOcNTu9WlS
         sLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gi1xORrbzPoL0P3xPYkOl5Y2rSsp/Jx6024caSGqLbc=;
        b=eIzSCZvu042a5JUH/rOZITV+KkJW3PsSDrdu9Z71ezzmSdXTJgZLHU8F3CUu20YXNV
         4sDmQpEl+TN7KBvDcxVtA5BLjdBJf5FlU1w/bP7NZcqdy1RJZgg1wsl6pziTGetzx9Es
         GQxLVnq0F4cvb7/jXpmt+JPxfe2RcPVGS2LgdH6UfA6St1jVWYEuSv+y3CglAKoZpLaH
         K6M2LKPfkn7hqsn5m6emFVl9Lh8Ijvt2np0gmV/wiX3EOxqBS9cYU6RXF/h1Hgt5hDr1
         IscB/freTQli/1AtfOVhpICv/7RhWimWTTBmXubCUVJG+fHOKLKtGAo+N6bSlhrAWNYZ
         WJKw==
X-Gm-Message-State: APjAAAUwLTNkDIuIVrJki00YYr4NwLYLkpvDl8Fm8M4DhXBbGFQTWzkf
        c3nWXOpzosH0A+yZ+kPpLnU=
X-Google-Smtp-Source: APXvYqyghEfRUVyXaqFOtoJAxuf9vIQUldSnA+RxPc5VnJNH/jGwK5LyWk/4fl8Jqa4AbDDPhBwR4Q==
X-Received: by 2002:ae9:ed4b:: with SMTP id c72mr55914956qkg.404.1564085310644;
        Thu, 25 Jul 2019 13:08:30 -0700 (PDT)
Received: from karz-laptop.vlan96.localdomain ([200.17.97.58])
        by smtp.gmail.com with ESMTPSA id a67sm23870493qkg.131.2019.07.25.13.08.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 13:08:30 -0700 (PDT)
From:   Kartik Kulkarni <kartik.koolks@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Kartik Kulkarni <kartik.koolks@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: [PATCH] staging:iio:adc:ad7280a: add of_match_table entry
Date:   Fri, 26 Jul 2019 01:38:17 +0530
Message-Id: <20190725200817.31277-1-kartik.koolks@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the of_device_id struct and the respective
of_match_device entry to complete device tree support.

Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>
Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/adc/ad7280a.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 19a5f244dcae..ded0ba093a28 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -1027,9 +1027,16 @@ static const struct spi_device_id ad7280_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad7280_id);
 
+static const struct of_device_id ad7280_of_match[] = {
+	{ .compatible = "adi,ad7280a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7280_of_match);
+
 static struct spi_driver ad7280_driver = {
 	.driver = {
-		.name	= "ad7280",
+		.name	= "ad7280a",
+		.of_match_table = ad7280_of_match,
 	},
 	.probe		= ad7280_probe,
 	.id_table	= ad7280_id,
-- 
2.20.1

