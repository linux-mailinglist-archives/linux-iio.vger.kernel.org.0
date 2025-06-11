Return-Path: <linux-iio+bounces-20478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABFAD5F4A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B33AA4D2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506229B772;
	Wed, 11 Jun 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvRJrN+l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB481DFF7;
	Wed, 11 Jun 2025 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671272; cv=none; b=QXralo90SAY0+NBWeOuT7I3nzNliBJJFvdbkU0V4gD8RDizZ/VHQoqV9j1BoCCyCesWIv2N4xV0PwBsQkFwTrfPRfbmZFO9XxnFJlKa89m3rNhEeMKCqZ0lJ66GeHOGOvgBv7BsLGQe4WDEAJpbhXljDWxRMDT8JrdGJxJk1Yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671272; c=relaxed/simple;
	bh=Gqyo4fCstlkVEleXkAgPU9oWDNK+rPLjgHBpeirZILI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5GB2s13CPEmHRUHbV580GIKTiJshVfASTyoeW+cugFx36rzB06ULBfRxDSPUcDh5Frz+kqsEO/4KPTsmush+RLrcngn6XMX5FirEuiDN1vAuJy31YvUr8hYjTeCXI9KrcBIcaQknplIspZjzbW9Ob70GR/fg2u1jF4KDiRuH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvRJrN+l; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e64b430daso1541787b3.3;
        Wed, 11 Jun 2025 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749671269; x=1750276069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGAUWL2dZwy17PTD85xcsniFkQj8bTvYAj4X8J5pVic=;
        b=JvRJrN+lctiwFV5ErCqxdjEe+ce3LEJtMSr/5VFgMSJDVtROKpeAmxLPaO2aC0Fi/R
         KrE4sc44zIrO8KsZwhl3eghGf/yg+vZ8Ouot/O1sCk1IZ9buBoM/e8i6+MTMi3v/j7XW
         +Axiz39EGZlOIA5qc7C9eLnqnVNwzJKD7Ptwsdx5DrnICTsDNARS6qi/Y0m2NkjwTKN+
         7S5nOjhGrTtao3EhS8RmGJkZAIHos2cWiGs++7fp0uIeuapO+tZgdOMTceIrAihtIXI8
         Ut2edLSKrDPWtvBzPsjZ1JLbW3ZK5FcYoWK3saz6tA44mc1YU47Sc5Yf7ODutNLSqrFh
         PEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671269; x=1750276069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGAUWL2dZwy17PTD85xcsniFkQj8bTvYAj4X8J5pVic=;
        b=e//iLtDbbAr7X6d/8P94FOsHisEzEGeEbUIlj2+qGZoGcdyELsAf/PtFCemJroYhcS
         X3e6v8EsFIGeAl4W4mao+RR/w4oGxetMnhaHgXdhsGqAOLhEJImyB2zZMmBrqZDXFXjq
         wBwlReseLoJJYBN+HbodrY70TcgMQ9byda7RFARPZki/K0bHzZxsfQZP5/l3979kqu3x
         FMiprlAaEN80/AmJqu8DossSJxaKGrl5sCVgTSjxWOUWFIxFuwKMErdJjsI9616S87Tw
         LwwwxC4pvJzXxzXLa/a0v+Nzc4CzHJymMxTshOhCzmumk90rB6hKaWLID5n0EyWAEpbx
         W4ew==
X-Forwarded-Encrypted: i=1; AJvYcCW2x/CthDbgwlV4Syz/LF7J7/4yT1lx5+lkZ8RAdVVhlGscmDNplN2ibhWlo/5WnBWPkyY2a2qtmYE=@vger.kernel.org, AJvYcCX5YEyXyhEpGyFDrldoqo3hWSaQyoYB+XlLjd3zTm9wnIZiMQ+ABLGvUL4jjsmH6LseHLuT0CyeBqbXffA4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hP402rtd8LWskU4/OeA4rNkg2zpQbjwhzYU04yqf/+USoOGV
	gamY1skafB0gPmaeXLbC8EBSbV3bc5EWAg6GAuKbuxKbvpIq0RH1/pJV
X-Gm-Gg: ASbGnctN+ZKwe+bdh7GthVdxrIanC8GxoQWhB+qaFkhDjiVrau8zZM5RsxU+3ntWAig
	/MvSaVe1d9PEXGcAeNuUqwkoDCC0MdJ3CiXMU/d2heXD+NYp/6PwIiq+tUD5f7SiojQzAEoSArk
	2hi2HllFuJaT5WuI/n0/RdET2oAIQchJwA11zUS70mjtrgDoAMYnjPal4CFFL/znYRhM5eoCKhI
	jI3QLDe/3GltEOuVG9MFZmj22rBFzAlmWTErZdaO2pxeaKJFwrBkXBeXR7t9XmPNm31Cal5zN0B
	rRyXZ0LIpTLMXnI1eotmDJwILvey7zcwGnNu2jx6TFhctmwuwAfsHq9ddMQvVc532L/bet4rTlG
	uKr6e
X-Google-Smtp-Source: AGHT+IHLs4g2USl9/3mIyc4/NBHj2TilOt7w38tn6sLQ9Sanz7WX2m3aB8WGZ+BR2XHkEhceRYX7uQ==
X-Received: by 2002:a05:690c:5c09:b0:70e:128c:3019 with SMTP id 00721157ae682-71150a897e3mr4593667b3.31.1749671269321;
        Wed, 11 Jun 2025 12:47:49 -0700 (PDT)
Received: from delta4.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115206130csm80587b3.1.2025.06.11.12.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:47:49 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] iio: accel: sca3000: simplify by using newer infrastructure
Date: Wed, 11 Jun 2025 16:39:18 -0300
Message-ID: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sca3000 driver is old and could be simplified by using newer
infrastructure.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
v4 -> v5:
- break up the changes in three patches
- replace error_ret labels by simple returns
- use spi_w8r16be() for be16 reads
- use guard(mutex) for handling mutex lock

v3 -> v4:
- clean the code and remove redundant operations

v2 -> v3:
- replace usages of internal read data helpers by spi helpers

v1 -> v2:
- simplify the return of the internal read data function
---
Andrew Ijano (3):
  iio: accel: sca3000: replace error_ret labels by simple returns
  iio: accel: sca3000: replace usages of internal read data helpers by
    spi helpers
  iio: accel: sca3000: use guard(mutex)() for handling mutex lock

 drivers/iio/accel/sca3000.c | 366 +++++++++++++-----------------------
 1 file changed, 133 insertions(+), 233 deletions(-)

-- 
2.49.0


