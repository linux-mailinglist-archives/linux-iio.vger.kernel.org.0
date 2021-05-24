Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0037D38E81E
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhEXN4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 09:56:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3986 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXN4N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 09:56:13 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fpdtv4MkGzmZx5;
        Mon, 24 May 2021 21:52:23 +0800 (CST)
Received: from dggeml759-chm.china.huawei.com (10.1.199.138) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:54:43 +0800
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 21:54:42 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] iio: dummy: Fix build error when CONFIG_IIO_TRIGGERED_BUFFER is not set
Date:   Mon, 24 May 2021 14:05:36 +0000
Message-ID: <20210524140536.116224-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Gcc reports build error when CONFIG_IIO_TRIGGERED_BUFFER is not set:

riscv64-linux-gnu-ld: drivers/iio/dummy/iio_simple_dummy_buffer.o: in function `iio_simple_dummy_configure_buffer':
iio_simple_dummy_buffer.c:(.text+0x2b0): undefined reference to `iio_triggered_buffer_setup_ext'
riscv64-linux-gnu-ld: drivers/iio/dummy/iio_simple_dummy_buffer.o: in function `.L0 ':
iio_simple_dummy_buffer.c:(.text+0x2fc): undefined reference to `iio_triggered_buffer_cleanup'

Fix it by select IIO_TRIGGERED_BUFFER for config IIO_SIMPLE_DUMMY_BUFFER.

Fixes: 738f6ba11800 ("iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/dummy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index 5c5c2f8c55f3..1f46cb9e51b7 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -34,6 +34,7 @@ config IIO_SIMPLE_DUMMY_BUFFER
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_KFIFO_BUF
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Add buffered data capture to the simple dummy driver.
 

