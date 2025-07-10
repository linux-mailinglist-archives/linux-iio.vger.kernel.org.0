Return-Path: <linux-iio+bounces-21549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E3B00EA6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422607B7E59
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45929553A;
	Thu, 10 Jul 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C7ArjtEe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79C8633F
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186133; cv=none; b=BqOQgjvWEFdD1ojNxL/ewXiQuqxwfMEmiJ/spmJe8X7tINFhmqw3451MfyoXyEF+07hHm0m0FLomUIpo7Yp2aa337jBT63aZpqrj+f/E5tvc6NffokfFGpRr4rGgST7QxFILqJSMeA0JT1NlTHLBTvy0RdfhiwXQ1b2EfABwm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186133; c=relaxed/simple;
	bh=SsrP1cgk5ZxHAw1T5LxKC2jzRBKUCL3UkePoEJyRuqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T5guYsriy2XBy2P6tjnrs97xVRq1CXhclS1uXmolydDICsBg4QfNKdh5W2+JMdKTp6b5ubULSbii47N6Q7eKdtgMJDy/zWxxTwcGFMwyHT2HASrJTAL8gryPlIklGjYmU9inKcAWK2sErIcYtOcWrCQIKsq9o4s/tcMlxRYUJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C7ArjtEe; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-612033bb26cso629829eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752186131; x=1752790931; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx73u9VXSxci3zVsfu1OAUwwaENWROKjKLvmUe4fglc=;
        b=C7ArjtEek9xwxd5fuP8Dvcl+vL8UwtRqL8hZpH+dBAi+5+6r9NtdjXvRfg3VuSFnOf
         jkfuKWR4o1iSzY/Z4oEuWmjTSRRXGiulTfmmRfhlRE4kqMr8ULoVpXfaJtio0NkWntoc
         JyldGSjnsB5Q/Zid1HPy9isnytGAYl1BkMyoBAcF6Ry01fs6LrMOIr58oWe6MrCg+Dm2
         NhOm5pMbm/K9zlyfpEjglz3fUffda5rtAkW7tJfs1tf5QjnS+SzN3hRCxIiaI551k4RP
         I2hrymBpEcGdGTFpis1dyyEECWa7muXoDj7Whg+CztgDH5wHtceCDirC4cua0ctT9dj1
         kGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186131; x=1752790931;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kx73u9VXSxci3zVsfu1OAUwwaENWROKjKLvmUe4fglc=;
        b=g+AYdox0Y+b1joP3B0az2ZBBCN+xAY5CMt3vgy5uUaEtl5pkgnUPj/258pm8Qi+0h/
         uXDGvlYSq821ecdk9Nyv5VfSc4fpM1EUfRAz/KOb9iiRX/mg07lDqNP53iAjk8QIljqw
         fuoJA500El0YoIHt7T/kp0/UZDmggHGlmyW0gjLA88QtjrkrITzHHS2jaRNhX4wNfv6c
         ekX7IHz03S+Ow9ZbctiwgWnVxLh5cgGTsHHfMmpC1QhnBtgBbTU0etdiu883T/6/t9WN
         QKZmiSRlxYRMleVZBJKLkbE1eJ68LC14CYu36/yElPTzPMv/GRs4BIxRcCTiyJW5JdE2
         XUng==
X-Gm-Message-State: AOJu0YxeQkCRAhm+N9FQk8F6bEd3rAzd3nua2+QAryMVvMin33szuu74
	D6g++jaufhIpT26UhvEpav0zxvI5CMxS4zA3YQO9cJvzx7xEz4xFQUnjT+719M2YVRJmVF5Rm/2
	Ncs9vmDM=
X-Gm-Gg: ASbGncsyFyba0m+r7dl4fDAI5cZPDtk2NVckTptc9OYiUxlbVI+fRqZf61Zv4joePcT
	AM2ihgC+k49oXjkmbZxg7lWWCICCl8I+JcOSE5TIZ/wyvi7KMjvKmW9SSXEaw+8WNGAhWmgaDXp
	n/9c1Fqk4ZZzfJ7Hsm4Cn5adHVSrMYpzz8TUukEMMkku3sbNdnjY0sZKGF1QKUlX621y4tCKLgT
	4irg93GVjWcBDrWP5xipkDR9soURD5PXR3dhMLQx0/bZXx4mmNtLNWszF0WpBz5+5jO7QoDWK3g
	R7w51vBSI3ScJiC+AnsOkuJTlAUWwuJxGq3vYFi6wH+ASbSPLDJl1l3eACu+w8fQbeJpGiXPtgu
	bHwOtmtyu0/P+e2w0JywmyjYqLqGQpcHjHkTW
