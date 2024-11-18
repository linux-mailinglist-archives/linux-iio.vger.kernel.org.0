Return-Path: <linux-iio+bounces-12367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69C9D0B55
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88BB3B21DD0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA31547E8;
	Mon, 18 Nov 2024 09:02:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BC2907;
	Mon, 18 Nov 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920544; cv=none; b=FoPb/ABQN51KEwOd4xsvPoBFmLRW+OBR1KJpLw96fXQX+Qn9sCPYYWAbpaiEfJHWl5k2e5MQ251eNAfdjIxK/Y34eBHL3pbJC7sqBj73I5Y5cE4JeunmZ5qHx4HtdQM3XnCUwKW+eIdk+M/UC0ZWO/dE1SvcfQtu3NFm3QglBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920544; c=relaxed/simple;
	bh=iUoKBVB/z1PEswfHo5ffqPcf7Ek4yj/Xd2hiOyUmolI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GP0COJTIwfZFYlARjP9yd6quDuaKwJShjAK13mbWgta6ePY1fRCLXWeiOBpDcFLKH26kSQbYaKYI4yTsp0IZELG9cf4efQk0FOQMVqovpBgedly0ryiaPdanQ2OwGfI+FKeYPKR4rsYXG2U3hAaVH1jarFgfYGVON6pafZmJmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id PMV00010;
        Mon, 18 Nov 2024 17:02:10 +0800
Received: from localhost.localdomain (10.94.9.174) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.39; Mon, 18 Nov 2024 17:02:09 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mike.looijmans@topic.nl>, <jic23@kernel.org>, <lars@metafoo.de>,
	<dan.carpenter@linaro.org>, <nuno.sa@analog.com>,
	<andriy.shevchenko@linux.intel.com>, <viro@zeniv.linux.org.uk>,
	<yujiaoliang@vivo.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] iio: adc: ti-ads1298: Add NULL check in ads1298_init
Date: Mon, 18 Nov 2024 17:02:08 +0800
Message-ID: <20241118090208.14586-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202411181702103f599d7c91711c50224c9150cc7d6926
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in ads1298_init() is not checked.
Add NULL check in ads1298_init(), to handle kernel NULL
pointer dereference error.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 36d43495f603..03f762415fa5 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -613,6 +613,8 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	}
 	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
 					 indio_dev->num_channels, suffix);
+	if (!indio_dev->name)
+		return -ENOMEM;
 
 	/* Enable internal test signal, double amplitude, double frequency */
 	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
-- 
2.31.1


