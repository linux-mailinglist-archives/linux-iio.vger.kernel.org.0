Return-Path: <linux-iio+bounces-11493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB909B36BA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1645C1F227EF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DC1DEFDC;
	Mon, 28 Oct 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XAqe5VyG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1D1DEFF8
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133504; cv=none; b=tQ+9gPtWu+vShkbuGtvux7DXNyTgSQ05tEmtco2cAjeLl+LXYFxQYlzSt9KRUC99+sQb3wzJ0y1rolOip9OOK9j1ra41TAjNEgot3QvPtQQGiKY+FEKFKqIFcvSwRk83EGXwCWO5vSIufsHfZior+xzBjfL060GJtI2HKT2bztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133504; c=relaxed/simple;
	bh=hHJXDmhylRh3O3BFx5xZ+s06isPtPyPXfRia7GR0aDw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dHkZbaKTM4surkQzOU5axU0MBfdbOS9QwtBkDBilZqBFW5zlPnSSpQSeGTr1rMVWq5K5TV0fZePXPyVQVnubpqeznX4XRcNT1Zo64t9r/QBSdv7R1UoLFGAWwDOp9ZnYBQZc7vD+NeIYeR5w5GyKPSCVlsuHSzEcUIxQv5nMamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XAqe5VyG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso3739741f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730133500; x=1730738300; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q69icp1hb78J9SPv3nCWelkJnu1ZqcQlll/pYihOIHE=;
        b=XAqe5VyGbr5ec+YHnEI6VljLBe6AVRpqEwEg0pJvAUVEEwhR8ORcaiKEIEjFWaav9h
         sZ2mOCuQdrVPOSZQ4/GB00smPAM6TpBDxmOWhW4oxW1WmCUzWHoBgpOgAI4XH4vMt82f
         pg/J13/fIULSRe5RL0IfgaNm4phBr0323C0JoslV69qy7m57K12aoyfeK8aujQVU53qy
         Rd/HdDubBL0Kj/VzJ9e5onI3X7iDbWufqon2ykBwLnrqRRyvQ4mkkB9DBdjjbWmTERUO
         Q6ZZzMuzYWEStp0cWQBNyt1DG3u/+xIptFFGhjYrdXEg+HHrgrBM61DPjXR90VlW7tk1
         mlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133500; x=1730738300;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q69icp1hb78J9SPv3nCWelkJnu1ZqcQlll/pYihOIHE=;
        b=Hk4A+JtwxnA58f1QqP2liuIZg08dFm2/sq7bRYHKHJ9B1sUhVeYGkXcls9SP5qZ0wu
         k1ZfkD+H5LoXzswrwZUMLLPLYUo+nXVBFbGgQkwyURiOaIPIX3yEX8KcEvDMdgLR80Hn
         mXsI8B4ztcZljOtx/9EZVFBH8C20y5mjKBKFTGUfYhMSqpCSwdM/F9XfUlQKVZ+SRO17
         z6tIMe3zZfpt14rdprrUhXBrY3bx6RivHwKwfWckjJ2ISksUedR80E9vyHidc6kWWVMY
         sE1aCL0dramQQbb9j0gPxXpc0KjgKsT2jU2APZV45U7sgX8ai6TSiK068GmSnsLG9m45
         QgAA==
X-Gm-Message-State: AOJu0YyqXs3XnJFgIP1Dfy1STghl4oxs/wK7TjMpBmsx8uyCnDqLM9Hd
	AfIJiehlhbpKRcH1vOxjISY75ln3Fypu6Hx0FMjEHHYWUR9TAIeB/XgmLFo6ipQ=
X-Google-Smtp-Source: AGHT+IHpRSLPeME4Yr5ESp52IQeBhy2ewnStphm9pY+1vq0l7oc8c3AUToEMUzoFjVjvRbMpG5F9HA==
X-Received: by 2002:a5d:6a43:0:b0:37d:890c:63e4 with SMTP id ffacd0b85a97d-380611ff53cmr6728013f8f.55.1730133500360;
        Mon, 28 Oct 2024 09:38:20 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55d753sm147308435e9.11.2024.10.28.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:38:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] iio: events.h: add event identifier macros for
 differential channel
Date: Mon, 28 Oct 2024 17:38:10 +0100
Message-Id: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPK9H2cC/x2NwQrCQAxEf6XkbMAuPYi/Ih7iZqKBuitZKULpv
 7vtYQ5vGOat1BCORtdhpcDizWvpMJ4Gyi8pT7BrZ0rnNI097F5ZVPktOSpbDcaC0lcoXzdHHJ2
 6GWKvZOb9qGBuPD70IqaSbUrUDZ+A+e+w3+7b9gdwI4u+jQAAAA==
X-Change-ID: 20241024-iio-add-macro-for-even-identifier-for-differential-channels-1bd8afdacf42
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Hello,

This series adds a a new helper macro, IIO_DIFF_EVENT_CODE, to
specifically create event identifiers for differential channel.

Indeed, currently, there are 3 helper macros in iio/events.h to create
event identifiers:
- IIO_EVENT_CODE : create generic event identifier for differential and non
  differential channels
- IIO_MOD_EVENT_CODE : create event identifier for modified (non
  differential) channels
- IIO_UNMOD_EVENT_CODE : create event identifier for unmodified (non
  differential) channels

For differential channels, drivers are expected to use IIO_EVENT_CODE.
However, only one driver in drivers/iio currently uses it correctly,
leading to inconsistent event identifiers for differential channels that
don’t match the intended attributes (such as max1363.c that supports
differential channels, but only uses IIO_UNMOD_EVENT_CODE).

Adding this new macro to prevent such issues in future drivers.
Only one helper is needed for differential channels since they cannot have
modifiers.

Additionally, the descriptions for IIO_MOD_EVENT_CODE and
IIO_UNMOD_EVENT_CODE have been updated to clarify that they are intended
for non-differential channels,

This series also fix ad7280a driver to use the new helper.
However, the current implementation in ad7280a incorrectly sets both
chan1 and chan2 to 0. To maintain compatibility and avoid breaking
existing user space applications, this behavior is preserved for now.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (2):
      iio: events.h: add event identifier macros for differential channel
      iio: adc: ad7280a: use IIO_DIFF_EVENT_CODE macro helper

 drivers/iio/adc/ad7280a.c  | 14 ++++++--------
 include/linux/iio/events.h | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 10 deletions(-)
---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241024-iio-add-macro-for-even-identifier-for-differential-channels-1bd8afdacf42

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


