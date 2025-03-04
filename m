Return-Path: <linux-iio+bounces-16364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33490A4E40C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D09719C3AEE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1C28D066;
	Tue,  4 Mar 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IqVBDmkA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B728D04F
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102058; cv=none; b=rLKoYffivQgATmY/bnOJwVYba/hTvAz6y1gkhNB6atzxol6+98MtFUgyQjceFTNik0QdDLHAolteKK/h9vQ+b2R433v/g+enwDTVsxmeosx6VwaBH/6qEFN7IHyucTrCclOKkBxOiAsntNPDzsz6unzIup5JPJl2QR75Dw5xrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102058; c=relaxed/simple;
	bh=uuQKh3mKy6W10Rx5aVL8Bxq79MzsKeJfW6stjMAKKC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klXG2OK9dgWX7uzB0is0QY9S6GqF8Er9QGw3wg9LTg7FOrpRYak0EcslITozP0Y5V/iUKXbmeWrYUGkf2KwsgIB31+G/DSUkJDrEsF4eAdq7pZW8YGK5WoJhZPKPzjKzvpLJf6XFQGwBZ/v2SeRZlag6pQGCC9v7ExvkKGepqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IqVBDmkA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso62304585e9.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741102055; x=1741706855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oa/LjsLwWuUnAPX0dIe4E63CiyKqmPE+fmfAuxCt00=;
        b=IqVBDmkAihvX59kShKSuCPwosZfRAMCU6ok931WXCJc/JeCzdl8J1hdPY/dTiJ81O/
         /ROhJIBi5TiaXbE8QJS6HWC7ZWG7iD7vkeloVe8yUfNn04riYjgjmh2hH5cW4zE0NMqC
         E/0YKZgnP24yX9xhkmvkYwNX2Hra3ot6YTW4gMw8uSdEuCOiYiwVR6/dQxRuO0oBZl06
         P7hPTMIxHzU/ruaVkvb16bBKgym/eBnwqmm/jJ3Xohhho4wETHKX3xewcCeaPnU2Nckr
         KQmJXrg28INF7D9JNMTUkq9T6nDbRpvcafcNRKyT2KVpe7zxqYkDpaQFOqQsDmWGJIoK
         1uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102055; x=1741706855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oa/LjsLwWuUnAPX0dIe4E63CiyKqmPE+fmfAuxCt00=;
        b=kIzrJqeYpmxbwFUGZWwRJemZ2brLJ6BWrNy8b4INMXz2b42YkTf+o5KGPkcFGVwoxE
         JHegEAgf11lKGMIjynAZsDfK6GjzYSBbMTa5YqZTzEK4zeOrRuoRfAv35LGpp8mupDRy
         a8JsJqGsumzFmv3da7/6FpfMhX/5F2EC6hj5pFeYBpNkYgFQRY20+zTj5mpzXB+1tVaS
         jnZWiVfrAkk61WY6n2tdqEtSeOuwef7IRWGkN4gZ4uuVvjGl/QTKcgd3hKyIrqjYT+pD
         0JHP4V+AhASIv1i3e3sMTH3T/ISTndONZgN49UxYyNOtZjio2dH4auCXJGXYYKi41LcO
         yZ2g==
X-Gm-Message-State: AOJu0YzC9RV49K8b6ByS0tbXOFYvnc3OvbJwxwKyutLawSqokGgue+EO
	ZcrePm9VghpHWHh7ssazIKBlyFp6lzsYpTSE8Wz5XDDIQ3duTNCrhgue7wWabPw=
X-Gm-Gg: ASbGncvICOS1yIy5R9WbqQlTkorYWwT5nC4Jiv7dzt3s43m/YS2ca9qAgP/WaMfDqjH
	Y5RTI7PodvtL/rZsfsJoyTz1GJNruTOVedR2Xyv4Tj875dQ5YwTBrQVeFd5Fz/3hccz14D1B0Ze
	Myi/DQY0pCD7ml4eX2pabOrCmKacAmkhcrtXvRYNn37mGfELsw7BvEwT0NeukUtWkKB3CjPUvAC
	cmWXv1Mct3T3Z3qHaRYwKKH0sfLyswQANwoBg6EA6aTLtae+LRdCmwXSeK4+mdYSzKwX3EIpGIj
	sxwePODRBC36xufZ+Oi7IJyUKdJ8/TO3oBcObm1bV/BqZ/tSAOxzc8jzJ9GjfsbjWvdLVj4fN16
	ZBf/Ps/0ahce7aBkHesJMyqiBWGU/002BDg==
X-Google-Smtp-Source: AGHT+IHyqFt3+P6QFQ7++XK+TXtEDjynFjltHEGg53g+W1SS5peidJaNiu6oFmUx9mlZeW4OoWsj7A==
X-Received: by 2002:a05:600c:46ce:b0:43b:cf12:2ca6 with SMTP id 5b1f17b1804b1-43bcf122e47mr14088885e9.1.1741102053546;
        Tue, 04 Mar 2025 07:27:33 -0800 (PST)
Received: from [10.2.5.157] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm18245580f8f.55.2025.03.04.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:27:33 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Tue, 04 Mar 2025 16:25:45 +0100
Subject: [PATCH v3 2/2] docs: iio: ad7380: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-wip-bl-spi-offload-ad7380-v3-2-2d830f863bd1@baylibre.com>
References: <20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com>
In-Reply-To: <20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad7380 driver.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/iio/ad7380.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index cff688bcc2d9601a9faf42d5e9c217486639ca66..12709ce051110e68b6f0c9b9a0baefcc954f2bc0 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -169,6 +169,42 @@ gain is selectable from device tree using the ``adi,gain-milli`` property.
 Refer to the typical connection diagrams section of the datasheet for pin
 wiring.
 
+
+SPI offload support
+-------------------
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
+
+When SPI offload is being used, some attributes will be different.
+
+* ``in_voltage-voltage_sampling_frequency`` attribute is added for setting the
+  sample rate.
+* ``in_voltage-voltage_sampling_frequency_available`` attribute is added for
+  querying the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``buffer0/in_voltage0-voltage1_type`` and the
+  ``buffer0/in_voltage2-voltage3_type`` attributes.
+
+Effective sample rate for buffered reads
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Using SPI offload, the PWM generator drives the starting of the conversion by
+executing the pre-recorded SPI transfer at each PWM cycle, asserting CS and
+reading the previous available sample values for all channels.
+Default sample rate is set to a quite low frequency, to allow oversampling x32,
+user is then responsible to adjust ``in_voltage-voltage_sampling_frequency`` for
+the specific case.
+
+For single-ended chips where 2 banks of simultaneous inputs are available, as
+ad7386, ad7387 and ad7388, if at least one channel from each bank is enabled in
+a buffered read, the effective sample rate will be 1/2 of what is set as
+``in_voltage-voltage_sampling_frequency``, this because a separate conversion
+needs to be done for each bank.
+
 Unimplemented features
 ----------------------
 

-- 
2.48.1


