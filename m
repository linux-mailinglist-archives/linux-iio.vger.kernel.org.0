Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF288BD4
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2019 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHJPBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Aug 2019 11:01:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37307 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfHJPBy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Aug 2019 11:01:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so98767084qto.4;
        Sat, 10 Aug 2019 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mYT1ugU9XRJDqmG3NJqTPI0yF8pfPERIAlPeQwQtf0=;
        b=UDu6z/Ryj5Yfv0lVew1vY4USzE5YR0tHTTGKa6pJxuBs5mciviPi8g8+E5vtvCIk6U
         aiuB3WNP0JTY2d0ogF1V1RMIoOdLBLRMYp+BBSeQH7L+leWH5avL6qyacwYhXBIPOE6D
         3QWQAengrm16iF/XCUdurKjlWHhLP1MeULmftZiPeeH1blN6KDC3m8Up9rXEiM/H20Jq
         bcma6QMHvI/8Fia29TwreP9uTLkOiCI8mRsCZwbDcHrOjt6rORSU+m8H19G/pWkf51AJ
         yFLa/qWNKfpzN2Db19/sutNWpE3HPjKiaIbdoDXMMu9mMUXhAg3iNBRawZ4i1af6tKpC
         RKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mYT1ugU9XRJDqmG3NJqTPI0yF8pfPERIAlPeQwQtf0=;
        b=WBjShuLS5rfHDwfLcurZaovCcs1DORkF1GyNSdYRRMlcXYzrpxWAPDmxfhBr16ybv4
         GvBQ46p8H6C8tvlxJrCs5vX3RhV6K1uAUpvVfsnvP8erEMJh5JLrAtJ+hhzYTGB6gSeG
         gp9BGrepkgoawJOMUVe8MkEu3RCdxkNgA2ZAY1YqT0/tEb2GQfegVJz+cp2ichA6O/7E
         o++KxDVVjUTjtBIErR7ZM7ZgYTL1kfBHatjKKgLWlNXG8X4KE0r2gDAKrtsbcMRUSIg/
         IT9nHOCpUqOpkpPQZEHLQJRKHxhGcFIUdUwJm8DW7zEQDl0gqWtEclO7diO7NxSCw24W
         KxDA==
X-Gm-Message-State: APjAAAW1RHQZPa1D3w97B/5t+QzpNgLIWtn0nYc+aUv4n96VjVbUaphs
        D/h6w+tgDe6I64ceE+4JsJs=
X-Google-Smtp-Source: APXvYqxnQk2WPGlsBCZXZQu9NJFObYjPab0Ld/NBPiUpclVSBl5TMw7Jm8xAVB7UmcgqDAm5nCZY7A==
X-Received: by 2002:aed:3a03:: with SMTP id n3mr22246315qte.85.1565449313499;
        Sat, 10 Aug 2019 08:01:53 -0700 (PDT)
Received: from localhost.localdomain ([187.34.245.102])
        by smtp.gmail.com with ESMTPSA id 47sm58079273qtw.90.2019.08.10.08.01.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 08:01:53 -0700 (PDT)
From:   Rodrigo <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH] staging: iio: accel: adis16240: Improve readability on write_raw function
Date:   Sat, 10 Aug 2019 12:00:58 -0300
Message-Id: <20190810150058.3509-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Rodrigo Carvalho <rodrigorsdc@gmail.com>

Improve readability by using GENMASK macro, changing switch statement
by if statement and removing unnecessary local variables.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 62f4b3b1b457..68f165501389 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -309,17 +309,15 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	int bits = 10;
-	s16 val16;
+	int m;
 	u8 addr;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16240_addresses[chan->scan_index][0];
-		return adis_write_reg_16(st, addr, val16);
-	}
-	return -EINVAL;
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
+
+	m = GENMASK(9, 0);
+	addr = adis16240_addresses[chan->scan_index][0];
+	return adis_write_reg_16(st, addr, val & m);
 }
 
 static const struct iio_chan_spec adis16240_channels[] = {
-- 
2.20.1

