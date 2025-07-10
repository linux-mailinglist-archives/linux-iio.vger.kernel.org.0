Return-Path: <linux-iio+bounces-21551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DDB00ECD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A4C1CA6AEA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D882BE7D6;
	Thu, 10 Jul 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SD03mh7/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98529ACD4
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187239; cv=none; b=mAhZ21/uv/NsrRv9rHaMEqooStwfqnP5CUY7RVTd4dJFBdL8cxihWmYadMu0WEaTsI6/xu3oM/zzC1hq/cNO+rdxOUSGLUqNdQjq4AomWl1lFG4NK4FARtKXKIRPdq4l5S2yhNbNiNwO9JXyfHR/ypZbSEqUXtW3suA2dNRuQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187239; c=relaxed/simple;
	bh=MaYXwOVhgpK5Xi5DZi0kiBPz0Bgrh0rRZus9pfeI4MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SmaBNIze5jl87AOjroPW0eJKyxGkOgICha7I+MgslxsSrlWaY3Z/onJ57V9Y7gzMlwjPkLFBesjCry6Q6ySk7JoW3KW/dk1SDzF51TaDtGo3k0t5Hw/xdylnEf5gUp7O17W/eB9Kx3rvcKx5CdMX/4F5AJSNaFa1lTFfOjulwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SD03mh7/; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4067b7d7e52so520074b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187237; x=1752792037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cn3FuFolIz/oVPrLKB9jwmwj/1LLi3bqA0GwWnqdwBs=;
        b=SD03mh7/YN5TeWOyUNkBhg8L6KPpmbnIsnPsXFCMIETGsbQ5eYuwEpVdUnGvNeKvfA
         m0VL+HVJeT6aktlf8z+EcEN/cHqL1dXm1CxOqidpyORWpPLQVbSbJN1uqjRylL1kptk1
         Fi37/3q+/gZhdT08KcPwx4FNMtOT5MLaPQj3rKaHQqNYmmJ0RdzQ+7cnZ5WxKe6HiNY9
         wX9XorbJGfoFjgFjoabjf6Spw1DNTc4njZvnhIxoX0/djbBHWdwRNA+HFYmfAfcLnEpK
         wfpGuTdzO5y6g/EPxHLjxngR3Q/2sop7LAoBgeHOZzFtsrqxzKbwuaHn7bmDmSwPa17U
         DspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187237; x=1752792037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn3FuFolIz/oVPrLKB9jwmwj/1LLi3bqA0GwWnqdwBs=;
        b=wSwxUNzJ3zPVtzJcLW4ORgXye3PScBk36NiXBxpHHrpWMFm+GV9luXpHkTL3k353l3
         AbJUmnULsS8eHN+pLvbXNRqcuzSwv0cHmzRlTpBM2IrDCTL/RkLncS68YLY36uJ9uGRF
         eE/hVbigHXjfQJBR2HXcDK08T519KEwMzVYtRnFSlXufUAabBLqFzPiyO5q9cnjuKvKF
         4MJdc6UpLrFCCir0UvcR4Cpy7EKKeoTr+8gOMaEK/9wfOB3RyxrV2iJOqNUJ0LNQhq5w
         PDbk0i5BITngoA/OuL/2c+/nwKyrSx/UfSZEfU1PClUKHCDQAWzuT7BM07Jto0VTU+ta
         WQOA==
X-Gm-Message-State: AOJu0Yzri8EslydRfkQ5cI9fgdOP9NPKEtAxos8vPVMjrdXXA1qagYeD
	luB8qhJCX3XEAj+8nA+3+N00cQSquV16etWbHJojygixtqzSJpTkuJgeATgPcW/qFlE=
X-Gm-Gg: ASbGnctpN1G+n1/LymEUGsYlswpdTUQNeT47KCj/3VAS4++OqeU/1wdFPk5vh19LZnb
	6y6CDThdVSRktdBWcPNhXs+cK1HIhupff23+D3YSXKTzAmtKvUuxb5JznRwsyk4TMWHutHzjU/K
	LwfY9HGBnFX4EUugTKKfWswgqPrwJRE0ekDYpFi6kgpFTTKykRmK7hLS670SXo9Dr0XC6c92a7R
	+PuCmqE0JZrn/si1sGEjDOeqW9SqdolrvZ6OkeKVLmNc+bBETFmtcUUC5o78VOnZgxcEPT+UPaU
	p5CKKr9NcjCj9jsY2tOyY/q5Vl62lxhHimShRM3Gw+1ND/leWEjbK6JgYcjMQBbkXtce/NQ2BJK
	FYcyaWs4dDzezLaVHij1HAFXXrA==
X-Google-Smtp-Source: AGHT+IHYUQBd8GeQ+9Tb5ObCJT4XR2tTpt4gxlV5blMQaypp/KU5zeE7veLWTa1cVd6iC+qH7UKS5w==
X-Received: by 2002:a05:6808:444b:b0:406:6fd3:ff14 with SMTP id 5614622812f47-4150f4bfee6mr1026731b6e.25.1752187236704;
        Thu, 10 Jul 2025 15:40:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:39:50 -0500
Subject: [PATCH 1/5] iio: adc: ad7173: rename ad7173_chan_spec_ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-1-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MaYXwOVhgpK5Xi5DZi0kiBPz0Bgrh0rRZus9pfeI4MU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEE/eU1VlTlQKHR3pqsR26n9yqGb/IAQ3XTiT
 cAPJqfD+tCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBBPwAKCRDCzCAB/wGP
 wA7WB/9l/qvw969ULrPF3r4bQGB5gCkZBseIzNoyb3Ug2CjJ4ugerY7zMKfWU7tj/ppD37ti27D
 u7azLTGeGyjiYjzFlKVxSpLAPScBoE2a8MXkXoQ+1TbLyeufImoccg0pxeGFRX+D/DjqrX3gS7s
 36ZEWZ+j5Yt3506NfSSU6Ao7+yzKhlufkKTvsrVRNuR6dlO5yn0kwomQ9H7uFL10bHUPM+ZcVIf
 dIkYkiXEHySCMYE9bhLP28VYwNopnBX53OBJ0EatcRip0y8O7/gPO5Rio88HBNSipCmwEyhZgJL
 F8qxOUcZTpLOeRejMev/Bm/stOHkzTrm11E7z3lpKCUdmADA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename ad7173_calibsys_ext_info[] to ad7173_chan_spec_ext_info[]. This
array is not limited to calibration attributes, so the name should be
more generic.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index ed5020167089ab96eb1927c9b1ae207e36f8b9e7..5daf21c6ba5637b2e47dcd052bdd019c3ecbb442 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -369,7 +369,7 @@ static const struct iio_enum ad7173_syscalib_mode_enum = {
 	.get = ad7173_get_syscalib_mode
 };
 
-static const struct iio_chan_spec_ext_info ad7173_calibsys_ext_info[] = {
+static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
 	{
 		.name = "sys_calibration",
 		.write = ad7173_write_syscalib,
@@ -1399,7 +1399,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 		.storagebits = 32,
 		.endianness = IIO_BE,
 	},
-	.ext_info = ad7173_calibsys_ext_info,
+	.ext_info = ad7173_chan_spec_ext_info,
 };
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {

-- 
2.43.0


