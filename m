Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300EFE9803
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 09:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfJ3IXr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 04:23:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfJ3IXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Oct 2019 04:23:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ED353CCB77D6F525F10E;
        Wed, 30 Oct 2019 16:23:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 16:23:33 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <zhongjiang@huawei.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Date:   Wed, 30 Oct 2019 16:19:39 +0800
Message-ID: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The issue is detected with the help of coccinelle.

zhong jiang (2):
  iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs
    fops
  iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs
    fops

 drivers/iio/imu/adis16400.c | 4 ++--
 drivers/iio/imu/adis16460.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.12.4

