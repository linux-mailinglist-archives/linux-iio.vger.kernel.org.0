Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A417510EA4C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 14:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLBNCD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 08:02:03 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13842 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfLBNCD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 08:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575291721;
        s=strato-dkim-0002; d=plating.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8xw/PUSaR2bRWaDcLTWw0lYR54+NRptSDf9HXpq4ORE=;
        b=fhQJLeZcq3GF/cgOwlGjFN9I3hhP+1+ztzx3Cn8kgkpfczDrSfLIiWhqsb9y6261p+
        wlSmRw7OBc4w3o03AZ2r9ZMuUFiRDSAXsVysKcu5JVqwsvzCOpZO6v+xctVyd2XSPSlE
        LbbCsqQleD+gI6Z6UjUtQ6tD4SWWxkNlFfdY1lcP/OpyulFWpfcjHv7peukW+wlGp6G0
        XJ5+z6t8m4y9fqWrSUUm1c1WRQAsJZnpN24tE5BzAHOyuhfpVgPhBRo85o25z6Y720Iw
        UF9lqF5LHcmowkDfSTykhw3ukgd6m1CPxJ3HZsjFIRkLVYKNYQIEH8dIU8MvYD4OC6Qk
        sUnQ==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id c0a227vB2D2012L
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 2 Dec 2019 14:02:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id CE302120433;
        Mon,  2 Dec 2019 14:01:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3mLCG84bPhqu; Mon,  2 Dec 2019 14:01:55 +0100 (CET)
Received: from localhost (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id AD72A120432;
        Mon,  2 Dec 2019 14:01:53 +0100 (CET)
From:   =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
Subject: [PATCH 1/3] iio: buffer: align the size of scan bytes to size of the largest element
Date:   Mon,  2 Dec 2019 14:01:13 +0100
Message-Id: <20191202130113.24005-1-lars.moellendorf@plating.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <810ab64f-31bf-c4af-a655-7bddf364dae4@metafoo.de>
References: <810ab64f-31bf-c4af-a655-7bddf364dae4@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

