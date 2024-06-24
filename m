Return-Path: <linux-iio+bounces-6826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91665915561
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C49E281214
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419819EEC6;
	Mon, 24 Jun 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VHGrcv9C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE2FC08
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250276; cv=none; b=TV7v+LrvCXLR3WgrJmzozxDFOXv2aQG4n5O6RFAerclu6f4zSUkoa3533JJYfPBFJLLAcl28zcjCEGvvGYwx3A6uoRIr4ruMnZTTP1THXvawChbcEalugxsKJKaidrSsRIAH7xoDga7WyAuPmLj0ZV+ZMXVwnpwpkYaTpOGrVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250276; c=relaxed/simple;
	bh=mI5kS1HCJJ7WW1Oy+YtN1Y3anfqpSihlvEVZxueVrhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYkIeRmk/Qsv+Tc835B6/HTQq3OfGhNf2hAVrcP9RlAwNVTx9EfIfURMhMhmSk7g7Pxe1bYk2kpGuEYt4tyBLWb4u7RrJudcALyDGQxydK9WGrYaOZvsxns+fPZhGvwccF9/fmBiIRZ4bFbLQDKevJGk9AyEHjcac59CP6gi38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VHGrcv9C; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295eb47b48so5398092e87.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719250272; x=1719855072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPcbUebpH9a97qWXq4TA9VXjoMaci8v0q9yhJMVEHEc=;
        b=VHGrcv9CT0cp+StcHUnLhVrPiqAwLhYifZ9sX/NnwIUEYIMWPCHaxmmX0e9TgvOwjj
         66u6CdY8q5/mNLKubvSNHh1kur9LOLw5cVByXgh4AfiptScyGKXDZS/tgZj1Lk/+Z/lO
         /RD5V9ZY/cmelqaQxuJubN4j80uCVVXGyu1OeZ4WIfIDZuScHX7u95RHh+vv9HszeDjL
         BkxgeYm4TqVxgfnfgWcW76gF6X14rlTv10qqK7fRwEPUFY5mSL8iTFgkMNNEEEFkkZsD
         8LksNVC+dM/8HZ7wqDD8IyZDJ5BGmPSYNSiV35pV+kIPIodC50/Wl6kUZSGqY0cvZ4Z/
         u8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250272; x=1719855072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPcbUebpH9a97qWXq4TA9VXjoMaci8v0q9yhJMVEHEc=;
        b=clwVCFQ3ShByA6tU8qXXralrDCkTSUJ+UpuUgsOG6/+PQlZ3I2GzxRjVAupODTKDlE
         N4a8OkOjwR/ZzyH8KzvYaRtGYVnaPFWK1bZWDcd3ybjFXp4SfWxf1HZKbyJE00jhvfMw
         /CaYVAIeYzDr7Mo7s34jkbkMs/a+MbHKcKyYdiIfzMmewujxnUajW1nhKT7HN19mqeE7
         ZceOkLZjyx0PTKpud9io98mp5c+UmRABBN7oG+aSitdR5ZQyFAImrEA03iK2kX44WhaP
         XTOuucoWFErLIMPhdM4pG3c0XeJ1RcChrAsqXQxUK02/7l9osYzkOHq1H9jAdYzqQasE
         abYg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9qka/TJnou0v09JBY2vpRE/fEoPK0FzyO1yaCAu+0obl4GtDeQh5wCgyFyQnPw8/LLI+jqoHu6UHhNRS5/CicM4r5WTHboY5
X-Gm-Message-State: AOJu0YwNccuOCeH5nMzu2vfDgJ2rc0VB0zS2q5SXDWF/TM+1OSupKNU2
	lbB4aVkQ0c6EdC01pX2Bx6xpeX8nSVhz5KLTqa0X/7yoP1cdOo8V8yFw/HLeWY4=
X-Google-Smtp-Source: AGHT+IEE048c9lMdvxS1C2GH7HGqg2NC8yP2EE4vRfM+rV8ty+EL0J/9Kf/sLSBChaan4EUIwSKmjw==
X-Received: by 2002:a05:6512:6c3:b0:52c:83c2:9670 with SMTP id 2adb3069b0e04-52ce0646e8bmr4645039e87.69.1719250271980;
        Mon, 24 Jun 2024 10:31:11 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e4ee:e6f8:8fcc:a63b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d210ff9sm183742385e9.39.2024.06.24.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:31:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock measure
Date: Mon, 24 Jun 2024 19:31:01 +0200
Message-ID: <20240624173105.909554-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add support for the HW found in most Amlogic SoC dedicated to measure
system clocks.

This drivers aims to replace the one found in
drivers/soc/amlogic/meson-clk-measure.c with following improvements:

* Access to the measurements through the IIO API:
  Easier re-use of the results in userspace and other drivers
* Controllable scale with raw measurements
* Higher precision with processed measurements

Jerome Brunet (2):
  dt-bindings: iio: frequency: add clock measure support
  iio: frequency: add amlogic clock measure support

 .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
 drivers/iio/frequency/Kconfig                 |  15 +
 drivers/iio/frequency/Makefile                |   1 +
 drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
 4 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
 create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c

-- 
2.43.0


