Return-Path: <linux-iio+bounces-13556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D8E9F3AF9
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC66F16A65E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F41D61BC;
	Mon, 16 Dec 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QyPAmi97"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C191D5AB8
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381477; cv=none; b=hNNgmf7NiwLTRnh/BTxqgSlZLB4jz0NVvHLZNHOOgxEycchiPqML6q1CNjvbpdST2tOmDcP7ZVOIGj0emCOxkMYG3amUk7ovXE8/b0XviHZLaEb5Sxs5QhFd5o/obGe6b4kpywlDHIT0jKSe3nrTNkY036mdT+11lfQDSz1hqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381477; c=relaxed/simple;
	bh=2TNtd8bu9LxPRIrOodJUWYgJ1168COuSyLXsxGXbSEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THBJw2X7KM+4WsZEXitBJcD3LyR1Rerq0VzVh+FHihvD6d9ph+JNmtYBbx6WRq8evEVrIk1omBWZBB2CbHt6FNu8MDJJoAGYufsQ8/FnSf7lMJ/YFN66VbinVRUd7bXH7qqo5Pwlj0hvuCZTqlbstPtViSMHAm0TAoMBOexVjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QyPAmi97; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso49892095e9.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381474; x=1734986274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJIklXOID+OyZc6zxu5hCcPuRwlOSwyq9lkiHYE4XLg=;
        b=QyPAmi97HiyoOrNiF1e+cZlgGR5eyiCWYGFy2x8eqYUFWFzxlo+KC1tAMkfRVcUaIW
         aAAd7ia2qU2krClnelA6no3dQFTrAFeLxfePC7cG3gbiuofBXB2GovU/qV9XSPs1wgWr
         EwBgp9jVs+kjZxDgf9DoLUWxOtnjtHtlpE6BFpmEyxgHSCpETwIUe3eYVsxJkO3OD86T
         yJJoktOgPUFjhpQQpm7grrxe2UXpKFZxvEvb9WcDMrNZVKtCiTg5EKMDKK4BQ03vDp4l
         ud9NkW8U0ZJKrsDejlsrGVIEp+pzjZIRNZDACTRk6t/J9RZwiVTx27y8sbEj5djct5py
         lsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381474; x=1734986274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJIklXOID+OyZc6zxu5hCcPuRwlOSwyq9lkiHYE4XLg=;
        b=nsBBHx08Pz6yj3oMmxqfEiRvyzo0Ki3NS6nkpI4+uOJKZbepuhEe6q9FUgPe3iPIVJ
         80+za4DGtGqBt+F2i97SyReZBOw2+wTD5kK7sLEbMSpQCAWtduCtycX32k6AT+IGaN5I
         5B+4X4TwCIHrEHeEjRgN1DJb7mSfFziiFxSp8N/eZb67KVpK83C//zKlNfAHXaNN/4yM
         mfq8kicxIvH03ehmFyLo/oA2FzWQcTkJZ3ap6uiudlcyzN/hbDBwVrKsMdOFQgte2p+u
         7uopnBmKODcbsC+dEuWfx+h85st87nuWsrVE8y1COuytjGx10QglO/2KXeddRqgQm+mr
         Luhw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhWdWqasYT7Qw4JN37xI+JNGLRWI58xSx1zCBTV9R3t7jHXacUtg/yeeGi5/vhTvyNE/sdIKYTtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpxI82OsBkGOtdxRMqt8l9A2pveysnGaFJI4gBOigb0PmH2SO
	R/VqI+A2XeAVwxt0zO4pc8qLmvdj/cQ87s2ztptAqKMshsLGWRJcN/DlmUCZxys=
X-Gm-Gg: ASbGncv5xU+UfAhOPDpmtjeUzQ32lMGrzf1wIhAbkIcba6eFeq1KRBPIeqJb/Z3WfdN
	6R41ERanI9gmldtLw3WCiaTJsz5vQH8W34NfpHB1cf+Ub9/+ZwYUe2Jw15ZBYf3Fzm+WsKi504S
	IqhqTbRo1lNT5OB4Y/RLvehO8kHcTBguX5gKf3wUpeHPPzItzxS2p8lQbu17ix713OvoRcpAHya
	eRds6Hjkgrt+kYWYJYptJTgOV6OsfRD+Kcca0eQWZxnA7yo/LkZ+k+1D54rDpnolp8Kf1KlmCvG
	z9jd3GCBrIba56mdNmGD06AoSWgtmf95gQ==
X-Google-Smtp-Source: AGHT+IEqQC7MOTbxN57stiY7bAykjPNYWOaM2c6G5oj9OGIy69wCD6fru70qM6fFomrs0Q01tRwbOg==
X-Received: by 2002:a05:600c:510f:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-4362aa9fe20mr134933515e9.31.1734381473773;
        Mon, 16 Dec 2024 12:37:53 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:53 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:25 +0100
Subject: [PATCH 5/8] iio: dac: adi-axi-dac: add bus mode setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-5-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

The ad354xr requires DSPI mode to work in buffering mode, so
backend needs to allow a mode selection between:
    SPI  (entire ad35xxr family),
    DSPI (ad354xr),
    QSPI (ad355xr).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index d02eb535b648..f7d22409e9b3 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -64,7 +64,7 @@
 #define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
 #define AXI_DAC_CUSTOM_CTRL_REG			0x008C
 #define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
-#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
+#define   AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE	GENMASK(3, 2)
 #define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
 #define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
 
@@ -95,6 +95,12 @@ enum {
 	AXI_DAC_DATA_INTERNAL_RAMP_16BIT = 11,
 };
 
+enum multi_io_mode {
+	AXI_DAC_MULTI_IO_MODE_SPI,
+	AXI_DAC_MULTI_IO_MODE_DSPI,
+	AXI_DAC_MULTI_IO_MODE_QSPI,
+};
+
 struct axi_dac_info {
 	unsigned int version;
 	const struct iio_backend_info *backend_info;
@@ -725,6 +731,43 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static int axi_dac_interface_type_set(struct iio_backend *back,
+				      enum iio_backend_interface_type type)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int mode, ival, ret;
+
+	switch (type) {
+	case IIO_BACKEND_INTERFACE_SERIAL_SPI:
+		mode = AXI_DAC_MULTI_IO_MODE_SPI;
+		break;
+	case IIO_BACKEND_INTERFACE_SERIAL_DSPI:
+		mode = AXI_DAC_MULTI_IO_MODE_DSPI;
+		break;
+	case IIO_BACKEND_INTERFACE_SERIAL_QSPI:
+		mode = AXI_DAC_MULTI_IO_MODE_QSPI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+			AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
+			FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+			AXI_DAC_UI_STATUS_REG, ival,
+			FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
+			10, 100 * KILO);
+
+	if (ret == -ETIMEDOUT)
+		dev_err(st->dev, "AXI read timeout\n");
+
+	return ret;
+}
+
 static void axi_dac_child_remove(void *data)
 {
 	platform_device_unregister(data);
@@ -774,6 +817,7 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.data_source_set = axi_dac_data_source_set,
+	.interface_type_set = axi_dac_interface_type_set,
 	.ddr_enable = axi_dac_ddr_enable,
 	.ddr_disable = axi_dac_ddr_disable,
 	.data_stream_enable = axi_dac_data_stream_enable,

-- 
2.47.0


