Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FE8A6FF
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfHLTVw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 15:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfHLTVw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 15:21:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EA120651;
        Mon, 12 Aug 2019 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565637711;
        bh=sr8y8HWtUcKPiqjBa6u0zQDM5T/0MVbScZ2uFoUNx7Q=;
        h=Date:From:To:Subject:From;
        b=1FqMeV/qjHHG/HipZcqwhds5o4gfaHLPYw7p1WfziEtO5DWH+GtNq8VUSt2GsAChs
         XdxZ8XolK2JGz2GpjGTEnkEP0w/fBNUBetbEoibxCd3mF/jQgUZ/JovvgzJFsEQJzr
         5yyo3lolos30FhXhxe+tRCD8fbP7azoBUWttZ65M=
Date:   Mon, 12 Aug 2019 20:21:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 5.3 cycle.
Message-ID: <20190812202147.065fb84e@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 09f6109ff4f8003af3370dfee0f73fcf6d20087a:

  Merge tag 'iio-fixes-for-5.3a' of git://git.kernel.org/pub/scm/linux/kern=
el/git/jic23/iio into staging-linus (2019-07-28 11:07:26 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixe=
s-for-5.3b

for you to fetch changes up to b9ddd5091160793ee9fac10da765cf3f53d2aaf0:

  iio: adc: max9611: Fix temperature reading in probe (2019-08-05 17:42:24 =
+0100)

----------------------------------------------------------------
Second set of IIO fix for the 5.3 cycle.

* adf4371
  - Calculation of the value to program to control the output frequency
    was incorrect.
* max9611
  - Fix temperature reading in probe.  A recent fix for a wrong mask
    meant this code was looked at afresh.  A second bug became obvious
    in which the return value was used inplace of the desired register
    value.  This had no visible effect other than a communication test
    not actually testing the communications.

----------------------------------------------------------------
Jacopo Mondi (1):
      iio: adc: max9611: Fix temperature reading in probe

Nuno S=C3=A1 (1):
      iio: frequency: adf4371: Fix output frequency setting

 drivers/iio/adc/max9611.c       | 2 +-
 drivers/iio/frequency/adf4371.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
