Return-Path: <linux-iio+bounces-11706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398C9B7E68
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948E5B22270
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B81BE251;
	Thu, 31 Oct 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VyMcOcy2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA121A3BC8
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388442; cv=none; b=QXlbrovwo+NvmTWxIumQ8gjxAi6HrdV1UK7aym8ZwWml+qZt+Bu2/pNBBAmzqRIG6WtSF/eZvwoAs6Ev7UAicxOYbEZKd9VW8SPdkHafBjZfdnWjTGjR/ldOoYIZEddhWISkjmMOWWfviX+fwIFwcj9DAQBa5BmhZLAujY2Cr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388442; c=relaxed/simple;
	bh=lNWa0KqaStuVBH6MPmyCH56JtdUmYjodW8Uzx50cst8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsqJRFRF0+uCgK5UXO0Q1r02rcK5msVttimaF0oIB/qdep6j/Zx7VSbWh+lPHh2QkVwcWpnpXBQen+6NgI7yceIhOd9kE6SUXg5tj3HEhrdSI6mwkBzsuro+Jg/5EoG1Po+ktxINaBXkF5wtT9C7SlEi7YtPyST99SKVp7xXoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VyMcOcy2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1350860e87.2
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388438; x=1730993238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFsb0303PjNI48V2V72P3jKH8c+L4bxDvzzJkb075Z8=;
        b=VyMcOcy21a/eQSvIN5J/KFHyshrUk+xsffkJAjjYYyIxXEp2AX5wA4jTiWOB9l+eq5
         64x5vrVKJ+SENIdwePNy4GPkYq/ff6Hqh+pEjIa6fcc6qb+L0TGe33LnvhNc9bIHjAuC
         aJFawt8YlGv/uxpRrgp3rv6/DIEuhBWBdqmrRsZ9Gd1Q5Neh1AG/5xO16fmsu8AuGJpn
         fGa+/9r4AVgsjVyx3a6QvQZzQrIZIVu0Mza5KQRcFoX+24g1fDbxK3Y3dOyj/SryKXhq
         bfFawXoTVXo/Sb19uEsuSbpgUvnDBNGfkXdQD8mP8xW8y8wWLBnaTmwFqpuH99RiCBfF
         sF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388438; x=1730993238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFsb0303PjNI48V2V72P3jKH8c+L4bxDvzzJkb075Z8=;
        b=gPuT0/1C+KydFagrJT5lD9D1QSC/aQBUUU30fSUoh157cGUhGqj07dlWkXNtjEnR6E
         rMtcFlIIudMMinZvGYqNe/9aTPlV/E2lmOMxeKmQ5YMUdokbeGniJHFo74QVOFRO5EC9
         BRkIMiQ4bpLDvpVmOgjqopXxFEcj2N32DAvCmnMILlqXTo2Qokhs0YxbVpofmCJ7pu/4
         /B/YF3C8PiEh25z2De3TjMR5L21Rjxtx0ppL9QFvg/udJN2u124B5VefX4fVMpsrSOMO
         upJ3W4Z4ZLbxS2p54jiitR9pnpNQHcRulgAROB5AwzTnvfQZoWyHR5tdrlHJXehVz9Ss
         AvIA==
X-Gm-Message-State: AOJu0YzIFIuCNSC6zmaURoDCj3FZnAmqOf2T2MkzzRaTCcN6bcUQZzE0
	J3gR3BXOgwSXHTj50fnwEteaZTUiVWnriZH3rZJNcKHH82GR4mqWc1SgW7Zb/L4=
X-Google-Smtp-Source: AGHT+IGZJyt5pS0YUa3i9kFlv6G7+rYaLlulmcGcSn6EUiy6VmRiBhyhHkSniuvcZZRqwpxExeJiyg==
X-Received: by 2002:a05:6512:1255:b0:539:dca9:19a2 with SMTP id 2adb3069b0e04-53b3491c152mr9322585e87.39.1730388437575;
        Thu, 31 Oct 2024 08:27:17 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:05 +0100
Subject: [PATCH v2 10/15] iio: imu: bmi323: use bool for event state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-10-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Since the write_event_config callback now uses a bool for the state
parameter, update the signatures of the functions it calls accordingly.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 76a88e1ccc1d89988eb52d6b1be8da0f5005f0e6..161bb1d2e761688dd740635f8a2830e9562d1b59 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -467,7 +467,7 @@ static int bmi323_feature_engine_events(struct bmi323_data *data,
 			    BMI323_FEAT_IO_STATUS_MSK);
 }
 
-static int bmi323_step_wtrmrk_en(struct bmi323_data *data, int state)
+static int bmi323_step_wtrmrk_en(struct bmi323_data *data, bool state)
 {
 	enum bmi323_irq_pin step_irq;
 	int ret;
@@ -484,7 +484,7 @@ static int bmi323_step_wtrmrk_en(struct bmi323_data *data, int state)
 	ret = bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
 				    BMI323_STEP_SC1_WTRMRK_MSK,
 				    FIELD_PREP(BMI323_STEP_SC1_WTRMRK_MSK,
-					       state ? 1 : 0));
+					       state));
 	if (ret)
 		return ret;
 
@@ -506,7 +506,7 @@ static int bmi323_motion_config_reg(enum iio_event_direction dir)
 }
 
 static int bmi323_motion_event_en(struct bmi323_data *data,
-				  enum iio_event_direction dir, int state)
+				  enum iio_event_direction dir, bool state)
 {
 	unsigned int state_value = state ? BMI323_FEAT_XYZ_MSK : 0;
 	int config, ret, msk, raw, field_value;
@@ -570,7 +570,7 @@ static int bmi323_motion_event_en(struct bmi323_data *data,
 }
 
 static int bmi323_tap_event_en(struct bmi323_data *data,
-			       enum iio_event_direction dir, int state)
+			       enum iio_event_direction dir, bool state)
 {
 	enum bmi323_irq_pin tap_irq;
 	int ret, tap_enabled;

-- 
2.47.0


