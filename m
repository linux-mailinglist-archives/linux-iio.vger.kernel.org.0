Return-Path: <linux-iio+bounces-14740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD213A2334C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BE318882A6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56E7148304;
	Thu, 30 Jan 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2JFpPNoU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAD16F282
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259141; cv=none; b=AKXiBgsrboyzKemv4ZpaNW//hZdr9mZxwGg6hGMVlvX7SX7xxCTmsKGrx2DYFasDy6soiV2P1zqcm1y3Vspxcy9JddOFlC3zkx5/ccLJHPGqXtD0YeEWvmxFeBxtvnsjnKJieOZQtv9Yb8lNljPNfNXZMoYI0iE7CIZEZjNonrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259141; c=relaxed/simple;
	bh=Fr2UAtp53rdVn9W2p6nAF9LyjAXysmHa0oUrGKzl8pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYb/NOsows/9vS7kzfk0nDJ79OkTRbPvE/W3d/zWhaKbsvEHk8rhf/MHjQWsIaksK8C7ncCqMv/p7pq5MsQsMWUOKEZQ/FOq4sFjDFEUjyot6HMq/+d8AySZ11XSlUVlE6DXXsmJUZ6bYjf5la9Xk9mrZimxn/7fal02gnvy58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2JFpPNoU; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so1756639a12.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738259137; x=1738863937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ1qbmNoFtzX39YhkCHwQ31EJfBQJsCwuViqHYM8ChU=;
        b=2JFpPNoURYk0LTJF1LlcMDzMSdZNqIRvZ/ocW9jRkG7BUpGkRMKlnTfC9/ojakhzC5
         EtsBPwkzxM9JiMFkRamzfdVPrWmcVG1GCWwr0Fr53/MvjsEtq71aJQLB25Jw1+KQJ+S+
         YKHphQgdbyXwhhyn/ceDDShBQ6ugrHPXMsMmAMCIpIn1pkP1Th955zw4PAzP/EP3zTVc
         V2uVyivslQu2M3EEpUGqqWLuB4k0aUIMLkmWan9+rAsAzf/4EUXuYnUyuwVQ5+PnoSgf
         ra/h/s0drGTJfZdiiuED5YHthT3TnKPzSaG6zh6ZWRzScX5MT1iW5k904TgDs3e6EsQ+
         Jskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738259137; x=1738863937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQ1qbmNoFtzX39YhkCHwQ31EJfBQJsCwuViqHYM8ChU=;
        b=LV2MXsmTU8nu6ih7T+vLEQ6IYzUY1nPjYBJEw1PxPAseEjLkg6a6GeiC9zwdPDH77r
         hIY/nWxaUtDrSjK56B9CHYGsYn9M4EFG7ybsxkOeNaKROEhvd7h3KaUxCg3wHoKR7mHt
         TqH0loKTq1XpwNPHOxHDreqXzrCSVkTnwoWrXz153AG4Hilolggh91FpiHrXu79nKssM
         0oBnykFrG0RTjQq/PA8hl0OgH0kKrazMXEE9kz8zuQs+cMPrhr5u4EJ6RgfQjSYeOQfv
         6bfQD1s/PH5T93XJKYWMAr5ORCQ5nm0bDf5GKLiVPB7OrCkmgsGfpIH9Ox7xbo3/DVTC
         3/7A==
X-Gm-Message-State: AOJu0YyYukcvl099eRBlhkYwIO3ZzaS7kPE+0SvjxH3N0HMgIccNdDk/
	3tIV2uzO/npKlzB2+Q19OFHVYp16T1submd/6Z8oXiVUWxIU/Jgx45BiFsGk4ss=
X-Gm-Gg: ASbGncsNPGERRVkb2HcEhfg+KpKIJ/nk+jinTv2fpRyTbHChtdu2KAx/oQTSq2P7vdq
	WG5+9TZeYlNPC128DI7p6z1ZSZQIABVDys0e852HM9KkMdhm+6rG07R/r7gbjidYwf8soV89O1M
	9GvQnooMtj1kKuLlLe+FTGscsCZpU6boh6BW3zxpTbZ4d8QGckUcU+JZ+APFUw9PKujsrVarLXL
	s7UBkB6hawWj0kLESI8SmDa/wdTjIiE3TjNNkNLu6CWWxr+x18nyEcJDG4VbtBZoboRv0jr129b
	3tbCshQW+IerXxYh/+VL
X-Google-Smtp-Source: AGHT+IFwMz7ly42qGKVg/zE8b98VuDP03pCy/AhloNUIkdPpKscsLlNWIx8KjgdRr/UMtNz0ENNMFg==
X-Received: by 2002:a05:6402:348f:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5dc5efbf626mr20304884a12.11.1738259137343;
        Thu, 30 Jan 2025 09:45:37 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f1db3sm154561766b.83.2025.01.30.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:45:37 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad*: Fix comparisons using memcmp
Date: Thu, 30 Jan 2025 18:45:00 +0100
Message-ID: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Fr2UAtp53rdVn9W2p6nAF9LyjAXysmHa0oUrGKzl8pI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnm7qdEtsb0w1jeFIW3kD1FCYk76te0Qf7oeWqD EsZF4eHuAKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5u6nQAKCRCPgPtYfRL+ TnJ4CACr6RJSYgizs0AvYKJ1T+vvgKGz+Z8xK3vG8yvKC/SHwqCOrmPWciT1sro+CenUE588pQp nV+Ac67so/3TULyA/EWodbChFeKE9PEf7XXjh0WGK6q3jhdKTYxqbCoq9l+nyo3FviAWtxQrAsb EYA2Qk+2bVlwZPUM64sY8FQXrY9eCqrF3lI8K3F9X+JEMvGlX1ZQOjF8BXOU0yIDGR/qnPxUDTH KozQhkmP77aiiJfr+w2fgcSBXgJ0Z+0iqMnF10I6XRc0JcxHZpemUtj5WqShCjuswPAuOd73Plg Ee0dzPOCvJPR5RVOvstAuIwuc7GP1mvj0iUNrNUCxnsKnsWK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

I recently sent a patch fixing a bad coding pattern in the ad7124
driver; see
https://lore.kernel.org/linux-iio/20250124160124.435520-2-u.kleine-koenig@baylibre.com/.

The same pattern is used for ad4130 and ad7173. This series fixes these
two drivers in the same way. As for the ad7124 driver this didn't break
in production and if the memcmp comparison wrongly returns false,
nothing bad happens. Only usage of the resources isn't optimal then but
that is probably nothing a user would notice. So there is no urge here.

Still it's the correct thing to do to drop the comparison using memcmp
and compare member-by-member instead.

Best regards
Uwe

Uwe Kleine-König (2):
  iio: adc: ad4130: Fix comparison of channel setups
  iio: adc: ad7173: Fix comparison of channel configs

 drivers/iio/adc/ad4130.c | 33 +++++++++++++++++++++++++++++++--
 drivers/iio/adc/ad7173.c | 15 ++++++++++++---
 2 files changed, 43 insertions(+), 5 deletions(-)

base-commit: a13f6e0f405ed0d3bcfd37c692c7d7fa3c052154
-- 
2.47.1


