Return-Path: <linux-iio+bounces-25746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4FC25029
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0635102A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80034A3AB;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr6SaprV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25A3491F8
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=TA8TCiyEh6FytBMCpRRAmvZgQF8qwBs0Pp4V54kZYNxQLNFlgWzP+zy1nRK/lsE90z8JQr+wTnBm8c8JTewMqhPztIrXE5Sv2wdaLKbEB8zdJrckvyaYjlYrd1JQnb30gPsJ4Hp34XXNT+K0w9TTYNEEN9lQshXkF0N8ZDzLUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=1HO/SYtCE0DJ8TL5FJADI5tnsat5a9GIc97ThqPoMHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3lWyHOFlemTTme/Cu9W8q3cqTKNDVe53QIwhjmyIGTnaSbCyYWSux8nXCFFHQndIbR0V1gX0AwMwM+57p0HK99ab417qCWI9PiSFws3aSmVcOJHE7GVQYebfCylom52iHjAbHZwDOZT/IqwB3tzlK08PTOvt8BFzC15CW2+N5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr6SaprV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A5AFC116B1;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913862;
	bh=1HO/SYtCE0DJ8TL5FJADI5tnsat5a9GIc97ThqPoMHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rr6SaprVoleIIf0oFh5hfhWRvHf70dF9DAzbMngSCMcPzjtVve11gpcMPgHxQ24SR
	 BOcKhGRx5s+864qFAqMCeJnRpIpx5iw9Mzx2V2pj2T+ezSUFZG7svUDhOoBul7Ik1D
	 mVhIEF6xD4oL1DCjOFsq7cYBVSqLizlskuZQ/yArrqOGAVmShSthJk1NbFue+E1YwX
	 E7bwH9u+JFuVtWY2Y+AieEWSyTBLy0Ec4ydV5dNaxnNrkCAxSXSLD0mKG0o5plxtgG
	 +Oz2OGppSsoTA5sl3cFwBEWaNx4sonsMGnwfsYnmsaEJqxb8fui9Plq2LYWVHceGC9
	 oYOjZ1eBkL+Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D6CCFA05;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:29 +0000
Subject: [PATCH v3 08/10] iio: dac: ad5446: Make use of the cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-8-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=2674;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XRRsl2kvXmXQ+Dyr+JqLdRqLpyys78PUIXrgeGFX7z8=;
 b=Vvd/EltwbcR2VDOW3XcedPWIhHigmcL+PQnK81Wt8xbQJ3gbgRubZWZoCRXMWNR+2y3CREGMY
 FxXP8CmRmDxDHj6Gq1nAd/lx+gIx2ku0eYHSZivJQpL4xOA4UgD29b/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use the auto unlocking helpers from cleanup.h. Allows for some code
simplification.

While at it, don't use the ternary operator in
ad5446_write_dac_powerdown() and add an helper function to write the DAC
code. The reason for the function was purely to avoid having to use
unreachable().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index d9fc69e1039f..d288fb56e324 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -5,6 +5,7 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
@@ -80,7 +81,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	st->pwr_down = powerdown;
 
 	if (st->pwr_down) {
@@ -91,9 +92,10 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	}
 
 	ret = st->chip_info->write(st, val);
-	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : len;
+	return len;
 }
 
 const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
@@ -129,32 +131,37 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad5446_write_dac_raw(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				int val)
+{
+	struct ad5446_state *st = iio_priv(indio_dev);
+
+	if (val >= (1 << chan->scan_type.realbits) || val < 0)
+		return -EINVAL;
+
+	val <<= chan->scan_type.shift;
+	guard(mutex)(&st->lock);
+
+	st->cached_val = val;
+	if (st->pwr_down)
+		return 0;
+
+	return st->chip_info->write(st, val);
+}
+
 static int ad5446_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
 			       int val2,
 			       long mask)
 {
-	struct ad5446_state *st = iio_priv(indio_dev);
-	int ret = 0;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val >= (1 << chan->scan_type.realbits) || val < 0)
-			return -EINVAL;
-
-		val <<= chan->scan_type.shift;
-		mutex_lock(&st->lock);
-		st->cached_val = val;
-		if (!st->pwr_down)
-			ret = st->chip_info->write(st, val);
-		mutex_unlock(&st->lock);
-		break;
+		return ad5446_write_dac_raw(indio_dev, chan, val);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info ad5446_info = {

-- 
2.51.0



