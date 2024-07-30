Return-Path: <linux-iio+bounces-8042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB1940901
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30A72813B9
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB8168493;
	Tue, 30 Jul 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwPKT/kS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3E2114;
	Tue, 30 Jul 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322721; cv=none; b=oap1AYbWewQyyArTlqie3GoU78T/eyMX7qiDm1Mml9SneUNPLFIa8La6UJ+Fhzh5RavwJkWwXDGpb56tRLrG5e29FGBFD7OtbfAwS/X2L3rUBPFTXl4/2KGz1egleE39v3EudwXMOQkZWrsaX/q/7g5QXAzP5kkmMIkFBZ2N+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322721; c=relaxed/simple;
	bh=EAGFY24+aKwg+COhv5FuvRrMVOoKE4cdi2MAfmH4hto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KC/yVD0Iz52dLa1eItZ2WOG4941D8Wz76ESOzbJ+eKT0kN8R3d4Nkx7N2ItG1r90vpSsFSOKF2kTuu3sq4g7lQn4+GQgathxI92e9EV+Pjjb05kArSUgcA6acAjby3M/lALOGZvWxasDBTX8OvXe8ulr0WMDVMYOIb0iDfrlgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwPKT/kS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc611a0f8cso26538485ad.2;
        Mon, 29 Jul 2024 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722322718; x=1722927518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDSRa9vGjkgpDFZP5olqZGwo+nYn0qRqIX9fzN+w42Y=;
        b=MwPKT/kSmZnMuUjP+RKS+YvhAqGT6InLwcgY7+eKU9geKS5NRZ5K6SHWlGAd6Twq/z
         On6bYywnjVhkA+fNhMZcRujtGBjnHv9XY+VZYY3VfJP8FGsSR2XjsdicrNHel+96Q7Z/
         f45PBTxZfesVqF5dBxgJP/aKboYyAfcETIPCe607q3eIbXzRTb4hm1uGDl5VNZ3vXHY6
         8UfrNcCVdAJIvEsmAENSGQVrj3TJ8KspyeGPAjEV9sTAI43m17ZwoZHF7OubvnvmM4UM
         0G5OI6UIMmxNCghPjsQZ3nsduQMZemFEhs0E/uJDeKj8sY/2HI549SN8hwbmprrxuBNU
         AQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322718; x=1722927518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDSRa9vGjkgpDFZP5olqZGwo+nYn0qRqIX9fzN+w42Y=;
        b=l/31KmMa2/nNqUNHS72ZMf0Npxtf5j9cM9FFW5UBpr+FarHbpHyX2dJmdK253l8pct
         pg+d00KCbxylDK7a+vxQ0TQvveFz/zrfvQhaMxwzwGqWJDbZYPHhjMfK9Ta+mhNE08Fo
         W2ejs34xSZM0yJwmd1ir6zwhiH9KFRmSUXObG/oUcvPN0GJvlQcTAneQaS2hXcrDpT1m
         1asylCJindU67+vxYcvrz/9g6WhKzXMeUfSQ8z3arBXMEfhJFBOagEZONfpXr2SQXi8R
         HYJfZNcFTARGzBtEwbN5IhAW6uq9UjfqWuCfDyHqvXGYKTzByj54ZM0Sv5/DJjgSsb+y
         +y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe8j1mXqSCE+gw1EQS33dpDh1mTO0441BtTg4/aqfZ2rrZf3zt3KeWgwOTaC2FLUKlDH5O4gydA/ZqUNli/x0x9CcTvPiSQZK9DfgW
X-Gm-Message-State: AOJu0YwS5OOGA+L6kuwOfYGQ1Zo9795/G2xtGKM3kHCP8HkmVQx+xNfn
	ITbbRxw9wj/RVdgCImU6z7omHDgW67WXSIR/VWb+OTWBqceXD0R88TQzY6dG+Uxw7OhS
X-Google-Smtp-Source: AGHT+IG+cqvqPDOgWOkkW+j1TElpJNv/+xHUTJJ4TLODTa02l66qx4mBzUc1UG718ihm+7dex8u0PQ==
X-Received: by 2002:a17:902:e804:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-1ff0489f4ddmr75305965ad.41.1722322717650;
        Mon, 29 Jul 2024 23:58:37 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7d378a7sm94337605ad.109.2024.07.29.23.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:58:37 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v4 0/3] Fixed minor kernel test bot error
Date: Tue, 30 Jul 2024 12:28:16 +0530
Message-ID: <20240730065822.5707-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch in the series adds support for configuring the gain and
resolution(integration time) of the ltr390 sensor by writing to the
respective registers. Then the available values for gain and resolution
that are listed in the datasheet are provided via the `read_avail`
callback. 

The second patch adds a new channel for the ALS feature of the sensor.
The same configuration of gain and resolution has to be provided for this
channel as well. As there are two IIO channels now, we would need to
switch the sensor's mode of operation depending on which sensor is being
accessed. Hence, mode switching is also provided.

Then the third patch adds support for calculating `counts_per_uvi` based
on the current gain and resolution value.

Changes in v4:
- Added "bitfield.h" include to fix `-Wimplicit-function-declaration`.

Changes in v3:
- Added cover letter to the patch series.
- Fixed indentation in the patch description.
- Patch specific changes are listed below.

[PATCH v3 1/3]
	- Cleaned up the spurious changes made in v2.
	- ltr390_set_int_time and ltr390_set_gain now return -EINVAL to
      indicate no match.

[PATCH v3 2/3]
	- Used enum ltr390_mode inside the ltr390_data struct.
  - Refactored `ltr390_set_mode` function according to the comments in v2.

[PATCH v3 3/3]
	- Simplified the formula for `counts_per_uvi` calculation.
  - Removed spurious whitespace changes introduced in v2.

- Link to v2: https://lore.kernel.org/linux-iio/20240728151957.310237-1-abhashkumarjha123@gmail.com/

Changes in v2:
- Split the single patch into 3 patches.
- Used FIELD_PREP to perform bit shifting.
- Used enum for mode selection instead of defines.
- Fixed indentation and whitespace issues pointed out in the comments
- Replaced `mutex_lock(&data->lock)` with `guard(mutex)(&data->lock)`
- Provided available values for gain and resolution via `read_avail`
  instead of sysfs attributes.
- Refactored `ltr390_set_gain` and `ltr390_set_int_time`.
- Used early returns instead of single exit points.

- Link to v1: https://lore.kernel.org/linux-iio/20240718104947.7384-1-abhashkumarjha123@gmail.com/


Abhash Jha (3):
  iio: light: ltr390: Add configurable gain and resolution
  iio: light: ltr390: Add ALS channel and support for gain and
    resolution
  iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

 drivers/iio/light/ltr390.c | 247 +++++++++++++++++++++++++++++++++----
 1 file changed, 226 insertions(+), 21 deletions(-)

-- 
2.43.0


