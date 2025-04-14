Return-Path: <linux-iio+bounces-18093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D7A8877F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655387A3438
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39B275848;
	Mon, 14 Apr 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFiyUxs9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898192741C8;
	Mon, 14 Apr 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645255; cv=none; b=eAOxf8Y0+Y9B0PB4NAGpy6YysOqccysnA+UxfQmqGHbWthiJVYlZ0jXq+uqpOguN+/UAWiva0evKUsWFsJ+EoQ899/f4eBwewZEzSopP6e77jcS1zt2QJazEKQbki3w6mKO3/3fAeKQuHjccyVNFtc/j1AUgRFwsEvgeJjoek2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645255; c=relaxed/simple;
	bh=Y2R2YkgMI4z5Gdq/9hMDzIFoW0ch3l2+U7PzSeN3pOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nL7AseY7cFYkBv7Ppb9llLYE/hY10tBYK3Epd3DewE4v1RAVm3Dj2kREfNupOQlDoOsnIpV0SjJA4cd7gXMXo8fi957RqasvZnDBJEWPvwyoSdhfM5bNY0IHV6m76TxiGupDpq5CB3eevWRbwwVUYxhL0z/ebA73eVqWzn+gnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFiyUxs9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47677b77725so47186521cf.3;
        Mon, 14 Apr 2025 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645252; x=1745250052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THkCE1P6uezsB9SiyYtWzI3sCDAsq5Y3PC8P0mjg8FU=;
        b=ZFiyUxs92KJGE+HNsWybE3AXKbD1qROwG2A50DmFwliHHcOSa0Xv9wmmrA282xUZjp
         drh85jLcXUrh6/vFHMNqD/L046qXtexko+2jO0XhAqZry1wG2rdZoQDQLdrWaeTVrxYF
         LxkWpyQidSEAlia7SQU6lqbQ6eoKGqYSobTNFL40EAxuTSVo+OZNcGMM6drxwsgUgggp
         V3/MOB0LhjOTx9FzWeN3G4ipNCiUM4nEgEOyiVhO03SJ78nheuPgSewtfL0eXw1FVxxc
         9MfXLQrjCr/qaAoDxC3rlv7eAokl5b6GLiY0Y0Ab62vcrb6fBEJcacyanvJtL30gcKZ+
         BWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645252; x=1745250052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THkCE1P6uezsB9SiyYtWzI3sCDAsq5Y3PC8P0mjg8FU=;
        b=BgKWRcRpMJoEYSqWYZGtzz75gfVmn3fhNJsX5CXXyhBT4t6re3bIdykjjWim1U1tpd
         6gErpZHHjHcsSZLNjEL/QXfn1rUBxeYvhLZ3XG+65T89y4o1KqEz6G+MWB8GWlUhU29Q
         ynjBgDCO7TXEzogcFhlcq4xot6JqV1joPnKpKFLEz1i29meo+HwEOJbLAsJc2VhtcOnu
         rTu71o6D4S9KlaauRCQVsQRTuMMOtrAdhda4WurTHTw25msMhaGwxKEwCxG1OeIKuyIY
         +o+ASrph2MZ55MH0feR3JQU0xsyDQxDhbDWiQRSrHvgTxMbzklGYzI0xNMHlsjbDpcKJ
         U8DA==
X-Forwarded-Encrypted: i=1; AJvYcCVrNvxd/agYLqQyzuA8mM7mVOg9z2CwJHcPlHd/77tiz39fwDsNPL4clCWx6AlSR5tlq9mX5rjG+sLe4/YW@vger.kernel.org, AJvYcCVtMtWcOxgGb/fkh49MRay/6TP0usVVBp9T4GbCD6zPmm5Shp4ZrAPn340NjTwir7J0g4ozSeQv@vger.kernel.org, AJvYcCVzePF0qY9Lpk9eO+nv/PqaSiumFqq4xHzKXYCh0d03wv0RxzAE/FTXv0qKLDzxWfJOXAJpwNYCdYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+7gJVIc+CHJ+QcKNH1rFXsZO9kda3SmHcpRKtj1nVXJuicL4
	pJfoP+Bd9Tfpq4oinv1F5P/tQ8bFpkJiWtiqnJ0jXDSeeJIFKfUL
X-Gm-Gg: ASbGnctN8jvg+z7rImmZmoLKl+tysHhIYZQm0STVnql7YLpNyKZa9S3ex2vjD5Y5HaV
	0+M3dGDNjE5u+UAXMYTUCuM0hScn50eChpDYY9jShGfgIYz/WMk7RDpwQhUNiEhjYlDViSap5oz
	s9vhsM60Jr3xsoIaRgIPKlJZnv6c/NVX6k1bSivtl5QkVZlImRkomTYkTozwCJeeWYFUnz14U/Z
	pZmgWGLWPvulc2KudjLlthrPrfjc2eOAgjAmaZ5BhsgYLZaHMsPf62HMz2zTpG9pNL/mYz4zHCf
	ilXzZIPsIkl4ix8t6txpd7k76ekQKvXCEQyvxpbegrnwdAUmEXHgHJoHLQpkEdMtA9JlX//M+Re
	ix0tLB++DDcSUgAhtFhk=
X-Google-Smtp-Source: AGHT+IEwo4m61h2lh7WsG10CzeSqTahaZOSmn4LaTbTF1zwgcXtuS8psu/bJtldb9rrV8Bhc4Bt7PA==
X-Received: by 2002:ac8:7dcc:0:b0:477:8a94:dc77 with SMTP id d75a77b69052e-4797750f99amr136157491cf.9.1744645252140;
        Mon, 14 Apr 2025 08:40:52 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2d020sm76433801cf.36.2025.04.14.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:40:51 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	kernelmentees@lists.linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v3] iio: adc: Correct conditional logic for store mode
Date: Mon, 14 Apr 2025 11:40:49 -0400
Message-ID: <20250414154050.469482-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mode setting logic in ad7816_store_mode was reversed due to
incorrect handling of the strcmp return value. strcmp returns 0 on
match, so the `if (strcmp(buf, "full"))` block executed when the
input was not "full".

This resulted in "full" setting the mode to AD7816_PD (power-down) and
other inputs setting it to AD7816_FULL.

Fix this by checking it against 0 to correctly check for "full" and
"power-down", mapping them to AD7816_FULL and AD7816_PD respectively.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Changes since v3:
	- Tag stable@vger.kernel.org instead of an email CC
	- Use the correct version for patch
Changes since v2:
	- Add fixes tag that references commit that introduced the bug.
        - Replace sysfs_streq with strcmp.
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..081b17f498638 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full")) {
+	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-- 
2.43.0


