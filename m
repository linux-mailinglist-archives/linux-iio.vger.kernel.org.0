Return-Path: <linux-iio+bounces-625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A6804C76
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 09:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370851C20B72
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F653C47C;
	Tue,  5 Dec 2023 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+h72PDl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188BAC0
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 00:33:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00c200782dso730319866b.1
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2023 00:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765236; x=1702370036; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRNDIe/KBmdwiEFebmgnyZjwbE9oVYUOUNfWvCDZb28=;
        b=c+h72PDl1sfvuX0WdG4vHMehwjOcD6dbcQOCEeoOxLx9ZQ2vH1Hma+iny4FMw8jxAh
         mc8U6Qn2ifg4J7k8+zl+PLs2UKxM3hg9Qh9U7M19PQOAxS6heeh0vy5mQ3QCUZDlpOSE
         YrPpTNFTzp4+lJixRiEDjwHiidWTmD9isTIWNNjrQkQ93M4z4+ePkiutdK2I5yuMO2qW
         S3qn+cWHyS7QSZkLk/ydC7zBqpigW7l9rB1sobqRJWRA9WLgtKeWB3Owazn50om8qCnB
         QGlRdKw2nfwdiSlhVrw9BBmDn95+3Zyl5Ibfr4K7DzKr1zIHcA+xNXpL4plA2c+NY+Ax
         pNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765236; x=1702370036;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRNDIe/KBmdwiEFebmgnyZjwbE9oVYUOUNfWvCDZb28=;
        b=a5kGJjLOLNiy3bR6CVjaU6BctI/BNoi6Qn3sn7z1OGpWitXBpVSEcx1BA4Vsmsa93/
         lnKadVj4Y3ZYX0eQi/tE8VAMUeoemWdTkXmjoIYRebrTksC2U4Squ41iFuYmFd56snYL
         QuQ4x7UGx7JtPiPg+fDiWSkcKHSmNj4OTnF7ImOEvQAhbCo7eMIE8dSYCeoDcUIfKKIz
         LwjQGCCeW9PQOLqs1fmGF5ud9Lkwb39aaYSaNMa7Zckd/qTEl+HXGF8QZkxAf5SsPj7B
         wJbRFTN20JlsnQMXIcjX42DJ/UARRtHUvk79G+xG/G0oVQFBdbywNDDRSk31peoKMfYp
         4cRg==
X-Gm-Message-State: AOJu0YwVS9j+OLWUiO1M8l5NYxc7i/sFnhO49C0ehX5Kxp/ejYr8en8u
	Hr1EK185Lb7V8ubQLNlzU5k8v0pRbKw=
X-Google-Smtp-Source: AGHT+IHHIuTA4Jeyt1dS3i64pMG30AFxQod2LgAPYFAc+6LYdF4X/mUKRjCo8hPrJdnCRSmVuN/dug==
X-Received: by 2002:a17:906:109e:b0:a1a:e070:49d9 with SMTP id u30-20020a170906109e00b00a1ae07049d9mr1576659eju.228.1701765235680;
        Tue, 05 Dec 2023 00:33:55 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7143-f865-4a98-8091.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7143:f865:4a98:8091])
        by smtp.gmail.com with ESMTPSA id oz23-20020a170906cd1700b00a0ad10b3f68sm6253853ejb.205.2023.12.05.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:33:55 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] iio: humidity: Add driver for TI HDC302x humidity
 sensors
Date: Tue, 05 Dec 2023 09:33:51 +0100
Message-Id: <20231130-hdc302x-v2-0-72f765c0f1e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/gbmUC/2WNyw6CMBBFf4XM2ppOGwy48j8Miz5GOgkU0yrBk
 P67la3Lc3Jz7g6ZElOGa7NDopUzL7GCOjXggokjCfaVQUmlEbUUwTst1Sba3namdxqVlVDX1mQ
 SNpnoQt3H9zRV+Uz04O3I34fKgfNrSZ/jbcWf/Q+vKKTAi+5b8h47r2/jbHg6u2WGoZTyBc6XX
 I2zAAAA
To: Li peiyu <579lpy@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701765234; l=1581;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=nQIwo0Ix8N/C4bwUZ/TzK3wgkYiW+Tsffjez5kcbxsI=;
 b=0aXwIPeeCpDfBiOzZBAHw+VVvCecXVnJImng2nZM9lzqec8UBUtbEjGR13q7dg+eHBR73ZF+T
 hQYbp9O0qnqCCMTdSi7i/rl+gWyyZMx35mFJWd/OmUdj7Au3YlmfjMx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Updated version of my modifications. From my side the series is ready
for a new version to send upstream.

Feel free to add any improvements or discuss any of my modifications.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Drop IIO_CHAN_INFO_PEAK_SCALE. It was discussed with Jonathan Cameron
  and this modifier will only be required if its value overrides the
  _SCALE value.
- Document the new _TROUGH modifier.
- Fix heater configuration order: config value and then enable.

---
Javier Carrasco (2):
      iio: core: introduce trough modifier for minimum values
      iio: ABI: document temperature and humidity peak/trough raw attributes

Li peiyu (2):
      dt-bindings: iio: humidity: Add TI HDC302x support
      iio: humidity: Add driver for TI HDC302x humidity sensors

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
 .../bindings/iio/humidity/ti,hdc3020.yaml          |  55 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/humidity/Kconfig                       |  12 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc3020.c                     | 468 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 8 files changed, 558 insertions(+), 1 deletion(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231130-hdc302x-59b8a9c312b0

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


