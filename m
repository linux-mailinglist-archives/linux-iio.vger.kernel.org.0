Return-Path: <linux-iio+bounces-10309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA397993858
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E91F22C5F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3211DE4F4;
	Mon,  7 Oct 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/nxH7lP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D16320F;
	Mon,  7 Oct 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333416; cv=none; b=Kt3eNWTpxcbpyZjvZfsMrcetbKd8UTrfXmOw4I0pzsNIvpCFFptY+iV/lJU0jDIEQN5jWuAPE62TpIf/PQ2yyeSxND60hoe8GkknggToY3LwR2thssmKkTYnAHkkLRJyBIGpXFns66PelCztQMIQf/bEXZ/uTWFk4UTFcGcZLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333416; c=relaxed/simple;
	bh=ow9NioT5w3FxuoOvHqYRz2hyT9/a1YQqOexCD7IhW0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YWCJ8jj8cW1I7QaR3C4Ic8cuCNXO+O+0HEUtf7X7g/aVtSsWo9b1YZmoulTX2REGuV5IiCgQmZlXj8Fcf7AJzcj4eeQoKNemRNMhvTx8V5vjPJ0tnpPF9YY964d5sxm+t/KwakLtsh7xgT5RiSDDpwiSgJEgpKx8+dl6ysJyeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/nxH7lP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so50185785e9.3;
        Mon, 07 Oct 2024 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728333413; x=1728938213; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pgVf/25SpCcPbO1erYr4STgtbMAkebYdtOeFGq+eUGA=;
        b=C/nxH7lPW8XiWD5VuqEqLaX0TkGjEDpTgdjt+eJp0JEpHXCCkYxEUEqbrO4gIxwyBv
         1VSxoXNLsgeOzlTNVQDGnflIDtaqGrNy5MS1Z5OBYb15mb+sZefVaiaLF1JTDsyc+u2m
         VgYsXQXkpZRSaE0BP6Ovf9G0Ae7d6Q6YRtJbtrf0LvNJo5tdlKApO8BAdkDYDi4OLaX+
         Qd3RSG88i92idXQCrY52Exg2Cws026jP1sA9/wYI1PO2aSwlqSLgh2yllxUNR8KyCxNC
         ac+UgOkILbNc5S44dQ2lmzvhhZTwj3zWb2W7v1EpBy6ijhMu6x7cYhkJ4Z/tSCvLFipm
         pQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333413; x=1728938213;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgVf/25SpCcPbO1erYr4STgtbMAkebYdtOeFGq+eUGA=;
        b=PLgp17dGzG0QBRyB1Md6ObU4i5xG5xy8p0EVUL5rH7YMSfpyddbk+IbUEgmacUgWIm
         68I36c5eTtE4IbMzSo6xDThJXXSZarPuvlRPItWxPJtNrgT0hZ3hR6T9q5d1BdFSTRIf
         pHr26oImy96dO2hCY6kmb/WSZgmYR+qiP9vS/nUIQIB0su0wFu+9kAviZjBm0B0OM9Ww
         IG/6WSEGH5/BAbW/dUaVsnoBjCA55wUUcaIOzmLjEGOp5jJnhYl1p/SboxnREde7gl/i
         oVcSe2sfUwENU0X5nY2eFvYeP+6jGBJxvYY+dCCsaD2s+O5U3Hsq9srl7WIYNREcz6Rv
         rsNw==
X-Forwarded-Encrypted: i=1; AJvYcCU9UJANlkGoxOVgjtc9bO7U7su6mAMtw9BQepvXSsPXV61GRBKQ1ErblPvGXQPSlWkW3z3+nqSTSVs7@vger.kernel.org, AJvYcCW89aNXezHg27tp3xtfTG9UO6S14kqKVNrKuAEz+3crEniX2eCERg7lL5Ja+FylzqD2fxr51m3gTGNuRxKU@vger.kernel.org, AJvYcCXT6Djjg+//fC8Nx8fjPK1otWP4uphoIkXDX1IzE5baAY7PLy4Ju+1PHpw5atNBFtNeBVRcR4jMsXHC@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIMThLAddu+sUjIGnxfTU8w7YR1p0QE2CKZIUWVOi/KQD6BNf
	Hw4AoR0FY8gHOXp+sRTlDvsSzz9PXPIkx14apwIs4mPKMZQSY3i+
X-Google-Smtp-Source: AGHT+IFebJB9AVFtdGZGbmdzTsl0otcRga3Um93PQ7pkbPTHaPktZ5vUPN29PVCYq6nApctt3WbXcw==
X-Received: by 2002:a5d:4491:0:b0:37c:d027:d92e with SMTP id ffacd0b85a97d-37d0e772854mr6220359f8f.25.1728333412675;
        Mon, 07 Oct 2024 13:36:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f75bsm6464315f8f.23.2024.10.07.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:36:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] iio: light: veml6030: add support for veml7700
Date: Mon, 07 Oct 2024 22:36:35 +0200
Message-Id: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFNGBGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNz3bLU3BxzcwMDXQvjNFOT5DRLEyMzIyWg8oKi1LTMCrBR0bG1tQC
 HnqFnWgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728333411; l=2076;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ow9NioT5w3FxuoOvHqYRz2hyT9/a1YQqOexCD7IhW0M=;
 b=xEMYo4nIwCX33BBvd/774g0GcBRzvLeDIMw4hY3VKu+lWtH6kYXDxk71S3b0mr59tODPYiWJ+
 vQDBWbT5ulzC4YPSpiryw4rTx9gOdFLyoxTNClFTYqp6m7tTziGKoST
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds support for the veml7700 ALS sensor, which is basically
a vem6030 within a different package, with no pins for the interrupt and
the I2C address. The changes introduced are meant to hide the event
functionality in that case, while borrowing the rest from the veml6030.

In theory, the interrupt functionality would still be available as all
the registers are the same, and some polling could be done to read the
threshold indicators to generate events. I did not find examples in iio
where the INIT_DELAYED_WORK() queue_delayed_work() mechanism is used for
that (some drivers do it to read results), so I am not sure if that
would be the desired approach. I am open for discussions about that, but
probably to be applied later on.

While testing this "no_irq" device, I noticed that the veml6035 is still
using dedicated structs for the iio_info, which were there to account
for the device-specific attribute values before read_avail() was
introduced in the driver in later versions of the patch series, and they
managed to survive until v3 was applied.
Once read_avail() was introduced, the device-specific structs were not
required anymore, and they are repetitive. Moreover, the initialization
of the no_irq iio_info for the veml6035 was not updated to account for
the new read_avail(), which is a bug if no irq is provided, as there is
no callback to retrieve the available values.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      iio: light: veml6035: fix read_avail in no_irq case for veml6035
      dt-bindings: iio: light: veml6030: add veml7700
      iio: light: veml6030: add support for veml7700

 .../bindings/iio/light/vishay,veml6030.yaml        |  16 ++-
 drivers/iio/light/veml6030.c                       | 130 ++++++++++++++-------
 2 files changed, 106 insertions(+), 40 deletions(-)
---
base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
change-id: 20241007-veml7700-83f54cf94262

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


