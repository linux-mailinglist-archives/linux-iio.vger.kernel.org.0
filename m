Return-Path: <linux-iio+bounces-19155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66310AA9C74
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B630617E4C6
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4822701C3;
	Mon,  5 May 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b8UQtFmP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1162701A0
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472946; cv=none; b=XgRLNUhqcdRXDXI/ibIMNSDtcZPdzTRborm6u10MkFNH9nohajhNxDPu36KbdJs2mZuKD6lyVlai+NOvKqLEhA+/rZKCwowCVudxUUiNVO/E+W/l6fRes91m8aQ3Bt3pr07pNZ35g5WMcmQlqZuouWmHT8YxfrFf8tmztYZncdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472946; c=relaxed/simple;
	bh=UGQcqHdSu34YDZoRD1XVkvJy/yBHv9Lh1BJRlQY0stI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0B5Al7MKh5Lykntxz+ONDdYbWQ9PCS5ny62rJ1WzoJecsPSbxxk/g3Twore+V74tzrmUyTWCu2fVQUsRf4P+d3NSglAbhYkWn1Y+5e2Gm2vLYqXYTrE3yR+CMQ1eqZmaLafk8DKLOxLz0VaqcLubyWQj8mJ5K16TozbME+RQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b8UQtFmP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c47631b4cso2839895a34.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472943; x=1747077743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCh/sVhB0DOnRDahlg1cUo0LP2dfGdlpj3b9LEwGq0M=;
        b=b8UQtFmPoVuDz8DuwzaUx9Xj+9NEG2YNIC6GOCcAHY10c+k7C2iNweI+87dsxaz7JV
         GaU11LQxFNrqt/S9wuH5RO3Uy18AzkHyTsqM4lxiT78qg8TForQLj7p7tLEVjQl+0I36
         zlOlfpqmL61u3OQj5ehZmJeDW74AEwnXu9kwpZSZA1myk4AwowKfrmI3y6tPk+I7rLTC
         XGv2uM/CI3PZzSS2uqTh0ZyiZxXDWokBVD+GUGRjtDTpR3osrRhzRlpXR2lLA94D75S6
         TfmhnaP4s2Qh5bLEC4qQG2D3STAMMA8UX9l8EKK94O7SmsPTk3qVbqxyJLZkOABs3ac2
         Nc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472943; x=1747077743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCh/sVhB0DOnRDahlg1cUo0LP2dfGdlpj3b9LEwGq0M=;
        b=duu08WAuBOrbDdXgyRiZsUVvqac5ubng1Gxj1v+0CYmCadgEbzNHXsKKYHd1ifdK47
         qSvK8AzMMlh4b10X0jLrFVZP3P44InhekoDIbFhh8FE7Vqcl2uk8xU4FDVIUJjfkQqV3
         QrRCks7INfyjUpflYMh+yLWEGDzXwIxbfa6MqcsqJOF6Yllfn1faZqopzCkPP807maPW
         HKKnzAaRHaiaemq6UoyOqgHTi1IN2SqDrXoU94mste8fVsiFUNZKlbfWn4Xu0AfaIfdo
         OjHTudZRKNY/SBrlrC4O8/yxVx6Axfgm1f+OYhswRcBVv8n5HRz8k9yCUtIru9H9Ffr5
         Kzkw==
X-Gm-Message-State: AOJu0Yw7bWpnSBY2sfEAD2eusrXxc9C5XB44vi6AK7jgKywGLMlHcAsO
	7nFhwk/FeBgZEQrIP3BszjqReJGW5030V9lPLT4AjTorz2eHmaBVS7G6fwGyRAg=
X-Gm-Gg: ASbGncsc8WLj8gABw8uVIFZy3Jv17cT9hLe2MRK0FIWBhNOtCnruwIIJ0wTkdSPJ+VJ
	WY7p+VJ3bJ70vMrrRtzLW6f5wTBin7SSklYrJLztliEHWMU4ZBel0kzfB/XeZSADPMyAWUk4Fth
	5Pf52qZ1qfofqwe9rxkmp97jp8C1RVjQ7T8Z2fsdRBDj4baiSO6HDugCJapygANbSj2dF+tTIZC
	42eiJB/8skIZbvpnkMePGStVeO0o8Xua67HcNZ0KPzy/A4JrgcCHxh2y83d+Usl70awb+rhbWGe
	PEVrxsZxFw6n2/5n6hh+0C7RW11tSbzs/R/WhVr7fix7Eg==
X-Google-Smtp-Source: AGHT+IGDNKtYUu7kFstcQ1XCNXpXl4n26WpC2nuSu74CpmoGFHN0jVEyVEhzvXUVQR48PgPGl3hTrQ==
X-Received: by 2002:a05:6830:600d:b0:72a:1494:481e with SMTP id 46e09a7af769-731eaafdf96mr6094173a34.0.1746472943440;
        Mon, 05 May 2025 12:22:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:28 -0500
Subject: [PATCH 01/14] iio: adc: ad4030: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-1-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UGQcqHdSu34YDZoRD1XVkvJy/yBHv9Lh1BJRlQY0stI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ+MIchi+//nh67cO3B0ZIiSXPAAxLRL9+8xi
 IC4gcksNmuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPjAAKCRDCzCAB/wGP
 wCmbB/4xNggrGkqqzXFkJQN6zjqHQafctoZSwdwv9YbrbqDC6LkLpdnz/ukX3hrpcn+mYqnp3cb
 f63KOv5PlJUgyY3ObBewAG16iq0aa08OduiNSfPfEBw+8MblQDn78fQDbqX5+on1X59sOViZsGA
 jN82esDp/ypfLSTApr3J/O3nPh24TxvsCJN2K4KCPBGg1ag5KPD7E7jK0nOvcqogfXR5i9T+GAM
 TS6UGkIsExkivskUcSgkPl0pmnVgUm5HyFHy3KR2yy5Gw+RJ9rpTeaPxY0e6CRsh0aZuk0tCEFl
 P6bNzoXH/HK1F/fpjWttqLcmnZuRJEb2/7k3UQ8FiNmux/nM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the ad4030 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 5aa26dc3a2cefed9bcaec1b9f3cc127d06aff19a..1bc2f9a2247081e166680232aa6d4aebc5f41b89 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -244,7 +244,6 @@ static int ad4030_enter_config_mode(struct ad4030_state *st)
 
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
-		.bits_per_word = 8,
 		.len = 1,
 		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
 	};
@@ -260,7 +259,6 @@ static int ad4030_exit_config_mode(struct ad4030_state *st)
 
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
-		.bits_per_word = 8,
 		.len = 3,
 		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
 	};
@@ -276,7 +274,6 @@ static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
 		.rx_buf = st->rx_data.raw,
-		.bits_per_word = 8,
 		.len = reg_size + val_size,
 		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
 	};
@@ -311,7 +308,6 @@ static int ad4030_spi_write(void *context, const void *data, size_t count)
 			((u8 *)data)[2] == 0x81;
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
-		.bits_per_word = 8,
 		.len = count,
 		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
 	};

-- 
2.43.0


