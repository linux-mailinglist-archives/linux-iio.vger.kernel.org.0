Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB66F224F9
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfERVBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:01:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39026 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfERVBC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:01:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id z128so6601453qkb.6;
        Sat, 18 May 2019 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsAT5qbsaotm0oBGUetquV7WtLzGgBbpbWMnm1fUtaw=;
        b=FNpAL29qZqJo1UbDaDy/m2Lx+72Jdb/OcpovJocPvNdp8WBksBQuzTgTykux8OFEry
         u7I0119akjhgDUCZaMemtZzzAY+Nce0SIu4gcu8otcvtmQP5OUc3K9AJzRIRCCQ/5QT2
         Usk+/Q1Y3Jqf8QpXqcMawAnSv3sFqsaFNepu7mzfwoqWmbkfFerAsRz67rnleRgN68pP
         /OMaOgbmt4Un+ZoapzcSr1CxD9vQqKdgiMG3mcXs0svJKhG+AqIhtnQsSfhWmQOMg9rd
         vFBaje0SFFonG9/h748wKquhNT6wFCc/Z9B8BGZtvU0LDKTCubGCI/mQ3kjvtwOtLkwS
         uL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsAT5qbsaotm0oBGUetquV7WtLzGgBbpbWMnm1fUtaw=;
        b=HHyK1Bgxfplge6t7PwZfx87cyUcoKY5lMABCc8YyxarwLwoLV+FKFTpdE1d0OUfulT
         UEUREUBQ8SHxn1nuwrlY8ls7kkea1/YoS/uWSw3eZ8eapaKBZgwx3nY4JmyV17m8YCGh
         o99asHA96zw8nfEmrunYFjqao1AXxyvF5U6bpLs+DoLSRlgcKn6plZRyzfrebejakyn8
         Ga1vr0VhKaGmHXXwcTHwVpzf+KKo22zyy/xH+ibm2V/oA1HMgnrJVTXEJY3A6k7bndlX
         CsnC1AOxZlwIDkYUwTJVjzpCut5AoLWmoU86Kyvmu2Hl/1JCSFVt5i/LK76ZJgWN4sjL
         dWLg==
X-Gm-Message-State: APjAAAWFLGhuh3osCnvJC8VviqFjhhnma4CctjefBxopb8rLJtCMmkrv
        +lLUA1BHrtYnjTZJ10HSisA=
X-Google-Smtp-Source: APXvYqzxWN1QgdaQ3liwyrherSRNq5sJ61pYI5Zg395d80UXIdRoppdxLpHirXw2L9D4LwA2p75eRA==
X-Received: by 2002:a37:6043:: with SMTP id u64mr39779236qkb.9.1558213261871;
        Sat, 18 May 2019 14:01:01 -0700 (PDT)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q5sm7730906qtj.3.2019.05.18.14.00.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 14:01:01 -0700 (PDT)
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
Subject: [PATCH] staging: iio: adis16240: add device to module device table
Date:   Sat, 18 May 2019 18:00:08 -0300
Message-Id: <20190518210008.20147-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a of_device_id struct and MODULE_DEVICE_TABLE call.

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

