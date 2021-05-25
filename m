Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3738FD25
	for <lists+linux-iio@lfdr.de>; Tue, 25 May 2021 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhEYIug (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 May 2021 04:50:36 -0400
Received: from new.vh-s.de ([178.63.54.93]:41092 "EHLO new.vh-s.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhEYIuf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 May 2021 04:50:35 -0400
X-Greylist: delayed 1577 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 04:50:35 EDT
Received: from p4ff90040.dip0.t-ipconnect.de ([79.249.0.64] helo=vhssv2.vhs)
        by new.vh-s.de with esmtpsa (TLS1.2:RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <knopf@vh-s.de>)
        id 1llSKj-0005Ab-8J; Tue, 25 May 2021 10:22:37 +0200
Received: from [10.1.0.22]
        by vhssv2.vhs with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <knopf@vh-s.de>)
        id 1llSKi-0002tG-Ue; Tue, 25 May 2021 10:22:37 +0200
From:   Felix Knopf <knopf@vh-s.de>
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
To:     "Li, Meng" <Meng.Li@windriver.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
 <20210519092104.pntanimcjg6s6fca@pengutronix.de>
 <PH0PR11MB51913E1982E3208302CE29CCF1269@PH0PR11MB5191.namprd11.prod.outlook.com>
Message-ID: <45829810-7921-3150-6df1-c19ffcb2ae6f@vh-s.de>
Date:   Tue, 25 May 2021 10:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB51913E1982E3208302CE29CCF1269@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 79.249.0.64
X-SA-Exim-Mail-From: knopf@vh-s.de
X-SA-Exim-Scanned: No (on new.vh-s.de); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> On Wed, May 12, 2021 at 12:57:25PM +0800, Meng.Li@windriver.com wrote:
>>> When read adc conversion value with below command:
>>> cat /sys/.../iio:device0/in_voltage0-voltage1_raw
>>> There is an error reported as below:
>>> ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transfer
>>> issue is introduced by commit 69548b7c2c4f ("iio:
>>> adc: ltc2497: split protocol independent part in a separate module").
>>> When extract the common code into ltc2497-core.c, it change the code
>>> logic of function ltc2497core_read(). With wrong reading sequence, the
>>> action of enable adc channel is sent to chip again during adc channel
>>> is in conversion status. In this way, there is no ack from chip, and
>>> then cause i2c transfer failed.

Hi,

I came across the same or a very similar issue with the ltc2497 but took
a different approach to solve it.  I suspect this issue is caused by a
suboptimal I2C access pattern.

The ltc2497 triggers a new conversion on the stop condition of
transactions addressed to it.  As the chip cannot communicate during a
conversion, it will not ACK until it is finished.  The current driver
produces the following sequence to read from an arbitrary channel:

ltc2497_result_and_measure(…, NULL);
1) S <ADDR> W A | <CONF> A | P    (select channel)

2) [sleep 150ms]                  (wait for conversion)

ltc2497_result_and_measure(…, val);
3) S <ADDR> R A | <data> … | P    (read data)
4) S <ADDR> W N | P               (chip is busy, error)

Transaction 3 triggers a new conversion on the previously selected
channel and causes the following channel select (4) to fail.  The
examples in the datasheet [1] make use of repeated start conditions to
prevent unintended triggers.  In our case, 3 and 4 should be combined
into one transaction.

Limeng's patch sikps 4 which solves the problem but causes issues at
high sample rates, were 1 is skipped by the core.

I attached my ad-hoc solution below.
@Limeng: Could you test this with your hardware?

If there is interest, I will prepare a proper patch.
(Should that go into a new thread then?)

Regards, Felix

[1] https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf#page=18

-- 
Felix Knopf
von Hoerner & Sulger GmbH
https://vh-s.de


diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 1adddf5a88a9..8968bf70859b 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -34,20 +34,23 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
        int ret;
 
        if (val) {
-               ret = i2c_master_recv(st->client, (char *)&st->buf, 3);
+               ret = i2c_smbus_read_i2c_block_data(st->client,
+                                                   LTC2497_ENABLE | address, 3,
+                                                   (char *)&st->buf);
                if (ret < 0) {
-                       dev_err(&st->client->dev, "i2c_master_recv failed\n");
+                       dev_err(&st->client->dev, "i2c transfer failed\n");
                        return ret;
                }
 
                *val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
+       } else {
+               ret = i2c_smbus_write_byte(st->client,
+                                          LTC2497_ENABLE | address);
+               if (ret)
+                       dev_err(&st->client->dev, "i2c write failed: %pe\n",
+                               ERR_PTR(ret));
        }
 
-       ret = i2c_smbus_write_byte(st->client,
-                                  LTC2497_ENABLE | address);
-       if (ret)
-               dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
-                       ERR_PTR(ret));
        return ret;
 }
