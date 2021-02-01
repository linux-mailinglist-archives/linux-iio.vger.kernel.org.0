Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE230A2CA
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 08:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBAHnp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 02:43:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:46032 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhBAHnp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Feb 2021 02:43:45 -0500
IronPort-SDR: MHrAxa9h54kj45sYnG6kWiQGlPXy2CN2hcXK27NwJ+sIZfkabFTVHVQymr4AxmveHJqY3EUGWq
 VP8b3nQ+pcVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="159813871"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="159813871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 23:43:04 -0800
IronPort-SDR: jyN6eaTycdkE6MwnOjJbiLa4rneI1rBfuQtlTE2acndDbQeImO1+4QIaO43nsyszutESCRvbxo
 vdTvXV3ZFPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="432235766"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2021 23:43:01 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 0/3] Add relative hysteresis support for hid sensors
Date:   Mon,  1 Feb 2021 15:43:55 +0800
Message-Id: <20210201074358.18435-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, hid sensor als are using the relative hysteresis.
This patch series add the relative hysteresis for hid sensors.

Ye Xiang (3):
  iio: Add relative sensitivity support
  iio: hid-sensor-als: Add relative hysteresis support
  iio: Add relative hysteresis in ABI documentation

 Documentation/ABI/testing/sysfs-bus-iio       |  8 ++
 .../hid-sensors/hid-sensor-attributes.c       | 75 ++++++++++++++++++-
 drivers/iio/industrialio-core.c               |  1 +
 drivers/iio/light/hid-sensor-als.c            | 14 +++-
 include/linux/hid-sensor-hub.h                |  5 ++
 include/linux/hid-sensor-ids.h                |  1 +
 include/linux/iio/types.h                     |  1 +
 7 files changed, 99 insertions(+), 6 deletions(-)

-- 
2.17.1

