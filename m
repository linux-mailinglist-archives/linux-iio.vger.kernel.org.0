Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96F841CC38
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbhI2TAf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345545AbhI2TAe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 15:00:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F858C061764;
        Wed, 29 Sep 2021 11:58:53 -0700 (PDT)
Received: from groot.intra.skream.org (mobile-user-c1d306-252.dhcp.inet.fi [193.211.6.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pekka.korpinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 130E11B0030E;
        Wed, 29 Sep 2021 21:58:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1632941929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8+w7okSOx/BOQbKgOezP2IcqpFc5kkNNTtE4GU2tNM=;
        b=H6Gg6oppKtqB6daVI5wijl1SO9wUfpUNmO56KdK1lBxz/3/PD+zbYwkC4ysPk19AAUFkj5
        hN7gOkGJ+cq1ZG0l2h7qQ5NblX7v7tTo4q9q2LqiE6Si7M+39UfNpX8I9fRgGrkOPqJTVa
        /uzJMyTbv84ctCTVdATwm5POYi61lKqrglJuOhEqvaDBN4vG6a4NI6cHqfxyO6xeDziTqM
        Vv4KOHzTVXkPPZQ3C/7OYfkVRR9XLb7m5k1b8Y/975oJLwr5mGFaL+dO5OO9gGMHpgCdtb
        9YGu8Zomb//WRgbr5DStAG8ngBvrp+AW7/yvce1rBlvs6bcyVSgy+nwvQWbaeA==
From:   Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     ardeleanalex@gmail.com, Pekka Korpinen <pekka.korpinen@iki.fi>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: dac: ad5446: Fix ad5622_write() return value
Date:   Wed, 29 Sep 2021 21:57:55 +0300
Message-Id: <20210929185755.2384-1-pekka.korpinen@iki.fi>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20d11fbb-ba93-802c-1abc-60d7f5ec0c0c@metafoo.de>
References: <20d11fbb-ba93-802c-1abc-60d7f5ec0c0c@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1632941929; a=rsa-sha256;
        cv=none;
        b=gRK6Mj6XPgfueCre46YyQpkrTNdwGWfXt0cm6WROwxUF0ktQ/UXEwxM9emBkIBQSG7GsWl
        XkccYQSdMFVnBb+czSFeUudOTnsAPTxkrHUG5rQdzFHbB3neMJ47lR1JcmQ15Qd5aNJ/6h
        hD1iytgM8vHMqgJAH789MjA9xQ6vlb8OA516EUEpBtDEv66ELZKi0OH9FkejnGCuuvHfPw
        Djm1JpZPkdmAWkd8fe7FT1twV3HxJV+jfF37riFmSWbaITtWZRUv8964gEnZkqlsrndk8s
        Uv2Nmwu/vOjKZ3p0hzFSoFVh7MQnLdiDK+8S2zH2aIf3QTEUnyzKlIRR8+ebRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1632941929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8+w7okSOx/BOQbKgOezP2IcqpFc5kkNNTtE4GU2tNM=;
        b=eqe3BqIuuauGAf9HJLzxwnA8m3dWpQqU78+6ETjvPv4o+RSjcMIAwWnXh0g+mrZuUq8pAU
        seAiJ87VCdxaIPRrZwEpYmvOJ5pM+M0pp8wdrzVEIIC6A9CxuOynjfFv9aiYVtC3xEf+5m
        VVEvclqvV4yDXz7uirwjHZ5S8U4fge52dpFnooWRzZ95MXlw9SZBQ7k+jU2x+DlC5/d9Sk
        46Vj4Qcw1/2f9p/6h6NMGAWpv9W60gIeTQ95YSJrUxhJwUxf2wJABBsgIJKsmK1tjXqwsl
        C2glSjNjK9qHpyiEWIfQuWC8XaRHarR799Q+p38y05LaTvYVhQMoVhnIrn25yA==
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

