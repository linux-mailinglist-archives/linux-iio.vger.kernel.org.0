Return-Path: <linux-iio+bounces-4317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13E8A89CC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 19:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A96B1C239A0
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A3172781;
	Wed, 17 Apr 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfB06bTX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05A171E59;
	Wed, 17 Apr 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373471; cv=none; b=d8NHS4TIf7aGvbjj8XHt5Rzb157JqRRqPwyyrzVO0kUQClOUisEbryiZc0U2NunIIzRl+DOMgDjEwOMxfftMK32q4GLYHiD6nW4zfUWVf9wGQ5svsHbx4RIpZvrGdrbeGJaOvRjdhGyE/dgC9t5eXvs8mubfCA3oW0lI++JxgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373471; c=relaxed/simple;
	bh=fIKOLKWTxB083m3S7ogllEU+AR/b1bZP165v0nLJgyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xvoba+ZgjADnlfvOypOnn8GORqJe9rWz6ifkd0vJcxen7VgVLYorEmL17StqANROW2UCY8vvXd/tY9srdiyLfTQW8VpYbTjZrrfc5/4Fkge7zCM5BD94Cj7I995Wu534AhZvA+d3ldnNi9SpxALKbfMQvo7vHsiS5pC+fF+YRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfB06bTX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb8ae9b14eso1705271a34.0;
        Wed, 17 Apr 2024 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373469; x=1713978269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnDj8AkYyHP5FgPYgPq1dtF6Gy+NT5+5GBKZUHlBHno=;
        b=mfB06bTXRRKMVGpzFPlY5cS2zwhZ1C0njSzd+15K5cKQ8/VLp0GHNLODSflaN8l4hh
         c4919s/Tp49BK789Luf7lplUNjF94zuESbDVCertejkfbpmutkCmpghMMcZ87wulMC+N
         vNdzV5LuipHoar/j8h2F7OB6dmmK0xi/A0WaKiDzVTlyDnwiMwdHDdt2q0kKa1AqFaDn
         HDZs05YyOqANH457uGmIXTcDVGaTPewOZ8K38bohfeq+pAQmg21EXdHRfnohCPcgrqLa
         kn7boelouO69dPUVrn1PV1T/2PXbHbLi+rjWMK9EPnwt3kHCNOFJmW33dCmFDRNfRSNu
         bIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373469; x=1713978269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnDj8AkYyHP5FgPYgPq1dtF6Gy+NT5+5GBKZUHlBHno=;
        b=eEp9hfuG5Y77fQpplQvqQ1y+Zc2wkBN9Q9OlRFEIYZpOMgxP2O/7SFSazkdRE+4umb
         F7u18XBVpw9zO3apLZGWoe/Yj7XqY2IxqR4Z2ydJKAQ45rabBDGsGSDTrrBizjYfWHvc
         kNq2hZLyQZB0rN8280tN6cHoacLVGXGACfdPXsvYT1UTSUKvhHUZLg27Bzxg4foXWKuy
         Tih6Kwj9LnV36Zn1lNSj/2s3TTDd3EROuGxfL38ChOWd3y4ae1pqzExEsOcIoRIR2dpH
         8NsvVOHjrbJDzU7BZC47L9ZKyh64wrEm57H4MGtFCnOFH7mi92Ic17MQjXNhFhVpAZcH
         pADw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmUmW/IU3A7qUsoP66Nx21W7Xcvse/Fml+W6ev7TNtrSxVUImpV6kxXGro+5MjHEpmB8lHuRpDb02aYRcJl0W43uHBhsF127HAjjOghmxFfZlkmH+IWjltXr2LT94A7O5ZGInxw==
X-Gm-Message-State: AOJu0YxXP6JrOB/IecH//0/bC4wwwYng4gqA25lMCPKNSQ6wKTpzxhfR
	K+5iOo5llcaZLBT7djAWs1WcUt2PaQa1z8xpWQL6gYD2Z63DP4QF
X-Google-Smtp-Source: AGHT+IGUEpdZ43OwhjDnGVsGC3xESlw9v3kYAOkMg+9vvhbiEUXF9l2XlN9MhwrFlDCAjBjR+PS8SQ==
X-Received: by 2002:a05:6830:18d1:b0:6eb:7b64:e5c1 with SMTP id v17-20020a05683018d100b006eb7b64e5c1mr51443ote.18.1713373469336;
        Wed, 17 Apr 2024 10:04:29 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id k20-20020a056830151400b006eb77e42ff5sm1721615otp.26.2024.04.17.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:04:29 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	p.zabel@pengutronix.de,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3] Add GPADC for Allwinner H616
Date: Wed, 17 Apr 2024 12:04:20 -0500
Message-Id: <20240417170423.20640-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the general purpose analog-to-digital converter (GPADC)
for the Allwinner H616 SoC.

Chris Morgan (3):
  clk: sunxi-ng: h616: Add clock/reset for GPADC
  dt-bindings: iio: adc: Add GPADC for Allwinner H616
  arm64: dts: allwinner: h616: Add GPADC device node

 .../bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml   |  9 +++++++--
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi        | 11 +++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c                |  5 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h                |  2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h           |  1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h           |  1 +
 6 files changed, 26 insertions(+), 3 deletions(-)

--
2.34.1


