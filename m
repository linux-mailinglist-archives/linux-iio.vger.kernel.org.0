Return-Path: <linux-iio+bounces-24932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C7BCE7C1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 22:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A5319A7DC2
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBB302161;
	Fri, 10 Oct 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vUg9Y+UM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0326F297
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127884; cv=none; b=UycHE164yMLBuiXcHEQE39oIYXp9TcqtglaLFxbQ/CdoGTYvVyOY0RBeOHVkPXQ/c4xNmi51jOvbQ8JXi5YgGu6DIv8ovly/zLsbtc8CVmHVH8a94Bi+/VFgoNPBTyoWAvwrC7Cfb+QQyPadjSg+67WiJZiwPic2xFgd0IoMuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127884; c=relaxed/simple;
	bh=NgmV/wTZZURejsJ+2VBaInl7u9CRnnkDWyHMfWsbVLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l1A+B8vGveW9x+R7PHdFWl7NzQBuJiFXpVgTOknFOYaCjAv1nHkvqSi4hPgvcDZj516oNx82lK83TurlQBUAXmgA6ynSdS7Z0/svMAXEIdc9o3hYgoEQqB3wLrkCTUxpSU4pI4g0pbTagOBJbsjtUPcSn+z4NwAM/GNpCpd/Vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vUg9Y+UM; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-36c9859b036so1616012fac.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760127881; x=1760732681; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ohCA47n/0QQWux/zB9KYmPHe4Ax+701jzx0dvdsVvk=;
        b=vUg9Y+UM4NymYfP7nzHknYwLTjpj6gpO4MUmxt3MYg7PdLXdZan9ynkTg18V+hOviR
         Gppo9XFkzQLT8GuQmSw3gfM2NwFDrFv4srlV3LX1xVZj1Ry24LaKfleajay0TS2+6YrH
         /caDLypQPu0Ph06CGSvB9ScXyRjvHmN60lnmd5mB7CnPbfkpqJq/+G0/fSs3j0Y7uudq
         S7eCAXg0ZnVdglOpnPoDXBOejBMOBPJtUIM73QPhSsJQwZnrnaRTCTLymBxo45eBMr/2
         enyVQNQSA8AuTkb2Zk/6WSEaht/p4b+DV2tQFHDWYA6Wq+Hd22eZwY1ZN/OrEvU4/Vl9
         /puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760127881; x=1760732681;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ohCA47n/0QQWux/zB9KYmPHe4Ax+701jzx0dvdsVvk=;
        b=adSVPkXQC6Y38Ch8ABLzvnG+LIu3yY1QkNZt1/b4pY2yXKesVrct5R2nE7Sr4zwZ3a
         BJ8CBogX6VlNH8bigz9IKkwpTGhe8vLRqe+eYBzlmWJuzC636Q0vL8pkwPHTv3MkMavi
         bJ3rzxR8KxGIoS2DnqTP7rDwdVm4dM7IqtsHEaRfbyNPRInxp+sPDRrtfkidWl1XcMv1
         pkGdlL5cQ4s8gsX/BhdSA3W6WrChy8rYcj69mDYngcBR7yPcuiCE51Rsm/kE5IJ53WvU
         /y1uLVTOMWUgBPp7hsP050Yv/D+vRGvgM3Gp1VyLrcDodVeMC53DuZkF+A0nmE9BLjEZ
         0ywg==
X-Forwarded-Encrypted: i=1; AJvYcCUIU7tvGeSQBBTE+zESFJsIaINTTtnN/pZ8Da5KLr8Yg2j3QpD4Bw0jQagza/gip2VJcXCJLsJjDXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulJVqk3aO1KciRBDNkQkH7olppfJv2kgzR0fH6Rz7Pf1FNXTU
	X11mYVTVhVSbYkvJsYTnNrHZ3FK3R8IgHEe5qAe727RZ61z4WvhxWo+G7VO/PyyugHo=
X-Gm-Gg: ASbGncugvNIUqYN+5HCOUTwOLMAaB7KoZJAlWQhsTYGWsEG1yayUm8cema6siW7HP3S
	T0OGZlSf3lDos4hkwxqcoktbG2F84vt9r0HevniHc87UWjhjSfPWUPMiKhs5uHXlpe7/4V8UrY+
	mlr2e1Oxlq/AOuuFOs6fCv5nL9hA9C1JwbGsUJ8uLBySD1LFXEtjlFqCukW01pCgZMhMoTaILXk
	Ha2UOqPTNRQJce0HO1NclAV4OMJ9IMXACC9K90zgEd/4MX5QgAXfBV69P1XKEa+FkN17P5sZoJB
	S9xnmswmIAV/Xup5z3dDjlf2bIf4IMDxCaCUhVlZI1UYUob4820QrEhBkJkFKQnpHjSxypv7BwX
	QJK/tBPxfJUDLnyvgGlfbe5JUiSyb5wjSHUBB3HMuYhuU0A==
