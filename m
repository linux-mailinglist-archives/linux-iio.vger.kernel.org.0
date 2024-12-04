Return-Path: <linux-iio+bounces-13103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F79E4941
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE84281B88
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A155214A93;
	Wed,  4 Dec 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VileEiKi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4C206F3D;
	Wed,  4 Dec 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354936; cv=none; b=BdjszYrJjuaRiqbI+RNUaNySC9qKTiRBMqIkgDp4NdOgjxXsNDAHHEMHNkqqGheFoo5ObpRBHE6fEBSjlhuvCE+x3etFtcqzYutCuMqj2W80qlcQ7/XHKC1TlNYKjXSCIKZ5xpd3iRoffTr0NhiOIUqECyjtFb1gOKuU/HMQQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354936; c=relaxed/simple;
	bh=MSGmzj2yzkte66DjP8N81A39NevXdQ1SAV14LbdnG3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwNYOoMvMOnLCGG5ORoaTXrxkMeLtzjQL05kCfdJwxSBvbZES+q9qw8Eva0lcFp3b2PoAYm7Qt+hJM2XnpsEUG8cSVCn9oodpm29Sh6lZ7OYRZV+LoAwbphCEzzmej5hMot/AOPeq29wva1XgKcZSNRkyySokPKRjbtaRsUUHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VileEiKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A2C4CED6;
	Wed,  4 Dec 2024 23:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354936;
	bh=MSGmzj2yzkte66DjP8N81A39NevXdQ1SAV14LbdnG3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VileEiKiCFVr03m9uxgwxpXXxCsCGTekDl/10YnNBa4xYLIwg0xeKk0+PiEo1nG4C
	 +PsV3LH1oRzR01gv4yR7ydLqERkUHFKju3PUFf70BZixJHYYt5/xYSz+owT1ZoUCz3
	 sXfO/MiESeUS6cc7dLjoH0Ei49VLKsCF48VsRSpsYatzEsy/KsQQyBtA6HEdS0GS3S
	 WSz2HAoCr0vOT5NpBjbwaS4QawpyUobzzL0vj8t3nWw9b+uWKglkxivWvA9+OXW4co
	 RorJ8gsUPg7u7IrNFCw47IDuxveCQWB6WIZLXz/2M5ZLAP/Hmxvz1ieKf3Fk90i6og
	 XpO5uNRRq1c/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	alisa.roman@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 06/15] iio: adc: ad7192: properly check spi_get_device_match_data()
Date: Wed,  4 Dec 2024 17:17:00 -0500
Message-ID: <20241204221726.2247988-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8 ]

spi_get_device_match_data() can return a NULL pointer. Hence, let's
check for it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20241014-fix-error-check-v1-1-089e1003d12f@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 334ab90991d4c..1d5958a05dee4 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1255,6 +1255,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.43.0


