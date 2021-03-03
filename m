Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4254632C6B0
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbhCDA3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:29:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:50147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1841811AbhCCGiH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 01:38:07 -0500
IronPort-SDR: TPlu16eNbBiss4vLPZspzX/5nPs0u6CCNuEEYWdz7ZOEirPot+eyQX/6AekHp2kXAWu7Ln+yG2
 19rkInf89dnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167012870"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="167012870"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:35:54 -0800
IronPort-SDR: Gzn2x7vY5mxZAMjemJh3w5kxMeMEWJ1BgqEKmADFG8aUy5X8il+BXRZhJK0q7I9gP4bF4b1UDn
 f8C+tJXKdKIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383870885"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2021 22:35:52 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 0/4] Fix humidity and temperature timestamp channel issues
Date:   Wed,  3 Mar 2021 14:36:11 +0800
Message-Id: <20210303063615.12130-1-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series fixes timestamp issues for humidity and temperature sensor.

Ye Xiang (4):
  iio: hid-sensor-humidity: Fix alignment issue of timestamp channel
  iio: hid-sensor-humidity: Get sample timestamp from sensor hub
  iio: hid-sensor-temperature: Fix issues of timestamp channel
  iio: hid-sensor-temperature: Get sample timestamp from sensor hub

 drivers/iio/humidity/hid-sensor-humidity.c    | 24 ++++++++++++-----
 .../iio/temperature/hid-sensor-temperature.c  | 26 ++++++++++++++-----
 2 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.17.1

