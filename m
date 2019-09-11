Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90157AF620
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIKGua (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 02:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfIKGua (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 02:50:30 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B09121928;
        Wed, 11 Sep 2019 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568184629;
        bh=n6valUD4UzL7CG64h9ucb5FjPOw1fgfympQQcoFORWE=;
        h=From:To:Cc:Subject:Date:From;
        b=y+F+xWoST55Nv1OppIqbNf+Jy0i7nCl3mC/o0YT1yP7tBDXm1PGaOmN55oQX9GnMH
         XJwTbErl2m0+YirVLAjR8RA+6mY9jZQouwfo4F0w2kbI04CaKvpDyPJS5AkX76OhQb
         oa3zCsS9Vew2PBN5B0C8sXJzPCVWOw41cUW9WTYo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     sean@geanix.com, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, mario.tesi@st.com,
        armando.visconti@st.com, denis.ciocca@st.com
Subject: [PATCH 0/2] enable LIR and clear_on_read for st_lsm6dsx
Date:   Wed, 11 Sep 2019 08:50:02 +0200
Message-Id: <cover.1568184231.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable by default Latched interrupts and clear_on_read (when available)
for sensor events.

@Sean: could you please rebase your series on top of this one in order to double
check if it fixes the reported issue between buffered reading and wakeup
events?

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: enable LIR for sensor events
  iio: imu: st_lsm6dsx: enable clear on read for latched interrupts

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  4 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 59 ++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.21.0

