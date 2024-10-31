Return-Path: <linux-iio+bounces-11703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 273519B7E62
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7495B22DEA
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3B1BC07B;
	Thu, 31 Oct 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r1kWn1E1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB41ADFFE
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388437; cv=none; b=drpdoV7pch/vca5fw30tlLNCxW8itF1mayaK9JrBL4PHLX9lvqYPa1Zv5dlRBm7T6ESLC9SVvvgoc5rL/yYId6I8KiArLOxlEwTPaY9TyLf92cnLAx+mprwv1NA7uEaJTePKtoUDtgNw0YgNv38y0mEHB1GrkLgkO5v7Hzj2UuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388437; c=relaxed/simple;
	bh=Crws9hBcBUgMNyTwteduHmHWY+ibF9suD+aQH3je7N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eq28ZMNVbpXn9FoQamkENMGUsakgZyX38tLprK+BTJB0oewhBWi78jYj+diACdJiLpH3fcPc+bZCsrcizby8KYxR/6+u4JfmoDwwLf+hcCrwApm4V7WCmFiv6NAuw62vvy71mLbfpAgnwgu6eTLEBbE/rZVZ8SMQckAziRcJbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r1kWn1E1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso11531545e9.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388433; x=1730993233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeXr3qZeoMT4Q41ImmT91MFFoZboqwE1uhQTfbeavwY=;
        b=r1kWn1E1yxvTzXA45e0pzvuWzpaLc9n7gdq3rd2h+2NGX4GHTIMtS8jjXUsQ7tpZII
         fojQ9BCloMjtlKeHHG73Ab8l7PdrLo4SdF/B7qLv6fHA1SVmRWASQcbZBX5I5xlRcCIB
         jap2avtU7jGqg09+89kMIiZvxfYICeYHMHV4F+qqeGlAfULxqIsgmUhvt+6+SwhAkZY2
         68T2UkuNN5xk9OW7vSmM+wWLvGw8bnsHB5eWz+Njik7nybMCwIJkG0JirhffNDBfLrAY
         /d6bkX622Qd91F7WEQbF9lVz1K5rGqXc9vIxQs4dOruH/dp3wTKva0z2fEyFJXFUl8cm
         KE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388433; x=1730993233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeXr3qZeoMT4Q41ImmT91MFFoZboqwE1uhQTfbeavwY=;
        b=dvt3nJ4/RsZxl4yfO8j91yP01e+N3+/q6NA0uRe6wiDhwazqRddX40wo5gX0/dJxZc
         5KJ6yVn3pd77xdZ4fgI5Ji6/IAwK7erVaQXidIVte8nQg5UF/Mu1kgz9cwp+ncbcGlWG
         7XpiJi9LxmOwvcZtdHHSHITPhDe288ps0b1nDoSvwO3Uav4deUH4WQHh6DG5oPnGQG5b
         EuCjywacCGAdBuyK9X0usBE2DN83wUwYCWXoUCBxT70rNiPUTroKgqOqd/ZJa/HlU/mS
         D6HgOEMpMg8cQgH8swj1aXbRQUxqJr1HMfF9rL/rNaohJqGLw0W3LBaMzc/GtZsYO5EY
         kW/w==
X-Gm-Message-State: AOJu0YzJojpeoJloyCiX5lUeTki6NAG1x51a5Ax4ovM5zbh1z0bzaFLc
	atLlOQ5nkG2ia8+a4n3Ny18ws92lPbvNP1Cz3UBte6l+Kmym0Wieb7aGL84Lb5M=
X-Google-Smtp-Source: AGHT+IHhKXOtU6WrItuY3dPBqGFS+YCmx9LFZrBINQBT3KJgqU4GZtX+T26R8f/M/h9JuV4y1clo3w==
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id 5b1f17b1804b1-43283296066mr2433515e9.34.1730388433589;
        Thu, 31 Oct 2024 08:27:13 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:13 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:01 +0100
Subject: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
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

state parameter is currently an int, but it is actually a boolean.
iio_ev_state_store is actually using kstrtobool to check user input,
then gives the converted boolean value to write_event_config.  The code
in adux1020_write_event_config re-uses state parameter to store an
integer value. To prepare for updating the write_event_config signature
to use a boolean for state, introduce a new local int variable.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/adux1020.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5d1aba08a73ce18c367e 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 				       enum iio_event_direction dir, int state)
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
-	int ret, mask;
+	int ret, mask, val;
 
 	mutex_lock(&data->lock);
 
@@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 			mask = ADUX1020_PROX_OFF1_INT;
 
 		if (state)
-			state = 0;
+			val = 0;
 		else
-			state = mask;
+			val = mask;
 
 		ret = regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
-					 mask, state);
+					 mask, val);
 		if (ret < 0)
 			goto fail;
 

-- 
2.47.0


