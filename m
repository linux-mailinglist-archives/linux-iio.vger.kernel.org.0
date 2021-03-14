Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5933A6F4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhCNQtN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhCNQtG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 247FA64DE8;
        Sun, 14 Mar 2021 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740545;
        bh=QtL8z0QNjT5FTiiqz9YOnY4YLx2876T5YslE+03Oq3k=;
        h=From:To:Cc:Subject:Date:From;
        b=gUzWR1CYFdODNpB3f6HXR4OBexuxt9yixNWk397h6H8ao9Pj1OZOI8XCssoB5uMvo
         a+w3L1H6DBbxawk7cI8k7pjLQik/S9Ri+ViefCexfTIt0KtZVPVmtSd4+KWdnmEl8D
         aG238keAQQHy+zD99Mx3FHF1g7l3OZZ7+wILqQPrDwmJzZ6xW/gY9sUNB4NIgZfIot
         ZdbloKiX0pFF2fRD4gRAICKbbk2uCGvh9DeP64X73ECQEsSI/uwup1sNh76PoNyv6B
         efj06+OkNXiQXMEITeXIc878O+F9LOFVKsl3P4OC6oPX4u4qFg5GNJnDl8BFPSKgv8
         ANdwYRzLO/bTA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] iio: kernel-doc fixups
Date:   Sun, 14 Mar 2021 16:46:47 +0000
Message-Id: <20210314164655.408461-1-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A bunch of totally trivial kernel-doc fixes from W=1 builds.

Note I've not touched staging drivers as those are a good activity for
anyone who wants to get started working with IIO drivers. I'll post
a specific email about that in a few minutes.

Jonathan Cameron (8):
  iio: pressure: zpa2326: kernel-doc fixes
  iio: adc: ti-adc084s021: kernel-doc fixes, missing function names
  iio: dac: ad5770r: kernel-doc fix case of letter R wrong in structure
    name
  iio: dac: ad5504: fix wrong part number in kernel-doc structure name.
  iio: adc: cpcap-adc: kernel-doc fix - that should be _ in structure
    name
  iio: adc: adi-axi-adc: Drop false marking for kernel-doc
  iio: accel: sca3000: kernel-doc fixes. Missing - and wrong function
    names.
  iio: buffer: kfifo_buf: kernel-doc, typo in function name.

 drivers/iio/accel/sca3000.c     | 8 ++++----
 drivers/iio/adc/adi-axi-adc.c   | 2 +-
 drivers/iio/adc/cpcap-adc.c     | 2 +-
 drivers/iio/adc/ti-adc084s021.c | 4 ++--
 drivers/iio/buffer/kfifo_buf.c  | 2 +-
 drivers/iio/dac/ad5504.c        | 2 +-
 drivers/iio/dac/ad5770r.c       | 2 +-
 drivers/iio/pressure/zpa2326.c  | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.30.2

