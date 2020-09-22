Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE7274236
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVMkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 08:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgIVMkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 08:40:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D232395C;
        Tue, 22 Sep 2020 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600778422;
        bh=glyr4Ts0WAIQZH0vh63AEyg/MGLZ9VRPEa0rfeU2Mh8=;
        h=Date:From:To:Subject:From;
        b=wrsnb0CeclTbzt7IsH5xhWVBpnDlR7UsXgveGJO2E8FG505+Ye1FdP4myAkHNpwgX
         bSZlXNHMSv8tSXqRJqn5/W5HEROlkY2wz9mfAGSHd1zc6UyLnc57REWNOuUn5LC75O
         93lufphFD2nfbopTJZWKQ+701Wu4TERp0Zc8XhFQ=
Date:   Tue, 22 Sep 2020 13:40:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL V2] 2nd set of IIO fixes for 5.9
Message-ID: <20200922134018.064157eb@archlinux>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9b-take2

for you to fetch changes up to fdb29f4de1374483291232ae7515e5e7bb464762:

  iio: adc: qcom-spmi-adc5: fix driver name (2020-09-22 13:33:19 +0100)

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
