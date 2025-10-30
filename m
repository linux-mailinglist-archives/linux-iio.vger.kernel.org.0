Return-Path: <linux-iio+bounces-25684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4414C2135E
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 781824E974B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DFD277C96;
	Thu, 30 Oct 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZoYAMV6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7D26A088
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842083; cv=none; b=LlomE8/vwybveYl2Hc49xcFigsx/lh8J5B7bmVjbDOorYsrPkrMF9sV91m8vPdZzSfhsRCL/9xppcyx1RA/eVznhPHXUo5rsj1M58m2bZbfsquC/rN8FoH3Gl54qbvbbxQMFCpEIBXRDtEz2WQMYoy/uELUORqLLx/7K/FoWFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842083; c=relaxed/simple;
	bh=49TrQUGUtrEr2yZhMBoKYVsIAJVY+BeJ0rODJ0UUTWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mprz4UVFmBr845xud7gC2JFDRAbP7+3PUYJU1V9i7H9Zk3LK10mtEma5twLcFzn5KTvjiUljat2wzkOP434KXSYhvcqYlHuYCjQP2jjS5nR5M+vj1qYNNcJO5/d+KfVIjJ41OuZYY7Y244whZrSM2GoAPdt7f5tRTKaiVaHxHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZoYAMV6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf1a95274so892985a12.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842081; x=1762446881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GemJnWb5rbunzFGiUAhg7eKB3QXcsT4ACvgb/nKBts=;
        b=QZoYAMV6azRsYI4wMMudbgzETPhyCF0uRFgnDj0kFCm6BbFRka0ARsNJ8jF1RWdhYL
         l8UCmeOlhwEA0ur39my95Pcv6um2mRoe1UG51/CVUOZmadDqZKtaSfsUeDyjiPhNUtLR
         6QMy9UJG2BW19AJ886nRyzTdX9mEsfyzEkUqTJOGtzN1KdpLUzjBrBzjfJyCIjGGYa4e
         FR17otrwGiMGLBF70OWq3PaAnZ8hF/TboHyMnfo4E70RJxITDV8sv2zgYvpxzBgksPTD
         /GM7woueWkZI1Eb399L0zwKUP1IIF+JwBI/UXpG5pfzB3Gs6NJqfJbyRFcfeBgPhMJsh
         FX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842081; x=1762446881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GemJnWb5rbunzFGiUAhg7eKB3QXcsT4ACvgb/nKBts=;
        b=gle9diVu7bnBpxaT5nG/zWxIWkfJGzVVq4TPxfbREFQ4fGX62JQLaRjfCAc8kv62N2
         Lt+lYF73Tph1zTdtag0lsEx26AW51N6CMBftzj2EEy0vaB6JcO3XSds+M8mlmQMk/zYa
         qA8Ks/jt3j6410hb2iOiSfpwb4j2zyZZcosNy6lmKI2Xoe5tqyUSomNB+t6e3E4sc1cS
         UcK783rMF2aAHuECwPncr5hkBff3wq+gO0KvtC0xCVLQaD2BnbqVrrpoegBZKqw+XvOj
         4hnFxiRzt4pRmnkhnNFSjIbAYYgWNY9MY8y1Dzxb3tSL8o9TKS8R54hRjPIpBRuBn+4l
         AKjw==
X-Gm-Message-State: AOJu0YzT6RrfUT6dJfCCiVAQedkkdNvACy4jcVyeOgmRTsLsupVocfYP
	IR+mm1zhSEX82QZRwZ+NRXa8ExKGc1jxTNB3+UM/2V7Rm9P9BeZ6ym04Tqsoj+jd7vY=
X-Gm-Gg: ASbGncvM3wFnhYeHl58AiA6tlZ/VP441nvg/GdSNqqAus5KWK1Jh/B5J0Qc56noq0rQ
	l9Zfbf9pBhFmpWWNW3q61au0qY0HNBbSNvy6se+CurfD8aXcYUJzehwEU+2jF1LnK/ZnxTjtk1x
	MSrEZTKXLarrrNein4H3Dw7YSZZnAXdN3pxJ4aerJMieNmBqm2Nixv+jLqhCcS1r5Ynp5Yno6W/
	xm7zIq9cgJib+CbbO1W+9RBd0mlozcBcNP1kbdmqfFW5Ea+7Qs6K/aTR7Ms8/iYT/hcZarnbfw+
	pVLkCJRM+VGXRzz2wzrDsknjNYrdvDKxfMLy82VZyKTSY0beoJ/NoP4FtNttyWeukRGSvsfxDMU
	p10epAhoMXBkximsBnnf+bdgAsAsvisav0U1ZjpXZqOU+HxOxJPkWONsdQf+dE8Lx7pexSO39Qf
	72kZyELvN9V9A0FEoV6llM4e8F3bQ/U6J6Vy+FBFEqu3WkONX7sCBDGjFRhIzKVoAeJ+RKQNMmB
	1WTkJqu1vojgt3I5uDFVMkgpT3BDBLq1CeCfOxfLfdOELQ=
X-Google-Smtp-Source: AGHT+IFhVPa23fECGvV4dUIAld5HM4HNjatO6IlpoUW53cLuqxeeqTXNZkPLMxgkK1m51ToYYLi7xQ==
X-Received: by 2002:a17:903:1111:b0:267:9931:dbfb with SMTP id d9443c01a7336-2951a526f47mr3589515ad.54.1761842080791;
        Thu, 30 Oct 2025 09:34:40 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:34:40 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
Date: Thu, 30 Oct 2025 22:04:08 +0530
Message-Id: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch series adds support for the Texas Instruments ADS1120,
a precision 16-bit delta-sigma ADC with SPI interface.

The driver provides:
- 4 single-ended voltage input channels
- Programmable gain amplifier (1 to 128)
- Configurable data rates (20 to 1000 SPS)
- Single-shot conversion mode

I'm looking for feedback on:
1. The implementation approach for single-shot conversions
2. Any other suggestions for improvement

Datasheet: https://www.ti.com/lit/gpn/ads1120

Ajith Anandhan (3):
  dt-bindings: iio: adc: Add TI ADS1120 binding
  iio: adc: Add support for TI ADS1120
  MAINTAINERS: Add entry for TI ADS1120 ADC driver

 .../bindings/iio/adc/ti,ads1120.yaml          |  50 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1120.c                  | 509 ++++++++++++++++++
 5 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
 create mode 100644 drivers/iio/adc/ti-ads1120.c

-- 
2.34.1


