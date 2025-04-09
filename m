Return-Path: <linux-iio+bounces-17890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA756A82EE4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 20:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6A28A10EE
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C19278164;
	Wed,  9 Apr 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GXobtWZc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F512777F8
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223871; cv=none; b=P7NS4KhgcZWTRnRFiSVMK7yZQSu9t2YN+Emew2u86vHOfNcn7J27neWD3xZNckv5um7XROfoPmBT6EEuRo82SSUvZh90M9lwumgWN6fl6YtW9TazOLQZ6/sEpwaevYpiCbPLICc9Kw0Drlzo5r8y8wY10L7f909rJXC7g+2u6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223871; c=relaxed/simple;
	bh=zw417uR/ZWpcv9nH6L2TpojUTO4ryvZX0k+0vL2w1xM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dmSUJU0n6sFgmVFWvmAuI+/lY1pczHBeFhx+TdGx8rUcRJ3v3TsjbV9x+xgX7lJtxqaOlhwDmcshw8gDkjzeB33xYeUuPINa8YDp1cVwur6B4J54MnTCklgzvnBw3fi/5jorLhWBbxMV9hYd+Jvvhrw/8pGmfS1NjTSSnNVRzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GXobtWZc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso5167122f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744223867; x=1744828667; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7+A0za0sFmFx7AkTuxe+2GzgkkZttHX0FrNzkbasno=;
        b=GXobtWZc5DqNE4jiZl5Z7FjpCTPRWXS5wM/7d63RQ2+3DmvF+3YENyB2PxxecG14Ug
         Vqc34ZveTpCEEmrpmmLnWms3DrGziRFGtMnuqkXOaO3v94zUVaeTtZBwd1t5OeuRZpfJ
         O5wY7IhAhHLGVFzFNN5L12LheN89A1qCxtIubS99aJ9uPYgOGhr7Dsz8T8pSxjehnX5l
         GLeTUe34rBa60nG0C6G2F7n7Furc+ZOAXjOu8TgFg8nQ+/sALDODq2MpYECcb6tVDFnB
         bTEPrklAEMA6zcRoZag+PRYiYAPIW5pUWbdOebJiqfyOiju+vkWDBc7ePLer0Hfcv01Y
         N7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223867; x=1744828667;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7+A0za0sFmFx7AkTuxe+2GzgkkZttHX0FrNzkbasno=;
        b=dSy+Pg/bBL6rzxGan1CpAfZuelbE4bVRSOjY9ioUjFm6biO26KnPMSCTn1ZZgBm8k4
         koWNuLzzKbUg6OHSZ10IVbCIRTlKnDIzkBR4wqkCDQkgwlhTGDEuIVRWnIKxNzIluv3U
         YScnuzq5VaHB/TIoV6GVUSvuSgc7nc7bwbkQdVCKjtq4eiEL+Y6gTYiPbS+HAGKk2Czp
         RfhH+m/4lOpiOhwmSYtBchq96wEnREy7Z2NcmX6uEbl1o6yvIXOLaRB5KKGwNkbeo9yS
         pubkbvSeixfgRcyDmUaFTTqAQSd1yrehoJtdrJytpVAw2tLnDznn/zlw2PHG8yEqj/yL
         TfCA==
X-Gm-Message-State: AOJu0YweCwKOtiGQzF74sHbgRF2/WVcu5I7bA7wmegQPqBSWrvijRhe5
	7YuseJ/Lwg3pFErlHzBT6+NxlcJInc6gJHP012mQ56M9gky8zyR0kRprQwLoMeQ=
X-Gm-Gg: ASbGncsi31/jWFSkyT7zNiLWkbcmizmYbd0DbiDxs7XNDQqH2+UuOlsf24fducrJbHw
	dsDOUpssmVgo17XnyblcnIAIO5ViZqUo8gUtuXtDXIK07oI0EdhoLhnTJj+P/D8sNep/DgjF/Pc
	U6MpzWGzsexlLosxWzD6LRD6AlmfnUhNZ8VH8IIKoFrm04XNV6ouuGfHeSDA74oyWYfu343USi5
	EXIvTnoBqxDHRs1M5Kz0FT0pd3Kxo42fbFI7iSwdurYBxZtpO/UatHFBwJKh1Ma1zAcDbN9Exbl
	3dCvjDaL5fmUa/lUrTtbJM50g23WnnIKYVrlwWMj6qn03/Djv+MQa1FErwksnrm+bSQJBPeIgcl
	mUJ+ISMOr6yw/UMCS2w==
