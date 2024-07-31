Return-Path: <linux-iio+bounces-8108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CF9431A8
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6140B2173F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF711B1429;
	Wed, 31 Jul 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="dUh6Zcq6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179F16D4CB;
	Wed, 31 Jul 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434846; cv=none; b=WcEkKIjyKDKFo5SxYvnNgasA713AmU7Pt5matyaGnacdcLeMC3nHMZLExRzBLFjPMyAY2VJ/RIsWWJbbIuNFUuriIB2dpWCWWDow2ZpjJ0IdEc+TqoufLPDPwSkEUzfmSd4FCP7VayPMSl8SQ96Bxtd7Hwfvl94h2uYFVzL8Gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434846; c=relaxed/simple;
	bh=JoX70aaYaR65QoOAD6KJ1RwuhzUWBM9VWsljUPsvWDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f602z5DBU32P3ZouoBZeR6aGI7tPrJyHeTa5hKiPCarXDVztHSE4JDGfylGbsfnvoLrApsvAkYCTqZIuX6ka5n724d1bhfDM1GJquyuMJXiEvZpdkvcUhKb0SUBdofO8Tnl/UIDzENtVCMjM5l6+Ip1zHc6xK9TFCfwoDcHRI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=dUh6Zcq6; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 187121F994;
	Wed, 31 Jul 2024 16:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722434833;
	bh=XwNnKLgABhF9Yi4Eec0Q5+Yl8XsMDgAXvILKSHMA/k4=; h=From:To:Subject;
	b=dUh6Zcq65NVTRy3iI2W1cyNFtOdI5NZ9eLo7o/JYwDXHxTzk7wEenY3PrZd18E550
	 Nn97Sp01mTix7GF/A4uM1kCyHgUaIPNdLJtgsjxwesnJ7RF8Uu8pW1wKXTc3n14s8T
	 xUnIZdCPq5y/tMlNpbs28z9IHayDQb7yfy8RI3FniF7cYpm4KiCB6Fos2oP9b3QELL
	 nltMg2lZVgN74I3Cg05ZCeCqoSQB7470AyIQDxi+y1d/PIxOQUdM00+gr7v9P1P0BI
	 pLimbc8+kZNqy0td+5Cecxk43zJ4tGeXg0ZkzEZR2PzB5GlZi1n0Yogb6cQNyil1bz
	 62RpYavKotGiw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: adc: ads1119: Fix IRQ flags
Date: Wed, 31 Jul 2024 16:06:57 +0200
Message-Id: <20240731140657.88265-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Remove IRQF_TRIGGER_FALLING flag from irq request, this should come from
the platform firmware and should not be hard-coded into the driver.

Add IRQF_ONESHOT flag to the irq request, the interrupt should not be
re-activated in interrupt context, it should be done only after the
device irq handler run.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 630f5d5f9a60..d649980479e4 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -735,7 +735,7 @@ static int ads1119_probe(struct i2c_client *client)
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(dev, client->irq,
 						ads1119_irq_handler,
-						NULL, IRQF_TRIGGER_FALLING,
+						NULL, IRQF_ONESHOT,
 						"ads1119", indio_dev);
 		if (ret)
 			return dev_err_probe(dev, ret,
-- 
2.39.2


