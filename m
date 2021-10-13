Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1854F42BC17
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbhJMJwF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:52:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:23860 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239338AbhJMJvx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Oct 2021 05:51:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="288263458"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="288263458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="626271500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 02:49:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7529367; Wed, 13 Oct 2021 12:49:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] iio: buffer: allocation and freeing buffers fix and optimization
Date:   Wed, 13 Oct 2021 12:49:21 +0300
Message-Id: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Yang submitted a fix, but I think the code can be refactored a bit to be more
robust against similar mistakes in the future, if any.

In v2:
- put SoB Yang's patch (it's good for backporting)
- added refactoring patch on top of Yang's fix

Andy Shevchenko (1):
  iio: buffer: Use dedicated variable in
    iio_buffers_alloc_sysfs_and_mask()

Yang Yingliang (1):
  iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()

 drivers/iio/industrialio-buffer.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

-- 
2.33.0

