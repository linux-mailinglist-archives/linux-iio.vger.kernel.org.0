Return-Path: <linux-iio+bounces-7624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFE931A50
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36491F2200D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3F6FE21;
	Mon, 15 Jul 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EnppYMWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41810A24
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068312; cv=none; b=dtkXKoNy50v17qWrU3PyqiIkBqi9RZStfsPE0e6IEQVF3KEobxcwdj0hOx3LfoW16n2Ws2owu9zHoqEM4DVRj2yrbZCiCoAxDcvD+j/nx5SBm9tppH8X4h08FHIxm7gs91f+Ju7xQ5VERkh3VCHPCcIYkgdmYU7dqCTHjMdGIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068312; c=relaxed/simple;
	bh=xsC13xZMRfEfQotR1WW+8Mbipsg/fVFLMFsmbftEunA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyIaDBu+C0VMNpUi9SWtBtK4ophA9J6LELhg0b04PM3wVDw458BHzhUGYmkWPaFVjXzmnjIt5KzTwLjvOt+kMCPEIKVdOVsl4+Cu5fDcygDB0aaYqM7L0LV9ZYWe1OXC3HCrchBgz9Ve7zAKtD2fqKqX0RLnH6sC4WUzgx/rjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EnppYMWb; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9C3BE882B6;
	Mon, 15 Jul 2024 20:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721068308;
	bh=mnrus9K1Xf/c8w61xyhTZx6TkpXikt+zrNC4hoN4vYA=;
	h=From:To:Cc:Subject:Date:From;
	b=EnppYMWbYOu4Zeb+3lR5DoQVIKhA2JYZvC61HcM3ZJT1trzByQ6vWXSo+i2gS6CbW
	 9ieWCRwC12hXkbsLa51Zp2CX0dRSX2P4VgQAA/lgI4uW8Nym0D8Q+arY6E0t0TEjgD
	 LlMZFsgUaNt6B69k1Cr7QCfUa+PFWE0VYsdpJNvcmQW21ow4f1g4mwB9hlb0sE1y86
	 s1RTWVEZv2QbMp+Y+/TRBv7WcgGamz2dvq1sb3vOQzwz/zL44RlCap/niHwAPTmdMS
	 Fe9kdwYLYdezxkf4nc18hrKz4Ix+Ll84xeWIV5d/ihii7j0Flgxu9EhbW5yRyxK0tU
	 syafO/TfyeMXw==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio: light: noa1305: Simplify noa1305_read_raw()
Date: Mon, 15 Jul 2024 20:28:55 +0200
Message-ID: <20240715183120.143417-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The only channel this hardware supports is IIO_LIGHT, if the channel
is anything else, exit right away. The 'ret' variable is now always
only assigned by noa1305_measure(), do not initialize it anymore.
Update function parameter indent. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/noa1305.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index 596cc48c4c341..a76f158bb50e5 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -125,38 +125,27 @@ static const struct iio_chan_spec noa1305_channels[] = {
 };
 
 static int noa1305_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
 {
-	int ret = -EINVAL;
 	struct noa1305_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_LIGHT)
+		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		switch (chan->type) {
-		case IIO_LIGHT:
-			ret = noa1305_measure(priv);
-			if (ret < 0)
-				return ret;
-			*val = ret;
-			return IIO_VAL_INT;
-		default:
-			break;
-		}
-		break;
+		ret = noa1305_measure(priv);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_LIGHT:
-			return noa1305_scale(priv, val, val2);
-		default:
-			break;
-		}
-		break;
+		return noa1305_scale(priv, val, val2);
 	default:
-		break;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info noa1305_info = {
-- 
2.43.0


