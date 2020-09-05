Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9440F25E990
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgIERtk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgIERtj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:49:39 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F462086A;
        Sat,  5 Sep 2020 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599328178;
        bh=IICIiRXS5VlllCN+6hdnPLBmddAl5Eg2hdi9jR9+GYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qI7Kx02O8DpKX8vfke0Bae7icmLZTuNIqM6cC2SnDxF1iYQdp+7rYCfkSTFR1J3tT
         8hBHbaIOXpTGBpvVoIFwQ+E/DCy+9ZqBKzJw0+PFI+zgtJleiP4AScuACZNsVcI77b
         XdM3zvAKE3Y2bMTZppaFDmzgAZhte8WY0oo/qfG8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brian Masney <masneyb@onstation.org>
Subject: [PATCH 2/4] staging:iio:light: Move tsl2x7x ABI docs to correct location.
Date:   Sat,  5 Sep 2020 18:47:19 +0100
Message-Id: <20200905174721.216452-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905174721.216452-1-jic23@kernel.org>
References: <20200905174721.216452-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These seem to be up to date but never moved out of staging when the driver
did. Hence let us move them out now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Brian Masney <masneyb@onstation.org>
---
 .../ABI/testing/sysfs-bus-iio-light-tsl2772                       | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x b/Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772
similarity index 100%
rename from drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
rename to Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772
-- 
2.28.0

