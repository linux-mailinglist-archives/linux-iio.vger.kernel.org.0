Return-Path: <linux-iio+bounces-2489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D4851C39
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835A81C20954
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F24346441;
	Mon, 12 Feb 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="g6PZhm/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE645BED;
	Mon, 12 Feb 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760458; cv=none; b=F3xMLZTBC0JJ4glsUhofYXD29DGRdVVI+ZmpDL1PLwapBnewz+iHyMAXN+aw5py0lMPYdDsMUshAbHZsw1o8z39d5W9LTIDwdWNGMKouueN0JOrGfavcT8WLVaXkGaWN7ItuYAQ+RE4XEbxR9X1pmTFWz3NMYuHheno2nrqDFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760458; c=relaxed/simple;
	bh=w4dFeJN6ekT4fZLMgY0MSjyE6BSqXIkBWnDC/steBeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIlC4X8rmpv50Zj1eYv96EkQFk4myQclATHGXYiH40HQghgGeiPY6xpPYBjSKTLMRl+o+OjxdiKFGXhxJyheTlSBor6FI7enwn7FOYBRB/UnuEzFB0ANzncLmC1+7VQ0XJOdhL1755TcM9+/2kkUr4goI2lEpR72Xc2cmZl9ZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=g6PZhm/P; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707760454; bh=w4dFeJN6ekT4fZLMgY0MSjyE6BSqXIkBWnDC/steBeE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=g6PZhm/Prk73mVVUFfWlw4G87khYBj4/3uYUDF/qZlgJkO/84G1G8JzUCaTlQ7Nrv
	 LqO0FKEtTuLxXb2fm0k2ijhFcouznFtXWihL5gSj33pNfBHvmtyaLEpxAvzyhkTxCS
	 r2mWGyLtDitwYKtdbkZqu2jxcGjBNQ7fbQX1K0vU=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] MAINTAINERS: Add an entry for AF8133J driver
Date: Mon, 12 Feb 2024 18:53:56 +0100
Message-ID: <20240212175410.3101973-5-megi@xff.cz>
In-Reply-To: <20240212175410.3101973-1-megi@xff.cz>
References: <20240212175410.3101973-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

As I am submitting the driver and have the device to test. I'll maintain
the driver.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc5ca7a042b5..cc691f61a77e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -579,6 +579,12 @@ F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_i2c.c
 F:	drivers/iio/accel/adxl372_spi.c
 
+AF8133J THREE-AXIS MAGNETOMETER DRIVER
+M:	Ondřej Jirman <megi@xff.cz>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
+F:	drivers/iio/magnetometer/af8133j.c
+
 AF9013 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.43.0


