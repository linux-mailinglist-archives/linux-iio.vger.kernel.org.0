Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132ED30A1AB
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 06:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBAFwc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 00:52:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:19152 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhBAFtM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Feb 2021 00:49:12 -0500
IronPort-SDR: wvKYythIv9f2yYdRT3mlzF5GjcEfxTa9OGsyghikuw7V5onNMqpyd3YEiOR0Nh3CESYDLfJIQo
 u+SJX65lKZoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177129612"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="177129612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 21:48:31 -0800
IronPort-SDR: ON2leQPWDK+SX3Y2+E5xQdPnNCB8cvaFRPa7fjYnG3Xbp0/Q1zpLKDZEEbF56hboFOqwMYTGhq
 WAnuzMLFHzaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="506706366"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2021 21:48:30 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v2 0/2] resolve read hystersis return invalid argument issue for hid sensors
Date:   Mon,  1 Feb 2021 13:49:19 +0800
Message-Id: <20210201054921.18214-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series move get sensitivity attribute to common layer and
resolve read hystersis return invalid argument issue for hid sensors als,
incli-3d, rotation, and press on intel ISH Platform.

---
v2:
  - separate the add relative sensitivity patch to the next patch series.

Ye Xiang (2):
  iio: hid-sensors: Move get sensitivity attribute to hid-sensor-common
  hid-sensors: Add more data fields for sensitivity checking

 drivers/iio/accel/hid-sensor-accel-3d.c       | 23 ++++++-------
 .../hid-sensors/hid-sensor-attributes.c       | 17 +++++++++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 19 ++++-------
 drivers/iio/humidity/hid-sensor-humidity.c    | 16 ++++------
 drivers/iio/light/hid-sensor-als.c            | 20 +++++-------
 drivers/iio/light/hid-sensor-prox.c           | 27 +++++-----------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 32 ++++++-------------
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 20 +++++-------
 drivers/iio/orientation/hid-sensor-rotation.c | 24 ++++++--------
 .../position/hid-sensor-custom-intel-hinge.c  | 20 ++++--------
 drivers/iio/pressure/hid-sensor-press.c       | 20 +++++-------
 .../iio/temperature/hid-sensor-temperature.c  | 16 ++++------
 drivers/rtc/rtc-hid-sensor-time.c             |  4 ++-
 include/linux/hid-sensor-hub.h                |  4 ++-
 14 files changed, 111 insertions(+), 151 deletions(-)

-- 
2.17.1

