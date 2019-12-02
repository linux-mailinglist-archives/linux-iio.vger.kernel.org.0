Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7D10EB92
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 15:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBOeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 09:34:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:26870 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOeC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 09:34:02 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 09:34:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575297239;
        s=strato-dkim-0002; d=plating.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zvdNi3Ok7fddwEefkPFZZWgaMN09dK5U0z/nnKEfTRU=;
        b=c66ZM8Gz8GGGbf7hHkoOVG3uiDBrOCq6lZoXwHNHC+o/Dkby4mPaV6KR8EDbLUDPlo
        rOVDMfGSQiYKFekqhpDdZVV13pZD2fBnXELRyNr8QMoMsaMrL5lZ6yS2ksoqDBH/1o5M
        c90YkfUgzF4u9DwGTpNGQZE1Ej6UrRx2Rca9Dq3RRHQopgk7wevXwjKhHNEUED9LPHNW
        c5eoPrl22fvemHg7FuSNUl2YXSbyQ5vtLlYpOsrXhFoja9MDXBfNzhSQwVmY0qqXFIwj
        8vfC/T0bPcxBOGNntjSmENAAO30xWn5vhOWCWF3BvH8WCcUbBb4QfIdUlaVw11axkIeA
        tPUA==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id n0aa50vB2ERw09a
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 2 Dec 2019 15:27:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 68B8A12221B;
        Mon,  2 Dec 2019 15:27:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cEANVX3Wy4jk; Mon,  2 Dec 2019 15:27:53 +0100 (CET)
Received: from localhost (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id 5D06F120446;
        Mon,  2 Dec 2019 15:27:52 +0100 (CET)
From:   =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
Subject: [PATCH] iio: buffer: align the size of scan bytes to size of the largest element
Date:   Mon,  2 Dec 2019 15:27:14 +0100
Message-Id: <20191202142714.12030-1-lars.moellendorf@plating.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
References: <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Previous versions of `iio_compute_scan_bytes` only aligned the current
element to its own length (i.e. its own natural alignment). This worked
in case the length of each channel's scan elements had been smaller then
the length of the successive channel's scan elements.

E.g.

u16
u32 <- aligned to its natural alignment

But if the length of a channel's scan elements is greater then the
length of scan elements of the consecutive channel no alignment had
been taken into account. This is however needed to preserve the
alignment for multiple consecutive sets of scan elements.

u32 <- alignment is off by two byte for the second set of scan elements
u16 <- no alignment takes place

This commit fixes this by aligning the scan bytes to the size of the
largest scan element.

Signed-off-by: Lars Möllendorf <lars.moellendorf@plating.de>
---
 drivers/iio/industrialio-buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5d05c38c4ba9..2f037cd59d53 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				const unsigned long *mask, bool timestamp)
 {
 	unsigned bytes = 0;
-	int length, i;
+	int length, i, largest = 0;
 
 	/* How much space will the demuxed element take? */
 	for_each_set_bit(i, mask,
@@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 		length = iio_storage_bytes_for_si(indio_dev, i);
 		bytes = ALIGN(bytes, length);
 		bytes += length;
+		largest = max(largest, length);
 	}
 
 	if (timestamp) {
 		length = iio_storage_bytes_for_timestamp(indio_dev);
 		bytes = ALIGN(bytes, length);
 		bytes += length;
+		largest = max(largest, length);
 	}
+
+	bytes = ALIGN(bytes, largest);
 	return bytes;
 }
 
-- 
2.23.0

