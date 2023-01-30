Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3326E6809B5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 10:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjA3Jia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 04:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjA3Ji3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 04:38:29 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F2EC51
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 01:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675071480;
  x=1706607480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=joCa851O+vDPqv/b/deX49xWa/02AHOuCQyABIBPMQo=;
  b=djKb/70aZK3G64kACB3gat9mols4pIPhTJVuTkMeOeNETb6oEo4S4f1i
   67MF6kYYrHE7uEyLcrZVRGljix80ykxSRqiOoiAzrxUhSpK1gv3UZrTuM
   URPLbVFf1pKO5sZjYhhQjdrgkIX16FFFxCb3oge/6mqEQJeUFiMqkGH1W
   +5IAuLgfMQh9sfRRgMLu8tDhyhSvmUxZeB1nT+xtUpK0h6mB+qVFrGh29
   puKj6QbNsIzv5ZM9Mp+4x7ELb9U1sP4J6+PvAFkVPuyDvIZJYWFjaNA8S
   WbhNywR7fMTj1ujPnqOImzUdsTfUzRvO9bNz5CrlacNY6i3uoOof9bM3d
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Date:   Mon, 30 Jan 2023 10:37:42 +0100
Message-ID: <20230130093742.838577-1-marten.lindahl@axis.com>
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
e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
the vcnl4040 sensor started to depend on the lock, but it was missed to
initialize it in vcnl4040's init function. This has not been visible
until we run lockdep on it:

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: CPU: 1 PID: 8800 at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
  ...
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
   ...

Fix this by adding mutex_init on the lock in the init function used for
vcnl4040.

Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cc1a2062e76d..a8a9fc3b1a02 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -316,6 +316,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	}
 	mutex_init(&data->vcnl4200_al.lock);
 	mutex_init(&data->vcnl4200_ps.lock);
+	mutex_init(&data->vcnl4000_lock);
 
 	ret = data->chip_spec->set_power_state(data, true);
 	if (ret < 0)
-- 
2.30.2