X-Google-Smtp-Source: AGHT+IEc3zIBRrJ1Gk7ZuO0QXFIOJGwMkp/NqiOVJD7kofSvu0fdkrbmripzvrkjUvOsIDs5Q1hHUA==
X-Received: by 2002:a05:6820:4df3:b0:611:e30a:fa1c with SMTP id 006d021491bc7-613e5eeb902mr502134eaf.1.1752186130755;
        Thu, 10 Jul 2025 15:22:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f28e35sm310885eaf.39.2025.07.10.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:22:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:22:00 -0500
Subject: [PATCH v4] iio: adc: ad7173: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7173-add-spi-offload-support-v4-1-536857c4e043@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAc9cGgC/13NwQrCMAwG4FcZPRvWddrpXkVEuq3TgG1q04kgv
 rthHgQPIflz+L+XYp/Rs+qrl8r+gYwUJWw3lRqvLl484CRZGW122hoNiARuGmW6pmtlTcAJgeb
 5Rk7uJSXKBVrjmm4/WGtdq6QsZT/jc4WOp2/O/r6IV77PH9dXK9bp9h+TBohLOPONCgNFCMQFx
 ismhuGwN0ZbZ/TQ9I/VHBx7GCkELH0lPtfZBxKvlt5adsF4Uaf3+wPkmSvLBgEAAA==
X-Change-ID: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3244; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SsrP1cgk5ZxHAw1T5LxKC2jzRBKUCL3UkePoEJyRuqM=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDIKbLm7Oq03/Suv9lbyPZm0VSnTMWyuznupynWeAbGu9
 /Qilyd3MhqzMDByMciKKbK8kbg5L4mv+dqcGxkzYAaxMoFMYeDiFICJvMnhYJhQZsGcGlj8XC5q
 ptJN2Z0sn8T/8XUX8fawz2lXaqlpPXGs4rybXLAL36OWCIMvWd+sMlZ7B9w3rRUNqDox17zr9DP
 m9P9T+U3Ssl6fKWHaEte5KSQwdabRd73Dk+Wsa5ec3bA54PpZ+VeNbbPu8vxfvvb6Y7ZQJ9Y3wu
 uCKic+bdl6X99PfcOajKpWjXuqXo43/Mx4ferqfLvW7qhyyXvrH6Tm139Fb/8+Kcv3s6yW8epOL
 px3/crLq4V67Psz1+Z6Gb1gDD1osyau8uOLZo5Zb8+ZnHj6xN3ML02u6MvXk5phoavnHvZo0PnJ
 HdzW5h6wSOiDW5eMsPaLVBEF8dW85eyVCqoHG1U/5kwEAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Enable SPI offload support for the AD7173 ADC driver.

The scan_type used for SPI offload is assuming that we are using the
ad411x_ad717x HDL project [1] which always stores data words in 32-bits.

Link: https://analogdevicesinc.github.io/hdl/projects/ad411x_ad717x/index.html [1]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 was applied, but then we had to drop the final patch due to a
conflicting fix. Here is that patch again with the changes needed to
adjust it to the changes in the fix.

We'll have to wait for the fix to make it's way back into iio/testing
before we can apply this patch, so it will have to sit for a while.

v4 changes:
- Add one more instance of .supports_spi_offload = true,.
- Picked up Andy's Reviewed-by tag.
---
 drivers/iio/adc/ad7173.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 9730fda56186afc45f589899e669c41eb538af6b..3886d2f751d0370994ababf72409f4dcb328641d 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -747,6 +747,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -763,6 +764,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -779,6 +781,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -1595,6 +1598,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 
@@ -1685,6 +1693,12 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		/* Assuming SPI offload is ad411x_ad717x HDL project. */
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 	return 0;

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
prerequisite-change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1:v3
prerequisite-patch-id: 350fb675f3e0fe494e0ce4ddf5685d9369ffa11a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


