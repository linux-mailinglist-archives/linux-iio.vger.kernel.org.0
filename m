Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1600042E027
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJNRki (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 13:40:38 -0400
Received: from meesny.iki.fi ([195.140.195.201]:58788 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhJNRki (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Oct 2021 13:40:38 -0400
Received: from groot.intra.skream.org (mobile-user-2e84bd-76.dhcp.inet.fi [46.132.189.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pekka.korpinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 5DEF820054;
        Thu, 14 Oct 2021 20:38:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1634233111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q8+w7okSOx/BOQbKgOezP2IcqpFc5kkNNTtE4GU2tNM=;
        b=PPpG0Im+ZeXouQ6uCp62sDUMtmwNlZ+ZXbZw1Xlw8nAQmcvaCAsIvyNHTNbyembmXe2iwj
        NZH2B/XhELK2L5OzxKfI7zqJ5IJ+5KqDNvsLe4a9ZCDZOwjoQWDdrHBzccGKCIWdXmy3k/
        z5CDdEQX0S3dXVcFt2Iywj5LkJOi5IA=
From:   Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     Pekka Korpinen <pekka.korpinen@iki.fi>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] iio: dac: ad5446: Fix ad5622_write() return value
Date:   Thu, 14 Oct 2021 20:37:38 +0300
Message-Id: <20211014173738.2446-1-pekka.korpinen@iki.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pekka.korpinen smtp.mailfrom=pekka.korpinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1634233111; a=rsa-sha256; cv=none;
        b=vKuDbYDbq8iU6jE2Hfw1xELLKCxsYVlJYaPz5XPfW5YKRuLURpkPnrbVMmzN7ipy+bW7pR
        YaADd6xt9FWjyPAFlEDhMhI80nHegMRzlafI7rg2nXVmasTrAqN9rBK9Ci/vEZ77GjdU3E
        o8srsSYmkykEfs0a0us7ArtwHClFU2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1634233111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q8+w7okSOx/BOQbKgOezP2IcqpFc5kkNNTtE4GU2tNM=;
        b=aPaJ7qRs6m73yrtx7gbPW96SK1nq+LpNXeoHhCAFgR3Pe0sLO51vJvXg2ZcBn2rRBUToDA
        DmOv0v4GuCT3kDK3hyTl/jN+IB6SAC7thcsNMiB5VQH5OpakAR/t4Hyg7zPzRiB+iKN15Q
        0CLHp7AU8vf8/90C0VCpgEatCjvO4Yo=
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On success i2c_master_send() returns the number of bytes written. The
call from iio_write_channel_info(), however, expects the return value to
be zero on success.

This bug causes incorrect consumption of the sysfs buffer in
iio_write_channel_info(). When writing more than two characters to
out_voltage0_raw, the ad5446 write handler is called multiple times
causing unexpected behavior.

Fixes: 3ec36a2cf0d5 ("iio:ad5446: Add support for I2C based DACs")
Signed-off-by: Pekka Korpinen <pekka.korpinen@iki.fi>
---
v1->v2: Check against expected result, otherwise -EIO. Add Fixes tag.

A similar bug was fixed for ad5064.c in 2015 - commit 03fe472ef33b
("iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success").

 drivers/iio/dac/ad5446.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 488ec69967d6..e50718422411 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -531,8 +531,15 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
 {
 	struct i2c_client *client = to_i2c_client(st->dev);
 	__be16 data = cpu_to_be16(val);
+	int ret;
+
+	ret = i2c_master_send(client, (char *)&data, sizeof(data));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(data))
+		return -EIO;
 
-	return i2c_master_send(client, (char *)&data, sizeof(data));
+	return 0;
 }
 
 /*
-- 
2.33.0

