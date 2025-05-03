Return-Path: <linux-iio+bounces-19021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B1AA8202
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DBD7AD883
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1951E520D;
	Sat,  3 May 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d63Y/juU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F001624E9;
	Sat,  3 May 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746298091; cv=none; b=IoaIa/Fb7XxQGU9RGysaEPMEVJ0uhevJwmvJU+1t1TVozyeahulvR3SPuYYgROxssMfQhLD6OqsWtgbYY0lTvOR4Um5DNsk61twdM4caPQfelOMVILVIfhwhkk0g3DKKhfZNT7301pib6Bnp3P5TCkajn+QYqqKffxJW0mNkA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746298091; c=relaxed/simple;
	bh=xlYQ163hDkhmgErY25mBm19wcr2Qj8fSb7MgLR0tv58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVQLEcIoBJ+3ZDSM3tMG+Z+Jgjlwr82UBme99zpSL6Rt2bKS81yAAd0KS/C/kxJMXG69rOEe3MSDR9PJmVwk3nReMhKeCjUd+UkgEpChEr00POR78jJmhSy1q4FGVJibdL6AuEGyxPubSCV0j3fGJcf4uGDStlEIPAoUt0gWTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d63Y/juU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b98acaadso3087059b3a.1;
        Sat, 03 May 2025 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746298089; x=1746902889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHcRbppvMSqwRwoxXB969N7KQ0/ugOZSO5ywUwJYXKs=;
        b=d63Y/juUi9Cm9PtHd4aF3DLVg8uT2BXdiPt+PM5JM6bfc2QALSvpvAwA9lVfqytjiT
         26eiMb6iJt+CureazS7PDvFU0FyW+kg2ui82bW7W0l+gseTCV0DHwbYYywJnlwNudx3e
         NpCOVo6cclcMHtvp/qIkcuqqnesJidzUaHMfuZO35UALSYsyAlRE4nGPiGLxdiWJy+99
         ehCsrzeFEIApCV+jBhE5TIxUJZ3fHOnAAGcsUbbsXh5D8idgtxmJH6jl3TjqOGvQVPzO
         Tukk4JaOML1cXO80SfATrBHf3yrMbP6k1xANtG+vtIKb38OAFTMM4AMygQC90tTZRfCE
         iFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746298089; x=1746902889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHcRbppvMSqwRwoxXB969N7KQ0/ugOZSO5ywUwJYXKs=;
        b=v7Ca7Ks/0fvaIyLDmcfbXg0ceh/1+RarYXkB58plrA9qfqy7w3xtlXJzdUprakJNCd
         I2cqXq/yitW+UqfSbw6hK9/P79AXPirEatO1w+8YUOq+RIYgdLSO1F5/Xu6y0Nuqd8Wm
         4hTf7WQamUWKPuX5p/QXBOzWYsbQZ2bXmWopUKBu8ERIT6wxqzKKk7alSFokVCerNv9K
         gzNW7GDwiJF8+YI+rnk1yx5B+vUxss7QXHzGL+/FQQKnq1SmdbgpaejMv1xwaCwnODBi
         QaJ3rlr+y2wMWa9z2EZenp8uJbADPEfnqVTSvNcf1H6mjozthsPNhrF0tEj9tkBU31Gt
         j0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV364Q+/WS6IuQBgCXbCXS4bSUhVIzcv/X0gTxvR5jf6c7iaPJ6wzIrnU5OqW8o4BvM1EIPvcmTuH9y@vger.kernel.org, AJvYcCVhZYSRB1eg+VVBPE2DgyKYYX5Cfsq0Sj7A9J6/vjWrDe1JmOUbttAqytwMk6AlTmLG9dAFmNIiSqXi@vger.kernel.org, AJvYcCWjuWD4SDItuywdMnO8sVyy16uu4CAyaMU+pLEb/aB0x1XIcatyaepsVeemBXhS2r7xiGwROQSQkaJjhxve@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+GUUzphC74aZGRUQVU9h6nb67tppm74azkR4BefybJw6kQEt
	u0iRNLi5K6MOpHFh2qxL0HzixewAm32oAYK54vhMJ8yhlf+3psMn2J0Mgw2rBMw=
X-Gm-Gg: ASbGncsS/aTh+GVKcxFhvow5ZbeJIxHqK9jSwwpQqxXcOdTrJA4nYROkgbj6aiY6oFG
	ZxZuYMdcQfWy8EH0MjdlfPkbVPELGhduG4Ka4H91s+AHfZ8zgZCBbrg1sU3zMjP09MNqwNT1QsL
	7UWum2COEQrF9owi/XzJI9miBLtUQNqi9vlTSRDIK3G+orgZdmmRG0DeSKhiCCdKnxaVzYgFOWx
	AATN5NLZPvR9gmdEGhxn55b2ksaDTZd3yTykSM6iLvAdCk2tywKKlHUTuZiJlZmIIjJXRArFvwv
	OJsgueV5W8NcP35LjvqyVS0+QsGLHIoVaKfwtwntURk/JNUCEO4Szg7K1fwm7gU=
X-Google-Smtp-Source: AGHT+IG2f1e9Py8jCTDXwkqqSY2yZJE6TllMJro+MRSjHOeE+mcN8PlGZPLKgZBKTD5cuy1QpjDSLQ==
X-Received: by 2002:a05:6a00:8087:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-7406729efa7mr5644475b3a.3.1746298089035;
        Sat, 03 May 2025 11:48:09 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059065223sm3761921b3a.141.2025.05.03.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 11:48:08 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: conor@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format conversion.
Date: Sat,  3 May 2025 15:44:12 -0300
Message-ID: <20250503184800.27026-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250430-folic-skittle-06b0ccbedf35@spud>
References: <20250430-folic-skittle-06b0ccbedf35@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Is 0 the default here or 1? "Single data conversion" sounds more like 1
> sample than 0, and the default of 0 is below the minimum of 1. What's
> going on there?

Good point, after I`ve submitted the patch I was double checking it and noticed 
that too. It`s stange because the public datasheet mentions "Programmable averaging of results 
from 1 (No averaging) up to 128". Meanwhile, the spear_adc.c driver at probe
stated the following:

	/*
	 * Optional avg_samples defaults to 0, resulting in single data
	 * conversion
	 */
	device_property_read_u32(dev, "average-samples", &st->avg_samples);

Since avg_samples is inside 

	struct spear_adc_state *st;

which is allocated with devm_iio_device_alloc() (which uses the kzalloc/zero filling the priv data):

	indio_dev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
	if (!indio_dev)
		return dev_err_probe(dev, -ENOMEM,
				     "failed allocating iio device\n");

	st = iio_priv(indio_dev);

...matches the driver comment meaning the default is actually "0", single data, but it does
not match the public datasheet in my understanding. Since I don`t have access to a more
detailed datasheet, I chose to describe "1" as a minimum value, but I agree it is weird.
Maybe we could drop the minimum constraint in this case (go with default and max)?
Tks and regards.

