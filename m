Return-Path: <linux-iio+bounces-8462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E017E9519EC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B39A282A63
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2C1AED39;
	Wed, 14 Aug 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAgAfP3K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE31420A8;
	Wed, 14 Aug 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635139; cv=none; b=gspz16syCsH1p+cwKpawJGDlZF53S9jKgbfR2w5qU+r94ca/fx9FpuxTRT2MGu/gg9nvWrhM9Pb/UvdG+0wUdRS9PA7Jf0G9PtCmJ9hsm7N6PhF1CVE2G8A7r5seUV/WqiKXotv/MWJvfHy6lOlef50dy06VfWuRNh9jiZe5q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635139; c=relaxed/simple;
	bh=p/4ybLjhoZTgR4Kj7bHpwLlGdr23uGwe2Lc7tbsvbA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew26vOajpA2DHkL9C9zoUAjbF/0PugUm3KNENuaf6ZxRB9lcduKVGHWQCz+Vt0U+w/Mdd3Rl1wAg4ft/YEeEnEz/RVKLn6i/06Fj29BLt3nW5gUA2cex6Y2huZ1xypeSFy+1561xNVqKeJsyqRobcSkFG9V9ZaYvynTEZh+a8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAgAfP3K; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so205453a91.0;
        Wed, 14 Aug 2024 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723635137; x=1724239937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uApCJTpvejaUyF7Mf6zgNoGDmJ5KuE7S5xQ/c1NjlzM=;
        b=mAgAfP3K2h5jcn0L/opQ/eDXINpCQllJes5k2qa+9Op3kL0pFeMiqwztWl3yU0cfn4
         T0fanvnvbauZBoS8D5Q+g+NqFBA87pHeMBIo/JeKbJVNKa95F24cFNkpfCpN/gckBafe
         Y/tp3m/LJAJCZQIl1IACy1KP4nRDQBLyWWZrI3LdnIHXCxXwNm18fxrQt6EhcgneNAii
         3+gwUUlqLH+EXfpCVAgfZGeoCRjSeaYjHzlsiEcZlQWbaqrr+4AmAZ2MCzgc3p+tb15m
         BPQ+gA0vi+CiZM7j3FbxTJkOScVZ/tLDCbTQ0FbxMJTXTn/+r7ycv+ui4BspwRubUvpa
         lDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635137; x=1724239937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uApCJTpvejaUyF7Mf6zgNoGDmJ5KuE7S5xQ/c1NjlzM=;
        b=C2qv1J4bkjIVOdjgk28y04ij/LUV6brJGys01pB2RYigHUuMNkHJDK6eMZeK9MAncQ
         Qm9F4PFfHcBfAe+Hca9OpVSgZV2f44JBtjX+iHn73navWCgHZJGVXWRqizbAqw+YnXBA
         ZXgp2+qH5S3R3N8s2QIVXFnSlbwBalu17zzrdQo0ncTZI00caIYuox8hD2KUtyLIsaPW
         7+6u5MEj2Pvlnf/ZcBg1CWrAVmIibu02O+uM9pVdd85xmgjOespI898QakAVkvcVeAk4
         oSeCJPn1bEtiE20et6P+uhSq/vSxHUKVOZhBykeEPMZLyvOsLvgKq2jQRWCQu10ffAV/
         D7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS63NVKTtH+6yyJg4+hFoS4n42x7rRtssy7yLBgjmMMJLFcrmZvi4zZp54cNR0EF7fs8Ftnt7CO8UuIZZK8j6kH98YEm1VWi0+bqjG
X-Gm-Message-State: AOJu0YwTCaFoWUjqR+bi008t4eE5doJlVeGGMg9IU/k/JCzFNZIbJ5Tr
	5u69ZrMvJav1kJQA8GtGdOSMiNVOPhBx3clxVbv/fFs4R+D9IlGFTiMFVJngfNAIog==
X-Google-Smtp-Source: AGHT+IEYiFsf1CUh0JaTEZCA1tUtcy0wbn4Ojp8/ElNNp11twGHG3JRK2ZKXSe43nsInl5T6kAp68g==
X-Received: by 2002:a17:90b:3808:b0:2d1:c9c8:301c with SMTP id 98e67ed59e1d1-2d3aab6baf8mr2486397a91.29.1723635136678;
        Wed, 14 Aug 2024 04:32:16 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7e80e5sm1467434a91.17.2024.08.14.04.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:32:15 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v7 0/2] Add light channel for LTR390
Date: Wed, 14 Aug 2024 17:01:32 +0530
Message-ID: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds a new channel for the ALS feature of the sensor.
The same configuration of gain and resolution has to be provided for this
channel as well. As there are two IIO channels now, we would need to
switch the sensor's mode of operation depending on which sensor is being
accessed. Hence, mode switching is also provided.

Then the second patch adds support for calculating `counts_per_uvi` based
on the current gain and resolution value.

Changes in v7:
- Changed the `ltr390_set_mode` function to do better error handling.
- Link to v6: https://lore.kernel.org/linux-iio/20240803180950.32821-1-abhashkumarjha123@gmail.com/T/#t

Changes in v6:
- Changed IIO_CHAN_INFO_PROCESSED to IIO_CHAN_INFO_RAW
- Changed the scaling code
- Link to v5: https://lore.kernel.org/linux-iio/CAG=0Rq+q0WJzMroYwQy-4Ng0aSkTvaw-FEMx68i3MqAZwfteCg@mail.gmail.com/T/#t

Changes in v5:
- Replaced the IIO_INTENSITY channel with IIO_LIGHT channel
- We calculate the lux value directly using `als_data / (gain * int_time)`
- Provided a scale channel where the scale is 0.6 * WINDOW_FACTOR
- Link to v4: https://lore.kernel.org/linux-iio/20240730065822.5707-1-abhashkumarjha123@gmail.com/T/#m

Changes in v4:
- Added "bitfield.h" include to fix `-Wimplicit-function-declaration`.
- Link to v3: https://lore.kernel.org/linux-iio/20240729115056.355466-1-abhashkumarjha123@gmail.com/

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

Regards,
Abhash

Abhash Jha (2):
  iio: light: ltr390: Add ALS channel and support for gain and
    resolution
  iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

 drivers/iio/light/ltr390.c | 115 ++++++++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 15 deletions(-)

-- 
2.43.0


