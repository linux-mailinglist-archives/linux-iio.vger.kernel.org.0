Return-Path: <linux-iio+bounces-17819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA9A80C72
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34D4903EA8
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F466137932;
	Tue,  8 Apr 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u8/j49+t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26F2A1A4
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118500; cv=none; b=SmqgY9K2vTzjhWTYAgwNaFNfY4ITHO/AIc/dXyuAQ+mNXQ/JpAduP+WXrqPDhHrlYI2qPZ7DaP3Youhg/X8e0xA66X+YEdMJ/aJ8vrSf2LHTfvi28GxGFQ1rih/gx03J4DABKz4fPLV1b75iOgqm4ANx2Ybd+KzHuWyYRRPD4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118500; c=relaxed/simple;
	bh=JykIIwYDCyjawEXtijT7j0iU9oc/WpKabWh3X/j+B8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJxKh6w2HqCH29XCipTbDt3SSJYTxHdk1y3q34Wdk9T+olYa5pDB0DuclLTQLdVhG1LQYm2CXQaGCQdUZxrYHSAdeWESV7Mt6AlTW9yxMgbU/G+P/ttCO62Gu6ZTNwTgDJqQBwhzuadQlOGRpblIYHSpPNMck6Orqgo7zp3iJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u8/j49+t; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso6595321b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744118498; x=1744723298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXhow9G6LfPKft7ESsFuZneQo6aQLWh4r6wFJN4PTzQ=;
        b=u8/j49+tB2P4ZzBEY+z9VjkIrsEIyBqQaqNSXCzB73jnumnX8eJYaceXCkjSS7bV4S
         JJuKDESQxB1AV5Zc69Lj9C0y4Pi0b4Q7K1qvWLoMUD0+paomls/RdfDsCSeL9LHj+Dq6
         Kp40G6fHhlTYdWvandxI/Tcyf8c6pR3lk+/BCFYTuIv5VzOl/v7W6y6Kmj4ZZ97g/MrP
         nDK63pPdc07c+0v0qchcxAdE0UU10qaCh0L6vnZkQbk56gHcEIsnHIYpwHenhuf96lzh
         zKCQ1vBhPu/BKcMNp1GpyyQ+DzIq7EXbb9WmnL2j4ndrHHtDrKxLOfqquRp+i2W9sHF0
         eVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118498; x=1744723298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXhow9G6LfPKft7ESsFuZneQo6aQLWh4r6wFJN4PTzQ=;
        b=Qa0zeyxpEDQoMFapk4t9vIWyMpjsfIkWiaAvHvV3NEWKgXO1Eh4RRnjiR1Js9jhIhe
         2THNszZvtAZj3FVu8Ef8UF4tXNiK80R8alIwa4jIPus7PvX5tHKKLxd4ATlYYH+bhFeM
         Mn4d3UDVH3r7visBa9QBl6A7t+UVa3MtSG30AZ5THPdo2l03T9gaQFlbVd+c2+tiDRBn
         8aYp5kzt3RxSEpaPwb27OXdS039aWg4fNLrbUu8syxa/NP+IOSdxZJB2DBzw4udzd0Lg
         IH7QSe0Y93nxPu4vbNX4P/8XYz4ZQfUW9MuSlRuEJgjU4Fp9QrVpnz5d/kb5PyqqcY4a
         vobA==
X-Forwarded-Encrypted: i=1; AJvYcCWjk5xsod7rMOe3ShfQIjNZduhMLmXFa0pegGp2xvLpaYTrQapn9f5eOfKfYbr6dbWWINPpCWbblzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDYgVaySRxhOBcxL5HUAcgMpTH/fWIkYLqtJqS47U76G7GJlw
	xB+JkelvW6ZfUStG2dHY8BxoWO8uTSNh7OJnDRYBCICUdwzWmeoDSStLGe+ocK0=
X-Gm-Gg: ASbGncvvitVqJNLKsBsAFeG1y+zYMFjaplSQ2J2LghXvO1xn54809MCaqbGqnCpLDTx
	Y/4Hylp5TVHhWzi1c/MvuPlA0dmThshoV5PVfQ6FFDq/i4J2W2+2UcAovyMN50POvnqWCkkb3g7
	UuXuwKpRfSYFR6D9l4wv4sbf/89WocSO3fsrWPc/1G4p2tDVhdkH5PwTqXTNcQBr03XN6HcTRMc
	D/pYq6gpsYKAFqFZBa6jSxjj8CBsy87Jcf9xBXWcEBVqwtVNyr9JL2O2UkIUsS7K8ahDXubeNpY
	U2r+efFx0Z2iwTv+8YOm1eeauwJwJToZSbZhVm0eYcoozjI/iSAb60tNz8fYol9F4Fj/0givlhv
	IIdap2GM=
X-Google-Smtp-Source: AGHT+IFz565EmwdZI6G6fqS5eARGKS6h/lUhrUYOGgeKnNkpmHWtd/3dLP7BxOpQYwBvP6XvleclEA==
X-Received: by 2002:a05:6a20:9c88:b0:1f5:70d8:6a98 with SMTP id adf61e73a8af0-20113b1a932mr18860716637.0.1744118498123;
        Tue, 08 Apr 2025 06:21:38 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41af71sm7439565a12.75.2025.04.08.06.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:21:37 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ti-adc128s052: Add support for adc102s021
Date: Tue,  8 Apr 2025 06:21:18 -0700
Message-Id: <20250408132120.836461-1-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch series adds the support for adc102s021 and family.

The family of devices are easier to
support since they all (no matter the resolution) seem to respond in
12-bits with the LSBs set to 0 for the reduced resolution devices.

Changes in v3:
	Patch 1:
        - No changes in dt-bindings

	Patch 2:
	- used be16_to_cpu() for the endian conversion.
	- used config index enum while setting up the adc128_config[]

- Link to v2:
	https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/

Changes in v2:
	Patch 1:
	- No changes in dt-bindings

	Patch 2:
	- Arranged of_device_id and spi_device_id in numeric order.
	- Used enum to index into adc128_config.
	- Reorder adc128_config in alphabetical.
	- Include channel resolution information.
	- Shift is calculated per resolution and used in scaling and
	raw data read.

- Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/

Sukrut Bellary (2):
  dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
  iio: adc: ti-adc128s052: Add lower resolution devices support

 .../bindings/iio/adc/ti,adc128s052.yaml       |   6 +
 drivers/iio/adc/ti-adc128s052.c               | 149 +++++++++++++-----
 2 files changed, 118 insertions(+), 37 deletions(-)

-- 
2.34.1


