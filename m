Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8DE27168A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgITSDz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 14:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgITSDz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 14:03:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FCB82078D;
        Sun, 20 Sep 2020 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600625034;
        bh=CgLr8uuNZJYsHKKyCbfONrNwb1SuL0qkiDfThT0F2OQ=;
        h=Date:From:To:Subject:From;
        b=rfKdxhJEpdxU5Aw9fgN2XOXoJcb2ZPEPWWpYucQ5eD+o9BXr0/BHPuaHL1tanx6Q/
         X+iQZyBT0d8dBYeBBOR5P9qlzc8ds6gdFo63tzf6JIF9sV6LsECZjA7ooM0XKtRYnU
         5BVnP5V2DFzFKPce6ZgKK7GL99EvTZCj6Q+/pdPs=
Date:   Sun, 20 Sep 2020 19:03:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for 5.9
Message-ID: <20200920190349.2732d4e8@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9b

for you to fetch changes up to 888f7cdc893a67d556187b12f40c9e9710ec1c99:

  iio: adc: qcom-spmi-adc5: fix driver name (2020-09-20 18:26:44 +0100)

----------------------------------------------------------------
2nd set of IIO fixes for the 5.9 cycle.

One of these fixes a regresison introduced this cycle, but if I am too late
sending this request, it can be queued up for the merge window.

ad7124: fix typo in device name exposed through sysfs.
qcom-spmi-adc: fix stray .c in driver name field.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      iio: adc: qcom-spmi-adc5: fix driver name

Mircea Caprioru (1):
      iio: adc: ad7124: Fix typo in device name

 drivers/iio/adc/ad7124.c         | 4 ++--
 drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
