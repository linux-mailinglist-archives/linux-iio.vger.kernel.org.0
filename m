Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7817D51D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCHRJp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 13:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgCHRJp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Mar 2020 13:09:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE22D208C3;
        Sun,  8 Mar 2020 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583687385;
        bh=3s8SOGXrFtj1VNmlx2arPZ+GJnBtGQJxrovVye7pJI8=;
        h=Date:From:To:Subject:From;
        b=WjgPz/NNBkQITVxn/qOw+DEsYfDK6Mxb5/ALh+iREdFY3QJvrl9vaQ0hTi0GDgyc/
         U1UbTGU74MCg2P/N4G7FiqCgMVEZGsMMjarPxj1Oy54QJfC/9CNPMZE7IePZg5Mccu
         de0lGgZA7jdiasdRAtSgIkE7fv6yB5OyhXwkjvYc=
Date:   Sun, 8 Mar 2020 17:09:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.6 cycle
Message-ID: <20200308170941.6d3b36ab@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 39bed42de2e7d74686a2d5a45638d6a5d7e7d473:

  Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/rdma/rdma (2020-01-29 19:56:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixe=
s-for-5.6a

for you to fetch changes up to 10856d88f7653b42196ca5b2775bbc1f15122a58:

  iio: ping: set pa_laser_ping_cfg in of_ping_match (2020-03-08 16:21:23 +0=
000)

----------------------------------------------------------------
First set of IIO fixes in the 5.6 cycle.

* adxl372
  - Fix marking of buffered values as big endian.
* ak8974
  - Fix wrong handling of negative values when read from sysfs.
* at91-sama5d2
  - Fix differential mode by ensuring configuration set correctly.
* ping
  - Use the write sensor type for of_ping_match table.
* sps30
  - Kconfig build dependency fix.
* st-sensors
  - Fix a wrong identification of which part the SMO8840 ACPI ID indicates.
* stm32-dsfdm
  - Fix a sleep in atomic issue by not using a trigger when it makes no sen=
se.
* stm32-timer
  - Make sure master mode is disabled when stopping.
* vcnl400
  - Update some sampling periods based on new docs.

----------------------------------------------------------------
Alexandru Tachici (1):
      iio: accel: adxl372: Set iio_chan BE

Eugen Hristev (1):
      iio: adc: at91-sama5d2_adc: fix differential channels in triggered mo=
de

Fabrice Gasnier (1):
      iio: trigger: stm32-timer: disable master mode when stopping

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fix sleep in atomic context

Petr =C5=A0tetiar (1):
      iio: chemical: sps30: fix missing triggered buffer dependency

Stephan Gerhold (1):
      iio: magnetometer: ak8974: Fix negative raw values in sysfs

Tomas Novotny (2):
      iio: light: vcnl4000: update sampling periods for vcnl4200
      iio: light: vcnl4000: update sampling periods for vcnl4040

Wen-chien Jesse Sung (1):
      iio: st_sensors: remap SMO8840 to LIS2DH12

YueHaibing (1):
      iio: ping: set pa_laser_ping_cfg in of_ping_match

 drivers/iio/accel/adxl372.c               |  1 +
 drivers/iio/accel/st_accel_i2c.c          |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c        | 15 +++++++++++
 drivers/iio/adc/stm32-dfsdm-adc.c         | 43 +++++++--------------------=
----
 drivers/iio/chemical/Kconfig              |  2 ++
 drivers/iio/light/vcnl4000.c              | 15 ++++++-----
 drivers/iio/magnetometer/ak8974.c         |  2 +-
 drivers/iio/proximity/ping.c              |  2 +-
 drivers/iio/trigger/stm32-timer-trigger.c | 11 ++++++--
 9 files changed, 48 insertions(+), 45 deletions(-)
