Return-Path: <linux-iio+bounces-11078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A179AE045
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 11:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F301C22332
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8E1BBBEB;
	Thu, 24 Oct 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EMAHKqdf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F81B6CF1
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761175; cv=none; b=RJAhbdvp+JQJUp1Gxt4YjL1tj6nZ/GZikcIcz/+Y2/pNDOO/Ytb2fzQ5XJi4cxCrcQkqh+EAvsFcL395m31MvQTppK6eeu1POeXcebBaMoDz2IdH9sOaQO49D+8GVp0uFNRuHc2M1o5A+wwASlCGPolbukCD2KcBI6woDmleJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761175; c=relaxed/simple;
	bh=1aInR4B+wLg0v2TJsedQv48QHKITvrOz8V91jOkfY1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3IMc1KrXiFXTv7KBsiYsnrN4aVa0kZLwICybEJJ+9Q7MRqNIqKvY+10dkaknww0vw67AaedyWpC+9/oX6Vt/PjuRQRdhhBSnk8TKdcG4wD78/QU7nl8LHJSOyULO7vNN0apbsy18XvYGbVH/zbJryMrxQuhWpvZQ7BlMUFNEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EMAHKqdf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d58377339so477772f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761171; x=1730365971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdOPmGMXx+g86q2x28kwH3RDTuMEma+ZJf3qhTRWEDw=;
        b=EMAHKqdfoVfM8zM0u8sVsxiokabhGMVopwwPyER5QuArbBAcFwIfn/gEgIzHtFcRr3
         BhPHcCuRMRoWnijuV+GRo1T7wM4egwBJzngxu8sUJnFcQcaI/4wc2pMDLSXksa3t/akE
         VwXIfI1OrNzs6OVX6oWoYTmMj3nnKRsR9pCMoA0oZN7J8Zl5Q/K+weTWUeDnmG6myOBy
         NjQ6w3lpB0FxalG9J8OhjqTRJ6NjHZlrfMjhhEviiP3mARxw7umPdpSqHTN3037QOTmX
         9DKZHKULF7J0tvt092I568cMxKmPDHgdwT3841XCVn2+9FA7UAPv7o7FNMnerKDIrpxM
         dTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761171; x=1730365971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdOPmGMXx+g86q2x28kwH3RDTuMEma+ZJf3qhTRWEDw=;
        b=uZMU5S4Mv53jBuaXyhLC9PWCWYfuH10nu6sPM0B9T9eHmu0dDi9TAfBmN2BlJ5btaQ
         k+8gPlaKwSMkGinpuF3qdYD549gMhQUKVDMuJE7+j/lkL+0k4qG2GJHcWuut5R89wHOP
         v09ujXX/Yql6rAs4KTDc4abt1eztpLBWCKyY+969TgTQedwSHBJg1dLaR+iWHjijDWcP
         APFGjVnWk3N4jHqWQbvr0dpiW+bze928DzTH97US798Ou6QjFKR398lax2XdjmdAeIIo
         20iGCk3GSVVYMyPvBewMnOoGU86rEGbHxFdvRcLR8O8iWcd5yuMYeLlP3PKdlTEI7sNb
         IXHw==
X-Gm-Message-State: AOJu0YxC48Z9iXQ7T3p0RnbjWpScVnm361vCq2uh1K2FW3Z+IDthop6x
	OaOttaCN90H8ZnqYH00R/WAOo4Ujl9VW2NcqxiJLXfzEzYzq9g9SaYdEBjWl6Uw=
X-Google-Smtp-Source: AGHT+IEJMo4HXjFBb2HAgz0IHf1OOTvuQTF5X6gInGGPV/HyBWXnP/yzVC8dnCAhyj14nu5bNPIoqQ==
X-Received: by 2002:a5d:5747:0:b0:37d:48f2:e749 with SMTP id ffacd0b85a97d-37efcee8c46mr4654386f8f.10.1729761170851;
        Thu, 24 Oct 2024 02:12:50 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:25 +0200
Subject: [PATCH 3/7] iio: light: ltr501: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-3-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
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
 drivers/iio/light/ltr501.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8c516ede911619bb4ee8f8a823f242b7aaa6af55..42daebd6023456098dc4bcedc3fe3a45f9ae5be0 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1083,10 +1083,6 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
 	struct ltr501_data *data = iio_priv(indio_dev);
 	int ret;
 
-	/* only 1 and 0 are valid inputs */
-	if (state != 1  && state != 0)
-		return -EINVAL;
-
 	switch (chan->type) {
 	case IIO_INTENSITY:
 		mutex_lock(&data->lock_als);

-- 
2.47.0


