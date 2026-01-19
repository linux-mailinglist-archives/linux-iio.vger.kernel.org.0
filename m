Return-Path: <linux-iio+bounces-27996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC8D3B5B7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6947300BBF1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8538A9C4;
	Mon, 19 Jan 2026 18:24:46 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFC3904FA
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847085; cv=none; b=FY6F4iOfC6az3qDB77bB6+p/vZGs5mxCQKF6miQbdWIeDmgyeZdlJrR0jjhJ42/2OqWIDbLQm9yLwfAdqKIhXOsxSY0Ywx5srjX9qyu2owB/xjmjxIPHOoqe2wyLnUoSbUBHOQMAwrn0BDBVMiDh4fC8WFrjZXNLAU1/d+fvpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847085; c=relaxed/simple;
	bh=+L8hofjKyjTSzyKgvlJ00wSPTK1EZoc14n6gT4ZKxvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT39cZ7DVc7r1xf159OzdEydUcT9BG7j8ENrFUABR+vLHsCYqiWtcBiXvbt0RkHKlhCRUv0h+clkgmzln6deAYKYgLyU0FDIPLgANMOtvcfIzM05oEFvfePu/cMj3nzZyggfg7ITbKOpBJ35qipbsRBeWl4e3ivOkuinCLJ/A8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-0004SO-7c; Mon, 19 Jan 2026 19:24:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-001SUi-1B;
	Mon, 19 Jan 2026 19:24:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvN-00000006y1y-2aWd;
	Mon, 19 Jan 2026 19:24:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v1 4/8] iio: dac: ds4424: reject -128 RAW value
Date: Mon, 19 Jan 2026 19:24:20 +0100
Message-ID: <20260119182424.1660601-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119182424.1660601-1-o.rempel@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

The DS442x DAC uses sign-magnitude encoding, so -128 cannot be
represented in hardware.

With the previous check, userspace could pass -128, which gets converted
to a magnitude of 128 and then truncated by the 7-bit DAC field. This
ends up programming a zero magnitude with the sign bit set, i.e. an
unintended output (effectively 0 mA instead of -128 steps).

Reject -128 to avoid silently producing the wrong current.

Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/dac/ds4424.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 072b7e6672cf..9c24c37d3c42 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -143,7 +143,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val < S8_MIN || val > S8_MAX)
+		if (val <= S8_MIN || val > S8_MAX)
 			return -EINVAL;
 
 		if (val > 0) {
-- 
2.47.3


