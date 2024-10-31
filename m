Return-Path: <linux-iio+bounces-11711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86289B7E71
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ADF1C22747
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3E1C9B7B;
	Thu, 31 Oct 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JEaUXMw1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3E1BC069
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388445; cv=none; b=adxoJzf0N+3o3jefSzXDSFJK/w3/BNAxgqqufskySe51pVyddwgyYAW4wEFCs02NtjX3ypMrxmQIM6r+GCgyUrMmm7SZojZZkZBtClYLr10ZsYmjSkqA6YYBKegP59FsXZw7ndMW7GhhUwAnQkdbtSca4ilaslKTW8gTnApqzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388445; c=relaxed/simple;
	bh=2oxEXngbpuK33jMEyFTuIjbJNAwiW7RbKMMTMHofTaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZ08vQFVvHd4KN4hq6xjUcg0OSg7JNjviOPBQySBTbwy4UHGJ+5SgGYHZujHNWZCIYae92vdGpUrYpFZpg/4NmsOGEYfIS0293S1C5cJmo/CAL/ePyQGR6GtzmfTeoH/M04WKPcJjCn135Y8ySk5W3jU4lc0kLBvbqKiaUQkJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JEaUXMw1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so8571445e9.3
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388442; x=1730993242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YCxmOEeimQsWbxSuJOXydqCcdjHVKIXSn+X4nwfNto=;
        b=JEaUXMw1AsPKYuoccFlJQ6UiM8up9bTqo+bnEMFvIQDgIYFz+2ZZRSRhCYWHYtgCbC
         dS8ZX5QWwl3wNj/gxDtJH1FbWLbKMidVPeBw5SATvDiaQ4JPRhnQOXas08BUIru4old4
         fl7vvG2fnCI8SA/uIRALNcBvrOxCm9S53gQ8e4zJPxx8bzD6qVp3XTESznwIErLrlBse
         8LAZe2Mqxeotnxv8q6KcMC9uTrwqFFv4e4KVbZ8JIoQPd9h1amq62oIUiOuqeLDyGYfM
         4b0AFtDaA/MIze6eQN3Y5rZ8WbkISujmv3Z2vwBf1eGWoTRs0jytORmR6X0dyGWqjciO
         +arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388442; x=1730993242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YCxmOEeimQsWbxSuJOXydqCcdjHVKIXSn+X4nwfNto=;
        b=BMPngq2EvbCS5NstpzTpP1ABY/wMmxgYlL0vuhzJOG1cjITwmSNTBemPd/NVuMRU/E
         eSG1/JHUMc4nSl+5bQSouLklrKJEovImWSgL4lH4EV2YdHPoUn9shB9tW6f2emvaa89W
         fpTRtc0v2GQelpeDYQXjtFIao9YAxGUMF/FkhNjQRrbJfaX2KJ+NocZtSFHVbRrolNQ+
         QOl9RslMFFutqfYqWnaVggIAU1AV68f6L3e56fUhtfmd2XuQeyDMSSCndxsxB4RdT6dl
         uIAUwtUIR3E31hOWNVWRattdjNkKZWrgtWABSLvEpJdgCJGOAOFqPsXhFtmj5k2GNxLm
         66EA==
X-Gm-Message-State: AOJu0Yyjv/TDTbbE9zix+tkLowAIDjKUP/jc9H9hqzxlcaSc6lohhHuQ
	8nurVRajtVCHfn9Kvy8CT5CpIRoCQKtn6YH2aE/MbU/s9Qd99i6JBolMcK+AMGk=
X-Google-Smtp-Source: AGHT+IGGmHVzwn16NX5EZfe8eqBf1qzHN/yW4gKwcafvrQsBbKKrxU9ApLBrOxE39bgUdtUYNo0xBQ==
X-Received: by 2002:a05:600c:354e:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-431bb9de8a9mr66687935e9.30.1730388441668;
        Thu, 31 Oct 2024 08:27:21 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:09 +0100
Subject: [PATCH v2 14/15] iio: light: apds9960: convert als_int and pxs_int
 to bool
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-14-2bcacbb517a2@baylibre.com>
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
parameter, update type of als_int and pxs_int to bool.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/apds9960.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index a7f0cc99f236685900f89fbc48de3be0e9a40704..7b3da88885693c488807da459ceaa1cbb3881bcd 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -133,8 +133,8 @@ struct apds9960_data {
 	struct regmap_field *reg_enable_pxs;
 
 	/* state */
-	int als_int;
-	int pxs_int;
+	bool als_int;
+	bool pxs_int;
 	int gesture_mode_running;
 
 	/* gain values */

-- 
2.47.0


