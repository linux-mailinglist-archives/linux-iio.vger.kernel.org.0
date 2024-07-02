Return-Path: <linux-iio+bounces-7165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026B92431B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36A71C21B78
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5551BD02F;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGYWFwgq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA571BD501;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=FsOSSE0eaQpcZJzGGS0N2OB1CnZ4qhPzeWBnkQT6YdfKanHDuRhs7dJbYxX0BPPW6Kbt/wDahSTlrkIkW2ODx3/q7jthJDFNtT2LCUpN/kc1XYYIB+nZbN7HJFd50a4ZXNbqafWCKWVe9MjOyqPBgFPw23VnKyuy55cEqujqAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=fE3JhjjT2bztKbT9EOlEvE1SsTlV+JMoyOGt+QtwuZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjIOWTU5YAeCVniPotFab0OFMDoo9sA/dNTr0028KYt2/xRhTj/+6yUZnNZp3uQlT2W2II9Gu+XMtWYSw0Zo0mnRIajcUx+zy9cilk2mRGdHGUxdNWxNrb6DXXUZvAKq5V5/DqjcTIQYjaUYTV78EoC9tn7X9dYRX9th8dxj9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGYWFwgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EE9DC4AF68;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936160;
	bh=fE3JhjjT2bztKbT9EOlEvE1SsTlV+JMoyOGt+QtwuZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eGYWFwgqqvXg9Bzn41VrH2vawvuQXqsjfcV35VVcEis7XSUtBig618DLuReJejf2G
	 FokgPm69EGEzxUMXruS9khYGzECvWrnul+bogqojcTm4KT7QHQzpuNrZrEnk420Iol
	 6+1+I8k1GXoyrQAVbOBp8Z59gnYcXBrYaPyDuGYd+6552criqW7CyaMVKKdB6gtyln
	 ZZ1Vn+yU1VmAziug1gH0eguUPtGUm7RM1Or06RlMrjB2m1vTFStMQ+swTNXxLzLvNS
	 Xljzl0UKoZuGh/f3+9XRQkRoHXDzA1qYLp7QRFnvBefCe4SG88v+f0UhHEf7CeW74s
	 2JvBpPg5jNsZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B68C3065C;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:49 +0200
Subject: [PATCH 17/20] iio: adc: ad_sigma_delta: use new '.masklength'
 accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-17-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=1684;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=GoBEg3yNYVlK4uhicWAng1ZNnwcbQvwHl3xbhcuNjPI=;
 b=wH7sHfvZ2g43QU6gZdGIAYHosI3ta6a2Y2rX0bDLPTTZP8YUKYKEsPAHOiPLFkpEy6X8JewNQ
 inqywiBMXhEAwR5cClPLYIWa1ixv/6XnrnAEBltg4drZ+C/pVbkHVmn
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of iio_get_masklength) and iio_for_each_active_channel() to
access '.masklength' so it can be annotated as __private when there
are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a2b87f6b7a07..62653d7fe39b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -350,7 +350,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 	if (sigma_delta->num_slots == 1) {
 		channel = find_first_bit(indio_dev->active_scan_mask,
-					 indio_dev->masklength);
+					 iio_get_masklength(indio_dev));
 		ret = ad_sigma_delta_set_channel(sigma_delta,
 						 indio_dev->channels[channel].address);
 		if (ret)
@@ -363,7 +363,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		 * implementation is mandatory.
 		 */
 		slot = 0;
-		for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
+		iio_for_each_active_channel(indio_dev, i) {
 			sigma_delta->slots[slot] = indio_dev->channels[i].address;
 			slot++;
 		}
@@ -525,7 +525,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
-	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->num_slots;
+	return bitmap_weight(mask, iio_get_masklength(indio_dev)) <= sigma_delta->num_slots;
 }
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {

-- 
2.45.2



