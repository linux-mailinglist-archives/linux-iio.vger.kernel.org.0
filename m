Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD44342C17
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhCTLYt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhCTLYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:24:33 -0400
X-Greylist: delayed 773 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Mar 2021 03:42:26 PDT
Received: from www381.your-server.de (www381.your-server.de [IPv6:2a01:4f8:d0a:52ac::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8320C0613AA
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=+QirHeI7egYHQG7DGYB2/4JcE/PCrLSMzTBS4UYAims=; b=IUmt7fBOU9wVTEDiC9Xn2vijRN
        4np2TwU9b7ni2J3EnsnbYPR4J2887LqCdYKm9VQzEgBq1i8dF4BoRihbokw34hizGbZLqCffvSExg
        2/Odi6CBss+ZcFLivUxWtLuAnA/06mKT4P4Yf5qmquuCSv+fQ+NtRkjSD7KVVDzXKGYSkGLTt3vAv
        yvy7Q4UB5CmkEA4j12BE01VDS7YiXTYwQhaj7QXVCVxAn/qRh9dD3Ykbp/4kFtOnt6vTd6rb2RfSZ
        mYLwifg1cUd19x5aeeU9NupL4zuIDArGaY7lVRDZm5TpuD2E+ocdeEGEstXfd4dz0vZrOJUeB0lQa
        Y5efAlPQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNVoj-000AyH-Tk; Sat, 20 Mar 2021 08:14:37 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNVoj-000Vc8-P9; Sat, 20 Mar 2021 08:14:37 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] iio: Start conversion to sysfs_emit()
Date:   Sat, 20 Mar 2021 08:14:01 +0100
Message-Id: <20210320071405.9347-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26114/Sat Mar 20 04:43:32 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sysfs_emit() and sysfs_emit_at() are new helper functions for output data
for sysfs attributes. They are preferred over raw s*printf() for sysfs
attributes since it knows about the sysfs buffer specifics and has some
built-in sanity checks.

This patch series updates the IIO core to make use these new helper
functions instead of raw s*printf().

In addition all the powerdown callbacks of DAC drivers are also updated to
use sysfs_emit().

There remain many instances of s*printf() in individual drivers for now.
These can be converted in follow up patch series.

But in many cases rather than doing the conversion from s*printf() to
sysfs_emit() it will be better to convert those drivers to implement
read_raw() or read_avail() callbacks and let the IIO core do the
formatting.

Implementing read_raw() or read_avail() instead of directly implementing a
sysfs attribute has the advantage that the data can then also be accessed
through in-kernel APIs and is available to in-kernel consumers.

Lars-Peter Clausen (4):
  iio: core: Use sysfs_emit() (trivial bits)
  iio: iio_enum_available_read(): Convert to sysfs_emit_at()
  iio: __iio_format_value(): Convert to sysfs_emit_at()
  iio: dac: Convert powerdown read callbacks to sysfs_emit()

 drivers/iio/dac/ad5064.c           |  2 +-
 drivers/iio/dac/ad5360.c           |  2 +-
 drivers/iio/dac/ad5380.c           |  2 +-
 drivers/iio/dac/ad5446.c           |  2 +-
 drivers/iio/dac/ad5504.c           |  4 +-
 drivers/iio/dac/ad5624r_spi.c      |  4 +-
 drivers/iio/dac/ad5686.c           |  2 +-
 drivers/iio/dac/ad5755.c           |  4 +-
 drivers/iio/dac/ad5758.c           |  2 +-
 drivers/iio/dac/ad5770r.c          |  2 +-
 drivers/iio/dac/ad5791.c           |  2 +-
 drivers/iio/dac/ad7303.c           |  2 +-
 drivers/iio/dac/ltc2632.c          |  4 +-
 drivers/iio/dac/max5821.c          |  2 +-
 drivers/iio/dac/mcp4725.c          |  2 +-
 drivers/iio/dac/stm32-dac.c        |  2 +-
 drivers/iio/dac/ti-dac082s085.c    |  2 +-
 drivers/iio/dac/ti-dac5571.c       |  2 +-
 drivers/iio/dac/ti-dac7311.c       |  2 +-
 drivers/iio/industrialio-buffer.c  | 20 ++++-----
 drivers/iio/industrialio-core.c    | 70 +++++++++++++++---------------
 drivers/iio/industrialio-event.c   |  2 +-
 drivers/iio/industrialio-trigger.c |  4 +-
 23 files changed, 71 insertions(+), 71 deletions(-)

-- 
2.20.1

