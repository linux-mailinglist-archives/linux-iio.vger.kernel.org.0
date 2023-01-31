Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1228682A8D
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjAaKaB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 05:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAaKaA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 05:30:00 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D84C6C9
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675160997;
  x=1706696997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYRZ0qDTV1jqiyRnNxqnCtMnM79B0pnr9Yt5Xu3e8Bs=;
  b=iruiLl2UNChGxuF5qLscwvQ6Mugm/OSW/nGSq1Zbt5D6BTToguGX13+X
   dSfMrkSyb2Pc7VISvTXT7zkIPbCJAaP1UB67YLYfNQ2PNqWQVHIc3cb8p
   QsdQQ/rwf3WbcTIK/qFJ7D4OG2GbCjCNgfrf3+iLIj4T//LhyfLCESWD3
   C3LyuzkvgiVLo7L0zmvniLzsfADbFPWWz39xbkCqwPjSOBZ5fJ96Qf9ef
   DskF1nRLfyP5fku0B76B+R6i1Snwopzgc0fbZAiCQb3KDXsnsg/kdJU1o
   tWsitQ7lft/tduk7+6FpqE4b+/aQkFZLgA13SwJD1Qt716olpfOhotAyt
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Date:   Tue, 31 Jan 2023 11:29:51 +0100
Message-ID: <20230131102951.2012021-1-marten.lindahl@axis.com>
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
which only one initialize the generic vcnl4000_lock. With commit
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
  i2c_device_probe
  really_probe
  __driver_probe_device
  driver_probe_device
  __driver_attach
  bus_for_each_dev
  driver_attach
  bus_add_driver
  driver_register
  i2c_register_driver
  vcnl4000_driver_init
  do_one_initcall
  do_init_module
  load_module
  __do_sys_finit_module

Fix this by initializing the lock in the probe function instead of doing
it in the chip specific init functions.

Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Trimmed backtrace in commit message
 - Have 12 digit sha-1 id in Fixes tag
 - Make the lock initialization in probe instead of in _init function

 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b5d398228289..caa2fff9f486 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -208,7 +208,6 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
-	mutex_init(&data->vcnl4000_lock);
 
 	return data->chip_spec->set_power_state(data, true);
 };
@@ -1366,6 +1365,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 	data->client = client;
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
+	mutex_init(&data->vcnl4000_lock);
 
 	ret = data->chip_spec->init(data);
 	if (ret < 0)
-- 
2.30.2

