Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3212241B7D4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbhI1T6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhI1T6k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 15:58:40 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EEC06161C;
        Tue, 28 Sep 2021 12:57:00 -0700 (PDT)
Received: from groot.intra.skream.org (mobile-user-2e84bb-13.dhcp.inet.fi [46.132.187.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pekka.korpinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5DCBA1B001C6;
        Tue, 28 Sep 2021 22:56:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1632859014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Pv7C2sMIx0ey5J4LhX0/v7PZ370uBe7XXywiIOBNGQ=;
        b=N5cdWZo5f0iZhZCl48laTsYsGQUaLOkwDmp3HcAa/N4DvnvHcscGWgyQlQeomkLKmsRLSB
        vrz3pG6UDEg91gLwLy3ePX8TgrqV51xQMKnOht5+XqAefMiNY+AjFxFMZGKgxqR+itNbCH
        7fAAYdYjsFtxfBGWNCcbxseH8P/bcaZLgxV5YCe/8RocwILET9EGZcRINystQ0zYAOhrV0
        7ZC8MtVo0mRmxYgf7qZeSjdtrQ5LZMCcrSqQ7gDibWfDooFGn5+h6U1Jklano/bEWN2REM
        OzK8O096WVUwIE7L9+hMuz055Ue+JQt8fUZ9yIC7nAGY2XD8eK5HzPphNRp8YQ==
From:   Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     Pekka Korpinen <pekka.korpinen@iki.fi>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: ad5446: Fix ad5622_write() return value
Date:   Tue, 28 Sep 2021 22:55:48 +0300
Message-Id: <20210928195548.17846-1-pekka.korpinen@iki.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1632859014; a=rsa-sha256;
        cv=none;
        b=leupTbo/KG6HZyN/d+683TfdU7qJ6HyyJl/bz6ptXNZt1niXAvQcwv3LsfKWXoWG+ZHeTs
        01wZuHBQHClSSCR0QZBcpiCQzb3J7aDSOysENtao0cZKRLNnZqLumN1Rf6KaWii8QjiWUu
        VhFja23DQJx+LVE9H21+4d7pofc3jEhKduh/tcae2dl2C8Ht4I1j+dOPzxmpIgWe49W3ji
        xUMV0fe4HhH5qo2i8L6ofcSkOazENSQcfbThf4XcFZIRnO/0LGTV1iktEzv4YpDNFoLEUZ
        kYa658LvYpma3zA2fv6BXdOTO5IiDRJrr2N5S3ZhdXb8vQrwl2N1cvmQZFM2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1632859014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Pv7C2sMIx0ey5J4LhX0/v7PZ370uBe7XXywiIOBNGQ=;
        b=KQOImEur8j3QAA7RgVuLK2oXMbojnO7ErjPgEJC13ZhMm1rKnlkEzFxGBigIwSyyyfcRCv
        wWUoxu2PvFcXb2woQGzYfPb5mg1+JQZyCMI9i5JyDaEXgUugFk8SnOGJ+P2jsfpKlcCdRU
        iF+F+ZFNPvvBH1Nzy9yN41N3SjEjtwRGTZgtKw9lthBqs3qWilUSsWwSBBVZ9FpC31rEd+
        aK14cwS9ZqNUXDOC3X9Ucc4POOwY3KDck9euCoUAvGA21EOYKyAKIgONNRYkk97FRWpl9z
        lBpsCdLgq/44u7J1/BX7FUuC3FOOigKISYw7QtJ7onboUspujj5GUBUOV40Kmg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pekka.korpinen smtp.mailfrom=pekka.korpinen@iki.fi
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On success i2c_master_send() returns the number of bytes written. The
call from iio_write_channel_info(), however, expects the return value to
be zero on success.

Signed-off-by: Pekka Korpinen <pekka.korpinen@iki.fi>
---
This bug causes incorrect consumption of the sysfs buffer in
iio_write_channel_info(). When writing more than two characters to
out_voltage0_raw, the ad5446 write handler is called multiple times
causing unexpected behavior.

A similar fix was applied for ad5064.c in 2015 - commit 03fe472ef33b
("iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success").

 drivers/iio/dac/ad5446.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 488ec69967d6..dfd541bbde5b 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -531,8 +531,13 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
 {
 	struct i2c_client *client = to_i2c_client(st->dev);
 	__be16 data = cpu_to_be16(val);
+	int ret;
+
+	ret = i2c_master_send(client, (char *)&data, sizeof(data));
+	if (ret < 0)
+		return ret;
 
-	return i2c_master_send(client, (char *)&data, sizeof(data));
+	return 0;
 }
 
 /*
-- 
2.33.0

