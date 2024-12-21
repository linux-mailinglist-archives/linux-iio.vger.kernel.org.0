Return-Path: <linux-iio+bounces-13738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BDA9FA182
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB241670F1
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C08148300;
	Sat, 21 Dec 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acpy43Vs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9072594B0;
	Sat, 21 Dec 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796784; cv=none; b=IoCD8QHPD2nKqf3qsLj2snRyOUbf+nMxaQo6KiGgXYjGHQhXA+v70/swfmNIlG99cdlkmGbwAboenpkZcbmSI6Y9ZabVLSZuiUCi1BGXWteO0gg0PvZMsNnJ620o49kQyn04+5Q7MlNk4U0ENei/rYgOaHvzt2wSirDNcLBfMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796784; c=relaxed/simple;
	bh=FrKh0cTyJq4j0qv0CvaQvoXwDbpRH7JHCU40812Ne20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGzZ4v8nJDm6FeaB22C3qSlMv3+PYBw6bjszeBy1QCARe1e9N4Nsxlg8se6Jepntpk4UI5uO6DgViSKcVapL9Epi73BgeqoxFv6TsYOA60JGTHYi4aIul71bVFxFXS3zm2SjQFbVjM5CeCg0fKpNo4hBZdVT06HEk/LbI/qqteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acpy43Vs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so1592103f8f.1;
        Sat, 21 Dec 2024 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734796781; x=1735401581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrKh0cTyJq4j0qv0CvaQvoXwDbpRH7JHCU40812Ne20=;
        b=Acpy43VsuWvlZtcAkD4Ly/ijKG6mXn27XfYTWDQb8fLMiqapCUekoMcriNeqlHDcvp
         kpPuAfnNCRFRVPfhWijjrQBPkN03fSWfchn4PBVLu+cTyNlebyB5Sv7IGYGzvfmjFIlJ
         kgsdX/8z69m1SVKp6yg8ZeqDMYoCPPpARLgtX29R5582qyM56vaP2aMdxv9pAtcQniXZ
         8F2rmq2ZmpoNRRdGlBX6m5H2Y8L0dPAj87EiccprU37TrUe6F221THO2FDyGsbie25ml
         1maHCbaKrLqS0Wssi+NBKvDWcyZGZG6HCzV6Ehscz6RESF3LWInd4FjzHx8x4crxAC44
         43ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734796781; x=1735401581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrKh0cTyJq4j0qv0CvaQvoXwDbpRH7JHCU40812Ne20=;
        b=SCOCn+0msv/bX5kaHIl9hDRo061QOrwr8M29LDdOv45ZpLfWH2JGWWZcc6GdXP9dWh
         5QkbcXfRKtGySz6P2HCqVEsK6eW0cPEQoBRdL6+DH9llN7IzDoOEsZK2HJmUPleE41rL
         NoArfEBzf7RDeear+K1SO4m0hcDqurwElpWlMcewvsTx/OVrIwWoCea8hYZeMD+9YjMp
         qNri9ND+YAg1OEl8X12Q1T351Hh3Hwng/C8VmjMmYCcLHoE3RCvCGHizN/Xd52n8m8fZ
         Tz/GbbwPflp9zVLlJ8l1nF0HsJbEoperNwCzCmG+CidZzuUjyq6r/wFMbetWwmLPrM6K
         4WqA==
X-Forwarded-Encrypted: i=1; AJvYcCWsQgmZDPX/X4kpe+Yb0seYKGfB0IVTQy6bFKQwhUZzmuAcuJ96PE5DdXjfNZX6Hqw2rzNoKjJss0hgdnCw@vger.kernel.org, AJvYcCWxIUwOid8iPzLg/BIZkDDAFQGNW7LHl4qJRPc+exRjzZ66nRxn1Di7kV4XoRx+Pnv94kwxB9++Er9U@vger.kernel.org, AJvYcCXNEkFPaEdvzzyB8aZztVnHyy2M9ieOuqtjDFJLIeVjpMqF5+dQ18JL30ACiIYj7cM14yiqdO1Nx0wK@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnMEISQNkxv4QJv5qfOtW299p7jqmVeM6TvwmcWpP41uvuC+H
	kwOwsnzBMYg1JqKuEIr/qSOM2d1YO30NzjnuAGHRiXARKfrQAcpewrnVIv9k
X-Gm-Gg: ASbGncvDPzxmlAACzPoPCg+fuf1NU4A/JFyMbKbJ1zukvRLhHuM6054ppQZxh7ZyDxA
	UqaTmNs7mNWOhr6o5u60Iy/ZH3RcvTFMUieTX4IVm0lrqSH271J/L+C7hKLGT/8N7aSxXM9B5/T
	UbZjjBt5Yp9h8gu6grkzw0NpJ4YCDE0r+FDRJC1DnU6l4AOf2wuJ6x2Mz6tdSzh4jTGn8+l/Glf
	hdwmfEO4mMZDSaPamOrPt1W6AUF9xI1D8LXGqERXsi0FPTDDqOOw5OM
X-Google-Smtp-Source: AGHT+IFJdYyQ8TAYkGvjIYJg4YgyGsiA7+FxH2gHE2JgM+q7EewTCPxDIs4BUYkfGDaVMLBJW9Q+cw==
X-Received: by 2002:a05:6000:178c:b0:385:f13c:570a with SMTP id ffacd0b85a97d-38a221e1528mr6626584f8f.7.1734796780986;
        Sat, 21 Dec 2024 07:59:40 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:604:8900:a4e6:d95:2e66:864e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8b874asm6751081f8f.109.2024.12.21.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 07:59:40 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v0 0/3] Add support for AD7191
Date: Sat, 21 Dec 2024 17:55:59 +0200
Message-ID: <20241221155926.81954-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear maintainers,

Here is a series of patches adding support for AD7191, a chip from the AD719X
family, with similar functionalities. Since this chip is entirely
pin-programmable with no registers, I wrote a separate driver from ad7192.c.
Sigma delta adc drivers use the set_mode() callback function which contains a
register write to make sure the chip select line is asserted before waiting for
an interrupt. Devices such as AD7191 and AD7780 have no registers to write to,
so I added a helper function ad_sd_assert_cs() for these use cases.

Kind regards,
Alisa-Dariana Roman.


