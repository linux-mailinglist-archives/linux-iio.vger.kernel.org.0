Return-Path: <linux-iio+bounces-22005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610FB11474
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3393E582C05
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB18242D7F;
	Thu, 24 Jul 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iyv4YIxR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B824167F
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399563; cv=none; b=XpF6OKSlYo/+zy0WBsn4oiZCPTlgnz6mMkRTfFwRo2xW0B/g3zmc3erlkDxmrWck61n68ZM94lDEhctQ2znkX31d5FlBH5TRM7bnfEDY79Q07+4uCOhfKxZCIOUD49PCTbP+8iOW40EePrc1nmmcGBU63T1wqcMCPlJSepbyc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399563; c=relaxed/simple;
	bh=dL2PSwFlohMjte/0MXtPjUXionCzDJupDvIGkJBlwK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kltkd0qzVvV8kpqe45cmUOadIYa3cDl6ivU+BQjxTZAkmq0FiUlQY3EkYjLoWRb5LYHTD/gQjqywY1vYs+pzTIl6NgvYMtZheHDmtenr5ntGwdZnauUJ2e105dBAqiLQ7nF36P9HBOJ+c8d5Xs8mpE6afwxFKOsHuTDpYJikSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iyv4YIxR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2fef7f6d776so536466fac.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753399561; x=1754004361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeKHbbTRbkREiyUQUHW3LJ0gzMYahsTWwJDV1ry44cA=;
        b=iyv4YIxRAS4ln2n3tH0FN/Z98V/M7ur1o14sA9eI4hQ4TdPCPIl/Jw0fbWCeSzafWx
         CfKsuZfqUDgoJ5fJK6LWsdTy6g9rOpVpivtU1P1XMQLBkrK20HCOw74n3R/NOFFRLQXe
         PZ/2l7kN+8lp8oSpV0/In/PwziXoiQ8QYpiuKEfFatzRJrq+Kjpiwq8je7ykZzNhji6c
         DX9iH9WIJY3uu9mzQw7zDthkee6T4ORdiNn7bpe9zxYrMhXm5XzvLWBZoVDhbN2nBDsj
         KItd8fmjGH5WSbB+i0eXnlxAKqzNqKk/1/zS5KLQYArVDmighoy/gVXlvX+UvYIuuL6i
         cUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753399561; x=1754004361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeKHbbTRbkREiyUQUHW3LJ0gzMYahsTWwJDV1ry44cA=;
        b=CBQhVrIf2XIweJxwikSWE5tIcaPW5aJVeMC4p7gLTRWfMI3SUiLmtrDlGNof/c5ep6
         7PcGNf+CChK4fHT9Fx4cJ976pG4vOd/Yi5rgROcV0mDnMCxTB4B+MCJp/mApzm0yl3p1
         pTGgfHm0+IWrZ1cnFUcARAFGphkVVvyjoRWA+vx2N32iosNghaEiCl6l/9NfpYP6QN5g
         cdYMeL0iWiJyrL0YKaJVZ3aQAH+xXQCt4b4QXbiVFVw+sBeWCeNtNiWh9mpBkew6xSmw
         iiXe+1/Dt89HSJ0mZ2oMKuvprqZu9MSJFTVWZIxQ4FSaeGWbp0AAnG+e0OOM8QlYcgmg
         UL5Q==
X-Gm-Message-State: AOJu0YxPYHDWEBtDlh3HMjypvnmmMnzgy/nkL4WJHz+jpv/AWbON8h7Q
	Hcl/M3npVoUu5YWND1lR4TYByqwsOJZL3m9fgLCDHEt+aDUelA9fZ/0igr0mJvL6O+I=
X-Gm-Gg: ASbGnctX8j/cGcYBZ7WS9sFrFGtbjNueSNb6TNdG3s8GDmYoI/wYpVJUiLzlSyopqEQ
	KH3Vdfeg2F0wCLYKG3fkSRYyFnguWKoKqaCNCoX17HbJfux0dwtF4sETSX57PtKzVhOQ2kPWq+P
	YgopoHuiKLeIFrkFu3UC0j7O7WXcztckMClvcFCBMfpTVLRNpuVnCmfSyZ4PfSS6tLsZlhqP1Ho
	Q9RPmyuCTrACY6n6Hhf/qJuj8ASjXWao51IaChgJ750Fx33CPxRBWDYJwkajquEr0qjRHeRBAI3
	CUAM3KF1wW2s1iKmPP1HIohvakkxK4kPW6Tc/V90424PefOUa79Gpe0e7RON3eKluvB2yZr0DKu
	K8+weZtoxklV4+hkKZlU9MMNqXA==
X-Google-Smtp-Source: AGHT+IGQrI5um8n+0JkcZXB2b0zbweZ5nlNx1XY8MFeNT5SIYqpju8IAvichyXi7+QEtARAFQIZnwg==
X-Received: by 2002:a05:6870:a712:b0:2c1:bc87:9bc0 with SMTP id 586e51a60fabf-306c6facfb5mr5934201fac.15.1753399561216;
        Thu, 24 Jul 2025 16:26:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:337f:e3bf:e9d2:b3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e3971332sm689626fac.0.2025.07.24.16.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:26:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Jul 2025 18:25:23 -0500
