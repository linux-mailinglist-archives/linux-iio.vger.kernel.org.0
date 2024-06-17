Return-Path: <linux-iio+bounces-6447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88B90BFC1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 01:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EEE282CA2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91C1993BF;
	Mon, 17 Jun 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTOzgPKU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A7163A97;
	Mon, 17 Jun 2024 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666542; cv=none; b=OnirRMvP9tX1BZR5KKw3M8yn/5l85ksGerSRu8QqciSpdDNZ+2wNFwLS7nfDTkypZI2ayvFPIkvAao8HT8q29uP2DP9aR/1DubC4XeU0ib3W1s+NsD14wlZs1kksEM8XjpjptaKOPb10rEZCvaFT1+zQ+sQ57jPhPmgZZna0uQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666542; c=relaxed/simple;
	bh=wKRTlIR7nnOjM0KXV8XEYm+3gbeEEjKGhoRIr/a9C1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p41shoPigVrxhK30gRxb112uN7KqtjgzXLvWBmROnnzyMk51+ZJxWiWJrSdTw36QY3QQVaOu5qHintunlVkRovyaro4OIa8nN0kXudzNmTkIgFtfdDBBHNDAgM0n2eLPWy8a44fbuH4fsUlyEDXQilfNLqROTuy2Xijlms/kPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTOzgPKU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6efe62f583so477045566b.3;
        Mon, 17 Jun 2024 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718666538; x=1719271338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKRTlIR7nnOjM0KXV8XEYm+3gbeEEjKGhoRIr/a9C1M=;
        b=fTOzgPKUDbw0o7teLfte5KGTTjNT7rPmNYZalz8FeT6YTWVriPMx1CNalZfE+s+D7r
         WQrSOJEz87+kbNyI0RWIJ4Zm+1qQZeftTXT9H7qwNQjYDJVVLI3iDJFqcfYL3ndxQp/c
         gynN1P3EAhP16LoPILgXSTZAzuj1zlVxbeUR+kxBSCrCk+SrKnnzQCUlFq8GwqJv8N57
         FkHzaad9BO8xK4KoMo5sspQOIAW4G03S10/x/DmsiwGHnEiBuo6bDU8+iqiixcu/NafC
         r+d7AhCcZWzNd+0OxQvvCAI6phUiTPfmypP5bXLVonN5/5s8iDh4Hq/6EuFuOl7yXpbu
         6CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718666538; x=1719271338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKRTlIR7nnOjM0KXV8XEYm+3gbeEEjKGhoRIr/a9C1M=;
        b=wGx7XRBcJJ/fjISmVzkjG/8H2O3hV3NVf7YF3DJbZ7x4hnoX2XntEHGDlXIM1n57cW
         dD7kHzUFDfSF2lCvKF3JUpZJ+bXIACGFR9JNGLhKx/NcbvttNmyhHsOxie+oXSmL7eYz
         YpeGxth2GZGRr+UhTk/1vSllTwhEf03/l9XiU1ZMnw2DEsxHyMzoKAeVxx1W1STFKO5r
         bUskyudGosRmnJyXCVjVbE3k8ba/Tnnne0ir1XPugz6WXAN+A8NukNwB+zUFKRfLoG1L
         FEpOIgfA2ndmdblvUTNbUJx/Yy1W0Xq9qxazlko9wS7YKzWp0FLoWqoshLEKN8EBJ1b0
         ei7g==
X-Forwarded-Encrypted: i=1; AJvYcCX/q1HAUzqQSldaEIb4BRbNU8jLgl2N8P20pBTB+YxyeaVX4ZHAtnJ2U4tGqi7bFPXI1AxrqiqqFgNcWawhnwIojWm2NtoZVLoKlyFpjn26gJf0lXyXjtA69PtJhXjt9gHEaj14sHjO7xcYTm3l42irynii0gxAJnWDhGkPt0LBV3txicJYdQ==
X-Gm-Message-State: AOJu0YzryXLh1p/N8yZUihItuGD+6+EKeydQMEH3Wx8Z16c9BLN2DP/4
	AIdwbjZzaBdH0mo4+ilXTPrxmr3EjZh/fjgGRnL9JqN25UWMeFev
X-Google-Smtp-Source: AGHT+IGjp3Ii1wNb0dBKA712QfgjfMKbqZ/mXIwxAYEF4EPT50uybie8uvCZMH9EY/OD9lYqsMYbEw==
X-Received: by 2002:a17:906:d18f:b0:a6f:256c:8163 with SMTP id a640c23a62f3a-a6f60bca7a3mr697845766b.0.1718666537578;
        Mon, 17 Jun 2024 16:22:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b152:a6ad:d6c8:f0e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6b2b04f5sm411879666b.192.2024.06.17.16.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:22:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: tgamblin@baylibre.com
Cc: Michael.Hennerich@analog.com,
	alexandre.torgue@foss.st.com,
	baolin.wang@linux.alibaba.com,
	bcm-kernel-feedback-list@broadcom.com,
	cmo@melexis.com,
	cosmin.tanislav@analog.com,
	ddrokosov@sberdevices.ru,
	festevam@gmail.com,
	hdegoede@redhat.com,
	imx@lists.linux.dev,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	jmaneyrol@invensense.com,
	kernel@pengutronix.de,
	khilman@baylibre.com,
	lars@metafoo.de,
	linus.walleij@linaro.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	martin.blumenstingl@googlemail.com,
	mcoquelin.stm32@gmail.com,
	neil.armstrong@linaro.org,
	nuno.sa@analog.com,
	orsonzhai@gmail.com,
	rjui@broadcom.com,
	s.hauer@pengutronix.de,
	sbranden@broadcom.com,
	shawnguo@kernel.org,
	sravanhome@gmail.com,
	u.kleine-koenig@baylibre.com,
	wens@csie.org,
	zhang.lyra@gmail.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: Re: [PATCH v3 35/41] iio: pressure: bmp280-core: make use of
Date: Tue, 18 Jun 2024 01:22:12 +0200
Message-Id: <20240617232212.34280-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617-review-v3-35-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-35-88d1338c4cca@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the bmp280-core.c part, in Patch 35/41:

Tested-By: Vasileios Amoiridis <vassilisamir@gmail.com>

