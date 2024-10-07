Return-Path: <linux-iio+bounces-10289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A841C9931C3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB061C236B6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851331D968C;
	Mon,  7 Oct 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WgL9y4oP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0F1D5ABA
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315948; cv=none; b=hHqhqDQcZ0Pqd5vfvEwpakk3K1aEitm60GsXcYVYldDVw8L4P9rVIbwZbz3P05YKCIeiFDD03eZ37904uRHh/vOPsu/A26Vih9eJNVqE6VZDKQDcr3LPWf4Yz4xTLFCMjCpyWyXqR69y90sV5VM2zYyYyjpIkb50pDDHrNLb380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315948; c=relaxed/simple;
	bh=adjIKONqQldQq+nYfRFYqYIa4peg7k+DD94EtLL12aY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gvqL/T6oR8/KvT2asGtL7IQPF2KYGdvD19sLJJe2UAE4P2cdKmnEwj9s8oX6sITgUYO5xeOYw2ewhEOJGj0Yrae0myegV/uwdSapA6guNQ6KrmDxdt7R73J+nuhiccYjg/r0uYtK1AqEdFA2ZKjMHWS/S8vyqL9ym1PUEusetyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WgL9y4oP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so2988875f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315944; x=1728920744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IebLd9pybc2nbLozfLLDXz3gBz/LDqnDpQAr15l89v0=;
        b=WgL9y4oPhVU5CU2XRqENuOYDGZx91sIqy10aYAOdQfDY3RAKMGiNU7Z+r6hAaNpaWT
         bgTQQ6g4+JFyn/2PngLEMpYbJA2HBdleUsuHshZC8PnbBETWjvKic5YWoxOrz07E6lWi
         OUJTh9Ho6JniWBR948uP3g90DuziHpXZqqyhBHFGZqJQWiFnnKqfrAsNbsP1HYHaHlBN
         q/31zIW+++dp9XHheuFEhqRrSrEOD8LEwDjF9gGyFbmWVsiz1LWsl7IiUJ7AW/dVUUbS
         kS+ac37+K/SRbw+dhucBbKnF3KIm0r7HwlG8bEnBdmadJoqxZwGbCGuBmZW6aYtPujun
         d3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315944; x=1728920744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IebLd9pybc2nbLozfLLDXz3gBz/LDqnDpQAr15l89v0=;
        b=HjGNKZOuzNMVZbTs8pZPRkoqlN/P1OXNLwk4gIoplMvSjNByJ8RPAom/cBMYQGPtip
         67B353Omv+07H4SmAcRtj10P6NW8/kuhIvckjRWKLerjKECtFjMQX5PQAQm+rD2S4ZaG
         TQmjkVQoNUh3G/R+PUz1y26m+XMys7DLE+RN3uAq8X4Yj9d7p+KfnQWchqDKLN6QlGeN
         ZPFbbmgxWZbnLykc2C6AJR1N0/RfhB9/xDA+gWF6S7TYYK8z+zEohThN35xOL8c0lHSe
         P0+xobzeKZkEYmclwRCnGnacxf1O1apqYsJINkwt7AkuXso7v5PYNKKetDTzsNcGZd7I
         suzA==
X-Gm-Message-State: AOJu0YwPyL94G1c9EAhzKeZjwAxLzB3qXyMeX171LgwRQQqiSEWpThr8
	gHePebm4VqbU8V0v8+8D3r202Aja8/WYmhZ9GSsTAgNmu7WCgJk768Q+RZKVyYA=
X-Google-Smtp-Source: AGHT+IG4xZiJ9Dxrm/XmWrYjYFc2ltp0HZl/BJIa/shgIDu3Ewcr2gbsH0yy3XGYqB+hqg8efWUjYA==
X-Received: by 2002:adf:f306:0:b0:37c:d526:9bb0 with SMTP id ffacd0b85a97d-37d0e76575dmr6868032f8f.35.1728315944069;
        Mon, 07 Oct 2024 08:45:44 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/6] iio: adc: ad7380: fix several supplies issues
Date: Mon, 07 Oct 2024 17:45:43 +0200
Message-Id: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcCBGcC/x2MQQqAIBAAvxJ7bkGzMvpKdJDcaiFKlCIQ/97Sc
 RhmMiSKTAnGKkOkhxNfp4CuK1h2d26E7IWhUU2rlWrReWsGhSu/mO4QDonR9NaavlvWwTmQMkQ
 S/1+nuZQPlvh6lGUAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

Hello,

This series tries to fix several issues found on the ad7380 driver about
supplies:

- vcc and vlogic are required, but are not retrieved and enabled in the
probe function
- ad7380-4 is the only device from the family that does not have internal
reference and uses REFIN instead of REFIO for external reference.

driver, bindings, and doc are fixed accordingly

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (6):
      dt-bindings: iio: adc: ad7380: remove voltage reference for supplies
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
      iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7380: add missing supplies
      iio: adc: ad7380: fix supplies for ad7380-4
      docs: iio: ad7380: fix supply for ad7380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  32 +++--
 Documentation/iio/ad7380.rst                       |  13 +-
 drivers/iio/adc/ad7380.c                           | 136 ++++++++++++---------
 3 files changed, 110 insertions(+), 71 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241004-ad7380-fix-supplies-3677365cf8aa

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