X-Google-Smtp-Source: AGHT+IHA/Bb6A+Qw4x9EcHFnmRKfEZ1mJPteh91sY6GeuPQrrgCAwSA67yrgm073hiMHCMtpyNKZXQ==
X-Received: by 2002:a05:6870:f607:b0:318:70e5:3ce with SMTP id 586e51a60fabf-3c11a250cf6mr6484649fac.21.1760127880776;
        Fri, 10 Oct 2025 13:24:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8e8343csm1182109fac.17.2025.10.10.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 13:24:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Oct 2025 15:24:31 -0500
Subject: [PATCH v2] iio: adc: ad7124: fix temperature channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-iio-adc-ad7124-fix-temperature-channel-v2-1-b51b411faf36@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAH5r6WgC/5WNQQ6DMAwEv4JyrqvEQIGe+o+KQwimWKIEORQVI
 f7ewA968GGs3Z1NBRKmoO7JpoQWDuzHCHhJlOvt+CLgNrJCjbmuMAVmD7Z18QqDGXT8hZneE4m
 dP0JwlEYaIK+07opUY1neVBybhGL0FD3ryD2H2ct6ehdzfP9WLAYMUIbGVaXTbYGPxq4DN0JX5
 9+q3vf9B9w9W0TfAAAA
X-Change-ID: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2609; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NgmV/wTZZURejsJ+2VBaInl7u9CRnnkDWyHMfWsbVLA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo6WuBN+838DasTJ4Uo/uLWutAyoA9Osc6PiPjJ
 MXA7pDizUGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaOlrgQAKCRDCzCAB/wGP
 wK55B/4ql2pWuD4Nbrdi0m5/tm0jLpTnTK91WZXWCQvD2EywRvnuw97mYdi6EU6OOQDydfFU6Cu
 fF4HljsPVx6AfG7f+jJAYRQ4VLh3dNaBfp6DBNHZnMy7h3TMgYnCrJ+4fqtgIlhfAER8AQ1kpk4
 nGsFyFAsL9igYcOjhYv3d/vHpJHfxknIqVzzcLrg2/au0A3Qh5nSKV8yn0ecLJSQW8TG3EsbGT3
 7Qp3ZNJf7o9NUXu+JtYbdoEzbqWYa0zFWb3uJIHL0VZKaH+ScWY2bTMFXAPosFGrfHWgb1IiFEP
 cLPZWEjL/O8CFjF77xd8vNqiTOj0HUCpmcpZIZjjUeOvuSgy
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix temperature channel not working due to gain and offset not being
initialized.  For channels other than the voltage ones calibration is
skipped (which is OK).  However that results in the calibration register
values tracked in st->channels[i].cfg all being zero.  These zeros are
later written to hardware before a measurement is made which caused the
raw temperature readings to be always 8388608 (0x800000).

To fix it, we just make sure the gain and offset values are set to the
default values and still return early without doing an internal
calibration.

While here, add a comment explaining why we don't bother calibrating
the temperature channel.

Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Improved commit message.
- Expanded code comment.
- Link to v1: https://lore.kernel.org/r/20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com
---
 drivers/iio/adc/ad7124.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9d58ced7371d0af7004a81153888714e9795d4f4..2a449baf5b5645c8dbcc6af671aaafb86db96011 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1482,10 +1482,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 	int ret, i;
 
 	for (i = 0; i < st->num_channels; i++) {
-
-		if (indio_dev->channels[i].type != IIO_VOLTAGE)
-			continue;
-
 		/*
 		 * For calibration the OFFSET register should hold its reset default
 		 * value. For the GAIN register there is no such requirement but
@@ -1495,6 +1491,14 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		st->channels[i].cfg.calibration_offset = 0x800000;
 		st->channels[i].cfg.calibration_gain = st->gain_default;
 
+		/*
+		 * Only the main voltage input channels are important enough
+		 * to be automatically calibrated here. For everything else,
+		 * just use the default values set above.
+		 */
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
 		/*
 		 * Full-scale calibration isn't supported at gain 1, so skip in
 		 * that case. Note that untypically full-scale calibration has

---
base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
change-id: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


