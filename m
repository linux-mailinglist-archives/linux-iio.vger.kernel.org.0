Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1D8C18A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfHMTbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 15:31:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37502 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfHMTba (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 15:31:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so107594471qto.4;
        Tue, 13 Aug 2019 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZrsJ75uAl0CvFW97qeOMuBabIxioxFuZCHkYM94A0LA=;
        b=oeUsGepxWxGwvAWqyLXN21B4JepvWUV9hHbolgX2xKRyBoUoRrxCEddc4hAtHT7HQ+
         AoGnnCk3xWvxMnSmHdAk5aCTAE7fCx7UhHQI3uTM40S6/5E07y/arn0Lek8qRxQOxBuP
         TV3lGCGcNuGw+zYZGj5NTx1fc7zCiJgDk1xjJ8X/ewyQcNAgQodATlqbCVeq7ynHJQhj
         8xGZkD5otdl/CmNVMLERUUQjGYc1NBi62Nlnk9ih6xntQI6cwyGrS8tS0MnI+kSXnv4s
         yR78QP1gwLm77D+paUklwomMEzbYtajHT3C2V2KTZFQpsvOdzRiy/99dKhisq8+oyIfV
         9f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZrsJ75uAl0CvFW97qeOMuBabIxioxFuZCHkYM94A0LA=;
        b=iUgW++zOBS1kFXWlr0zC513lf4CZJT9Hiqc2UH9JmgcqQFp3yLkiFwT6zxDZ0UJJ5y
         26E2xXZ6WjElWIw3HdcD+pzAj1PrpOIK1MO0N3S0baZhjPYIe9MyTAV7ki0fwscgiVtj
         x8E3RNhMhyPwtCvS78fHyoBAWsYRSsKDN2P6PIfRLQCZ6wfff7lMLN1Ta6C9TWyvDZzs
         wBok/D5ux0+HHebBKyNJpFulpvcGT6qNnO8BlQiRQzI9fqFAqIK750NsT4XyFpxJIOZW
         hHMxupIHJG+pVzDCxm9WnnlKc+jPPKrL1NL1D/q/v7jaCLUVq83wfj0prdmaJCsZrjxn
         3VXw==
X-Gm-Message-State: APjAAAWSL0TbNUGKOGOq2ES2oyXFAX97oymP+YDfdYJhbkI1HIULiKRN
        x/QPaLtarQwByTK7fdLF/Mk=
X-Google-Smtp-Source: APXvYqyE30ghXoW4lyuazBzGdIN1K2YIYdWEw1TaM6LGrPL7xJwCrZqQ6LKihXqLCTqfIS7vkKFSEA==
X-Received: by 2002:ac8:2b47:: with SMTP id 7mr26123152qtv.116.1565724689118;
        Tue, 13 Aug 2019 12:31:29 -0700 (PDT)
Received: from rodrigo-note.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 145sm2382399qkm.1.2019.08.13.12.31.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 12:31:28 -0700 (PDT)
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-usp@googlegroups.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v2] staging: iio: accel: adis16240: Improve readability on write_raw function
Date:   Tue, 13 Aug 2019 16:31:01 -0300
Message-Id: <20190813193101.26867-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace shift and minus operation by GENMASK macro and remove the local
variables used to store intermediate data.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
v2:
   - Leave switch statement instead of replace by if statement
 drivers/staging/iio/accel/adis16240.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 62f4b3b1b457..82099db4bf0c 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -309,15 +309,12 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	int bits = 10;
-	s16 val16;
 	u8 addr;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		val16 = val & ((1 << bits) - 1);
 		addr = adis16240_addresses[chan->scan_index][0];
-		return adis_write_reg_16(st, addr, val16);
+		return adis_write_reg_16(st, addr, val & GENMASK(9, 0));
 	}
 	return -EINVAL;
 }
-- 
2.20.1

