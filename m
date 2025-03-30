Return-Path: <linux-iio+bounces-17333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F2A75984
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 12:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62C33AB9FE
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11581AF0CA;
	Sun, 30 Mar 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GIagihhS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CD156F5E;
	Sun, 30 Mar 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329981; cv=none; b=MRBBH7OEBRWYAVDazRa9JHtk1lRJgHFQEVGI2Lmi2sEwPXMtrmkCXCXXWFIbBzLkfx52UJbpuG/LEqt81tOtbcqymYMVWJsbUHZlrp/ui4W2AuxBPaTVd5q1w+GSA8/xpmWSOL5fzNdi1lqJQhloc6EdZtWDqrRx44oWIbdqfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329981; c=relaxed/simple;
	bh=I37r9SDMxLBROgUOZE6+G/DI+4Eulr1igT/HMPRemd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUJXNCgC1e4xfnneIcpmAC2s3j7S/30LO3UAYDTJHeoE+E2aVyaG7cYEHhfsxZ648eZYn8KuPIBrTWRwoPJMRqGCrh35dHxDQ3L7tY1Aa1Sxjxmb5gFvvy2I7o9mm1d85sKfSwEsYXJFTGlOEDvpQ+TmASnUJOzMELdCq1jzRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GIagihhS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso6941893a12.2;
        Sun, 30 Mar 2025 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743329978; x=1743934778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFZ3SyUnUFP6g3RoNH2rAWHWsI1Dx6a8W3EREPo/yvE=;
        b=GIagihhSB3njWCKhTgKndWfuy1zCJ1NpxnLJGetYLtiRsPSE8UaTP/27FYTxqTYyT9
         zwWQyik+53/1yhypOnuZh6cUSeRJAeqdr6meX7i+2wOIrSD7Z0blaYCJcv7I64CvhQtL
         hmOHvVjXEBcsqkhhPqLwaNUcH5sekZw1Bvpw5+lc4wg9KwcvtQ4eVHs7diPYkiZHUlxj
         fqB2bfvHGvkeWp3fsP+D3v8LKtVa1Nd2A4QbI/uWDigWHTZ0FqDTEozdivQmKcPc/sDH
         j3+UMRxOYzerSz9iH9K7yARnUm+EnEovTVEWX41F1rWykNpowQKL+QHETn2gduMibvqb
         DHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329978; x=1743934778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFZ3SyUnUFP6g3RoNH2rAWHWsI1Dx6a8W3EREPo/yvE=;
        b=kt4JFr6vqMwLLdGS2xJhQmMWo6o2U+VDou6Pq1tD18OOqD+ld3sVa4cmo2fKatSJDn
         QdT0WXBLY/LZOVNcmhdjDMmG4d0UB7jSokceU4ZMY212Y/GK56egiuM7MYea7gTNDKMW
         TrDLiAQbouLOWcwM91zrrrbRwW7ingVFAOnEa83Aiey+f/+8j96yvBcEg8AL8T2AwbUx
         R9BuOYD+TOrlwpvakJjKvx+YtT+2gYIl3LgEfHjgFbcFkQQZVT69ncxRRAhkqqyQECZV
         Ba9D+5Rm5gUVn3kD97e6XnGeGaucjmG1A1G95x4nAnZK7k2OxBK6nvCiO4aUCoVpAj+Z
         cymw==
X-Forwarded-Encrypted: i=1; AJvYcCU2W8bPAi4cGw6tuLLcz33xL4DrKSjpb0qY+DzlHOKWISUx4nNr3IMkzLvVfpCiJeQI9tID1/I75trN6Cii@vger.kernel.org, AJvYcCWCGxHaGPASK35tPwaDfxTzYdxzUjBc6cgbjXae0awhb7xk4UsvRxGBk7P7Mwo3NYD79U4fCiNidqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Kn5ho8rKK8ZPVYYyTPYMPT0hX27Q5nvD64dgEyL0927szAnR
	NvbM/Lelyxz1Ejw3gboB/bV2UWbaRXBmsDIUNdpo/e+3d6X3/7bJ
X-Gm-Gg: ASbGncsGXfyRLwKxEwl7EBe8JmLENvI79LYjgh/2/3FIgN52q4GxTLDIViJreq4o5mZ
	224+EJl2feVIYrM+9/o7QUO7YocT+axMgeuF0SO4WI9U/IsLl0bvl2mwJ1+ntDcL+fX9GxwHYYX
	f0t2QzqkN0qgWpHm9lSsP/yjakGcc215ZMvaxbPTj3oD50oQzn24O6f147rdTFiIsf2Rt72X4zR
	4pBDu206rDthtwndYjd7GA5sGZLLgY6081+bPelDZUdQyOzG/TIxsMZUcV6E6Z27oUlDci8IKM0
	bo6NGQJ87+08q2y8zAhrKSmbjeimoFHPPkGJtOoP2QqbN/Phd6zq3QPx66BFGvkKujfpOGtNeI5
	FQIVu2wuME0ZDKpoc8nQFJFM3EMrpRzER+zCg82sLAKrWEGDcKRGKwu0tIhRGbqHK0H15U+BazS
	7pcwjF
X-Google-Smtp-Source: AGHT+IFzaM9D7vunf7JlSpNngmanlgLm7dWuOj8JtuMc99YkDjuuRnxWZlzBdqnKqounaNnHZZeR9g==
X-Received: by 2002:a17:907:7eaa:b0:ac2:d1bd:3293 with SMTP id a640c23a62f3a-ac738a66928mr601365666b.19.1743329977947;
        Sun, 30 Mar 2025 03:19:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad73-6800-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:ad73:6800::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac71922bb65sm459288866b.34.2025.03.30.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:19:37 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	christianshewitt@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] iio: adc: meson: add MPLL clock workaround for GXLX
Date: Sun, 30 Mar 2025 12:19:20 +0200
Message-ID: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Amlogic GXLX SoCs seem to be mostly the same silicon as GXL. The only
known differences are:
- one less Mali-450 GPU core
- no VP9 codec
- and an odd one: the three MPLL clocks need a bit toggled in the SAR
  ADC register space

This series attempt to fix audio output (which relies on the MPLL
clocks) on the GXLX boards. Unfortunately all we have is a downstream
commit [0] without any further explanation (or anyone who wants to
provide details on this). Since it's not clear if this is a gate, a
reset or some other hardware fix: the driver side includes a warning
for users to update their .dtb along with kernel images in case we
ever figure out what these bits do and how to model them properly.


Changes since v1 at [1]:
- added Krzysztof's Acked-by to the dt-bindings patch (thank you)
- added Neil's Reviewed-by (thank you!)
- fixed meson_sar_adc_gxlx_param to be independent of future
  to-be-upstreamed patches (fixes a build error)


[0] https://github.com/khadas/linux/commit/d1d98f2ed8c83eb42af8880ed8e206aa402dd70a#diff-c5aaf54323ef93777c5083de37f933058ea8d0af79a1941e0b5a0667dc0f89b3
[1] https://lore.kernel.org/linux-amlogic/20241231194207.2772750-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
  iio: adc: meson: add support for the GXLX SoC

 .../iio/adc/amlogic,meson-saradc.yaml         |  1 +
 drivers/iio/adc/meson_saradc.c                | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.49.0


