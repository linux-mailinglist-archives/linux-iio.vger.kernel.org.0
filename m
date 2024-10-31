Return-Path: <linux-iio+bounces-11707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9C9B7E6B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C4B2857A8
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03E1C3317;
	Thu, 31 Oct 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QFNOXxQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615831BDA8A
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388443; cv=none; b=nLhWdemBI+dsa/1DkSdOQpf8pDabTmXDi3oPoDUHhZxxGxWxZguToqpcZ108QuAsi3FIpIraHlV93e2JUnzzNo1pkefL4U1n1kFqSKEHiEAtExyrVFpanRidwa4pXa8CDD822Wrj6l7Gcd9zMyNDNL7e8rmBXoeGqZJhyynm7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388443; c=relaxed/simple;
	bh=s19xiscdrxWoyhnH6+9SM+7lYdKPqidKN1eD+lS5570=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnItV3FoIdbp/21mQV2vTLkEzPWvtnYUg1DNxRqS4yBtB1iKv/XWVAhjTM0xVWYXBiBt+kpJwUbDA6C0V7FATwldVcQtLcc5Nzd3bL+MT4/qUm3P56mvKirx+lYRvrQPzfIc6il8Jefh0/rnc4hHUE13KV62x1J3v+C6EcIE3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QFNOXxQc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so8571085e9.3
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388440; x=1730993240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuKYisz+WfuMrY46Ard53ju2b4imnRFwr+IipE+GsB0=;
        b=QFNOXxQcYF3P09I6NeAK4Ne+d+4qQg5ClILyzktm5eFd0lXZKVVs3RDzqgziD1Irm+
         wP9TVCrOfuCpMMW8Yy0usUiF8QkPdNezYgMrJA97UrKYiNB5C7eSHqBCat/N6ip1vT6z
         +DRXk/pdbJyP3XP6bKuUB3dsq3UNewlZnJx6YY5vJ96HpX3TG8njwJslXwErbZ8Yu9oh
         t0dKGZXnNSEpTM9wYRM3uxudXSyuGHdQDMiZemvp/rYGr5J+/3xxXitsVZIUZsNS1l9r
         A/TQh0kwW8d+te9ySkk+KyNlBAK36N88M34OrLKD/PU5DUT9sUVSAzlMQ5imLp5PetBP
         knmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388440; x=1730993240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuKYisz+WfuMrY46Ard53ju2b4imnRFwr+IipE+GsB0=;
        b=qcfdOIpkjB+GgWqaYSvkgHauHi9VRU1zaRT1Y/GxBkDFb18sXvj2QDQWZfr3S7Z87F
         Y1VgRMOk7HibNMyV2z3zXBr4u6l7cXOMYOTs4XcnAN/ao31MRisvJpzkjIlUmfhe+yG1
         UqoPtpRcjeRGjPGB2L3iHViFTR3ev7rmc6a/MvuwT693iMsWrGz8Uj/2G5BNgg3HFgPE
         I5gG0Fl8JSEQ7cOx9cTrszOm6/InLxLamTeJCrkV1z3JH3oyyf5z81AGvjNrKHDV1Zrm
         YEL2ZzENcLb0CWbejCLU/W1wZAZoVFOCAPCc3Md6mur9Gxla0K/rMFYSZm3ey0RdoGFm
         /C1Q==
X-Gm-Message-State: AOJu0YyzLgvQBnZarZSn4TebS8iKmI/2vtidAnwZC0WybueKv7Mmu6QA
	lgePMrOLPBvvghuHztp6SH0b7VrJ79+zNAE/fb5gq/EHVBpR8wYcMWTGLRP54VE=
X-Google-Smtp-Source: AGHT+IF6/i3o0ia+iwTXrJkK/PpU7s5AqPYFhPt+pBzmwQ1VaBg1134R2wQ1oOCceXnLNgNRe+dsWA==
X-Received: by 2002:a05:600c:a04:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-431bb8a01dfmr64636815e9.0.1730388439775;
        Thu, 31 Oct 2024 08:27:19 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:07 +0100
Subject: [PATCH v2 12/15] iio: light: apds9300: use bool for event state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-12-2bcacbb517a2@baylibre.com>
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
parameter, update apds9300_set_intr_state accordingly and change intr_en
to bool.

Also update apds9300_set_power_state and power_state for consistency.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/apds9300.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 95861b2a5b2d94011d894959289c5c4f06cc1efe..98bdf8bc298b664aba71d3c38d7f224808e5997d 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -46,10 +46,10 @@
 struct apds9300_data {
 	struct i2c_client *client;
 	struct mutex mutex;
-	int power_state;
+	bool power_state;
 	int thresh_low;
 	int thresh_hi;
-	int intr_en;
+	bool intr_en;
 };
 
 /* Lux calculation */
@@ -148,7 +148,7 @@ static int apds9300_set_thresh_hi(struct apds9300_data *data, int value)
 	return 0;
 }
 
-static int apds9300_set_intr_state(struct apds9300_data *data, int state)
+static int apds9300_set_intr_state(struct apds9300_data *data, bool state)
 {
 	int ret;
 	u8 cmd;
@@ -169,7 +169,7 @@ static int apds9300_set_intr_state(struct apds9300_data *data, int state)
 	return 0;
 }
 
-static int apds9300_set_power_state(struct apds9300_data *data, int state)
+static int apds9300_set_power_state(struct apds9300_data *data, bool state)
 {
 	int ret;
 	u8 cmd;

-- 
2.47.0


