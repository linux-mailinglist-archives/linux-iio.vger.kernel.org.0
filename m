Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70E682EA8
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 15:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjAaOBp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 09:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjAaOBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 09:01:32 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BAC4FC2C
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675173674;
  x=1706709674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m3KwEkQqMf2ozAw8CcAUkARFwgX+f8plKEMQb9rDv64=;
  b=ToxEqK7TvAW+kIO3MQJab+pVqRLDvEhFh4PDvrngEf59PWJCFVaRD6lx
   nEdHijpmg7iRdjj8ASsnGFF4+j3TJFJZD3JoP18kEuqcbKdmQLMrpnwub
   KtV2jF5EMXqz7oie4LFFXPw21ndhPW48zERmEPK2kqbmt8y3//p1+EppQ
   LktD9bjcesOBj6AfrTjEFisdG/tc1/PhyNGgYjXMOU//VEKLFi86yO9J8
   k2klwp26qNWMglahyAFmvFb5o93BawI2qaJK75P1erDRpl9Tb1u1ybwrA
   Lnn9HQ8+n9/fCeDt5LozKens6D8vn+YdV5MpTIWHi1l6pkvKw7XVJXMLf
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Date:   Tue, 31 Jan 2023 15:01:09 +0100
Message-ID: <20230131140109.2067577-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are different init functions for the sensors in this driver in
which only one initializes the generic vcnl4000_lock. With commit
e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
the vcnl4040 sensor started to depend on the lock, but it was missed to
initialize it in vcnl4040's init function. This has not been visible
until we run lockdep on it:

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
  Call trace:
  __mutex_lock
  mutex_lock_nested
  vcnl4200_set_power_state
  vcnl4200_init
  vcnl4000_probe

Fix this by initializing the lock in the probe function instead of doing
it in the chip specific init functions.

Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v3:
 - Trimmed backtrace in commit message even more
 - New line before mutex_init

v2:
 - Trimmed backtrace in commit message
 - Have 12 digit sha-1 id in Fixes tag
 - Make the lock initialization in probe instead of in _init function

 drivers/iio/light/vcnl4000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cc1a2062e76d..69c5bc987e26 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -199,7 +199,6 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
-	mutex_init(&data->vcnl4000_lock);
 
 	return data->chip_spec->set_power_state(data, true);
 };
@@ -1197,6 +1196,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
+	mutex_init(&data->vcnl4000_lock);
+
 	ret = data->chip_spec->init(data);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

