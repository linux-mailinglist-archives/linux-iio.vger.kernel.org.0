Return-Path: <linux-iio+bounces-23600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61946B3ED85
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E956A3BE57E
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343A320A20;
	Mon,  1 Sep 2025 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIFxx7Kx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC682EC0A4;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749136; cv=none; b=SOJGvdyKTYS8Ijg+5rBmTUAMKjSLPeli9cemPYG/S9Xoo853uYQpM5Y9K36k11+yY2xEa7B/5Y3H0HwsYm2z0B/vcKPQmyPf7z1IzWl4Yh0buTPm9vgdYgvspB9dqwblMhxZkwtjqdcqfNcaysbZNFMMQP5tlIRZ/zGXmlNspDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749136; c=relaxed/simple;
	bh=aZNgGvHlV7VcTlpwHrhtAjN8O1EjEhOimmgV9P7JcrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BF78RcTL6ECoamRZt4EvQRf35E2dc++gEKynSG8aBO0SHUSo+dhPsi7/a2uwrHvmCS5VwYvQv6XOhFEj3g+/37GzeJhopQvbRLYVWeEfQ9k1comAwXIeV1IGbiw+/ncQ8N3Ldt4c0JMeNn+xPd0i6+2R50rW0+y1x8iRRSURDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIFxx7Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35746C4CEF4;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756749136;
	bh=aZNgGvHlV7VcTlpwHrhtAjN8O1EjEhOimmgV9P7JcrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TIFxx7KxozzVplXltHXVTgvCKaUko5HrDSAVfI2X/JjAhGomqHt3eIs5VbCXfJhUq
	 z6WLzyTijYhTzGFwnCieTyGnOXMnlMmFUcCgIZQ1JD7ZyiX6LhzKTpCh6LZx8ULF4h
	 uDdyI85nU6bZQqBSHCs0YQC53Q0NfSXX5wzZAW+xgrVqN70fCe/XgK4ZYpib5F/nCt
	 Piu4DwyAnU9qO06iniG/aSxCQhZGybk9gvU3RbTC0LUM6cm0ZWCnFJohIcooiK3VdY
	 EZ1DVsZ1OgHiIORLA9FmCCzAFDdO+u3UgQAaYf7IaUMUz7Y6+RKjhakjtXlpIn+unz
	 ZVyZT7cu2sNfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E6CA0FF0;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 01 Sep 2025 19:51:58 +0200
Subject: [PATCH v2 1/2] iio: humditiy: hdc3020: fix units for temperature
 and humidity measurement
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-hdc3020-units-fix-v2-1-082038a15917@liebherr.com>
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
In-Reply-To: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Chris Lesiak <chris.lesiak@licorbio.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756749134; l=1275;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=DTk8F0sZi2VViT14ML9opSSbm/71ZSWvhkH8fmcKoZ0=;
 b=HSHFG7h0RuMGrhFJiHHzewuWELDvbnPQvrP/CLr/7uMt9tictl8aaA00z5uSlxwlYf9tBt5qt
 KqqGFw1ECy8Dk83kkQsWzMQSqid90wRpcf71HGcd2JB6uLr9fdgZAqp
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

According to the ABI the units after application of scale and offset are
milli degrees for temperature measurements and milli percent for relative
humidity measurements. Currently the resulting units are degree celsius for
temperature measurements and percent for relative humidity measurements.
Change scale factor to fix this issue.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Suggested-by: Chris Lesiak <chris.lesiak@licorbio.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ffb25596d3a8bad01d1f84a9a972561266f65d76..8aa567d9aded9cab461f1f905b6b5ada721ba2f0 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -301,9 +301,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val2 = 65536;
 		if (chan->type == IIO_TEMP)
-			*val = 175;
+			*val = 175 * MILLI;
 		else
-			*val = 100;
+			*val = 100 * MILLI;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OFFSET:

-- 
2.39.5



