Return-Path: <linux-iio+bounces-26567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97173C95197
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A11C3422EE
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A827F724;
	Sun, 30 Nov 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIurIvZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514722D4E9
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764517050; cv=none; b=n4w+ObgRtYqJ85LABevg2We1zgvQLgkPlwkF7Z0qvK/kKw0e1oalFQMOFIZa++PENZIruU71A6mAjLX4C2objHrU9MdfYsy+goqEIn4gmwu4unZdIURsTTfJteATn1AcNwZqjbHI9RIVzjhVkeuSS6PtGvHOUMWlMvoiAvsKriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764517050; c=relaxed/simple;
	bh=gJ/wBggrSvfll/tchEcHLURm8su12Vfwr0RSdsUT7Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W0fAfzcpXN3i9DJQDWbfsYTaeiEUwZlTVF1bM/c9rrDy65aFYQ84z2ZwbGgV8JHVoTccujc3jbHhYveCA1zF7wfA+fWLjJh8en8jNnPK9YSXuv7WjoxqKaow2HwNsJjoElO0HHuToybv5+jS2DNuNFWOPzhnEye7unPkBvmpUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIurIvZj; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2953ad5517dso32310515ad.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764517049; x=1765121849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JL8T1DOVjau20kxpBDZiXNqW8JjvL5Ds9csL0Ast2M=;
        b=kIurIvZjLaCoSapxrvC+293r6ffMyHnM9XIYItRwYih1yKNcXeG0i0iCX7M2mLzw1i
         vh694xLchP8I2hOSGyK/o2CV0U0koSo+BuPxmI78d75UsL4lgO7lHl13hApGFJpWdH/o
         llGDwHaIH+3GWbRgMe9FN2sav7kD3+pNqVeu1lptBQTsMHYNnh7dv05pWCf1/j/CM42Z
         HuPPuENDr2yJXrTLZC3uNAKxyEGQZ8max/fOrWh43AmiEybsSDylpu4qxER69L8ew/Wh
         ChTYznRjx9bWpdWl2rwp+SN9CxcpEq4gwYY5yAlj3t++fcitagvTEmH1NFMi18/Kxt/R
         l/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764517049; x=1765121849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JL8T1DOVjau20kxpBDZiXNqW8JjvL5Ds9csL0Ast2M=;
        b=xVfoAKGAnJDep94o4Wg7lBhT7+kkjmoPzFqwkoBPHGh1Pw275aUNvkjpokrao6IHb1
         Ui88UkXliBVrWW39rVaRny+RhiKkPFmNP6FsEAua5x5c+D8ATJUhlMfitDUGd5/v9HFf
         QZCSVa7GvuVCwMCEkeUdGPs1D9GXdLXLbeMnNiGohmbVg9Tw1D0MANf2VoAwekct62r/
         KYcTip/WcfDLnSyusjGxwDdP95/ByRndKLP2Wm11mNOz12yEAhhFOTPz5zDLkDIus8nx
         E0D+sIircTE28OaIAGsom56gzKzVc+aD5n6PmJ24AE9orFKYdkPbO7Qd+AM+hHR1m7fY
         U3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvrppEIDMi8FM2U0ol/N+GCXYAJuT9PjVlReTGus5bEMqTSDCJ+vMvfTg66ud9ioRsH+/WXQk/x1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4OcTZzTEtm9UDwuzzTOs4d0LdgF9apjWjO21TC8V2icGJihJ
	1Kee/yoNSlDPN4Q0avRMG7S42tjPXH5tkF3CF36pQU9H9GL13jhpf0SJ
X-Gm-Gg: ASbGncupwCn6cKTNNbYWkBWEiju6NlCV1JVtjdlHGIArL+q9YcZQi9dpaMvXzvqezdD
	2hN+wNwmvrPqGDOozzjJ/2OYp3LD47Lbgv3iyu4aT5cQdVVxT19PPNthLUR6b+kofVjo57GaENX
	RH1mx5/6tfBCBcueUq9JALsb8BrVyJvl20ym6byHFUjQC233eaYYDkKL+7SxlOaTPzpEXZj435N
	KWzH/EWkdIV4zksUgkrtcxqF3gD+VJy1o/RLwTLgJ3x8PSNgEd8Cll4IQIBmj0/bxhA4QDQXqKq
	aB/7E5ZWM0nMkziHN0X9GLflLmPeIi14U9BZ4vrNj2L8KfGAFKxhJmcIYEJyoI1d8Fw943ZOWYG
	mMA8OaDUpkquPlHED0om3qLxtwjatxHZzQsyzziIQc6ONo4rDxOiUcj0T14gdotRIt0X/WJmbKM
	QPO1ssLlFMlpN/IPgRWkzgyQGn
X-Google-Smtp-Source: AGHT+IHysbBgfy0feFPuTmeh6QtBC3zsJOGFsze3xPixNwFnxUGuAmkua+N/8fVVZZxCr44jmZYhNA==
X-Received: by 2002:a17:902:ce91:b0:298:321b:2694 with SMTP id d9443c01a7336-29baaf9a626mr264863565ad.19.1764517048742;
        Sun, 30 Nov 2025 07:37:28 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm6903483a91.1.2025.11.30.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:37:28 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v2 0/4] iio: proximity: Add DT and interrupt support for RFD77402
Date: Sun, 30 Nov 2025 21:07:08 +0530
Message-ID: <20251130153712.6792-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds:
 - Add RF Digital vendor prefix
 - YAML binding for RFD77402
 - Device Tree support in the driver
 - Move polling implementation into helper
 - Interrupt handling support
 
These changes enable DT-based configuration and event-driven
operation for the RFD77402 Time-of-Flight sensor.

Changelog:
Changes since v1:
- Fix commit message for dt-binding patch
- Update interrupt description in dt-binding
- Add 'vdd-supply' to 'required' property in dt-binding
- Add patch for moving polling implementation to helper
- Add helper rfd77402_wait_for_irq()
- Code refactoring
- Return failure if request IRQ fail

Shrikant Raskar (4):
  dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
  iio: proximity: rfd77402: Add Device Tree support
  iio: proximity: rfd77402: Move polling logic into helper
  iio: proximity: rfd77402: Add interrupt handling support

 .../iio/proximity/rfdigital,rfd77402.yaml     |  53 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/rfd77402.c              | 162 ++++++++++++++++--
 3 files changed, 198 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml

-- 
2.43.0


