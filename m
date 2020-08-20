Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137F024AD28
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 05:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHTDDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 23:03:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgHTDDg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Aug 2020 23:03:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 678F4137AC55FABC892E;
        Thu, 20 Aug 2020 11:03:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 11:03:32 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: adi-axi-adc: Use kobj_to_dev() instead of container_of()
Date:   Thu, 20 Aug 2020 11:01:26 +0800
Message-ID: <1597892486-3236-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/iio/adc/adi-axi-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 86b6b65..9109da2 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -276,7 +276,7 @@ static struct attribute *adi_axi_adc_attributes[] = {
 static umode_t axi_adc_attr_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adi_axi_adc_state *st = iio_priv(indio_dev);
 	struct adi_axi_adc_conv *conv = &st->client->conv;
-- 
2.7.4

