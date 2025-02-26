Return-Path: <linux-iio+bounces-16097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D0A463BF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5366A3B5B79
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F982253BC;
	Wed, 26 Feb 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mMKkrk1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E112222CC
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581429; cv=none; b=l2X3qJmcGu4J9ICcotFL7sZh97aGgEYs3U4gX6JCSWsqhcOZkAsBcbFOySxvYWTucSthW+26yrBqO2lVpSFz0/AGZPyYCOWpD3J0QYNqux6HsfDlSnKOFbX0XZWVGfGFNK9EIW80/uqW0I9rGYi8dequE5abnd0KYqrD0HVsoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581429; c=relaxed/simple;
	bh=AiBtlkpcTdJmU62MyZVlruSSe6cY2MOj4UoJW00/I1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBpHFROp1Bv4AAiZ6WConlsx1C41yvza3E2ioDB+34Jert8vexaZiZqCV80vRmNr9v3OWmMCfIZq6I+gtjsisEtPAmPRsAALe0jX9Jajj3VDVnQury072CN721cwRLYeKApk9N/ObEHM8ZTXxIercjh+b2KAmf6YAEBL9pIUIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mMKkrk1U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43994ef3872so43213085e9.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 06:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740581425; x=1741186225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0B5DTNgvnwka6JhdG1RxKRZQdylIuRKT1s0mr36XMI=;
        b=mMKkrk1U4oAhvNgDUXYB7mPOhiLokBNta9dqDUjYUUB7apPrvr5pJLEGFpXHP+eRYx
         qQrXSYLKGoz1HEHE82a/WLNRAefDTAp2VJHeagpuswD/LRMdHq+zvX1RPJMmSL6WHePO
         ptYLh6xM9IBB1Y2ADb5wASqH/mnJnd1DjwoHkRBZdHXZjDc85Uxskgws9vjLnCUj9RsK
         D1rNDJHtaiLgdCGeCQV/LdmkWWRR3dQ1FwMIiHMJ85H4PuioXu27clsdu5ZWAl+/UGQ4
         9p8pNMUmZlnQJLGhMDOHRVdaYHbztPMwRPMjZW3jGMad2Q40Pq9zP8+5xFu5jlPzU7ZK
         5Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581425; x=1741186225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0B5DTNgvnwka6JhdG1RxKRZQdylIuRKT1s0mr36XMI=;
        b=APSe8W29QxAdzv9WzKdREYN9F4yIaJYSwDNoke4oysdu+KgUQEmW1X5NeenKuv2kvL
         hbURlhUB89HhJf9qTrxdP/q7RkW4BxJEl0mhfXv6LK4J1ZOl25ehVDvbOP+kyodAh/zV
         mYAAXBNQyQdJ9QyhiSLs8xTz3BzD/hGDO+bWG87N0FcAewsmohc9eY//0DF/Txh4P95C
         dfDUob4Lnz7d4P9A0rXjIRe/wmJiATE3uDBsMvaND0576bRZm3f1cOPV5uPCNwVmkFhF
         RLVC4Y8LFf0h9UpFkTaDL5LgxcDaT4aYL66/VZWfsj9/ERYTzkIE+WsTUmL7xAdXo83M
         j4gg==
X-Gm-Message-State: AOJu0Yyz3FRQg4zfgkjYLwRv3Mss2ldd/UnJKFvZvoWojNIPYBDxJyvz
	HcNEiLLBEXyTRy289rc/IjvpcgeDPLOLg++3jPZ4gPbM+Qcjyyo16VfBObKrkDY=
X-Gm-Gg: ASbGnctRJkArLmKYfnM+bpiTtYtVCnYccK4Lq5UyO+mFstRZOlB4HNi99e9EU2TuMNO
	OabjKiKP2erlm2eeYx8eksQ9nDAlq08tmOfYXwjVKW6lddX1Z1UGCQL/LwVlZ5hAeMTeCiXsDFS
	v25XPa+0UBktCtsVNqoaDYtIki1MBOsvsZFkFQ5v077VVYLUtLU/L9xyedXzlbb5MRJ9Lcyk4/g
	G5f/bUFz/I0a6lWXRByM4ut42sFXmPBcVXTR6OMUsDxYYvzVIEJ+S63M/K6bST5feIW0Pkpn2dr
	MkBAG55VdVD1o5mv03sDtDFIChE9j79qrpKMicODoIAoUGCEMIH6IGfJ7NLpfuE1Nkh2W57GYvW
	gl8M7x7s+JWUhqgikf47P22Q=
X-Google-Smtp-Source: AGHT+IF606LkuiMsDjoxoFUsY5Gw5UF42U3bEMG+pWqETROOOXt9np0boII9VXCYLUynJeWaadJIDg==
X-Received: by 2002:a05:600c:5123:b0:439:88bb:d035 with SMTP id 5b1f17b1804b1-43ab0f2887dmr73970795e9.5.1740581425531;
        Wed, 26 Feb 2025 06:50:25 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549d6asm23747965e9.36.2025.02.26.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:50:24 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Feb 2025 15:50:05 +0100
Subject: [PATCH 3/3] docs: iio: ad7380: add adaq4381-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-ad7380-add-adaq4381-4-support-v1-3-f350ab872d37@baylibre.com>
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
In-Reply-To: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

adaq4381-4 is the 14 bits version of adaq4380-1 chip. Add it to the
documentation.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index cff688bcc2d9601a9faf42d5e9c217486639ca66..35232a0e3ad730c19b5201b74280bdb6deaa9667 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -29,6 +29,7 @@ The following chips are supported by this driver:
 * `AD7388-4 <https://www.analog.com/en/products/ad7388-4.html>`_
 * `ADAQ4370-4 <https://www.analog.com/en/products/adaq4370-4.html>`_
 * `ADAQ4380-4 <https://www.analog.com/en/products/adaq4380-4.html>`_
+* `ADAQ4381-4 <https://www.analog.com/en/products/adaq4381-4.html>`_
 
 
 Supported features
@@ -52,8 +53,8 @@ declared in the device tree as ``refin-supply``.
 ADAQ devices
 ~~~~~~~~~~~~
 
-adaq4370-4 and adaq4380-4 don't have an external reference, but use a 3.3V
-internal reference derived from one of its supplies (``refin-supply``)
+ADAQ devices don't have an external reference, but use a 3.3V internal reference
+derived from one of its supplies (``refin-supply``)
 
 All other devices from ad738x family
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
2.47.1


