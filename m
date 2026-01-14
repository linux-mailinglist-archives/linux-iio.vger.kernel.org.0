Return-Path: <linux-iio+bounces-27805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F8D205FC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEA8330167B6
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85913A7F57;
	Wed, 14 Jan 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="xLIwVY3v"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59303A7847;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409800; cv=none; b=rJNPf5Sr8jpRqw2VeZ+t15qUziZ7NI0sIeMXx/jKCfjn+m4imhPOlG1Ybh1Ez1dwWVjttbHR7c2rLe05WisUc086OIahv/EvzLlSk4Zlj/fB73MQtHMHbRSYtKz5Y4N085G/ctMppRsMj0a6iD2f/YA1cRQK0VtFBvhWB5hTXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409800; c=relaxed/simple;
	bh=Jagc9iqtf55Qs8ItH4kLzosR5Ollu8YjKJgssBpycWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbCym0KX4iKgs90yzY6yuitZLAdkHTLnRp+kGqnrOf198JXVaHknNXYreMUBFe85YRbGi08YZ7P5ngnbQyr3NeFBkFxQHD1Jzp7AXOIB6i76cYL+8hGjiABBSiTNynFXABPWQcH3T+Mo++9r115HcDsbVMbuAabILrXd3CmBx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=xLIwVY3v; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 8358D160214;
	Wed, 14 Jan 2026 18:56:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Id3DMlIC2cKbVHHR7YX17+YiedfAbBmVLYJX5OObzk=;
	b=xLIwVY3veW8AyTftU8CsxKFDWuTBYdCc+wGzpXMWn4eijYPZwuBR0K2cYcWXNm6wgS1DMA
	KI0P5nORdwA7Qg+7DprEFofGlGoU8KTjJOcd3hKXJQMl/Cu7O5tAHUKIgDZc7VafDFfO8C
	1U80c17Y09544gidvnjpZw3b38rrCHzwuJZIRQKbwdoUVAogLIxh844L/yuKVZpW6lUw2b
	rriut8XbWpwfn6enYsb6JM4zVbZF4tH8OiTl7Mh1l6XXRjiwObg9uE3Rq4o+CDwNI0bXho
	T5yfPrM5nHwGIBljsis6YbXYsNV5f75W2/QbCMih+y0myHeIelr9UOmaT6ZRHQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:39 +0200
Subject: [PATCH v3 10/13] iio: pressure: mprls0025pa: move memset to core
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-10-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=Jagc9iqtf55Qs8ItH4kLzosR5Ollu8YjKJgssBpycWo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXF2OVRxNEV6VXBzSFZnUWNIbVB3bm9hCitEMVN3Zks2VmdKWjRhZm5h
 b3lpZklrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cXJ
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXlMYg
 pELzloTGthS3Bnc3pQaFRPQ09qTG1hQzhrU2dZb1A1bmRvNGQ2czB3UFZmdTFLaEttY213TTUvY
 VpaTFRaK3NQCkRka1I3NGxGTmsvVjk2eWRRZ3NoT1RhN0VTSUlYeDNaQjFUbmUveWkwVHdtTzdo
 QWJoWmZhUmVGQ3hpV0pWdEgKV2E4Z1NacjFSd2tKN1ljOVRMMkpxRlRIK1paemgwYkNhN2t0OTB
 hVGRNdktMY2tockdzNm1ibEE2bjU4UllITwpGbFRCTXFNYnQ3QkwrZ0VqTllnRERLV3owT3B0RT
 VyaXU4TUpHWFlRYkFURlRkQUlqbUYyWlpmemt4NHdKVktOCjU1NUJiL1BsWi8xa2xGdmlWclNWU
 nhMTjVjR21kTkFrRjNwVEU0YjZ3dVNCaGNUUml0ci9QcWRTdUtjdFpkUmEKQW9lWGMweGRnSFBZ
 ZFlaQ1lRRldqc29QMXVBZjV0Y2ZKWlpSS2x6cmpYcVJSQjlSd2N4blZoc0drT2k1VHA4MwppVDV
 janpWd293Q2ZqVTNXNGtLaVVwMEFPTkluSTVBamNOSksyWUxjbElRUWRWdEFtUUpCME1kSFpPUk
 F3aURECmdZS3luWXp0bUpGTngxeFJTR2xoeXFzWnZ2SUNNQjNCRDg4M3l6TysrNEVZZDJBZWovb
 mwvWkNOOFUzZGdGckUKdUE2ZUYxZ3ExcE90Ry8wTHA5S1VVNURjNVUxK3VHQkxMOTdMWFB2VVR1
 QzZ0Qktnb01Md1hQL0ZBUnk3UjR3Kwo5bEpMb1ZNRCtjc0JyWEN2a0Z2K2swZEVSR2p0L01sSWF
 lUEtCT2RRWlFZa1JLUWVKS1pjRWlueUF0ZGJ2QzQ5CnA5VkdWODdYRjE5aDVjSk5FcHlPck5FaT
 RCV3RNczFFaW9GSEY2a3h0WEgrUE9Db0pEND0KPWlGWkwKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Move memset() from the bus specific code into core.

Zeroing out the buffer is performed because the sensor has noticeable
latch-up sensitivity and in some cases it clamps the MISO signal to GND
in sync with SCLK [1]. A raw conversion of zero is out of bounds since
valid values have to be between output_min and output_max (and the
smallest output_min is 2.5% of 2^24 = 419430).

The user is expected to discard out of bounds pressure values.

Given the fact that we can't follow the behaviour of all SPI controllers
when faced to this clamping of an output signal, a raw conversion of zero
is used as an early warning in case the low level SPI API reacts
unexpectedly.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1588325/am3358-spi-tx-data-corruption [1]
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no changes
---
 drivers/iio/pressure/mprls0025pa.c     | 2 ++
 drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 2bcd339dc84e..a7041a503bde 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -22,6 +22,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/string.h>
 #include <linux/units.h>
 
 #include <linux/gpio/consumer.h>
@@ -247,6 +248,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 		}
 	}
 
+	memset(data->rx_buf, 0, sizeof(data->rx_buf));
 	ret = data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index a0bbc6af9283..0fe8cfe0d7e7 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -25,7 +25,6 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
 	if (cnt > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;
 
-	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
 	ret = i2c_master_recv(client, data->rx_buf, cnt);
 	if (ret < 0)
 		return ret;

-- 
2.52.0


