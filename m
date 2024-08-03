Return-Path: <linux-iio+bounces-8218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73E946AC4
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976B61F215C4
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6215EA6;
	Sat,  3 Aug 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCUjeq4u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE61C696;
	Sat,  3 Aug 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722708608; cv=none; b=G5Mfqzgncdb5SbPYVdjcn6lOhAz88kVGdai+wZx2M84qGIBbqzrK8Mbs+kcEwpyJjV9zKoEnrbbEOuZsoeJqzhzodTiO4SVP5ddfiDappuOaOZJL23lrQjjTs23lKRRJ6aDddzfFng9zKpiDZ6Ja63rKHCxHHamUe7qJ6w+45mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722708608; c=relaxed/simple;
	bh=dNzIwul/cyACio8WXGJx1hSS88CQCb9KVP9/4i45JEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYCKI1wv8Au2tVbqVLh1/HD4n8vGLI1I5TBv83xSGLR+OYSoaDbOFJmG49cJeoUHqfhAhadONixm026ZicZ96XoMx9VXGaZc6ywdQqIXfTiYVGJlVkXQPzH3ocBoTJhnx8XowCEnTtPLR/OLgIGXKeJrltszl/BBUfect0qzhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCUjeq4u; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260e12aac26so5981898fac.0;
        Sat, 03 Aug 2024 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722708604; x=1723313404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnkhRMPKPbMnaTfv5blGb/FY72PqHqmG8iLuFD/CCzU=;
        b=FCUjeq4uyy/xVjXjsHloxGkEQyzX5mjKjZy1VqGXrO+nr+crgdmgRHU6wbV4JAx/md
         BEfb5vixscokajPyjhC8vgHAyrmZs7WyMXKLXZ4RUGpxiY4NjTM5FzURHnMpEzgS/v3Z
         yWqiq/OvXjukkEZYss/0cVbUhg6Gze2HjxZ1K9boH+vigClxwI5xBTTD88M5GQ8Oh7jZ
         4btArqRGw11RnXBvpSVw5uZ6JeTUVZIaccF83Ngd5KPhX0lb+FfXUlCupYy8HKq6waJs
         lbWo8xJpmTo7fRSa46aytmmK0ViFW4A71Q+yh2E0j9BK93q2sB8LEUePUzO2RUjUCmLQ
         eR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722708604; x=1723313404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnkhRMPKPbMnaTfv5blGb/FY72PqHqmG8iLuFD/CCzU=;
        b=kICHkImbjiIGvZDMippi1lXHlgATrirxzNR0gfYhCwfIp/0IgamuJ5eD7fmB0VAchv
         qBnuhveQX1rZDlkNCx9+QCFqyrFkFZd1+eyUI29rTm0FxFF4TgED7duL6O5sOtHlVziY
         FvTwTYrz5o5XxdwO6rsuRkiIZZImJy9vrUKOPt9/0jQl0EXc1/NXZ3vZDDpCYtP2a7Fj
         GA9zaAP+ku3368XETeeS9PWUsD5mw0FjbDe4sW6xLzBPy6h1rxPYBUjxx5cLotHodUAO
         pZqzC0X8NKvU1mGKAmUslnxy/syd/FsiBIyCXU0Eb6X1qJ+MdBBMCBuBi7OSQslNbde0
         L7jg==
X-Forwarded-Encrypted: i=1; AJvYcCX8xhlMp94J8QdgJ5cLq5Eqlk4SWiIhW0JEZU6UDCG8jeTTL3VI4J/GvdIBDtovtuc78MPytDPP/ZD4u/kLRb55wEkt4mKCo39TMtQp
X-Gm-Message-State: AOJu0YxibLKalvXB/EzAokQH6p2gsxOP7IZt1s/6Sp1eraMKxqJDD46/
	xkGH4UP/clkXimGlL+eZsd5Op+useIu7ZQSsC2+lXD6bznpwtbRS8Qtc4xsBQCk=
X-Google-Smtp-Source: AGHT+IGWRJb3o2LTDjYn2PIqYoAz849UT9k8zezOsK6hLonaKXP5v2ussTi5cjhkmmf/jH9JvlDidg==
X-Received: by 2002:a05:6871:3a25:b0:268:880c:9e0a with SMTP id 586e51a60fabf-26891d40a1emr8711564fac.20.1722708604594;
        Sat, 03 Aug 2024 11:10:04 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm3046128a12.6.2024.08.03.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:10:03 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v6 0/2] Add light channel for LTR390
Date: Sat,  3 Aug 2024 23:39:47 +0530
Message-ID: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
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

 drivers/iio/light/ltr390.c | 110 ++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 15 deletions(-)

-- 
2.43.0


