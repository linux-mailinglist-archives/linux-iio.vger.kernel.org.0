Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D1358222
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhDHLlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:41:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15976 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhDHLlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 07:41:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGK5y0cqnzyNSQ;
        Thu,  8 Apr 2021 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:40:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <prime.zeng@huawei.com>,
        <tiantao6@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
Date:   Thu, 8 Apr 2021 19:38:09 +0800
Message-ID: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devm variants are implemented with devres_alloc() and devres_add()
manually to only manage a single pointer. This can be simplified with
devm_add_action_or_reset() which works the same. Simplify these functions.

Yicong Yang (7):
  iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
  iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
  iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
  iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
  iio: core: simplify some devm functions
  iio: trigger: simplify __devm_iio_trigger_register
  iio: inkern: simplify some devm functions

 drivers/iio/adc/adi-axi-adc.c                      | 22 ++++----
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 ++++----
 drivers/iio/buffer/industrialio-hw-consumer.c      | 25 ++++-----
 drivers/iio/buffer/industrialio-triggered-buffer.c | 19 ++-----
 drivers/iio/industrialio-core.c                    | 43 ++++++---------
 drivers/iio/industrialio-trigger.c                 | 18 ++-----
 drivers/iio/inkern.c                               | 61 ++++++++--------------
 7 files changed, 78 insertions(+), 132 deletions(-)

-- 
2.8.1

