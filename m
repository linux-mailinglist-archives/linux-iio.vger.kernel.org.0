Return-Path: <linux-iio+bounces-21070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B457AEC951
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822D41897CA3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B362494FF;
	Sat, 28 Jun 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Beip5CUQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31121ABA5
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130936; cv=none; b=FYKk4k9Q7zxRS/fbwAFO2+/pa2X32xqBj0rByN41Cdwx9rYcdR/VgUk/G9WckfUVsbHHS/IiDdN5+1jbMDUf0pbV3R9kfRSWkS3YQz7ridv1H5Iq08xI+OJjQOMHrSDkQ0bKYTVPn/AhpLFZT7/m9ANDvZ0qYU09oLx5c2tQZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130936; c=relaxed/simple;
	bh=Ek7P39iKMCAoKmlKHyGYq6uvbk3DAG8A+YauoJlBjRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DdQUV9gXkH3jz/CRADwzjG2jWNhzx6Vl7f8eOeiBv2TLqgNM3A0Z66pzwDYHlbrVwQMJ/ZnLMjZrKuwHAr2kq/7E9xXKsYHv9wBkukqpOZMwkJMGkp3R+Gbrtbcp4kjju8wC7V5q3L6pwPAVYpJnSngK08MkWUGknoHns0bWSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Beip5CUQ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60402c94319so1932136eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751130934; x=1751735734; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQgYB0fnN51MmYUjJ9YiP44sEGLLrmHhd/vy972h9L0=;
        b=Beip5CUQhct3rtl3QDDn6vFP5BZwjDy5uSIbCcOb/p+cRvB4GVNV6KgpFWan/mCb3W
         80mNwWUSfJ7hoiFAgXMXnd0rzQVETw5Y7BaOnYMGeaQOmXNrUMZIjzv/dJhyDAPngSEs
         TfwJaUOW/NmcdhPQCuhh4HrCY9HZ2157B3DKtmxWCixgC4FyHCbqV8SjAcocxafGmVOI
         Pgyc4YyOGDyScoN6s2KI4YWf42d7iackyhcNSOGhVpd94WINbWfSCicHLW6x2kae7h89
         i2ga67+CsKUTymgWDJG+IlrTpz0fgOFrci9Yw2hwEKsfvTs6xWrX+d4GJsKr+EZy5Vev
         lOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751130934; x=1751735734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQgYB0fnN51MmYUjJ9YiP44sEGLLrmHhd/vy972h9L0=;
        b=BJh1Zpw4F+Caiaw8cVX0o7Nm6/hBTh8bSfHB+//dioK1lp03huZd/OFw6QAzLfN2Sl
         BzhQTZcB185PT2w5DlFydy08swsyt5RP4ZOYRpS4jsyepsSp0Gdo5FUtU1ZENPdYR++U
         j8Az7s937f3SlmQ2IuGGmgRQls1qsX1rFlwA0smu2oKEnaYdjHR2tlaEbis8zkOZtlnc
         3oDrpdDI//Q4ukgmRygf/VbpUzULxAYj/6aGE3vw1jWfm71NVv1OGXrU1sKeLaFJW0zY
         y2rnCikfW9cjq4luEzt8Eid4gTr8EjGsQ+9JMwAPc7PJxOWkqXMhmr2V9KegBI6FlReF
         UXGQ==
X-Gm-Message-State: AOJu0YwY3yykXMZkvmgN3eJzWIf7DJHL7e1bNNBTJ2Mt+Ne5AWwNhMB+
	msCsYd+pALEZdyKtrduakaAJBUv8APNlTwpD1ZAWPfhEKIkATzaAdAYQTMQU+YmqQiXmoQBi6L4
	N5hFXjKU=
