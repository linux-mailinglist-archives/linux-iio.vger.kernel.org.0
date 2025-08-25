Return-Path: <linux-iio+bounces-23269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8CB34F43
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 00:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF872A0D92
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 22:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA852C21C1;
	Mon, 25 Aug 2025 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ekB0ld9Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC42C0F67
	for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162545; cv=none; b=XwUtKrS1yxpB88uTtoVpxcpDOVgRCzfNSM+fH+H1gkhzqiOR3X8cY7ycnTQfZ44CDymuUXjRQOjqLGxXPiCSAzu54yTJBqYOrdaMBFh4pAs1eeH43Xfmol2LBz0svgSgL/NOBF+9Ta3nE1H1nvs5fMgCt35JGHnL+xGHRtfAZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162545; c=relaxed/simple;
	bh=iRPbZ3NmESqwUlU+AgCDLlpOo6ZQJuC2kenB043PMZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMfPHzoggPPgDH+0Sw+NMrgqp8vUdIbGTzGjujQpjIv0fbgG6evUp5iP2YjbX77KOt/trlyrsDxjjbmOWYVrD3Z6j/sh/k0XpzhXx+JY6TiKZtgI1XeGgSVIxQKeATlFh5n5BLI5DHYfioJNDITs09S1rE1Qmec1+ifDPBAogeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ekB0ld9Y; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381f0664fso1426852a34.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756162542; x=1756767342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USr+bxgxSSWwC2RjKRZCmku7TsEQGjaRWrkzaOYT/hU=;
        b=ekB0ld9YKtmuu+JauQS1tllkpphT66gdfz5wqQMa+jnPZFKNnO48uAmlibi+sjDoEj
         7fsIya5NudA49tMIkT068hUdWvGnZckbu9CSF3XJzuigwGUUnvBrfHcpi/DYSGgLbDy1
         gcdgDkZj3dnS9XZq9UwP3kkc5A54/DcTth39OAsUyJiRK9KFJiBpg507vAJ+PIgm0z31
         QRMMB4ODoTsLKYZyLxCkX/75nIEeN0nuBoiGFD1DbXrIYHsz80iljRTpNPg5O9I22yCC
         rTh4XRnJRpQ6gFlpTmr1dLriwz0O4svS1jhr8XRjdL4IY5YO8H6+S6nC/juRia0/6igx
         O/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162542; x=1756767342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USr+bxgxSSWwC2RjKRZCmku7TsEQGjaRWrkzaOYT/hU=;
        b=Q+YblKVHSe21hT1RFKvELy7ZByn/Mk94/q6Gy4Kt25Ioz8A4SWZRO9ti/MrbD9nkIP
         46Vjr4u9cntb6cKDv5Xe7aF/nAqYvcMsZjYWGxJ0H0wUK0S+ybZklECUPjAVgn7XqOrp
         xIOf0nMuXV2XPgGJnV2xcE3xyMyJAXyQ2TsWrVY8h8VqV2Ris4YAgwmbjuRP9VTaWa4/
         ZafQqByynIiswab5rhJtgd5L9bEB/12l0mgE5Nz/BAzwcjJoE0qn7Qsa0xRiCbkwlV+x
         dycctHqJNM+oM1lZnMf/o6jsKD1axgOSAUeZHyIu6lFaZ3zbv6s319ZgOQ87poC1Q5r3
         YRBw==
X-Gm-Message-State: AOJu0YzCHWlJp0nnlH7Eow3YPuYhQpHaC27eJ6uFhsJR1/lij8dzBiW0
	1bxACrI4Fq4tncZewxOIt2kNayHd1WPmtdwvscDbXHYMjNwV7kLN10Ip2yJd+a7On+0=
