Return-Path: <linux-iio+bounces-15066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBACBA2A34D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 09:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CA51691A9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804222577C;
	Thu,  6 Feb 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ivrbQ/e5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F32248B0
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831061; cv=none; b=F0KblTawoAYh4ankvr3fgSFFpgq22w899XrMNgzilVb8iz37q/9IufKgScg/8sqAsOisZcsX70vl65gdBbQ54/fzzrA/asaq9a90nl9MdhgSogjnnhs+i5fNKbcvxqBKXPQpzJ0eMdfGH8aJAyQgDHbDpwnx/nCb7TZHAh+5iqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831061; c=relaxed/simple;
	bh=b61mwkGmKa7qLwio/HyZKSIj9qw2WfofAWA65lWGS5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TgcrjrN3jH04gakLN/vaqPw/3bo14JPOFEc4FlcNHkbHJxLUNP2PVw6IO0/rL+/0jwlclAyWTbmeffrut+KbUojCGI8Dkq4ptJwF96yndzZgSOmW5J1kArLK7wYZHACCbsdtgYVUQJ/2jhqz6gvKKHLUR1n9bxkR2COr9BfGK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ivrbQ/e5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so241598f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738831055; x=1739435855; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6cGRhVGZQ/G+JhIHlnkJGdUnMYCYKnsKq6xNumw1bc8=;
        b=ivrbQ/e5ShXADrc6AAc8BkSjaLLbr6Ez1K0/SiFxe5Z6vEmVZLSqv01sdDzBkhYCDP
         5iAHuGn+VJpKEuGcgQpAHa67XiGjykeI6YboOUtUAXJpyjDn7GmB3eT2qf933RT77Wrr
         EHMmIyOInibBXdCfQK+QSTtEIU0RChvXxmII7ZCa3QUfKBEy8EW4luHK2GzlXbJ03uy5
         XRdmm15AIm6VrL4ahemVS+TCsu/AWSPo83lL0fneINAJjwne0916U7Wo5SpZjjEI4Od9
         xYaAzvAXDYfzB+14gh68FQ4/YPKcyQxPS+UFArANUlgmtexYm3YX8+ji3ankmvk3cxDG
         FV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738831055; x=1739435855;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cGRhVGZQ/G+JhIHlnkJGdUnMYCYKnsKq6xNumw1bc8=;
        b=aeX1ikktg685HG3QFv3h7VpmXzWCmA7260f8ofrUdWB11XdkVQstwoHx4OwesYpDSd
         LmNs/UqNF+PEqmUTc0+kdet6KPNcYTS2aTv7g1osJ3B8r6E0AvLA6/aF7wYztU1R6pTW
         obQLy26RyldcwmpLx8X61x2ZNxk69+sYPijqWa0S/Nh9PBeYxguhPNzi+jccRwqHGsPT
         Qr3hm7dJQIpjt0NpbKav2MzRxNgy2W2yg4do2M+4xS2wc0aB1x3tEpkh83K63fKyrRPk
         t7Px9sBF8giJ5LcKF5iJwTuJZeWfSS2k0QbOBKnGcf39k5WLRRfxqqfGuLQe22gnoXUD
         zKEg==
X-Forwarded-Encrypted: i=1; AJvYcCXhllJga2x4hAlIuTS4UDI7ZIEE8Z13Al86wnpH0Jh3mLjA7cLXhx1w250KQM/IhE9wJcP5VvUbYus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4gACaEBM6Xe5enxddbhkvt8EDt5RzK1GyvL+Na0fnzeX9RTx
	3FsW+QaewGYDCSght92k6sKlKULx1qh416vJtAFf9w+IKV19Uoi/GKlmzqo4aP0=
X-Gm-Gg: ASbGncv10y7NF4zhWWuRTOvBvM0OKH91VSgT/mhQavVm63CIb9sQyetnxD2osHOngkU
	cmC47Z+XsylFXGXG47TZepoYFsbt3lC9jkEVqKFehJNqqrqm1sPCIvGy31JdYxyZyAnVG/m+2Zm
	h/I5QlcEh0fY50KK2EWsgG4xNlh0kJ4z+aQIIIc2QnqipHfj/2iEwptfumAED6y6thQm+D7zyVE
	EX2iAXp/YmLzneIxCQhxzKkP49rGEzbJWmuHm9YarSZdaaFAjACM9u92vWwnr6QSNmM/jk6jC/x
	bP0FxLgYEiuIP2UN2vy3XQj0pFemSyma8gN9qGmtrScr65KpV2o2R9VgvUw849XrjN5Tkt8=
X-Google-Smtp-Source: AGHT+IFEG8qEl6QSztrpodBzSY7VlToA8lHWWeoXxXNowmla1vTj/PrZ5CLSg0ktKg2rUsp7PG4yPg==
X-Received: by 2002:a5d:6d09:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38db4861134mr4288492f8f.2.1738831055250;
        Thu, 06 Feb 2025 00:37:35 -0800 (PST)
Received: from [127.0.1.1] (host-95-244-234-244.retail.telecomitalia.it. [95.244.234.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da9648dsm11948095e9.7.2025.02.06.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 00:37:34 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 06 Feb 2025 09:36:14 +0100
Subject: [PATCH] iio: dac: adi-axi-dac: drop io_mode check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAH10pGcC/x3NQQrCQAxA0auUrA3EyFTwKuIincYaKDMlKbVQe
 ncHl2/z/wGhbhrw6A5w3SyslobrpYP8kTIp2tgMTJyIqcevLTjMKOMtJXaU3XAjNKu4aqxWJsz
 icw2kO2mWoZfEAi23uL5t/6+er/P8AWZr9qR6AAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Drop mode check, producing the following robot test warning:

smatch warnings:
drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode()
  warn: always true condition '(mode >= 0) => (0-u32max >= 0)'

The range check results not useful since these are the only
plausible modes for enum ad3552r_io_mode.

Fixes: 493122c53af1 ("iio: dac: adi-axi-dac: add bus mode setup")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index ac4c96c4ccf3..bcaf365feef4 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -728,9 +728,6 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 	int ival, ret;
 
-	if (!(mode >= AD3552R_IO_MODE_SPI && mode <= AD3552R_IO_MODE_QSPI))
-		return -EINVAL;
-
 	guard(mutex)(&st->lock);
 
 	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,

---
base-commit: c667ed738d7d1a01e9b946ef47cae113b0a05bee
change-id: 20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-070ecab6a52a

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