X-Gm-Gg: ASbGnctIHcZdYSqKAb+rAEkVOf020AR/nvT0zyf+7kt19orh6Sg1Gnl5wDo2+u63s+q
	H2wX3kz7L15hdB/31+8/pBQmcINATgTp/tSWMIXp3zG+4HFtvlfgcgjJLuMvSKz0JmOK1I5cd40
	KkLDIb4CLpMJa6GjeQ4LPDpnUOvgRFD0V+b88KPogmihpcOudu8Akiu5GCJTyiy6YH3bZk0EGCi
	ST7A8DrZJhg3p1vqpIVlgx3Xa5Hc7Apkvjy+iaE8L+6rjufWxZOWqY1/u/mJTLIfzhPGXkD61ne
	zdbASVPh1pzR5uUCmJpC+vv+9ab4walSrXVGXtUDXBu902zKOHse2nbUOUvpqhPVl7+D
X-Google-Smtp-Source: AGHT+IEs7eSgNcmKxpK3e0z+Th/9COv76cXD1N/+VYD9CCRsqtp1jdfYlM/lbPX8yG2lWA5o6MsV1Q==
X-Received: by 2002:a05:6870:1603:b0:2eb:87a9:7fc5 with SMTP id 586e51a60fabf-2efed4701b9mr4739620fac.16.1751130933720;
        Sat, 28 Jun 2025 10:15:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ea6d88sm1565341fac.6.2025.06.28.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:15:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:15:24 -0500
Subject: [PATCH] iio: dac: ltc2688: make ltc2688_dither_ext_info const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-16-v1-1-9b6514588b05@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACsjYGgC/x3MQQqAIBBA0avErBtQKZOuEi0GnWo2GhoRhHdPW
 r7F/y8UzsIF5u6FzLcUSbFB9x34g+LOKKEZjDKjssahSEKfYrkw0EWoLZJ3NLALm50stO7MvMn
 zP5e11g/j8I2mYwAAAA==
X-Change-ID: 20250628-iio-const-data-16-ac8a4e8df676
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Ek7P39iKMCAoKmlKHyGYq6uvbk3DAG8A+YauoJlBjRQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCMt3SA2A0jeeruKso7mSFQz35azW9tsK3ccK
 VaTRrUpVX6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAjLQAKCRDCzCAB/wGP
 wEQACACZ+CAbMyYbs4/OP8wdEIN8H2mO4dXBl83MJjVJyae0dErWNkn4vq6W6yCYyb3AXG8xEUa
 WynBxZ+2i/mUaBlcdFMxoI8mD9vJccR52bjQO1m0bAG7ZkKo945xkXBzpnURxVwywoKf7vqfMIk
 80qyBb+fYGMzdofbslNSXdKodUgWe7H850nxDAIAvZlrHDk0D/AcCqiakRA6MEux8Fy44rhqKmX
 EXrMQLVt+VRcHZJ52edHC47dGXAMZWrjXKRQ7Xl32YEScP+gkfQlo1J/ryeO8eR7qtSfX6ObhYP
 fOfO87nOLaR/Q9Zwo5vyfQgnlal3jhuZ8lft//782NGphRp4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct iio_chan_spec_ext_info
ltc2688_dither_ext_info[]. This is read-only data so it can be made
const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ltc2688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 1f24f07d1ad24ac1730da0e03b65207ca5f07884..7a2ee26a7d68730fe90d9cc91ea764f05eb61791 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -622,7 +622,7 @@ static const struct iio_chan_spec_ext_info ltc2688_toggle_ext_info[] = {
 	{ }
 };
 
-static struct iio_chan_spec_ext_info ltc2688_dither_ext_info[] = {
+static const struct iio_chan_spec_ext_info ltc2688_dither_ext_info[] = {
 	LTC2688_CHAN_EXT_INFO("dither_raw", LTC2688_INPUT_B, IIO_SEPARATE,
 			      ltc2688_dac_input_read, ltc2688_dac_input_write),
 	LTC2688_CHAN_EXT_INFO("dither_raw_available", LTC2688_INPUT_B_AVAIL,

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-16-ac8a4e8df676

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