X-Gm-Gg: ASbGncs8MlL8kvAmxYO36Xgtr99pVnpcHi1I5vvsP+RB2K1sNTiC6EYtmC5yRSMCYC4
	oOCQ8/jmgc5Xul2PCOXSlQ7AUXZ/HtDHv+VZ+fLWf0xhLSWSACZ9naBJxGz1B9uaL/qA+Uxaqeo
	RfCEoUWEjir3NlCwAh4T/S/1B4nm2/ts7/rYbC1iktAesG05rwjL2LbbZcdFwepDrFNnTmeN22O
	zgWHIW6q/z12SjAwdUsgEKrwuxNObzC9EJZMel9zqQRl8aIrDo2UwZt5FDKXbHjt+ZJ/cTONqRG
	EO5NVlpN5VzXp5xdb61l5ElAUtJwtQ4HvJpnSvN97wJt/cwvOjB91THh2uVQHm73c/JCFguATGb
	mdKKE5jAvzCmcAjwdz9jZTUAV5bwH
X-Google-Smtp-Source: AGHT+IHlGmNyIPUVE50HY9dGh77AHvPnG3SeflnB+KHOWyXaq14AyQRptbYJJmrjvo4NTSd31zmq+w==
X-Received: by 2002:a05:6830:7312:b0:744:f0db:a1a8 with SMTP id 46e09a7af769-74500ace8a5mr5718564a34.36.1756162542459;
        Mon, 25 Aug 2025 15:55:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e49d36esm1991747a34.40.2025.08.25.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:55:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Aug 2025 17:55:01 -0500
Subject: [PATCH v2 2/4] iio: adc: ad7124: do not require mclk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-iio-adc-ad7124-proper-clock-support-v2-2-4dcff9db6b35@baylibre.com>
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4211; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=iRPbZ3NmESqwUlU+AgCDLlpOo6ZQJuC2kenB043PMZY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBorOnWbuf6NViok3VnnttZmjsRZUbduojje2wxs
 flPgVuyMuGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaKzp1gAKCRDCzCAB/wGP
 wOytCACbhbEDQwMJStOx+iK43ZJ906hiYrpgABhn6pbD4Tpd6YwtWPbrXTnxuc7EGl/fKVEkBxw
 7+Fp6vLKLABFCl3p+Btdam3SWsq9ivsNaIQHB7Si1dgs8LDX09EM28KhrVnVXn6X4r7cRxbxW5i
 vapcerWI8P4CSa5SaSwWUKUSl1hZnHVDXrP8iXJHEo1aXVEILMDyxVMMFCqpT6/RudDEDjdetad
 7b8GwYhRN+5+nSKuBx5imQSORCkMxRPO741I44JoAyiWM1d0jTcLaoDTZNP/IfISwAjY6lTWZUu
 1BASM3xneUCYji//pD2S26B3wACRr92oGp6Dpj4vaGwp1lii
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
 drivers/iio/adc/ad7124.c | 62 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3fc24f5fffc8f200c8656cb97f9e7f80546f688b..49003c8436463f49a47564644fd8e405579df829 100644
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
+	fclk = ad7124_master_clk_freq_hz[FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE,
+						   st->adc_control)];
+
 	/*
 	 * FS[10:0] = fCLK / (fADC x 32) where:
 	 * fADC is the output data rate
@@ -1111,21 +1112,50 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
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
+	 * This "mclk" business is needed for backwards compatibility with old
+	 * devicetrees that specified a fake clock named "mclk" to select the
+	 * power mode.
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
+			return dev_err_probe(dev, -EINVAL,
+					     "Failed to get mclk rate\n");
+
+		/*
+		 * This logic is a bit backwards, which is why it is only here
+		 * for backwards compatibility. The driver should be able to set
+		 * the power mode as it sees fit and the f_clk/mclk rate should
+		 * be dynamic accordingly. But here, we are selecting a fixed
+		 * power mode based on the given "mclk" rate.
+		 */
+		power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
+			ARRAY_SIZE(ad7124_master_clk_freq_hz), mclk_hz);
+
+		if (mclk_hz != ad7124_master_clk_freq_hz[power_mode]) {
+			ret = clk_set_rate(mclk, mclk_hz);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set mclk rate\n");
+		}
 	}
 
 	/* Set the power mode */
@@ -1303,10 +1333,6 @@ static int ad7124_probe(struct spi_device *spi)
 			return ret;
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


