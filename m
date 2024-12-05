Return-Path: <linux-iio+bounces-13117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80FD9E5CA5
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628EF1883C8C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460C22579A;
	Thu,  5 Dec 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrHy9fVv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02172224B1D;
	Thu,  5 Dec 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418835; cv=none; b=Qaf3HvsqJrZnAVk19oLkXFsjwaaZgbhRpZ+SSMUSc87P+3MbRLFRkguB1pHyr1gLecAnDyvRwiJ6pW6LXo1MhFH17go+3dGuY0UOZsQ4igb0oVnmo3fEmdwPsL/VOPlARZ4w8rWy2hf7FvKdHYWcEbtPO9BuASMARaICVPsGdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418835; c=relaxed/simple;
	bh=MJRcOjRxqauR3VIt4oFjuLbKiHlmawUNI5WmBsNNWfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9v0cKoIRQJcOnRVyF2pzi8TnZtRZhsv1Tbtz1BxmgQn5aLz48O85POjtGjXSPrtnxQrUDdHQch2ANqTMcIDV3aJ3n1eQQtAYYijsHy/Kx3xeO1oTzH58HRXr368M321IHfFALw7r7OGaRkuFZI0WgNmNaNc7hkZr0EHUxc+Ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrHy9fVv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0cdff12b4so157738a12.1;
        Thu, 05 Dec 2024 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418832; x=1734023632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItFtpbeRue66V6lbrgr6VbuNzJvE3GBXZAD5o5I2hDY=;
        b=KrHy9fVvMCOfY1DK7S3xT/vIGUgVLu0dXC2vPz/acvlopp2pIwZPzpY7218M9LqCRv
         tXUavNoOXBRFerD366GqeE/ADldz8yny75I+B+zd9x+uDsVFba8yJYVINLMi7SYH2Inx
         low4hL/q8MkFFAxxvHqxp8WaDYsPyzQetrxMdOvdYd6yNge7j9DHXulh5wmrzynPStRB
         u/X6SScoIj8wn3hHkZhbweaHUzVFQU8uarVK8njYlxjn9gFn/ksEorrNTBe9VHdZB9zc
         5HlfGGoh4c5/t/+7ZWJwrbb+QQR4ldhNENBXd+k/xbL2gXu+ZW6TOfJ/u6xMPIk6zpdW
         ZT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418832; x=1734023632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItFtpbeRue66V6lbrgr6VbuNzJvE3GBXZAD5o5I2hDY=;
        b=RbnpdbH3piKGFpeIkIY6LEJliDl+uGZtJd0X6iRsdMW+VywMVUyeiAQK+dDbaDTVOH
         AuTOD3TIguMa3340yIjPdE7nxjlilT7LZTIGYLeg49d9HRJSLn4gQpmKOyCp4lpNQ0QL
         4fWK+z7IlPCjgAPkwOcG0yXu0TCkLwg9De3TBLHDYzLf+LeCBfZFin7/Tcqh8lZVE30Q
         h+rd8miw1f8dORdam65nK3/zkz5Cz+QAAXmoC7kmFau+jgaswGIs5O2LQm1gUvjl8Eoi
         RelcTQu0bdEFjse7WpwsEaksVy2j0VjoWtfyHnRbmRO246qZcFL3r7f9xcNYE+to9WQX
         f8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUA3Q0KVmZ1FPtVZYo6K/8wTW8pOxTtE/IhZ7S5g2CSsi0oDQl9uWW4laLbqI/yE7vX3xSSEGVI3nkEoA1l@vger.kernel.org, AJvYcCVG0IIpDNaDR3xCKxMzhb14+lS1dnuZuHtvpOt3MfTPDuJdNIm2LvKIQ/VcScZVyDRODvT/VlWrguQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycuhWYEQy98hcJz8V82o9JLUv9XSI5ahbYU2+qW4Sw4MC+Eiyp
	ELVlqCAinf35ljBUWPP2lUGyBTBwxQpCiFjWN4nw41m1PLEvSUNJ
X-Gm-Gg: ASbGnctG5NbuuTJqZehapao1n0fgXUTiO2BErUhBJEd6quCCDcG7pqhZMWLXNxZrYdq
	xDJpFo8npC5IePJGylAorc0gUo4IV+tpLGsKSVa4Z8Tjc+sNLRKRn2ohLVbvhS0iaRb9pZBG7lS
	XWwLveAm8rsnCq/e4zOKNYPkP16xkRdL7xoWYZKkBdT3X43NuIdOgRanMW6rNEC79Z+Ghej/qn6
	8syzaYo7R4sQ0Y+8LkdVz3sLj7yrQFUNG4sCxI/9A43HcqVgL+DLhtVX36jkC5oVpgJ4qK3KOzY
	fiLUGtSFHwdTjUjP00IayDlKkjTc
X-Google-Smtp-Source: AGHT+IHmtP89Hd42kGV5XG6wzg+Ft2bMoyYlcGKQLUi4Rsl9ZPuf3KxmWSund5x/E42vQ6Oqh+dizQ==
X-Received: by 2002:a05:6402:35d6:b0:5d0:defb:ed2e with SMTP id 4fb4d7f45d1cf-5d10cbaaf71mr4362107a12.10.1733418832125;
        Thu, 05 Dec 2024 09:13:52 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:51 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 01/10] iio: accel: adxl345: refrase comment on probe
Date: Thu,  5 Dec 2024 17:13:34 +0000
Message-Id: <20241205171343.308963-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refrase comment on the probe function, avoid naming different hardware.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 006ce66c0aa..eb3ce4434a5 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -169,8 +169,7 @@ static void adxl345_powerdown(void *regmap)
 }
 
 /**
- * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
- *                        also covers the adlx375 accelerometer
+ * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
  * @setup:	Setup routine to be executed right before the standard device
-- 
2.39.2


