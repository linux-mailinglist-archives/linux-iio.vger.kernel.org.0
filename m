Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4F22571
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfERWmb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:42:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41059 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbfERWmb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:42:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id g190so6655345qkf.8;
        Sat, 18 May 2019 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dE/BQT4p6YFMZdDx7suJdmYL3xI19O858zqs3rNJ+cM=;
        b=DHGdf95J6ICNbACJ82Zhj43yAvaHzY6E2SVvmXisk/S6D/i2mcqsSTc+L6zsHUWzX4
         3vO3oVZWJ08INaMCQ5iZG/OoQj1u6/1q8dV3ymTWRXMv8YxfsIT3DvuJQdDMKUkEEKBD
         bRCACqILKLr9JQGOkhdaLaiuTr0Jc5hQsH+5HMwHy3RInD/l11i/ShCubj9sMFj6we/p
         Dfxkwmy191x7yan7ZTh4u6GD+Jv5i5Pvd98kGtc2Nps3kKt5lCBxq5UKt0twdBX9fJfD
         GAo5dwIHloDaFMfFDc7Wo6rgxsz45Gs/cGiDjE2Q2V+6+kaE+1qok94IAuS/HTa75lBE
         2XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dE/BQT4p6YFMZdDx7suJdmYL3xI19O858zqs3rNJ+cM=;
        b=hS6uKOUuPN3mjfkV86/ElgpG+74xX5PjAEA+KWpPixL7xPXigf5mERLj9H1EckEZnp
         Qo2tcAXp5LA8SXAWRDJiAtZbGImv1BqUIr90ldFG9tFUsxrwZfRGIALGSjH9p1LRtfUX
         r2XS/Xe/2P3Dc1aNT9jhCFYYWLHJaQlk60V/8hrwo3VCROZ/HpgH4ExBYVt63EyTPN72
         5JkdxPgymiqWEhB1l5dlVsllDiNycnbdlD3POD6u0RPnNjYYaDjTM/Yw+vfvPlsFFECn
         xWArawORJknGDZ2g3hi64Z8woYVgdcc3jHWePeiNMUSaKokOIaLMcUqkMDORd2IRfped
         8gHw==
X-Gm-Message-State: APjAAAXHIoGPB+qUJz6oMHQ7Ma5J77WVkZ8E0LtNkk1rjg+o/3QnYWvq
        B+2mimVm7NfyOdZFoqZCOeY=
X-Google-Smtp-Source: APXvYqxj90LraptlSg//ifLM56VWqOy+y8+E2r9sf/wSta1QBy8cGX7IpRvfDEfNBLchuSpx2hojvg==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr24481882qkl.243.1558219350058;
        Sat, 18 May 2019 15:42:30 -0700 (PDT)
Received: from thiagestrela-Inspiron-15-7000-Gaming.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c30sm8481720qta.25.2019.05.18.15.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:42:29 -0700 (PDT)
From:   Thiago Estrela <thiagestrela@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Thiago Estrela <thiagestrela@gmail.com>,
        Tiago Napoli <napoli.tiago96@gmail.com>,
        Pedro Sousa <pedroteosousa@gmail.com>
Subject: [PATCH] staging: iio: adis16203: Add of_device_id table
Date:   Sat, 18 May 2019 19:42:13 -0300
Message-Id: <20190518224213.25927-1-thiagestrela@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Accomplish device tree compatibility to driver ADIS16203
by adding of_device_id table and making a subsequent call to
MODULE_DEVICE_TABLE.

Signed-off-by: Thiago Estrela <thiagestrela@gmail.com>
Signed-off-by: Tiago Napoli <napoli.tiago96@gmail.com>
Co-developed-by: Tiago Napoli <napoli.tiago96@gmail.com>
Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
Co-developed-by: Pedro Sousa <pedroteosousa@gmail.com>
Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 70381756a64a..a5d974ac2e3b 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -311,9 +311,17 @@ static int adis16203_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adis16203_of_match[] = {
+	{ .compatible = "adi,adis16203" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adis16203_of_match);
+
 static struct spi_driver adis16203_driver = {
 	.driver = {
 		.name = "adis16203",
+		.of_match_table = adis16203_of_match,
 	},
 	.probe = adis16203_probe,
 	.remove = adis16203_remove,
-- 
2.17.1