X-Google-Smtp-Source: AGHT+IEJsqcJmVgasORGJqpFYYzOUjgvY2GAmC+cFwr5JpPolHFNGVoVVY6og+kibacxCLtAZbLBvQ==
X-Received: by 2002:a05:6000:2c3:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-39d87aa8425mr3135813f8f.1.1744223866923;
        Wed, 09 Apr 2025 11:37:46 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938a808sm2380893f8f.53.2025.04.09.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:37:46 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v5 0/5] iio: ad3552r-hs: add support for internal ramp
 generator
Date: Wed, 09 Apr 2025 20:36:27 +0200
Message-Id: <20250409-wip-bl-ad3552r-fixes-v5-0-fb429c3a6515@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACu+9mcC/4XNTW7CMBAF4Ksgr+tq7BnbCaveA3XhnwEsURLZV
 ShCuTuGDagiYvne6H1zEZVL5irWq4soPOWah2ML5mMl4t4fdyxzallo0AZQK3nKowwH6RMao4v
 c5j+ukjx2tieKyoFo07Hw/dCWm++W97n+DuV8/zKpW/sGnJQEiVF5r6lPyuJX8OdDDoU/4/Ajb
 uaknxxccnRzYuIUCIF6xy8cfDgEbsHB5ljVOQJrgoXtC4eenW7BoeYExAjaUkiu++fM83wFtLh
 CcJMBAAA=
X-Change-ID: 20250321-wip-bl-ad3552r-fixes-4a386944c170
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=zw417uR/ZWpcv9nH6L2TpojUTO4ryvZX0k+0vL2w1xM=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/tk83Y5tM1vtJj/KWb4jcUJzn/2zvxp4gz9Wp18++d
 7x66e5njo5SFgYxLgZZMUWWusQIk9DboVLKCxhnw8xhZQIZwsDFKQATKXvF8N/vDVvrX85d1dmf
 pdac6/m28Az/gWlbc84rMJ5Pepyz68QlRobbQn4HoooXJv03/WRsEjx1744blWk8EVHry9tO317
 ydR03AA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add support to enable the HDL IP core internal ramp generator,
actually managed by the adi-axi-dac backend. 

It works this way:

/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage0_en 
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage1_en                                           
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/enable 

Activating ramp generator:

/sys/kernel/debug/iio/iio:device0# echo -n backend-ramp-generator > data_source

Deactivating:

/sys/kernel/debug/iio/iio:device0# echo -n iio-buffer > data_source

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v5:
- remove kmalloc, use a small buffer in the stack,
- change debugfs data_source names.
- Link to v4: https://lore.kernel.org/r/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com

Changes in v4:
- set data source based on hw channels available (model_data),
- use a string array for data_source debugfs attribute,
- modify debugfs accessors to use the string array,
- add new "data_source_available" debugfs attr,
- fix documentation accordingly.
- Link to v3: https://lore.kernel.org/r/20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com

Changes in v3:
- add mutex description,
- use devm_mutex_init and check for return value.
- Link to v2: https://lore.kernel.org/r/20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com

Changes in v2:
- doc, add few words for generic spi driver version,
- axi-dac, add a separate patch to check cntrl chan validity,
- axi-dac, return EIO on a wrong source on get, 
- add a lock on debugfs file access,
- use const strings and strlen on file access.
- Link to v1: https://lore.kernel.org/r/20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com

---
Angelo Dureghello (5):
      iio: dac: adi-axi-dac: add cntrl chan check
      docs: iio: add documentation for ad3552r driver
      iio: backend: add support for data source get
      iio: dac: adi-axi-dac: add data source get
      iio: dac: ad3552r-hs: add support for internal ramp

 Documentation/iio/ad3552r.rst      |  73 +++++++++++++++++
 Documentation/iio/index.rst        |   1 +
 MAINTAINERS                        |   1 +
 drivers/iio/dac/ad3552r-hs.c       | 162 +++++++++++++++++++++++++++++++++++--
 drivers/iio/dac/adi-axi-dac.c      |  54 +++++++++++++
 drivers/iio/industrialio-backend.c |  28 +++++++
 include/linux/iio/backend.h        |   5 ++
 7 files changed, 318 insertions(+), 6 deletions(-)
---
base-commit: 3677b089b9739b69c8e1c1eb99092230cbcf741f
change-id: 20250321-wip-bl-ad3552r-fixes-4a386944c170

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


