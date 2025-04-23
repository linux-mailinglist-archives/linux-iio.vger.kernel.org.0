Return-Path: <linux-iio+bounces-18578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C90A998B9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 21:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548583A319D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929C6293461;
	Wed, 23 Apr 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVNkhne9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AC29345C;
	Wed, 23 Apr 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437283; cv=none; b=L7xTqEPKDSQdfBr+b24B5fJoUClczzqSNrJ2aIUBWZ7UJt2R8T7Fs99H53yKPI813lS5t8sps//2e9CEejAOelVdEUg1g3Adp/rNKelIW+nPkc15XBqtZXahNF/+RkiS3nVck/A32T7yH7BlBKdTPIoSe8N0WzEEDd1lMxThfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437283; c=relaxed/simple;
	bh=4ZV3d40Tm2XO7zzcQysTMEbYDsjmMsuy4HuaEpq06/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQHLn8Dqn4j4xSg9ryr6Vv/BaDNWQ28z8FHc2HR5Ax+Kvbc6LG6/pdJLS278FNg5O21PzBouuBktu3l6p0SyqjgpOSMCFdDDBRziP86ncH3cwvUP6L7zDlZNac0GLnzEdr/Nok4/w/KhUkbAmdvwnSTMlAZFgxVpU22mlmdRS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVNkhne9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7394945d37eso140445b3a.3;
        Wed, 23 Apr 2025 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437281; x=1746042081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qN25pkP6mffuqxE858xvdxtS7Gg0hgWnr4F6+fvq5Ss=;
        b=CVNkhne9TWNNwU28ArWxh+umzF8YmaSKIpVQ3t7h4xjKLbMKWAYjgUW34h/DwpHLJN
         izMNsW/PyhAhM+bpsNgmzDZHgAMzNNjfw5Suh2KH4YCro6H5YTkIqt24Zgpsz5bURZx5
         ByZlPgWefD7WF/V3nUFsHB6CN6SfAo7sXYlIX2l+266v+WPWB5mYLuRs7eboHgJ0VJ76
         3iOQuJu7YxOl4ZtNaRoj5/VI/p35C+RDRdQTDfY1AeORpA4QsIXeUxCzKIr7+aacH1Ra
         WgAI34odAdFMw5kJ8VKbt2dbFFa+fP761TS17y9x9m7q/dl5e+a7yEm1/6XdckSGhNe8
         zWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437281; x=1746042081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN25pkP6mffuqxE858xvdxtS7Gg0hgWnr4F6+fvq5Ss=;
        b=SFs0HnxNzg/AvPhmBQLmL3t/MAKGz6qqKHe9nt9OLo1PV0T+9IsxEHa/tbMRf9L8Rp
         i0JSOFJPJobMrYT4vT60yfXv04xpuYpIphI5cBJo4Mf20ETOh5L9kSqE5L0pJP90LPHF
         fMX20N1FJVL0md6nslqmaM7Flds528S8UyZwH/p7weFJpPiVTNVOsFAb3e8PXcMTwNji
         3/0aqiz0GhsUahnCuPgv45EyI0X++tewBMs1BRUYGWaEZ8D5wEOnRuXK7K/LNndEBiSH
         DQWxZeifC9SI/yEmK6ziQ7P8iyB5TECKpxkxpp2HKXbm3WRPqRLpUPzvI71OG8Iv85RW
         8/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU2E0nN7AT5mhHpE/V32oywopqhGgMrgD3HqbGL1Px884Xi9zGmowMileoch7yklp0pglGFFJ9zwSmP@vger.kernel.org, AJvYcCXqB730f/18N9d0opj30Hr7rA+lNRZpmnwhlQudrRPrA3r8b/VcwGmwuoCQmtimPygQ+2J8Pv1P4KTI@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxCE5dbnP5cm6FUlmxE0Kj/OXQhkKwwHF3k6xHouFXJ+NBzEV
	nnYPQ/saFOyWQkizajrvhpMtNne8qxKweszN6v4EoLDdkxGkbtel
X-Gm-Gg: ASbGncumq5xTDR81t4x9+d53Zf6sAkWuuSKYbxLbFuQu97HdYnKQoziaLyZdWC4Ughy
	SQ/4j22kZQIznxUt4Hqlh4r3xUNTk+98cWMa3/vfhykvwceOGESUOYACCmdMCXOgxS5bylBElNR
	rx09i6skPTDiA93JXDrq8ALt/FPrlB8LYAvZizAPefTff7Uj8nYvM2au/+ZPVYbZauHyCy1/LLs
	6MJOkxA59b/ew9vGXTcS2dz4G6A5VYbQbNX1Uv615ZGoGjw6QJtQDlgAW9+7dYRy4YhVo0sbUXF
	FdVSOoEGsHwvJF744pMvH7SZCvNHzYi4iWx/of5KwIinpr4=
X-Google-Smtp-Source: AGHT+IFv7zGHei0JQq6iDL3V23Ai2or2hL+gS3fdepXRhLhuiFYhDlkG3RUeWszyCO6pLmyD4Py98Q==
X-Received: by 2002:a05:6a21:8cc3:b0:1f5:8cdb:2771 with SMTP id adf61e73a8af0-203cbc524fcmr31501181637.14.1745437281091;
        Wed, 23 Apr 2025 12:41:21 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf6a2dbesm10938291b3a.0.2025.04.23.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:20 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v6 0/4] Add support for Winsen MHZ19B CO2 sensor
Date: Thu, 24 Apr 2025 04:40:56 +0900
Message-Id: <20250423194100.53934-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6:
 - Replace magic numbers with named constants.

v5:
 - Include the required headers explicitly.
 - Fix coding style overall.

v4:
 - Ensure buffer is aligned to the cacheline.
 - Fix coding style overall.

v3:
 - Add vin supply regulator.
 - Drop custom ABI.
 - Drop unnecessary mutex.

v2:
 - Add ABI doc.
 - Add complete struct to receive UART transmission successfully.
 - Add undersigned as a maintainer for the WINSEN MHZ19B.
 - Modify to comply with the IIO subsystem ABI as much as possible.
 - Revise the coding style overall.

Gyeyoung Baek (4):
  dt-bindings: add winsen to the vendor prefixes
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  iio: chemical: add support for Winsen MHZ19B CO2 sensor
  MAINTAINERS: Add WINSEN MHZ19B

 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  33 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 316 ++++++++++++++++++
 6 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

--
2.34.1


