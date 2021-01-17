Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25CC2F9398
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbhAQPla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbhAQPl0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:41:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C68B2251F;
        Sun, 17 Jan 2021 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898035;
        bh=lNeedfoU1xazCMUCyZKami6dsmuMB2stdtfRD5qR9zo=;
        h=From:To:Cc:Subject:Date:From;
        b=JwgVJ//bE5AMOs/y9ppgdMzOirLkzHn4IVS6Pn9fMjNZq8aMeKMXWTlP6gorGRhkk
         T/lB+rAM0Mdzhi4HuZZ07Kxt4NYOyqlXwqJWxy4zlwpgYIms8AsvAkfDKUd1q74hQl
         sXTeMG3d9WpkgcpFbUkfIAGXwIt8NO5BaKcXIrxCtoUW30EcivlCP7Rtnz3L6TEUPN
         lhGYuc96srK48dEgTDqbe39tTtLU4s+Zg4kRENAfJusyTMzmcGI0oEsgXvPoVMdNLl
         0ADV/SzCkEGE7fIxpcfqVnLKRYWrBfo0+yQcyKI95DGSElPDwLAdx9T9yD8XcJJth9
         IrfBn8Z3mjf7g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/7] IIO ABI documentation duplication fixes
Date:   Sun, 17 Jan 2021 15:38:09 +0000
Message-Id: <20210117153816.696693-1-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The nature of IIO devices is that they are highly varied and occaisonly
ABI is used in somewhat of a 'best fit' fashion.  This has lead to a
situation where we had additional more specific ABI docs for some sysfs
parameters in certain drivers.  Unfortunately the automated documentation
building doesn't work well with this both issuing warnings and building
a less than ideal output.

So this series attempts to fix that up, mostly by moving the application
specific parts, of properties that are documented in more than one place,
into a higher level documentation file, sometimes with a device specific
note. In a few cases this the result is a bit non-obvious hence the RFC.
Roughly speaking I've put the more 'interesting' cases towards the end
of the series.

It's worth noting that a general reorganzation, audit of missing docs
etc is needed for the IIO ABI docs, but as that's a big job it may well
take sometime to get it done. In the meantime let's deal with these
issues.  Some of the drivers have complex enough ABI that we should probably
have detailed docs for them in addition to Documentation/ABI.

Note I haven't yet touched the remaining case of
Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8

This is mainly because I don't really know enough about these devices
to conclude exactly what a fused bit of docs should look like.
Also worth noting that those are probably deprecated ABI anyway given
the move of counters into their own subsystem.

Jonathan Cameron (7):
  iio:ABI docs: Fix up duplicate *_calibbias_* documentation for
    icm42600
  iio:ABI docs: Avoid repitition of triggerX/sampling_frequency
  iio:ABI docs: Drop device specific docs for _powerdown for the adf4371
  iio:ABI docs: Fix issue around repeated definition of out_currentY_raw
  iio:ABI docs: Combine sysfs-bus-iio-humidity-hdc2010/hdc100x into one
    file
  iio:ABI docs: Combine the two instances of docs for sensor_sensitivity
  iio:ABI docs: Move specific description of out_altvoltageX_frequency
    to main docs.

 Documentation/ABI/testing/sysfs-bus-iio       | 45 +++++++++++++++++++
 .../ABI/testing/sysfs-bus-iio-distance-srf08  |  8 ----
 .../testing/sysfs-bus-iio-frequency-adf4371   | 33 --------------
 .../ABI/testing/sysfs-bus-iio-health-afe440x  | 10 +----
 ...umidity-hdc2010 => sysfs-bus-iio-humidity} |  3 +-
 .../testing/sysfs-bus-iio-humidity-hdc100x    |  9 ----
 .../ABI/testing/sysfs-bus-iio-icm42600        | 20 ---------
 .../testing/sysfs-bus-iio-light-lm3533-als    | 11 ++---
 .../ABI/testing/sysfs-bus-iio-proximity       | 14 ++++++
 .../testing/sysfs-bus-iio-proximity-as3935    |  9 ----
 .../ABI/testing/sysfs-bus-iio-timer-stm32     |  8 ----
 11 files changed, 66 insertions(+), 104 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-iio-humidity-hdc2010 => sysfs-bus-iio-humidity} (79%)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600

-- 
2.30.0

