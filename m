Return-Path: <linux-iio+bounces-7112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D3291EB86
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 01:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06A61F227BF
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFF172BCC;
	Mon,  1 Jul 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="D1fWCCmL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7217277F;
	Mon,  1 Jul 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877571; cv=none; b=QU+KvS2ldlAHa6WvNhUFkQiH5t07QlmiSXivYcZLUTvqkGuXi/Yi5+NEd/fBWBBl2FgNAtxF0gTxLyFsNgKcSpFwwkF1GJc1OrCmFyFO4B6sKrs0xQdrpC97cx9vi45CAVbpS7IEjQSKhFpzGkWClIDIvETJwL0bzL81oXFWPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877571; c=relaxed/simple;
	bh=vDCAs5hfddH+lemVzwZUk4EaAhxdz0tNNx9npgmH4No=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxRdkGNKT4IDMrX/FEnwMF300A4IqiqDODq9kbOtD+7uXFl0iihqbJEcRDd9bJB8pwNmU2hN3/RmQtfW1hFRBen4oX6r+KPm5gO1e138C3tkwo+rTAniwfYgEd+SKoktjHcLmgLSe5CnhXeyA92eby1PEtue73KpnBUPast1yKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=D1fWCCmL; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 5F333100005;
	Tue,  2 Jul 2024 02:45:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719877552; bh=zsi0EpcTiG/36yNGtHhih1fjouzjejGqb6SOyBmE7js=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=D1fWCCmLKjwjB9HvsrYgzXso4sRv8EyaZPFGwLqPlpFkVpqJEbbA4N9snZL8K5Z0z
	 Xt/qOvtHQ8ziVhyAnULHda7XrtGKMbByVDAzI5IxpTfSJ2vMXw+mH9BVPpZg4/RR/1
	 btX+RX+2VPNp3g0OYMAY2VZzDSqqqrYlT//qbfc55tRleG2iZNT+ZF4926t38atD7v
	 QR4jG8QfyXeMu7C8RNJ3VD5Qfcb1/qYYaD1xJ5EepB9fgy9c10RlUJ3zQL8l1tBVcF
	 la+7qrUQU4A0c/0qjDOmJLPPnIvoEmiO3hsVxQDIP46BRJfATRjYRkdh4xBNkvZhO/
	 weXxJSgfbBGPg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 02:44:36 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 02:43:46 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Graf Yang <graf.yang@analog.com>, Mike Frysinger
	<vapier@gentoo.org>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10/5.15/6.1 1/1] staging: iio: resolver: ad2s1210: remove call to spi_setup()
Date: Tue, 2 Jul 2024 02:43:24 +0300
Message-ID: <20240701234324.20811-2-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240701234324.20811-1-amishin@t-argos.ru>
References: <20240701234324.20811-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186263 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/01 22:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/01 17:38:00 #25803542
X-KSMG-AntiVirus-Status: Clean, skipped

From: David Lechner <dlechner@baylibre.com>

commit 9829ebacea804ad4b5d1a74a8d94a1f843505546 upstream.

This removes the call to spi_setup() in the ad2s1210 driver.
Setting MODE_3 was incorrect. It should be MODE_1 but we can let the
device tree select this and avoid the need to call spi_setup().

Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-3-fa4364281745@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/staging/iio/resolver/ad2s1210.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 636c45b12843..42aab1ac3aac 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -681,8 +681,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 		return ret;
 
 	st->fclkin = spi->max_speed_hz;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
 	ad2s1210_initial(st);
 
 	return 0;
-- 
2.30.2


