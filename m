Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8869B2FCBF2
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbhATHqf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 02:46:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:7116 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbhATHqe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Jan 2021 02:46:34 -0500
IronPort-SDR: ZK9AsS1uldtu4kCYV1dvvyPLZU2EE/QxruDnGSjX9Hx8NpfE+SN1PXd9rnVHexHNisRhI07VfE
 PKy0jr3puuCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158836353"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="158836353"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 23:45:54 -0800
IronPort-SDR: +44SCZeZpBzqKfP3WQ9/Wys4rNcePPXriBEVdg6h6gAjCiD2aSza9OTs6qRByYDhda8IRATNij
 raOZSHbevbxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="466994219"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 23:45:52 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 0/3] resolve read hystersis return invalid argument issue for hid sensors
Date:   Wed, 20 Jan 2021 15:47:03 +0800
Message-Id: <20210120074706.23199-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series move get sensitivity attribute to common layer and
resolve read hystersis return invalid argument issue for hid sensors als,
incli-3d, rotation, and press on intel ISH Platform.

Ye Xiang (3):
  iio: hid-sensors: Move get sensitivity attribute to hid-sensor-common
  hid-sensor-common: Add relative sensitivity check
  hid-sensors: Add more data fields for sensitivity checking

 drivers/iio/accel/hid-sensor-accel-3d.c       | 23 +++++--------
 .../hid-sensors/hid-sensor-attributes.c       | 26 +++++++++++++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 19 ++++-------
 drivers/iio/humidity/hid-sensor-humidity.c    | 16 ++++-----
 drivers/iio/light/hid-sensor-als.c            | 20 +++++------
 drivers/iio/light/hid-sensor-prox.c           | 27 +++++----------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 34 ++++++-------------
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 20 +++++------
 drivers/iio/orientation/hid-sensor-rotation.c | 24 ++++++-------
 .../position/hid-sensor-custom-intel-hinge.c  | 20 ++++-------
 drivers/iio/pressure/hid-sensor-press.c       | 20 +++++------
 .../iio/temperature/hid-sensor-temperature.c  | 16 ++++-----
 drivers/rtc/rtc-hid-sensor-time.c             |  4 ++-
 include/linux/hid-sensor-hub.h                |  4 ++-
 include/linux/hid-sensor-ids.h                |  1 +
 15 files changed, 122 insertions(+), 152 deletions(-)

-- 
2.17.1

