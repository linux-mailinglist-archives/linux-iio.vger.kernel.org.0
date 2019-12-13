Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA811E4EE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLMNve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 08:51:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:28576 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMNve (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 08:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576245089;
        s=strato-dkim-0002; d=plating.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=GrbxwfJz6yuL1YHObJbY9zhNL1/QwfFLShtuNOP96gE=;
        b=fgWGTjjbe0MUwle3kWVYaQXb9x+nelGeEVQgb+/rqZn9ufPB2wIobrhGt2NXTIdwlh
        43zIICu6cmuw71/tJn056ScQWDO4Mz4c4YHUvjSeODgOljGmhTzXGPqcLB7r4tDgoeWK
        zhoZ83NpNg4X49n67WtT6MaLhCxAp10WXvDy+CIv1LXVECmTgVCNhZG2sW0xE/UL0e99
        C/6XLots9ph+t3kcqie/ia70OEYH1iLylRZ9PZLxHv1mDy7f64s5yc70OrtLdmtVmQx9
        nMLHTZb//UYmIw6tn+KnptjWgC4xdFkwzMkyxMYRZEpp5bZ0kVTyuc8WBFVCZtg5+Qex
        PyiQ==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.0.7 AUTH)
        with ESMTPSA id n050dcvBDDpS5ZK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 13 Dec 2019 14:51:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 60D04122249;
        Fri, 13 Dec 2019 14:51:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G_RFj11k10CL; Fri, 13 Dec 2019 14:51:23 +0100 (CET)
Received: from localhost (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id A14071203F9;
        Fri, 13 Dec 2019 14:51:22 +0100 (CET)
From:   =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
Subject: [PATCH v3] iio: buffer: align the size of scan bytes to size of the largest element
Date:   Fri, 13 Dec 2019 14:50:55 +0100
Message-Id: <20191213135055.9401-1-lars.moellendorf@plating.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Previous versions of `iio_compute_scan_bytes` only aligned each element
to its own length (i.e. its own natural alignment). Because multiple
consecutive sets of scan elements are buffered this does not work in
case the computed scan bytes do not align with the natural alignment of
the first scan element in the set.

This commit fixes this by aligning the scan bytes to the natural
alignment of the largest scan element in the set.

Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable much more general.")
Signed-off-by: Lars Möllendorf <lars.moellendorf@plating.de>
---
v3:
  - Fix the problem description in the commit message
  - Add "Fixes" tag

v2:
  - Fix subject of patch which marked it the first in a set of three.
  - Add a description of the problem in the commit message

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
