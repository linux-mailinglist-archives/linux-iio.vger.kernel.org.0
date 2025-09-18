Return-Path: <linux-iio+bounces-24241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C7B82B63
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 05:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082AF46423A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009F23507E;
	Thu, 18 Sep 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="cp0oyt0Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090382248B0;
	Thu, 18 Sep 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165025; cv=none; b=GCGLFCjWpMBB6ypjPGn2VHd4cdJX3en7Am7Zvcyahk3x3B1Y4+7KSNRaELja6koHfKBymMZ8rcGJVWqVNYFLdcbhGIfWaaFmhTOexsizwcrT0EGf4WLhA5+kP5G/iVQU/kI1Pu97Oxp/FmsYI6HRhncfheoi3oVgXuxL+Uqu2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165025; c=relaxed/simple;
	bh=szu3+YFCReXMzfUcogffIPXAAfsFvglxCgZKmD2ePkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiGoRHkVOGAmseDv7Wp1PR7UZxD3Y5E+WfcWOL+GahcoTtYzDEpI6//Kp/vKBgNfoit9Eao1ki1K0VWRow4hlqkg+VGYvx4wUVy9q64ukJ/rtm86dtRMLrDM3gVqmIu9e76PiHp3TTey7qUjIRaDjVtYjxhN7SGaacCBZm5AMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=cp0oyt0Q; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1758165014;
	bh=9gCOxxj8HcLtdDa0RY4gvkXPIDFZMu0DoSBNmq/f28k=; l=946;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cp0oyt0QkoNqdIXN8kQUZmDeXQgwClLMwds76AqQMIEvslQB8OXjkCaO25bS7zPHc
	 FYe23gOtMwqz6VZ6w2f7CcT0W5Rll24229cQ7sSF+acXqOLyk5xbVlqsNQszBggOP7
	 IwRPbweCCWeW0+QRctll13DJeqLN9BAlH9b1joUvNFJHQuGw974LPNYTIAnYCzLdYS
	 Rb0P8xZYQhNziHfr/uIGc4pQPLLcj4Y0j/oOQSEXqRcjhKYXHc1eAlu+A7LVdo5Ftf
	 XU9S+CyKMWiyVLZnbmDJk9XedKIyY6RN8CldYZY0zTrbBUe3GrllMmZgvxzf4d4oXT
	 KUHoyBibZT+Dg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2461096:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 18 Sep 2025 11:09:54 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 18 Sep
 2025 11:09:54 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Thu, 18 Sep 2025 11:09:54 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, ChiYuan Huang
	<cy_huang@richtek.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andy Hsu <andy_ya_hsu@wiwynn.com>
Subject: [PATCH] iio: adc: rtq6056: Correct the sign bit index
Date: Thu, 18 Sep 2025 11:10:59 +0800
Message-ID: <7e43ad09f814d63b570ab6b2b9fe3fe17775d22d.1758164614.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

The vshunt/current reported register is a signed 16bit integer. The
sign bit index should be '15', not '16'.

Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi, Andy:

Thanks for reporting the value convert issue.
---
 drivers/iio/adc/rtq6056.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index ad9738228b7f..2bf3a09ac6b0 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -300,7 +300,7 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 		return IIO_VAL_INT;
 	case RTQ6056_REG_SHUNTVOLT:
 	case RTQ6056_REG_CURRENT:
-		*val = sign_extend32(regval, 16);
+		*val = sign_extend32(regval, 15);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
-- 
2.34.1


