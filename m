Return-Path: <linux-iio+bounces-10306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852D9937E8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7101C236AD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE71DE3C5;
	Mon,  7 Oct 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRqb7x5Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD91DE3D8;
	Mon,  7 Oct 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331607; cv=none; b=L3GGTDUqneD3JzfuOwOQ88U3t1A9AgHFpUZ/c/VC9VdVPNVco2+tI+eCHgS9jA2+KHJvFSNLI33QE+CPH3FoAnHhqPTo0WaR8Frj+tLcky0bqAGvMZCy7K4xtT+mrbHUSgFtI0VMBQYGZB33VqTCASMLZstDdaGsXNUecnJ9ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331607; c=relaxed/simple;
	bh=GsIwhIQVTTkGLvK7w+sRPrDJNQNLfp5MvJrkD7KllOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mTiUzNwDPLDWEh19kBmT73+zJusy9zmi49H2dLdampLT2TB3+xg/xk0rdAkm6oCapoyotBh3mPWopV9Yf3llHdIr5lv9DnKrSsNoa2ZP9ax0xM1YVtnPMqKw+prr8g6tDKWFKJOa8yY0qG4utaVlLvZSAyumsIQB+MxFP+gYUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRqb7x5Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so42341665e9.2;
        Mon, 07 Oct 2024 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728331605; x=1728936405; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0M3WlIByMpnGigxWTYyi8ul6vf98g2GRWAjBe+Sh3Ms=;
        b=QRqb7x5Q3GPPabzkIOMExk0VFMpVGiORpEPuXhexMjnR6qgn+clbFbiHIEocl60QqQ
         e3/gO/6qLmanr+wUlOlEJ3H5o7Aq+uQqDPeXEEOWIJw+j2Y2s2dLX8NkWWk/ZytuTQxD
         mUcjJzf3HGaE3jZv0ih3y3gPd9Mk/nsHFsru2tBE5t5vR43fP0f9pr5iagyvz0r8KeMH
         9YhYv2HNBqk4JIsIRXoe3E6B0CerV5zS3JytFoVEu9xQ/CFNjVob6BF6pdbwH6xTjvBu
         mGE46hNMQiTpIHvIdkVy6lcsJtH3hb1W8oPw/4M6Ny5OLq0J259NdfBWafWSQpT1UXUK
         k6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728331605; x=1728936405;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M3WlIByMpnGigxWTYyi8ul6vf98g2GRWAjBe+Sh3Ms=;
        b=BpRyEwZVjfTsjsrYqqMSTZvJIrV+XvKyimEwbXS4lr09GXS0JTSLOtnPXCDlGt/hyt
         ouu6yVhdjjWpeuf/YILDw0UPibyo0ZgOD5v1uWcnZInUU62tspDrpF1UsEiDKWY0uI4V
         od/RsIcn3t9FLPrwpIIb8Hu7Z+62yjXTkrtOj2mU3OjihS9stzGF+kpRxgNgR/KWMuGF
         CK4DHsHD9U+6PLP7ukBuqpVDo9MiWiVjCdIrXLNgaYVYdLwwNoo3d7p7z9aQDtLsCVtJ
         GHWv08zgnHhyqgFhCQrIBajokGB98YtmXZBgsBDi3Xlb1ZnkRB1goDEqIWbR1wN//9J5
         PryA==
X-Forwarded-Encrypted: i=1; AJvYcCUYyQKzpukhLU7bViRnym4J0Fu+LkvScuKDdIXxb/012RpbQfwYhgNG2Wb449Jlc0MaSJSm13eR5WI=@vger.kernel.org, AJvYcCXrpIehXaEoT+6K2xeeCjBuS8EqYCCE1vPD9nzVrpYmgRJFmRQBVu5zI+Bs/CVBs8nwEKSMNZZm9WW5s03i@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGsjQkiIMv6SreV04yNqG0I5zZckU/Ru+hNmH4xvlo1i9Wcod
	DEdc/vqyGGRxUOlJmfTDaGhaxT1XkbU4Oiq2xNJTaoBa8Cux1gpz
X-Google-Smtp-Source: AGHT+IHH5ZiAIKuC+TEjXQZ5x1KRzck1heAcIRWoxW8bWtIYUwLAHIpeuI6Uc97Lbn/8/dp8gDilGg==
X-Received: by 2002:a05:600c:3b18:b0:42c:b34d:720c with SMTP id 5b1f17b1804b1-42f93184f9bmr21696565e9.4.1728331604449;
        Mon, 07 Oct 2024 13:06:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eda21esm85547155e9.46.2024.10.07.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:06:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: {amplifiers,dac,frequency,resolver}: add
 missing selects in Kconfig
Date: Mon, 07 Oct 2024 22:06:37 +0200
Message-Id: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0/BGcC/3WNywrCMBBFf6XM2sjkIUZX/od0MaTTdqAPSUpQS
 v7d2L3Lc+Ceu0PiKJzg3uwQOUuSdalgTg2EkZaBlXSVwaBxGtEq6kzSRqNKPHHYFCFdLTmP1hP
 U1StyL++j+Gwrj5K2NX6Og6x/9n8ra4XKob65i+19sPYxzCTTOawztKWUL+G4eyiuAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Cristian Pop <cristian.pop@analog.com>, 
 Mircea Caprioru <mircea.caprioru@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728331603; l=1346;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GsIwhIQVTTkGLvK7w+sRPrDJNQNLfp5MvJrkD7KllOI=;
 b=1WDaejsWNoLavonRb9Irnhoqiv/YOb4cMddMQvFLP9V2JuiF+efcIPjB/iGMjpEYi/uI0Siyh
 8UvptnXXnN0BzUDjEXLujKEv2mGbx0lPmAZccL7v1ODhNV/YlMfuusd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds some missing selects in the Kconfig entry for the
following drivers:
- ad2s1210 (BUFFER, TRIGGERED_BUFFER, REGMAP)
- adf4377 (REGMAP_SPI)
- admv4420 (REMGAP_SPI)
- ada4250 (REGMAP_SPI)
- ad4770r (REGMAP_SPI)
- ltc1660 (REGMAP_SPI)
- stm32-dac-core (REGMAP_MMIO)

Usually you will not notice the missing dependencies, but tiny
config files where those drivers are include will lead to multiple
errors when compiling and linking.

The issue was found while compiling the ad2s1210, and then I looked for
other cases where REGMAP was missing.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- rebase onto iio/fixes-togreg to drop applied patches.
- Split [4/8] and extend the code formatting to adrf6780.
- Link to v1: https://lore.kernel.org/r/20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com

---
Javier Carrasco (2):
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig

 drivers/iio/frequency/Kconfig | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)
---
base-commit: ccf9af8b0dadd0aecc24503ef289cbc178208418
change-id: 20241003-ad2s1210-select-a0a73a48038a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


