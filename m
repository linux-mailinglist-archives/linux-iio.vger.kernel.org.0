Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60383542AE
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhDEOUt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237450AbhDEOUt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:20:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48028613B1;
        Mon,  5 Apr 2021 14:20:42 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:20:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for the 5.12 cycle
Message-ID: <20210405152057.3157af41@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12b

for you to fetch changes up to 8aab53b7fb3668fdbed9fcdb41780040ef7e6a56:

  iio: sx9310: Fix write_.._debounce() (2021-04-01 14:21:10 +0100)

----------------------------------------------------------------
2nd set of IIO fixes for the 5.12 cycle

* adi,ad9467
  - Fix a HAS_IOMEM kconfig dependency issue.
* semtech,sx9310
  - Add missing sanity checks on debouce writes.
  - Fix access to variable sized DT array.
* yamaha,yas530
  - Fix a missing return value in erorr path.
  - Include asm/unaligned.h rather than be_byteshift.h.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: Kconfig: make AD9467 depend on ADI_AXI_ADC symbol

Gwendal Grignou (2):
      iio: sx9310: Fix access to variable DT array
      iio: sx9310: Fix write_.._debounce()

Linus Walleij (2):
      iio: magnetometer: yas530: Fix return value on errorpath
      iio: magnetometer: yas530: Inlucde right header

 drivers/iio/adc/Kconfig                  |  2 +-
 drivers/iio/magnetometer/yamaha-yas530.c |  4 ++-
 drivers/iio/proximity/sx9310.c           | 52 +++++++++++++++++++++++---------
 3 files changed, 42 insertions(+), 16 deletions(-)
