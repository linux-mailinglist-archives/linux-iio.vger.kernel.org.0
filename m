Return-Path: <linux-iio+bounces-11700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F79B7E5C
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9405285602
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D51AD5D8;
	Thu, 31 Oct 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WGHDno72"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16C1A08AB
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388434; cv=none; b=CuvunE2VMLmq7jaWUoR4yIeZUbAVPkiSk1eSt18yMUvO18t6GLLdb4mmBJLuZVwdeymJ1pp/1wULhfEHN+30qHoyr7gRTUSe6Tq4bBPsGTqcTyF1v5Ihjp72PthKtbL9FXEvCJWVQ8VqAhAEOahfA7BuxpOtlK6ILZhVdW6N54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388434; c=relaxed/simple;
	bh=mCLydiA0KKmrbPKui9elDYVWFMJ0Mv3IrFxNpz1HNfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8NpF/ChjuJwN8Sx1ICLSfbr0YAEPQlC8O4ONU7kb3Wel6JurFw1EEBlrM96z3d2lWdwe+BAl0QKS8FSCtUU1plRBwr0r6wErsH5rZTO+a1tX3kVA3/dS1SVZu87uX2fo4ynN/XFQ6OWgx6zWfV6eDpaltiH4V1CrYBpchCyZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WGHDno72; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1350695e87.2
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388430; x=1730993230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eDKpTruMZP+IxXjbPpb2d8Qn7H2+5jIQszhP7gdxmg=;
        b=WGHDno72euIKFcMsbFXlr7hNQ1MZjakQIOy0jNMMnCVItknjymVECbmHDxQ4hSh3Ko
         CYlyYNlRZXr4lpQU2AaFlDTlgyw6ESwK45XaP93idcYt0ijIhUTHH5VBH+774Njqds0+
         Wfk1EJQsvz8MZxEiU29/1AxTryhsgNRxHQcJdMDdbzPSTehSorbuL+D7VmEfjFtdrwpk
         Glv8XhKA+HjnsXV6X4MqbsxK0PohwH3mGBDu9TmzSPVQ5dzKiCs4rZs3hiCa3DhNO1bY
         TPus4zxm2xGMC/Bm9t/hbssmeEuNrwZBIWP3M5GmPUrXcgL/WiMzLTsETPcLTjnSwMpL
         uz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388430; x=1730993230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eDKpTruMZP+IxXjbPpb2d8Qn7H2+5jIQszhP7gdxmg=;
        b=fQfZlZZ6pXrrJU0pvdZCapxSjK/bccWqZZ2gME/A+nLJzpBaOz7TsfEMLHoCaPECZD
         R19novdtQDWzwhr1uId/Kn7MuSpjOVBhO7EYRnBOx/qe6NchG8dKHOb9GtN0MOgu8xne
         7Rbbk3+5KfSWHpbyPtuXpflAcF12k3RAoX4T1Bh8uZFX4t/KACmQ9zbftq7yLbNCsPAh
         NKntXTlajqVumWO1u9mF3lNM6bo+FnNCPppr0EIrCytAb/lF+OBrXpuAMTZeIR69ubju
         EbVj9unf0udQ/6WkLqgdZ2FMEoRSu7Y8tg38e4vlaXjsJvnPBbxFCIrf1svaUw5bySCp
         iqRA==
X-Gm-Message-State: AOJu0Yy1pxa0zjEMQQ5dp0mVWgPZsUDQSRsUeZCRxqKnmvt3z99KcYW/
	hzehIqEI2ZuI6r34lNR46F31bV0DHvGX/x47DAs+AJ5bcdzH6fNp0HYXL9Ka7ug=
X-Google-Smtp-Source: AGHT+IGjr93P1e7lz+9DxAcqNxw0ZM4hWmcWRfsYdyiLlzZAFmm8L5DUz7on0ZrmWR0iZ8h9Nc8dCg==
X-Received: by 2002:a05:6512:3ca2:b0:539:f699:bb29 with SMTP id 2adb3069b0e04-53b348c8d6fmr8574506e87.15.1730388429624;
        Thu, 31 Oct 2024 08:27:09 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:26:57 +0100
Subject: [PATCH v2 02/15] iio: proximity: hx9023s: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-2-2bcacbb517a2@baylibre.com>
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

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/proximity/hx9023s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index d8fb34060d3db88a3ba5ecdc209b14be8e42e8b9..38441b1ee040c7c26047b0cb2ac443ecb8396df3 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -879,7 +879,7 @@ static int hx9023s_write_event_config(struct iio_dev *indio_dev,
 	struct hx9023s_data *data = iio_priv(indio_dev);
 
 	if (test_bit(chan->channel, &data->chan_in_use)) {
-		hx9023s_ch_en(data, chan->channel, !!state);
+		hx9023s_ch_en(data, chan->channel, state);
 		__assign_bit(chan->channel, &data->chan_event,
 			     data->ch_data[chan->channel].enable);
 	}

-- 
2.47.0


