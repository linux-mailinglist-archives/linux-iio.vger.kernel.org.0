Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C918B341576
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 07:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhCSG3K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 02:29:10 -0400
Received: from m12-17.163.com ([220.181.12.17]:49345 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234031AbhCSG2q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 19 Mar 2021 02:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=x3cPQSnqLJMkw7yP+D
        zL9Ach3Zju3+3Kw9yXkblyQNQ=; b=lg437AYZsAHgecQPlXhmsEwLwtHMOCQCuF
        SzVFKcu0CzbYOkPtL0UTaq+hdGY+7Ah2qTop8IWO3YBMdyKDR5dXkUoygk1eRvS+
        vFXF/+VnSAOtvcuXsQX9tJZorZPMZbWSKT02RDEnJNWXMOw1BLnXt4V2CCU1BuGE
        mxdbwzkN0=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAB3fpZHRFRghNYpqw--.38989S2;
        Fri, 19 Mar 2021 14:27:23 +0800 (CST)
From:   Guoqing chi <chi962464zy@163.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        marcelo.schmitt1@gmail.com, pmeerw@pmeerw.net,
        chiguoqing@yulong.com
Subject: [PATCH] iio: adc: ad7292: Modify the bool initialization assignment
Date:   Fri, 19 Mar 2021 14:27:06 +0800
Message-Id: <20210319062706.5135-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowAB3fpZHRFRghNYpqw--.38989S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17XF1kAryxuF4kXF1kKrg_yoW3JFc_C3
        W8Z3s7W395Aw10yrs8J3yfXr9Yk340gFs5Cr1Svwn3WF9xCanrCryv9r4Uta48ur47Ca45
        ZF1UKr1Syw43WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUneuWJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/1tbiNwtaRFWBjy1OlAAAsO
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

A bool initializer is best assigned to false rather than 0.

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
---
 drivers/iio/adc/ad7292.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 70e33dd1c9f7..3271a31afde1 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -260,7 +260,7 @@ static int ad7292_probe(struct spi_device *spi)
 	struct ad7292_state *st;
 	struct iio_dev *indio_dev;
 	struct device_node *child;
-	bool diff_channels = 0;
+	bool diff_channels = false;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-- 
2.17.1


