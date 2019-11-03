Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80213ED469
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 20:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKCTrm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 14:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfKCTrm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 14:47:42 -0500
Received: from localhost.localdomain (unknown [151.66.0.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50E821929;
        Sun,  3 Nov 2019 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572810462;
        bh=7z0ukquQ36ZywYWolkCTnwbMFv38A643nAtzIcbVu+M=;
        h=From:To:Cc:Subject:Date:From;
        b=A8YLIlx4DDSlAq9paU+aV/ZWcmn6MtiIukZ65yKTll78wKXhtPOQ4HtppCUQsitl1
         MBhrGGYgTI57n+RlmCDdo3U1sIFD1i5DvpDgoYOM0miBwNN5G1cpAwL46xErrPuc/1
         gLQFgLpOmt/GLJwq7OvtCfO34GxkSqPTWp3/Voqs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, mario.tesi@st.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] support rational ODRs in st_lsm6dsx
Date:   Sun,  3 Nov 2019 20:47:16 +0100
Message-Id: <cover.1572810064.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Express ODRs in mHZ in order to support rational ODRs (e.g. 12.5Hz).
This series will fix an Android CTS failure.
Use u32 for ODR variables.
Explicitly define odr table size.
This series is based on 'iio: imu: st_lsm6dsx: fix ODR check in
st_lsm6dsx_write_raw'
https://patchwork.kernel.org/patch/11214281/

Changes since v1:
- express ODRs in mHZ and not in HZ / 10

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: explicitly define odr table size
  iio: imu: st_lsm6dsx: express odr in mHZ

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   8 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 222 ++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  41 ++--
 4 files changed, 153 insertions(+), 127 deletions(-)

-- 
2.21.0

