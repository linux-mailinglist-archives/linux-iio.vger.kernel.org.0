Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC34E5E61
	for <lists+linux-iio@lfdr.de>; Thu, 24 Mar 2022 06:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbiCXGA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Mar 2022 02:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347381AbiCXGA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2022 02:00:26 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7893994
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 22:58:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648101532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YZqkT1MmV6Rav9KzvVaFuvIq9sWkxOzSdiWPktkaH5Q=;
        b=MNjeJfRCwqFQtv2IYPj6hxCUHhYFd+7PgnTWc6pceKuVFlFtp0SHUAMXDpK+Zm5FFLgrn9
        A4UtBBBYQxBddSOqI98C94eDuVGxWEmsZHUd38B/inbRPVi5eZAJftwrBvtrVnwEmoctyw
        73xxUh8COKDZq6PwqMx6BAUfVmw8TiY=
From:   Jackie Liu <liu.yun@linux.dev>
To:     Jonathan.Cameron@huawei.com
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: da9150-gpadc: fix build on mips CONFIG_MIKROTIK_RB532=y
Date:   Thu, 24 Mar 2022 13:58:21 +0800
Message-Id: <20220324055821.3184872-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

kernel robot report build fail by randconfig:

[...]
drivers/iio/adc/da9150-gpadc.c:254:13: error: ‘DA9150_GPADC_CHAN_0x08’ undeclared here (not in a function); did you mean ‘DA9150_GPADC_CHAN_TBAT’?
  254 |  .channel = DA9150_GPADC_CHAN_##_id,   \
      |             ^~~~~~~~~~~~~~~~~~
drivers/iio/adc/da9150-gpadc.c:273:2: note: in expansion of macro ‘DA9150_GPADC_CHANNEL’
  273 |  DA9150_GPADC_CHANNEL(_id, _hw_id, _type,   \
      |  ^~~~~~~~~~~~~~~~~~~~
drivers/iio/adc/da9150-gpadc.c:281:2: note: in expansion of macro ‘DA9150_GPADC_CHANNEL_PROCESSED’
  281 |  DA9150_GPADC_CHANNEL_PROCESSED(GPIOD, GPIOD_6V, IIO_VOLTAGE, NULL),
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [../scripts/Makefile.build:288: drivers/iio/adc/da9150-gpadc.o] Error 1
make[3]: *** [../scripts/Makefile.build:550: drivers/iio/adc] Error 2
make[3]: *** Waiting for unfinished jobs....
[...]

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/iio/adc/da9150-gpadc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 8f0d3fb63b67..ed32061aee51 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -273,6 +273,12 @@ static const struct iio_info da9150_gpadc_info = {
 	DA9150_GPADC_CHANNEL(_id, _hw_id, _type,			\
 			     BIT(IIO_CHAN_INFO_PROCESSED), _ext_name)
 
+/*
+ * Workaround for arch/mips/include/asm/mach-rc32434/rb.h
+ *   #define GPIOD 0x08
+ */
+#undef GPIOD
+
 /* Supported channels */
 static const struct iio_chan_spec da9150_gpadc_channels[] = {
 	DA9150_GPADC_CHANNEL_PROCESSED(GPIOA, GPIOA_6V, IIO_VOLTAGE, NULL),
-- 
2.25.1

