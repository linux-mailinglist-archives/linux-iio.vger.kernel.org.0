Return-Path: <linux-iio+bounces-11821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980099B9ABA
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 23:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC46B1C21296
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09E1E7C25;
	Fri,  1 Nov 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BY5VmYvy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9315AAC1
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499441; cv=none; b=e1SUUf4WkwKgBk0b06b9x95+NW4FfkUvb3+JpkaVAm78Sh94JAbLpDnmZUWsn2eUshmwKzNtyt8Wk7z97sc8sHY6kfS081nV5aba2LfWq+J6qZqs+iCnMkmXreOyerSMoWVsOq/PdMADoWAH5iBdaDf4r0282WnhJ3wkJJOXHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499441; c=relaxed/simple;
	bh=pdrEtCsutVMsD7ZdyXTHnxVP1yiOgDXGeFRgfIDy81o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rh55L+w7QCcBAdVxRNNukwpyCm8pslU4RL3RUMmlfo0J5HO4v2Y0IxfEUn9TYzyGrwmXG9PS1YLCKutHRa2znNRunR7Qdd3bVgGV1bXfzCGtvlJipmeYrZd54qWk3N0UKiIJ+L0U/M7GbmyCOa7C2G0t8+P5yoX0Mo7rJzgdH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BY5VmYvy; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71850708dc9so1471330a34.0
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730499438; x=1731104238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLqOXH+eJdFKT3oFXoLVHge15ZV+4BlbLGdxueVt+Hk=;
        b=BY5VmYvyKYp2402/ynbeprqAx7UIPNWjS4B/YEz1Ie1UDGNlTnCAWnLCvrtHghOZbr
         XWQ8F1qoEIuLg7I8+lTxxWJbjRjy98aiPe7Mu67teSC2DnKSmpI4OnjZeSHwjf46+6jH
         6rxPLqmPFVozkNthc1jQWhqMs/hA7SyRD5ecfj9bAZFGSMyJ1rhImH3Ts5uHVX20HaLB
         fV3kauBLj3SrmHjwGp+6KCvVAPFC01pQX48r534c9ih1CdGnMheIC4R0s6el/FgPiGzT
         SDGfDGzvH8GTerF0SidTCEOjYpL0DZ72c6XtqSIq+MEliK77Z7cv69Ehk7hn4mwQ3BN4
         21rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499438; x=1731104238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLqOXH+eJdFKT3oFXoLVHge15ZV+4BlbLGdxueVt+Hk=;
        b=flJo58//ivV7ultPxuQsdBik4+w7GNMeqYpASymt2011ZnCfCfYWgiFfjl1ATRNgTL
         olAISUcK986wjWs8DqS7A0vj0l/e2IYqzkjxK0acKcDyXHtBumsGqedMYImM0jfLNOWA
         jiOKsXHlF2jMxxPWN31Q3tZWIrCQTL4KWtamPexb3sDwieIUJetqEDRPsZeZi0iNBNTu
         +gbbwnTLTa1kyXUrx+OvG9e6u5E1FtXLl5SKQ81ZauQeQh/aW+CrrOZEKGlbLF5CQty3
         MhzCB1ox5edxLJ8j/WHEgEtbzxgCs0VTRX7Ao8PmiOx5WtqMJLxVRj686c8sgltoz45b
         g4uQ==
X-Gm-Message-State: AOJu0Ywc6crDr4pJv36Hg7Vh3myEUrZSg5+aVYXrJgmLmnhwd1nmchSH
	zv6zo1sLn7g6XuggPp7BHNXgwfi3jV0V5DgYIkLimk+1noJvTYkEkLT07BSb3OjCbYCwBXDj81T
	2
X-Google-Smtp-Source: AGHT+IEVHFylBhGTVRnutothbagJB8enBNQj4LhsoJItGeX4ocpWlbNECxlA0RranBN9azfEBkq85Q==
X-Received: by 2002:a05:6830:6c88:b0:719:cc74:dfd9 with SMTP id 46e09a7af769-719cc74e0f4mr3121612a34.3.1730499438153;
        Fri, 01 Nov 2024 15:17:18 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec70698049sm789817eaf.48.2024.11.01.15.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:17:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 01 Nov 2024 17:17:08 -0500
Subject: [PATCH 1/3] iio: dummy: use specialized event code macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-iio-fix-event-macro-use-v1-1-0000c5d09f6d@baylibre.com>
References: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
In-Reply-To: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using IIO_UNMOD_EVENT_CODE and IIO_MOD_EVENT_CODE
instead of IIO_EVENT_CODE.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dummy/iio_simple_dummy_events.c | 30 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index c7f2d3a4d60b..b51ec21b6309 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -183,36 +183,34 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
 	switch (st->regs->reg_data) {
 	case 0:
 		iio_push_event(indio_dev,
-			       IIO_EVENT_CODE(IIO_VOLTAGE, 0, 0,
-					      IIO_EV_DIR_RISING,
-					      IIO_EV_TYPE_THRESH, 0, 0, 0),
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
 			       st->event_timestamp);
 		break;
 	case 1:
 		if (st->activity_running > st->event_val)
 			iio_push_event(indio_dev,
-				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-						      IIO_MOD_RUNNING,
-						      IIO_EV_DIR_RISING,
-						      IIO_EV_TYPE_THRESH,
-						      0, 0, 0),
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+							  IIO_MOD_RUNNING,
+							  IIO_EV_TYPE_THRESH,
+							  IIO_EV_DIR_RISING),
 				       st->event_timestamp);
 		break;
 	case 2:
 		if (st->activity_walking < st->event_val)
 			iio_push_event(indio_dev,
-				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-						      IIO_MOD_WALKING,
-						      IIO_EV_DIR_FALLING,
-						      IIO_EV_TYPE_THRESH,
-						      0, 0, 0),
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+							  IIO_MOD_WALKING,
+							  IIO_EV_TYPE_THRESH,
+							  IIO_EV_DIR_FALLING),
 				       st->event_timestamp);
 		break;
 	case 3:
 		iio_push_event(indio_dev,
-			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-					      IIO_EV_DIR_NONE,
-					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_NONE),
 			       st->event_timestamp);
 		break;
 	default:

-- 
2.43.0


