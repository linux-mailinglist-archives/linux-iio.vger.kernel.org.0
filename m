Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6C22548
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfERVoo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:44:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33437 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERVoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:44:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so12156438qtf.0;
        Sat, 18 May 2019 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJ5BRXNmtBYhU5KLCuS1xg2MlRH8bwhzIAasFCh/DOo=;
        b=maN8W3t5H1DNQIgzJCDprNKkVjep+KwFN0fMsVa9RUsrMSqp6yaLfSW9nrfmkhvfyo
         yTGr8uuUNZEUG2NvDyFbtVF+3sVlO4DQz2nu0BXUdQJ/x/wcwRAYFtucN2z12F08KIww
         encs/kF/M8cdOXgCm5yfxIeFYR4NSizg7EIno8WPXs/oE9J9/mvv/vMBQdSasqAZPwm7
         RNF1MLVv8Wb4Nis6vXPKQadOIhZvu907703LSWYOfkY4/WBVYoLzo3DFkD0AmDkcTtqN
         5eIij1WP2+/uwpckPTU1wUdR7TCobUyu9UgIs/YzADyUiaccn3Oek6Mlx0K+urXGJW2a
         TXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJ5BRXNmtBYhU5KLCuS1xg2MlRH8bwhzIAasFCh/DOo=;
        b=por1BR5ZC2PjaFEPAiHb2jI6IotFXn5h9JrUJywNBa7uaWDCYqDnX5Kye7bez+BR7u
         B/b2NxBIRkuglojzZYbhiN53BL9MDwAi99M8ODOok3kXiu74MhzYwl6HxUwXuQVUmKdO
         NV+Phhr0i87xhD6OEJToQMfXhnXI5697zfulEgv4ycVF8rK4i3ES+r5F+S3kWuAPHaKy
         fPGMmH1P+wyN4dDj00btUpcIm+T8KbzR9KVIREwuOU29oLpsxDrKGvJ6MdSHVQO6Xe1D
         gYWndsyTU7Wq1J9ZCG7Xexv+YEEV69Gz316k1fHL0TT7iJksyXuWX9QFy5NMS/KrNjlB
         k/xQ==
X-Gm-Message-State: APjAAAUq6ywzX2mBC+tBmoXMMULlzrQZPqJEnB1c+MbgBDC73CEHJ23b
        zXBLfCHqMIk5ygtJkSkkATg=
X-Google-Smtp-Source: APXvYqyFsB4cbFR6WK/GdTpC/L6EjHHB/VoLoxxr++FzPhf3RZRMVm1V2r8hdHE6BufpS47pq1fgmg==
X-Received: by 2002:ac8:2e84:: with SMTP id h4mr7898725qta.267.1558215883813;
        Sat, 18 May 2019 14:44:43 -0700 (PDT)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b22sm7313294qtc.37.2019.05.18.14.44.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 14:44:43 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Subject: [PATCH v2] staging: iio: adis16240: add device to module device table
Date:   Sat, 18 May 2019 18:44:34 -0300
Message-Id: <20190518214434.23660-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a of_device_id struct and MODULE_DEVICE_TABLE call, in order to add
device-tree support for this driver.

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Co-developed-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index b80e0d248b0f..8c6d23604eca 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -435,6 +435,12 @@ static int adis16240_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adis16240_of_match[] = {
+	{ .compatible = "adi,adis16240" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16240_of_match);
+
 static struct spi_driver adis16240_driver = {
 	.driver = {
 		.name = "adis16240",
-- 
2.21.0

