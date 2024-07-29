Return-Path: <linux-iio+bounces-8017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8493F483
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A540281C1E
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF971474B9;
	Mon, 29 Jul 2024 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv/jr/1R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003C1474A4;
	Mon, 29 Jul 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253893; cv=none; b=WeftWWgiNKBF64wM4atTa6VpEd7zhzL1yBS5+qNzblUY13gySZ4ikk2W6vvo7d8LTqmN8bYCZPDtvl2l7bzf+RoCny8sJMlsR0z/jcV08kMC5J+xKzpWjpOylbtGaJOTBGF1pa0TUTCryEmhuDeoDfRToTiSRzT4RBKesApb5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253893; c=relaxed/simple;
	bh=QyJDpS1atetkwE02EO8YDbcZlCcHohevnyHBEJ3asrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clthw+p/IMSI17S+eF6t8O8XB+dCIrXSTsJxJiZc0QYRDODO/Yk9k2/E8Cm4fkG/rr6ns52J9+ctkXbhqo9xinCXdfXH/e2R/9km0WxF/l4l4sC1g5Mjixwh5359jQKtYzC1hI0M0zuR9DCFOvsTU5sQdDx9a1ASh6AcheNk/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv/jr/1R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70eec5f2401so749198b3a.3;
        Mon, 29 Jul 2024 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253891; x=1722858691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwLH/dkMhtoKA+j6b70G4/pP9abL94o4tZuRe7ezv8k=;
        b=Vv/jr/1RnJCUpQUbmuZZ+NOWNv1iTREzxn+qndpYwC8AqA5vTm0iAwel/NTLVExJww
         miWNpjItpZzpLbfmE7wz1z57B8GlT3IoJWDid/wDtQkEWAwCfdhBzJuwdRSL3A3lgcTD
         OJTdP0k4CJSUtuEcDcMs5hVmLf5M4K4s4oiPanqBfEHduh6MG9N2z12H3+BRebxxnp6F
         os/TLO9g/6jwpvp8lDR6KH9YdpqsmPO1wXOxTkqW7eJxBgMOHFFUI5QDKj+WMzQL54lt
         X3fbAKJ4dov77BYZqd5ubJmz4TxAC5ACWrTpdvJ15hE92UiPNt+rb66q9AektEWvzNWV
         xtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253891; x=1722858691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwLH/dkMhtoKA+j6b70G4/pP9abL94o4tZuRe7ezv8k=;
        b=welgMPAfsQntWTDc7rTz63A9nlP6s9pJtoFuh3uJsZ9kbXQmNDj74SgNG1q4sMvraO
         amgqSwfkOd9opOfMIRYOWdluAvZe1c2fAvtQFWdy3kdoHtljvet+ZZ9lRfGIgwIdj1pX
         enhrhOnEz2ppq1gsH6X+Xom4hiJunDQVjRzBKyIqhu/AlWGju1JfCibDiMbuHWSprhtb
         4oeUuXIodGaljxLuZE0ywQZLAPu6edGw9CyRImGMZFskDvK3cdUONKML/bcHCb0U2i0j
         L/WgMnjhYULYTHeox0p/LYdBQNPNNwtaEQ9X9hO5Y+dpSilQC34HVd+l6963MLlYFwaR
         j84A==
X-Forwarded-Encrypted: i=1; AJvYcCVirVx5s6XgcR78xlI9aKoxNvTxXb6jbqDdKDLdNzm+Dj0ZxuXLr2fU71BuzYep+xgRM8dwy8wCAyBK/ou7o8yOurrpPoN6NZ5Ur3nt
X-Gm-Message-State: AOJu0YwoB4djhlfgr2OPzB3ug+UMGsRZwvHLZv2jp8iZItY5HG5anD2Y
	y7ZRSirjqx+KQbku7v4LtuCZAQ+rQOA2hyfR/5issVUCeSK3fVCE/Cr0XyNu97cf/Q==
X-Google-Smtp-Source: AGHT+IGCMKQLBBVNDQsjSaibF9kGo6HWr/AwUi9Ems4hsBgVn+yYnNcvExI6qf9tV5fWFYpwe79SGg==
X-Received: by 2002:a05:6a20:9f89:b0:1c4:d4b2:ffe5 with SMTP id adf61e73a8af0-1c4d4b30374mr1365356637.54.1722253890584;
        Mon, 29 Jul 2024 04:51:30 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cd8f7692f0sm6760987a91.1.2024.07.29.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:51:30 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 0/3] Minor cleanups and better error handling
Date: Mon, 29 Jul 2024 17:20:52 +0530
Message-ID: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
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

Abhash Jha (3):
  iio: light: ltr390: Add configurable gain and resolution
  iio: light: ltr390: Add ALS channel and support for gain and
    resolution
  iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

 drivers/iio/light/ltr390.c | 246 +++++++++++++++++++++++++++++++++----
 1 file changed, 225 insertions(+), 21 deletions(-)

-- 
2.43.0


