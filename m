Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B085B0925
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfILHGV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 03:06:21 -0400
Received: from first.geanix.com ([116.203.34.67]:53062 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfILHGV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Sep 2019 03:06:21 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 33B1E63992;
        Thu, 12 Sep 2019 07:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568271939; bh=oHQYP7aHsOAn2ooPh3RE4iA2W7vsPJ1KgrZnV1k4AFA=;
        h=From:To:Cc:Subject:Date;
        b=SvK9BN5OsmzSzw3S27b25EapVRSc+V94X0lWIY2KcQHnp9smJW8yHpSdt9nAPFMMC
         bMK8Wa9u0HzBQYQ5/kAphDo8uTjRRQ5PROekYO7Rku5zAe23OaC+gTCW3kJjD4AW8k
         fnCAd2v0z5S8RzUYXrKPmi5BhgHW22wM+Jw3t+S89uL2zV+p1Il9F5maCI+4K00WAm
         5X/41DqpxbyE4GhqUVgcTwViNcdtqbaJPtLooNJajiIajDdiNFwDdlwXfRZoXpLkfi
         vMpR14DNmy4z8FIoZThotrP44sl7G6rDkqxQL/kV1WilqyxmruS+1hdQr+L4/Fhm2q
         v0h9YpRfjoDNw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v7 0/5] enable motion events for st_lsm6dsx
Date:   Thu, 12 Sep 2019 09:06:09 +0200
Message-Id: <20190912070614.1144169-1-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset depends on:
[PATCH 0/2] enable LIR and clear_on_read for st_lsm6dsx

Sean Nyekjaer (5):
  iio: imu: st_lsm6dsx: move interrupt thread to core
  iio: imu: st_lsm6dsx: add motion events
  iio: imu: st_lsm6dsx: add wakeup-source option
  iio: imu: st_lsm6dsx: always enter interrupt thread
  iio: imu: st_lsm6dsx: add motion report function and call from
    interrupt

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  46 +++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  78 +---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 361 +++++++++++++++++-
 3 files changed, 404 insertions(+), 81 deletions(-)

-- 
2.23.0

