Return-Path: <linux-iio+bounces-21085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB71AEC9AF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0636D1896CF0
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13DD45C14;
	Sat, 28 Jun 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVYuAib/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E3184F
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751134524; cv=none; b=Mzpxftn8m93Dx+eyIGey0rQ/IC/u/aQabGcfCkwHxyfzt/GYQfWfxC+Z00zkKZyt2md7Lx4V0CoZLtyYB+AhEx0OdtIPRgWOAIbpA9e10o04GKnHa3emq0ItXekqJPrhlZlWJFztfQK6m4vqM6L45clQm9abTQ2n92AjywR2ZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751134524; c=relaxed/simple;
	bh=3zt8mg+aPAZlpd8w1QdUrw5xGVfDzOsGq/kAkTkdoOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TY3F7W5g0KZ3xFOKIrPf5IZhdXxNUApKcNsrF72DbrZXRq/UpHmtkfGB3GyiFrbWF4UV73m47Qwqxy+s4uSGfC3uGeHlYzKXoQ9BXGWLBnpTc4IiswYfxwfXrrXjGNyD1NlYTO2kIQuDFn7nEkA9eVEiyp5UYkHsOnka5jj+rLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IVYuAib/; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2e9a38d2a3aso831348fac.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751134522; x=1751739322; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4v6Cx2Kl49nGHZFG9V4yM6ZGEQFrnKHNkOfmL1J6bYY=;
        b=IVYuAib//IatBWbX0fkIKwSWnW0i1tTfw8TV31Lfo5gx8C0egUEGFsw3F6lFBUFbZ7
         1ObvxtNbZF4hRt7QIUw19jDFwpXVlULkXiay3JAz3Bnz51fJxTj4hwe53TYwRwmx3hi/
         QaHo7Xs5h8F+M0zRjU70BkdY2YySrvTTKcuAfKnt5HFmF3QVmVaDH+s4C1OsRql1m2Zf
         ++x8ld+8ZQ/Yuy1n4O3Dgewz7fvBkGm24Rh5iDIbBFPVQ7oEg2d6IEES07UYUAujQOuk
         o/uFyfExcLPpwMRkuU/EMx+L8VzuMSlDvtONg/AbztgVmjn/QEh3C5IpJ9ga+zDbHSw1
         sl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751134522; x=1751739322;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4v6Cx2Kl49nGHZFG9V4yM6ZGEQFrnKHNkOfmL1J6bYY=;
        b=aIxSDmVZ27a0qSP7nCwD+qoAJuYy945NFPN9xWDJ1gLDn5Va1Tv5t6rEFYPa8VOPm9
         W3z8DFUggAH2ddCjoRkLkpJPiIdHuD6blGbWDG0VhSnTFITraXDoCPLzLI2tyFmiUmaW
         +KLqfDC2ho2ojZHnXB4hhpfNbPzP9qvmb4QI697eHmBJ0hz1kHvBit2pFbbjZVzbwpSo
         Y+omn3Ayj8aVXjCfZGWEd9voqF/tOZsPqS9y5Swf4oRf4Eman/DzqtX5V/chR/Ge9lfK
         mWX0CJHCyI8FQGcPfbsruzrxSqth7MmXgKfa4vYF39v669KCUlYm+JhF+o2t4C+HvSuI
         K25Q==
X-Gm-Message-State: AOJu0YxzbbgBp4r7SirgIOHz/lP6zbSgufAoeOZpWSdEJcolYl2BN3JX
	oed8WoPXuBXr6r7W/Onxjt19lk+uLXKV2jhrFEgGR6hZ81LArMsDNhWd9qUO0Mh+eJI=
X-Gm-Gg: ASbGncvNBkbyQ+eL2MUOg1B/ISQV8QRzogkghTIfK5FSpic52sVz/15Yx9rYue9DK2b
	RU0Oi0vJsso1jeF04IhRD5iDi/cIIj6hwwdXLovATcXesLp6QuC9cpJ49FnXYdvP8cKkWWlgA6l
	2towNMBypqsHTO3DzsIk8ibxsAV4LW1xpwhSUqzBgQGkaq1pqAJBzwMjM9hVfiPBrSXmF+qYCEJ
	XhcnFTTGVHHkXQ531e1WsZXmZiLhLLtxqKYDvjcHH6rmnmn1VZU5nXY7t+mjNCs2PEID+6vOJUj
	dwp1ntrWrRQMMC2qNZfgYHIfhsnd0VCmel5qdlG6hBfqRENox6vS4itgwMigdwXoqf3U
X-Google-Smtp-Source: AGHT+IENC1KdkgQYgN9/eCaJhA2+gss4TeO/RTBnSgmy0/m5TEMULwDDw20Va7gGOlvJrKOfLAyXSQ==
X-Received: by 2002:a05:6871:3806:b0:2d5:ba2d:80ed with SMTP id 586e51a60fabf-2efed68536bmr5092378fac.25.1751134521710;
        Sat, 28 Jun 2025 11:15:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b1a53sm1636356fac.31.2025.06.28.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 11:15:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 13:15:10 -0500
Subject: [PATCH v2] iio: pressure: dlhl60d: drop use of chip info array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-24-v2-1-1c90073d1323@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAC0xYGgC/32NQQ6CMBBFr0Jm7Rg6gFRX3sOwaMsgkyglLWkkh
 LtbOYDL95L//gaRg3CEW7FB4CRR/JSBTgW40UxPRukzA5XUlBfSKOLR+Sku2JvFINVYG8eajG7
 t0EPezYEH+RzNR5d5lLj4sB4XSf3sv1pSqLBqKnttSaumqu/WrC+xgc/Ov6Hb9/0L8Sj4IbUAA
 AA=