Subject: [PATCH 2/4] iio: adc: ad7124: do not require mclk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-iio-adc-ad7124-proper-clock-support-v1-2-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4299; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dL2PSwFlohMjte/0MXtPjUXionCzDJupDvIGkJBlwK8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogsDy4SoQeoOS7NnvFMFXpRdK2BmluaOODtBco
 Xy3K+fKiD6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaILA8gAKCRDCzCAB/wGP
 wFznB/9yEt3eAkwnrFqny2nq2ETRVdI4p3bnMMQt3f3QrIzSZCumGS1D03+77M/bUppwuMrdQWh
 /uO6TAziTIp4jmVQgcfTkhVtDU/5yVs7qZXi/2b3vzyBnvWBrqylyds/c7QfUoExZX/haKvInVl
 elpxiM3dLH8/bEVRGu2r4Sp2Wws0jvt6U3DCcspEQzchr19xFVbDhvarzgyJeBiX75D1q1xlokO
 r9fzvFUeBMuWlFh9Hj1dWdP8T8QXVtFv5sOK2i/nXwnaniVr2rKCci0ka8/Kkh2fW1p7ypBq0/l
 86V9C9yRQdcs74vUogXxaIbs4CiInTHdW8jXcJGHVKBa7Vfw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Make the "mclk" clock optional in the ad7124 driver. The MCLK is an
internal counter on the ADC, so it is not something that should be
coming from the devicetree. However, existing users may be using this
to essentially select the power mode of the ADC from the devicetree.
In order to not break those users, we have to keep the existing "mclk"
handling, but now it is optional.

Now, when the "mclk" clock is omitted from the devicetree, the driver
will default to the full power mode. Support for an external clock
and dynamic power mode switching can be added later if needed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 61 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9808df2e92424283a86e9c105492c7447d071e44..f587574e8a24040540a470e13fed412ec9c81971 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -174,7 +174,6 @@ struct ad7124_state {
 	struct ad_sigma_delta sd;
 	struct ad7124_channel *channels;
 	struct regulator *vref[4];
-	struct clk *mclk;
 	unsigned int adc_control;
 	unsigned int num_channels;
 	struct mutex cfgs_lock; /* lock for configs access */
@@ -254,7 +253,9 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 {
 	unsigned int fclk, odr_sel_bits;
 
-	fclk = clk_get_rate(st->mclk);
+	fclk = ad7124_master_clk_freq_hz[FIELD_GET(
+		AD7124_ADC_CONTROL_POWER_MODE, st->adc_control)];
+
 	/*
 	 * FS[10:0] = fCLK / (fADC x 32) where:
 	 * fADC is the output data rate
@@ -1111,21 +1112,49 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int fclk, power_mode;
+	unsigned int power_mode;
+	struct clk *mclk;
 	int i, ret;
 
-	fclk = clk_get_rate(st->mclk);
-	if (!fclk)
-		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
+	/*
+	 * Always use full power mode for max performance. If needed, the driver
+	 * could be adapted to use a dynamic power mode based on the requested
+	 * output data rate.
+	 */
+	power_mode = AD7124_ADC_CONTROL_POWER_MODE_FULL;
 
-	/* The power mode changes the master clock frequency */
-	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
-					ARRAY_SIZE(ad7124_master_clk_freq_hz),
-					fclk);
-	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
-		ret = clk_set_rate(st->mclk, fclk);
-		if (ret)
-			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
+	/*
+	 * HACK: This "mclk" business is needed for backwards compatibility with
+	 * old devicetrees that specified a fake clock named "mclk" to select
+	 * the power mode.
+	 */
+	mclk = devm_clk_get_optional_enabled(dev, "mclk");
+	if (IS_ERR(mclk))
+		return dev_err_probe(dev, PTR_ERR(mclk), "Failed to get mclk\n");
+
+	if (mclk) {
+		unsigned long mclk_hz;
+
+		mclk_hz = clk_get_rate(mclk);
+		if (!mclk_hz)
+			return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
+
+		/*
+		 * This logic is a bit backwards, which is why it is considered
+		 * a hack and is only here for backwards compatibility. The
+		 * driver should be able to set the power mode as it sees fit
+		 * and the f_clk/mclk rate should be dynamic accordingly. But
+		 * here, we are selecting a fixed power mode based on the given
+		 * "mclk" rate.
+		 */
+		power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
+			ARRAY_SIZE(ad7124_master_clk_freq_hz), mclk_hz);
+
+		if (mclk_hz != ad7124_master_clk_freq_hz[power_mode]) {
+			ret = clk_set_rate(mclk, mclk_hz);
+			if (ret)
+				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
+		}
 	}
 
 	/* Set the power mode */
@@ -1303,10 +1332,6 @@ static int ad7124_probe(struct spi_device *spi)
 			return dev_err_probe(dev, ret, "Failed to register disable handler for regulator #%d\n", i);
 	}
 
-	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk))
-		return dev_err_probe(dev, PTR_ERR(st->mclk), "Failed to get mclk\n");
-
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
 		return ret;

-- 
2.43.0


