Return-Path: <linux-iio+bounces-17277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA64A72887
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 02:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3F01882DD7
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57086450F2;
	Thu, 27 Mar 2025 01:57:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88546F9FE;
	Thu, 27 Mar 2025 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040644; cv=none; b=nwADEMXbVOG7Y6jYhnxPSxRZy9sFOVQjOlcQN4WT5c9o2cvfwsY9FmEhx8MQkyS0dsygohorvlLcEphK6VjuvVvJ1mssOjaZdJpFoQ8lNPgMCxFv7nnJ3MYECq2PkOwWgZAKviFz8HjQ37+rcHiaWVPtdUtJtO8SUxHUJIqHG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040644; c=relaxed/simple;
	bh=BJgjdPnywHzL6SbPRbkS9cXGa83djIa6lNjH1o1yJ3A=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=hWwHWCDu9uP/OTIAIZWpLzGgaJbxmZglGeB85RddbgIeF7LhWT+M5DD8JIdnBtyUBj2OQUpwix3y5Tmgk+/1dE+X5nsMzOGHzSz1AkwQ4EXr8S50HdsQrCkQkZ+YvJ/q5C+qg+ds+28ukyZoLKfBDZR8ySIENEHTlhB6v6OMPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZNRcD0K06z501bR;
	Thu, 27 Mar 2025 09:57:16 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 52R1v3a0069523;
	Thu, 27 Mar 2025 09:57:03 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 27 Mar 2025 09:57:04 +0800 (CST)
Date: Thu, 27 Mar 2025 09:57:04 +0800 (CST)
X-Zmail-TransId: 2af967e4b070684-67c35
X-Mailer: Zmail v1.0
Message-ID: <202503270957044481PK0Xb23i08BgwkodLtEC@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <lars@metafoo.de>
Cc: <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <feng.wei8@zte.com.cn>, <michael.hennerich@analog.com>,
        <jic23@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzdGFnaW5nOiBpaW86IGFkdDczMTY6IHJlcGxhY2UgaXJxZF9nZXRfdHJpZ2dlcl90eXBlIHdpdGggaXJxX2dldF90cmlnZ2VyX3R5cGU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52R1v3a0069523
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E4B07C.000/4ZNRcD0K06z501bR

From: Feng Wei <feng.wei8@zte.com.cn>

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/staging/iio/addac/adt7316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index f4260786d50a..16f30c4f1aa0 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1794,7 +1794,7 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 	int irq_type, ret;

-	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
+	irq_type = irq_get_trigger_type(chip->bus.irq);

 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
-- 
2.25.1

