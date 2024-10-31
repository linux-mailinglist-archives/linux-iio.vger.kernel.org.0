Return-Path: <linux-iio+bounces-11710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD99B7E6F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EDF282746
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E021C7B86;
	Thu, 31 Oct 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TxoD4SbL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0B1BE852
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388445; cv=none; b=H4hngq887kDrpomB5hccnZvS3ZDrmSH3Aj4PDVfxnIrq4bKHFDd5puOtmD8pWGQNdQgURN2xNl50GyY2RV8QZy2UUVrKEsS0RSHFDSMJb9ZbV02tSaSosOdQPes2Eh7sQQdQXG54bDgOCcqh5D/t32q71GPQdE1w1E4+iHMBpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388445; c=relaxed/simple;
	bh=VmHbF416eUCiuhk2pPyLWQqW2F/AFbNe29dYg0B17jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXgDlwV3lOMht5/AInJKUJG0JV7ZtUZxJsBwQK7P4dySrQuOK6xoOToBRtBFj0XnFVuIF/FAxqfLUxklFPZfvgCfS8XxbWns5+cEdJSA3t1WXURWBa4WODVXrmOEMgw09OoJ3v+2tli+S7ruu65DS5oDS2PRERM5F0jGnbVhcVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TxoD4SbL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so9620735e9.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388441; x=1730993241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQxEAbikG832i9VGoZJgFYk9AEf9LJDD4S/9KzYjDMo=;
        b=TxoD4SbLRlYA22hMRqENoa1bK7LZCH9Mumw1JPXLftyfnhW1FU10Y9jBMpTkI8jvMG
         07xn1pTG1E4itmXbSGdw2Q7jE+/K4Jz+r4NUuF81KZhXwKsvqBEZhvfiPkmdX1JIywbM
         GMRDAlRvqSysaDpl31fC35Q3xqYJEUzbfQHnHn70vOXZueFvdgNHxO1i9WgUF7jI4V/v
         XPf5nqWREtmJbHrs+HJgqjzcxLUhZYZpBhxzAHHvmctPzFLyD2RFHgGNrsfhucT/0wIe
         tNNCWbM0JkwTXlncyWEnt01aZeGrUiDPYm78pv4ARpgPphFgE7vYx5X7qxOJBq1oUoR6
         ixJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388441; x=1730993241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQxEAbikG832i9VGoZJgFYk9AEf9LJDD4S/9KzYjDMo=;
        b=AJyr7CDM6m3UMdjxS3kmGib7t6K+KGFN313ig5+R4zEnPy8i9s+E+GPKzRRz5W/Kpj
         yqrMgrsA7G1JZH+Vhri9qGAnrwipSu5ISfjmnn5lQZOYqaQd+qKZlt2nqBBicxaDJIQj
         fIbNycsePocTuT4C5rs0dweP/nflYMe32aBwUJWP7TpLTYp8vMLPVaYz6o2xQeyd9PDE
         PG89tqH8nNDeELOevPBXjhZvB/cenEedrQJF/GFgVmzHzvPbiRci0Iea2ZMOm+DHMDDJ
         wrTVH+WFcAoYtua/w+zac8miRlDPZZyz2hb57YULd6oVjq1R0eZm9OFgRahltGr67K3S
         1qqA==
X-Gm-Message-State: AOJu0YyNIwebrMWT1VEzzFVruy9wqQaeBZZoLuW3b4YEzLM8nfolEIt5
	7xhRh9fmtbNUusHAcH0Z30EmTrhweE3xlx9pHoV89v0gw0ZOfbSEromZ5l5oDvQ=
X-Google-Smtp-Source: AGHT+IGjIoWlwinfZhKBEIrRl3MA4S88J1QJFbpNcM59olLwoOacmA/yBDxxHNOfzvA4r4tdWOJ2fw==
X-Received: by 2002:a7b:c848:0:b0:431:53db:3d29 with SMTP id 5b1f17b1804b1-4327b7019f5mr37167515e9.18.1730388440670;
        Thu, 31 Oct 2024 08:27:20 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:08 +0100
Subject: [PATCH v2 13/15] iio: light: apds9306: simplifies if branch in
 apds9306_write_event_config
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-13-2bcacbb517a2@baylibre.com>
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

Simplifies the regmap_wite if branch in apds9306_write_event_config.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/apds9306.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 8adc74040db2bddf93fbb773e3519abcc726b9a6..9c08e7c3ad0c17519689a630d42fe9b90438dfe8 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1125,10 +1125,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
 		}
 	}
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		if (state)
-			return regmap_field_write(rf->int_thresh_var_en, 1);
-		else
-			return regmap_field_write(rf->int_thresh_var_en, 0);
+		return regmap_field_write(rf->int_thresh_var_en, state);
 	default:
 		return -EINVAL;
 	}

-- 
2.47.0


