Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587875C044B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiIUQg3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIUQgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 12:36:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8EAB05A
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 09:19:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXk8Q0F4KzlDj9
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 00:17:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP1 (Coremail) with SMTP id cCh0CgCHDTF5OStjcRGBBA--.52958S4;
        Thu, 22 Sep 2022 00:19:07 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH 0/5 v3] iio: Silence no spi_device_id warnings
Date:   Wed, 21 Sep 2022 16:36:15 +0000
Message-Id: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHDTF5OStjcRGBBA--.52958S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw4DXw1rXF18Aw47Xr4rGrg_yoW8JF45pF
        WUKF90yryDuFn2kan3Zan7CFy5KF4SyayrX3W7K3Wj9wsxZa45JFWftFyjyw1DJay7t3ZF
        qFy2gr18GF18Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
        x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
        CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WF
        yUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

SPI devices use the spi_device_id for module autoloading even on
systems using device tree.

Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
compatible") added a test to check that every SPI driver has a
spi_device_id for each DT compatiable string defined by driver
and warns if the spi_device_id is missing.

This series add spi_device_id entries to silence the warnings, and
ensure driver module autoloading works.

v2 -> v3:
 - post as patch series
 - make use of the spi_get_device_id(spi)->driver_data
   path to provide the chip info structure if
   of_device_get_match_data() returns NULL.

Wei Yongjun (5):
  iio: adc: ti-ads131e08: Silence no spi_device_id warnings
  iio: accel: sca3300: Silence no spi_device_id warning
  iio: adc: ad9467: Silence no spi_device_id warnings
  iio: adc: ad7192: Silence no spi_device_id warnings
  iio: adc: ad7124: Silence no spi_device_id warnings

 drivers/iio/accel/sca3300.c    | 12 ++++++++++--
 drivers/iio/adc/ad7124.c       | 10 ++++++++++
 drivers/iio/adc/ad7192.c       | 12 ++++++++++++
 drivers/iio/adc/ad9467.c       | 11 +++++++++++
 drivers/iio/adc/ti-ads131e08.c | 11 +++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.34.1

