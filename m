Return-Path: <linux-iio+bounces-27751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD14D1DE1C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD85730B3414
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BEF38BF9A;
	Wed, 14 Jan 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="4KWbzUBY"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7338B98D;
	Wed, 14 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385275; cv=none; b=STjbI8IbgPb2EBayoL3nhHRGXWlDIADRFcoRIFbbDVEEn7OY7RecRHnLcUkRb3ZELnMFcRr20tLAFAkXtpGGM8985/bLpvKOzEfnQ9GLYbS8Wxsr4EWPtG3O25ufVDGRlylZ9QUWvhdtBICLUArAgn/TZONMzpGkCXHD9gR35fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385275; c=relaxed/simple;
	bh=LNYRbWpUSpQ5HqaUhe3nMKQLB0PShCOY0dkwhJh6i4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ndc6oWiaDgUEIY1os3Fz1czsGkFzSzSs2gMVkLUVpPYCVdCNqCk7b8gccS1l2WkkPPTxPJrxT20zPw3YD0govTgD16ID4vAtG6XRt1dai3Qo374dsfcQUDCPe3ddHJhKlk9Ix8i+3kIiAuo179SNO40VYpgE44wI9ZLlen3WhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=4KWbzUBY; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 7DC14160214;
	Wed, 14 Jan 2026 12:07:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYflhC/k/24Qffm/I8AJ/uvXlBOpnIFA1VYzH5roRDc=;
	b=4KWbzUBYT/VcZoJhw/UayY1zdU5Pq9bi3O7k22c+xF5hCXODfL3gTREJQ6Lk6tztBcuIYo
	i2oreubTzSuRxWmNgRSdRk4qs5UR1CMKL83XbsYjksn8pLCLbkBVsU0PItY5GR08ucCAUr
	8LJQ+JQy5AnVohRJjnNrReKmhNpPOMfUTAkBAB+EkD7GcqBqMDndjKMRBR0+sUIwpq8tfD
	5n27ZbVkcE+Vh7SvB86wX81LLAFfBOhb3gzXEul/eaFwQfPr1HnYPVMfli018UI17AgLOQ
	49y68QN1N2Reh/+G4J+PT3c75d0eSteAaTENwUpDGv707Q4wZ+kTLMMJg+vtow==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 12:05:44 +0200
Subject: [PATCH v2 10/13] iio: pressure: mprls0025pa: move memset to core
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v2-10-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=LNYRbWpUSpQ5HqaUhe3nMKQLB0PShCOY0dkwhJh6i4I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuYXVmZzAwTXRlTDM5NDZzRVFvZDh6eURRCmFRWVF6a3JHekwvZGx6cFlD
 RFE3R0lrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFoycm5
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTBrUg
 pELzl6ZHNVREtlQWhWbG1kNnBLL05FTDJBRWRpaDJhU0Y0eVphcGJqdktPTUdHb1VIV2ZNNExqO
 DYvR2JVODhoCnMrSzZKMC8vYjNUNVMrcTNjYnpBVVBJNUxYWElBZ3BUdnJWbDlSZCtaNUhlQmFM
 NzN6cDFMLzkzSWh1V0RCZnkKVWRtampkQmEvVUs3ZEN6QWJZL1VqSXhsT1VhYnJQcGl2WEt3Q0R
 IUXRUUHNwWjg5ZTVyWXlQdm50ZWwwcFhPRgpUOUxXZnEvT2VPN2tlbU4wbmpvMWRvek9ZaHdOej
 lsb1lUOW9hVWpZOUhqU2hLK3N4RHBRTDlHYlQ5U1MvbFQ3Clk1ZStCVmx2RXIwNjhqQTV5d0lnT
 XdzdmVTUHNBa3pwTHIvWCtTNmRGbXpFMkJBSGtoTW5qNVJJSG9yRnhkcTUKbStQS1Nkend6aG8y
 N1FMN202TWFSTXNCdnE3Kys0blVLOXRJd25wZExuYjBmVm10clMxN05lYlUzNkZ0dG9sVwpCZyt
 XaGdSejdqTm9zNXMydVQxVksvek5CZU9ML21vcGtoRTd1SndsS3dkY0Mwei9MTkc3eW9lQWFURW
 ZDbUZoCkNnUjIvdENRcysvd0lCWlRET0dyeWFuYVV3RlltUjJxNFhZbThZUnV0SndQWmxUSEIzd
 WR4cE5aRmFXaE5kRGsKNXZOTkcvZkVXcFlkVEVTTFljSHRBSHpNNjVCaEtpUWVnRlE1Ri90T0lJ
 MFRzS2x3bUZBdkhRWHhET012dGh4OApCcEl0V3c3K09YeEliLzBIbVQ2QVltbXh3dEFsS0ZtS3J
 KVldWN0xldXdPS2VzQTJuZEFJWm5HeUl1MGxySytKCmJpVnRBK1dEb1lJMitRWU9QUnMzeituRX
 BzaXN5V1QzenBNaFZmeHc1VE40ZEVIOUtqOD0KPXZrRUgKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
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
v1 -> v2 no change
---
 drivers/iio/pressure/mprls0025pa.c     | 2 ++
 drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 7532b2e74413..e4651d3f686d 100644
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


