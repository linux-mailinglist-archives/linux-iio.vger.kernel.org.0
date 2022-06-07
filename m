Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59453197D
	for <lists+linux-iio@lfdr.de>; Mon, 23 May 2022 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiEWSxC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 May 2022 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbiEWSvr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2022 14:51:47 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4CE74DE7;
        Mon, 23 May 2022 11:37:27 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C70E25FD03;
        Mon, 23 May 2022 21:37:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653331043;
        bh=Noow5oi6zcHI2WlvLtYK0Gx0bcKlwtT8V+5kTBP2c6I=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=O0jSIUTM4hNah88u7snuulxaVkfltJpOaEmp3UWmlDwCQgw8KYrg91PCuNIqBSuIc
         xt2ySfSwJOAXgl3m1fBZtfX5yMNqzxUQTBHVlv3WzhDD4x4Uxqp9NZhkMgcbR+YNXw
         fjmCqZPRW7WrAaQYZlMutJnGEEg0Mud6RgLY/tYSh+9Vmur/FBVIc2eH9yJtUwqIT4
         0EONHD3qEXArZ39PALpqdyodu8SB1/hRg2deax/Nhf0Wxp/Eq6drfcwySKhpukal5J
         aUJ2tDrxeJFi0DVxQKi5Y1rjmXp7ii3jxNIb1egDPSdpaSN9eem9P43LNXjw34cmPf
         G2YK8F9U6Zw7Q==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 23 May 2022 21:37:23 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 5/5] iio:humidity:hts221: rearrange iio trigger get and
 register
Thread-Topic: [PATCH v1 5/5] iio:humidity:hts221: rearrange iio trigger get
 and register
Thread-Index: AQHYbtQFJ4IV8bnfCkSEgy51IjLtng==
Date:   Mon, 23 May 2022 18:36:30 +0000
Message-ID: <20220523183716.20360-1-ddrokosov@sberdevices.ru>
References: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/23 11:48:00 #19537323
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO trigger interface function iio_trigger_get() should be called after
iio_trigger_register() (or its devm analogue) strictly, because of
iio_trigger_get() acquires module refcnt based on the trigger->owner
pointer, which is initialized inside iio_trigger_register() to
THIS_MODULE.
If this call order is wrong, the next iio_trigger_put() (from sysfs
callbacks or rmmod) will derefence "default" module refcnt, which is
completely incorrect.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/humidity/hts221_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/ht=
s221_buffer.c
index f29692b9d2db..66b32413cf5e 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -135,9 +135,12 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
=20
 	iio_trigger_set_drvdata(hw->trig, iio_dev);
 	hw->trig->ops =3D &hts221_trigger_ops;
+
+	err =3D devm_iio_trigger_register(hw->dev, hw->trig);
+
 	iio_dev->trig =3D iio_trigger_get(hw->trig);
=20
-	return devm_iio_trigger_register(hw->dev, hw->trig);
+	return err;
 }
=20
 static int hts221_buffer_preenable(struct iio_dev *iio_dev)
--=20
2.36.0
