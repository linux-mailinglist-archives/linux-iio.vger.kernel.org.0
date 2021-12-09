Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB046ECE7
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhLIQV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Dec 2021 11:21:28 -0500
Received: from www381.your-server.de ([78.46.137.84]:41288 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbhLIQV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Dec 2021 11:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+l5iBLZo4YyqZmfOoWMoRQdxUhEzjK+rR5duTgR7f+g=; b=JWDzpDYKNOacrKtH961DxWAMGZ
        CbXLOFXI3aj5ivYEpvjPRD4kHmefWUgpJh13guqZgKQ/SJylN0+Fqs4wxgIQtCkujaHcmkb4UTmzq
        nph52/j56e47jW8Fqwr7bXxEipJ/49iA1gYir4eLSMjgwtpKgrHx7SpvZ5Urfyf0YpHtiMl2NuBIn
        /1Kp2Bzmfzhbc2Hu5i3uZKM8IPNnAQUwhlp+dBY0xrxL3FMSx52ZLGcaKNbmIJX6ho3sSV/Z2xTYp
        jtTWWLRMCcQ4l6eWpzyDkWh1jSRHb8co964TgKLNFE8qllF5bJke1B27qVur49KIW8gByp/x6Kzmv
        MHg9A2Rw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mvM7E-0007zf-VL; Thu, 09 Dec 2021 17:17:52 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mvM7E-00083w-Pl; Thu, 09 Dec 2021 17:17:52 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: vz89x: Remove unnecessary cast
Date:   Thu,  9 Dec 2021 17:17:30 +0100
Message-Id: <20211209161730.396848-3-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209161730.396848-1-lars@metafoo.de>
References: <20211209161730.396848-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26378/Thu Dec  9 10:21:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The case to u8 * is unnecessary here since the expression is already of
type u8 *.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/chemical/vz89x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 23b22a5f5c1c..e7e1c74a351e 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -242,7 +242,7 @@ static int vz89x_get_resistance_reading(struct vz89x_data *data,
 					struct iio_chan_spec const *chan,
 					int *val)
 {
-	u8 *tmp = (u8 *) &data->buffer[chan->address];
+	u8 *tmp = &data->buffer[chan->address];
 
 	switch (chan->scan_type.endianness) {
 	case IIO_LE:
-- 
2.30.2