X-Change-ID: 20250628-iio-const-data-24-4ace82a87bfd
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=3zt8mg+aPAZlpd8w1QdUrw5xGVfDzOsGq/kAkTkdoOY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYDExnXvBRerSor1UGBH82MTrZonp+SKHedS9D
 cBwsgkP2KaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAxMQAKCRDCzCAB/wGP
 wOsMB/44VX/iH1HtT5Y4t1+Qyy/TIinxdiJJGT41AV1ADvv6USrSovlMuM6dakeWLpGAG8vDa5Z
 agX0G7SU8+jseuk67ZQXVxiSZtQyoOwEfcJKcO1/SEzzc+uQ9CwDpM/K4bMGI0tyGFNGMCDKejf
 6TPahTRIFFrPyxGea+WtkhFrCcDVC0dQfOjb0gzCR481f5JOB1m+TDhYVXItlgohD5ETt35DLOf
 iKut9ZhbPZkHAKKjo/lklwlBLrOsJTHUUS3mooYuKbZpttpiy3eO5MmrwJmc5GZhaJyrvGR4yvU
 C8Xc/a9Fe+haVMM8Yqd3sRC57BGWfTYBbBOTJyYzbeEIoFbq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the dlhl60d driver to use individual chip info structures instead
of an array. This reduces the verbosity of the code. Also, the data is
now const as it should have been in the first place.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Changed the patch to drop the chip info array.
- Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-24-v1-1-353b97281534@baylibre.com
---
 drivers/iio/pressure/dlhl60d.c | 47 +++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 48afe5c94000b44eb324d7631f3c0db8e3d0079e..6a13cf2eaf50187d4cbd94cd93b1d14ad4de8b26 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -32,35 +32,31 @@
 /* DLH  timings */
 #define DLH_SINGLE_DUT_MS   5
 
-enum dhl_ids {
-	dlhl60d,
-	dlhl60g,
-};
-
 struct dlh_info {
+	const char *name;   /* chip name */
 	u8 osdig;           /* digital offset factor */
 	unsigned int fss;   /* full scale span (inch H2O) */
 };
 
 struct dlh_state {
 	struct i2c_client *client;
-	struct dlh_info info;
+	const struct dlh_info *info;
 	bool use_interrupt;
 	struct completion completion;
 	u8 rx_buf[DLH_NUM_READ_BYTES];
 };
 
-static struct dlh_info dlh_info_tbl[] = {
-	[dlhl60d] = {
-		.osdig = 2,
-		.fss = 120,
-	},
-	[dlhl60g] = {
-		.osdig = 10,
-		.fss = 60,
-	},
+static const struct dlh_info dlhl60d_info = {
+	.name = "dlhl60d",
+	.osdig = 2,
+	.fss = 120,
 };
 
+static const struct dlh_info dlhl60g_info = {
+	.name = "dlhl60g",
+	.osdig = 10,
+	.fss = 60,
+};
 
 static int dlh_cmd_start_single(struct dlh_state *st)
 {
@@ -170,7 +166,7 @@ static int dlh_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (channel->type) {
 		case IIO_PRESSURE:
-			tmp = div_s64(125LL * st->info.fss * 24909 * 100,
+			tmp = div_s64(125LL * st->info->fss * 24909 * 100,
 				1 << DLH_NUM_PR_BITS);
 			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 			*value = tmp;
@@ -188,8 +184,8 @@ static int dlh_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (channel->type) {
 		case IIO_PRESSURE:
-			*value = -125 * st->info.fss * 24909;
-			*value2 = 100 * st->info.osdig * 100000;
+			*value = -125 * st->info->fss * 24909;
+			*value2 = 100 * st->info->osdig * 100000;
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_TEMP:
@@ -281,7 +277,6 @@ static irqreturn_t dlh_interrupt(int irq, void *private)
 
 static int dlh_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct dlh_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -302,11 +297,11 @@ static int dlh_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 
 	st = iio_priv(indio_dev);
-	st->info = dlh_info_tbl[id->driver_data];
+	st->info = i2c_get_match_data(client);
 	st->client = client;
 	st->use_interrupt = false;
 
-	indio_dev->name = id->name;
+	indio_dev->name = st->info->name;
 	indio_dev->info = &dlh_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels =  dlh_channels;
@@ -316,7 +311,7 @@ static int dlh_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 			dlh_interrupt, NULL,
 			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-			id->name, indio_dev);
+			st->info->name, indio_dev);
 		if (ret) {
 			dev_err(&client->dev, "failed to allocate threaded irq");
 			return ret;
@@ -341,15 +336,15 @@ static int dlh_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id dlh_of_match[] = {
-	{ .compatible = "asc,dlhl60d" },
-	{ .compatible = "asc,dlhl60g" },
+	{ .compatible = "asc,dlhl60d", .data = &dlhl60d_info },
+	{ .compatible = "asc,dlhl60g", .data = &dlhl60g_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dlh_of_match);
 
 static const struct i2c_device_id dlh_id[] = {
-	{ "dlhl60d",    dlhl60d },
-	{ "dlhl60g",    dlhl60g },
+	{ "dlhl60d", (kernel_ulong_t)&dlhl60d_info },
+	{ "dlhl60g", (kernel_ulong_t)&dlhl60g_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dlh_id);

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-24-4ace82a87bfd

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


