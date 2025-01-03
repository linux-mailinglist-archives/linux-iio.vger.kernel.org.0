Return-Path: <linux-iio+bounces-13880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A626A00A2E
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0DA7A1ED0
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179521F940A;
	Fri,  3 Jan 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OEHbV+Ej"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCE1FA8CF
	for <linux-iio@vger.kernel.org>; Fri,  3 Jan 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912860; cv=none; b=hW8/nDI/hhqfQ9HDN3gmD57txsChVNMNGmlqaKUrbqCraHEc0GDF/05dbAjevn2/6lT2qXus/qDP2bgEWa6oWV3uPt/yUTUHpRKTe/g8RPaB5X4eS6yu+bmupgbuTCptGsVvFQYHE6ysj9xsQsTfj6x403wpWa7kQlz1YcxKAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912860; c=relaxed/simple;
	bh=t8fxei54uN9o1jvVyQlhHWpPizYdfXuCssnzgSnQL90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iV5ll+eAVmp3mvUzhJnkgQvOqiWvY5TQMQmsBkym4IWNBxIUK2wPVLEYAVkZA3dJ5iChACUQdpwcz1fc+1AItz8bzyQdByIrlFBEWpXlN/0n0qQJXl0/3TRbjGDxp9iuMK60yga6G0E+R9dSEzruGjdRxhlIRcY7mbo8gj3u8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OEHbV+Ej; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso15154413a12.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jan 2025 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735912855; x=1736517655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJRIeirdBRYDa71STbttzeJBbsC2eIbsmBB0Kex5yKU=;
        b=OEHbV+EjEJYL5CaDyJ03GFqMu6um4qc4CtAniXMZigzWHLV1XzojiLrQ5kGsr8hGjC
         92axwhOidguOYCcf3l4ZkwSthudczwTveiCTNzrgd2BalLrmj76kt2s9HzQy21+zdsSH
         buIMbV2cTekErkbhngQ6IdyVG8fMU1cZogriHQD3UdUNXd9pjCXsVlBIJuN3D9GrC8U7
         cciCy38usx94ni0RrHUOT2UqCrrya+RNIpT8GG0O/ex21ZSMBYulzICLAeylt9uyvqX3
         +UoXLiiOz/5n1bgnZP4fYUEOBbUfBCDxvrpMdtdSQAUNjG1O9srHKfIW/bwrxNyvWUIy
         ypPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912855; x=1736517655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJRIeirdBRYDa71STbttzeJBbsC2eIbsmBB0Kex5yKU=;
        b=YNGmPNz8Zmh7BJ1SqFp97j2qOFhwHxJsdSF/AtbfxIji4LRQLLgYEap07rgIW2X6FI
         ij51CCZkIkCnCAKv/WKYiD19h79YuN0iqdchtIWWeGKP+Fyw9wmjXM+aSHkgJl0DZcok
         HoLxPkL6vpHnj2U9/cQpZni9JQ/6bgk9ystU1Ddbfy1HL00mCim+weg7YDWyLzRyGSjS
         KFRd6fQRLzDpcjO8f2qB0HBelYiENzV9KhxBqo4EDomfGlOCzgCVGRTjrRqXnW92q3zP
         Cqd8pBYMsC4hG7tONd+vxspqIg5zLiqLn/Y6sSFSypK1Kq3a63L6KAr8VJnxXCUbd8e9
         Nqsg==
X-Gm-Message-State: AOJu0YyiB6DimIeFG36Ihn9gys8OlbmCtzHqBVDRosJYFnp6ycOpnntH
	B/MxaH9+qRi5StpRUygOc6Y9ZIX1JjRrMipzKAMHiQ4mzFmaCzmenA8eCdk7FzA=
X-Gm-Gg: ASbGnct1BzSqAvRWi46F6iLDq9ai99NgVtxN5at5DB0BEjODD+Hx59MN6x1pbXHjG+y
	lr1YFzlVcewbCt8hRzm9x32+ZEko1ssiAvF8MDaQAz7ZfomhPdlEkkv+VAnh4QLSNlkByytA+0c
	eIfEdWU/2SbOmTROCGkdWk6PiXQWA4rsxL0EnaRowiljxQY/ZRhIcS5Z6RMDgwlhjbTUCsa7328
	h5ShDKpVFCneTAjpcuuggRtyP+1nTbUmGw95FPwxe5Rlr3sRwqMlroLoV4Gw6O0ftSJ82/x4H2T
	lcEojuHIAEI=
X-Google-Smtp-Source: AGHT+IFSyOQzbinppHxUP9oh8DJ5DHvKPosqPNihCcG+SIUNZQ/slS6mXMPHUj9d0EW0nov+n+p6Pw==
X-Received: by 2002:a05:6402:354b:b0:5d4:4143:c082 with SMTP id 4fb4d7f45d1cf-5d81ddfbda8mr36765096a12.21.1735912854203;
        Fri, 03 Jan 2025 06:00:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f0e4sm19502384a12.42.2025.01.03.06.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 06:00:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	ulf.hansson@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Fri,  3 Jan 2025 16:00:40 +0200
Message-ID: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Ulf, all,

Please, do you think there might be something wrong on the power domains
implementation that led to the conclusion from patch
"iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()"?

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
  iio: adc: rzg2l: Cleanup suspend/resume path

 drivers/iio/adc/rzg2l_adc.c | 62 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

-- 
2.43.0


