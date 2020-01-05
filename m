Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04E0130793
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2020 12:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAELAz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jan 2020 06:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgAELAz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jan 2020 06:00:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E8721582;
        Sun,  5 Jan 2020 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578222055;
        bh=LbAQUbuKBwLMJBM8+CnqKPKZbkas5Wj+BjNDMILjF1E=;
        h=Date:From:To:Subject:From;
        b=k3qiFoNzOlSN7QPTOYJKcYP6tVmm0zibhtc4lQNgUu0/+fFPx3f8I4i6YVYZjjZMK
         Kofv6F5a2sQ9aBjsg2StUc55sTLfAOKNUp9+85eRRQ+xu0+39Nj4h9H7HpOGFtJ3YH
         3XE5Jbf5UwEqnKOcbvP1iNxYjWSr2CHOgP9fHHZo=
Date:   Sun, 5 Jan 2020 11:00:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 5.5 cycle.
Message-ID: <20200105110051.445c9a95@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit c05c403b1d123031f86e65e867be2c2e9ee1e7e3:

  staging: wfx: fix wrong error message (2019-12-18 15:51:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixe=
s-for-5.5b

for you to fetch changes up to 80d92ea5f865175bf4cb2cb252b0d1f439c4bcec:

  iio: light: vcnl4000: Fix scale for vcnl4040 (2019-12-30 16:48:13 +0000)

----------------------------------------------------------------
2nd Set of IIO fixes for the 5.5 cycle.

* Core
  - Fix buffer alignment calculation.  The previous logic meant that scans
    could under some circumstances not have naturally aligned elements.
    In theory someone might have been working around this in userspace, but
    if so we'd have expected them to query this very odd behaviour.
    It's not hit in that many drivers as requires a mixture of channel
    resolutions broad enough to require different packing.  The one obvious
    case of timestamps was fine under existing code as they are always the
    last element if enabled and that was handled correctly.
* ad7124
  - DT channel configuration wasn't using the reg value so would lead
    to some odd mappings and readout of the wrong channels.
* pms7003
  - Kconfig didn't specify triggered buffer dependency.
* st_lsm6dsx
  - For the LSM6DS3 the id match wasn't working.
* vcnl4000
  - Scale was wrong for the vcnl4040

----------------------------------------------------------------
Alexandru Tachici (1):
      iio: adc: ad7124: Fix DT channel configuration

Guido G=C3=BCnther (1):
      iio: light: vcnl4000: Fix scale for vcnl4040

Lars M=C3=B6llendorf (1):
      iio: buffer: align the size of scan bytes to size of the largest elem=
ent

Stephan Gerhold (1):
      iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID

Tomasz Duszynski (1):
      iio: chemical: pms7003: fix unmet triggered buffer dependency

 drivers/iio/adc/ad7124.c                     | 12 +++++-------
 drivers/iio/chemical/Kconfig                 |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  3 ++-
 drivers/iio/industrialio-buffer.c            |  6 +++++-
 drivers/iio/light/vcnl4000.c                 |  3 ++-
 5 files changed, 15 insertions(+), 10 deletions(-)
