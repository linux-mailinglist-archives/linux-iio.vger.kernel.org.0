Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DA15EF7F7
	for <lists+linux-iio@lfdr.de>; Thu, 29 Sep 2022 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiI2Oqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Sep 2022 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiI2Oqd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2022 10:46:33 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7D132FE1;
        Thu, 29 Sep 2022 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664462790;
  x=1695998790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OxGeG7A8IvjQhjxy8ISS0rqQSqEh2euJO8T8ZyFtMek=;
  b=NV4pNOtZwf8h5Gpm7OJobvVPwQo5llgQGQBSDtaYJkoWlRx2Y10THTXj
   zgtzoxhcphlEDdzhrZsq7fxgXyUjJKT/X8WcQzNFe8sGubw4qlgbL4yV2
   pT4gNqlMH+nvskTSzxXsp9uYT+9lZsBTxggpPMoe0aniKUJTVbQ6YtBpH
   WZm+d8vjXxO2cqhQTfi3O10jjViXW1WGOHPHngF1KtAfLzfxMVcZGoSMp
   ETSEwgoUkU8qtaR0/OyObqW2gtFvrZuY+k3ILLrN+y+mS48y6mzW+H326
   RXCFrX9MqLhRIxYKRv5DiZqSNgkIk2/skv5FcaubPk6avAZEAmHFMOldy
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 0/2] Synchronize PM runtime enable state with parent
Date:   Thu, 29 Sep 2022 16:46:16 +0200
Message-ID: <20220929144618.1086985-1-marten.lindahl@axis.com>
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

Hi!

A device that creates a child character device with cdev_device_add by
default creates a PM sysfs group with power attributes for userspace
control. This means that the power attributes monitors the child device
only and thus does not reflect the parent device PM runtime behavior.

But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
only on a single device that has been enabled for runtime PM, but also
on its parent, it should be possible to synchronize the child and the
parent so that the power attribute monitoring reflects the child and
the parent as one.

As an example, if an i2c_client device registers an iio_device, the
iio_device will create sysfs power/attribute nodes for userspace
control. But if the dev_pm_ops with resume/suspend callbacks is
attached to the struct i2c_driver.driver.pm, the PM runtime needs to be
enabled for the i2c_client device and not for the child iio_device.

In this case PM runtime can be enabled for the i2c_client device and
suspend/resume callbacks will be triggered, but the child sysfs power
attributes will be visible but marked as 'unsupported' and can not be
used for control or monitoring. This can be confusing as the sysfs
device node presents the i2c_client and the iio_device as one device.

A solution to this is to enable runtime PM not only for the i2c_device
but for the iio_device child also. As there already exists a link from
the child to its parent and both are enabled, all sysfs
control/monitoring now reflects both devices, which from a userspace
perspective makes more sense.

These patches [1] adds a function to the PM runtime framework to
synchronize the PM runtime enable state of a device with its parent,
and [2] applies it to an iio device, where the described issue exists.

Kind regards
Mårten Lindahl

Mårten Lindahl (2):
  PM: runtime: Synchronize PM runtime enable state with parent
  iio: light: vcnl4000: Incorporate iio_device with PM runtime

 drivers/base/power/runtime.c | 18 ++++++++++++++++++
 drivers/iio/light/vcnl4000.c |  1 +
 include/linux/pm_runtime.h   |  2 ++
 3 files changed, 21 insertions(+)

-- 
2.30.2

