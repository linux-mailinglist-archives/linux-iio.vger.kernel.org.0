Return-Path: <linux-iio+bounces-5273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F249A8CEABC
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A71C20DC9
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2916FE16;
	Fri, 24 May 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QGHThyLD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821B38FA1
	for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581901; cv=none; b=AL9pputH1zdRHygM3qO0bKrRqaZe0ASujwID0h4OjUr/HETT0p49bTwhJNgd29PEwl3yEaMKp9sDyOfc23g7f9BbbcEbfKWzTRBvb6iPH6ttedWn5M7RVVE4NbxxVF1R+pqN7ta1G4jOR5qSgKU5yT++dK8tzY//bIfS4/otqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581901; c=relaxed/simple;
	bh=p/NRncoY56p0bib/WzzDXctsmUiON69N127T2VCB9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cYmTd9w6B9GkSgft7d68ZF5CfxEIfIDHgO2i7g4R7MZ7dyatI2ow3sZPVkbaS4zoNL/YAEqSNHJEiyjsueXdgX5akjdYSFdZaPvqhQJtU4t+Y3Mjrm7+P4aLJ2O1hxVRJtLQ9k8cx3yMl4bN4QgM648GHuSrPjEIW2eXnqzM3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QGHThyLD; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24d8b372911so327117fac.1
        for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716581897; x=1717186697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HalOAyLkDzegc+4kX0OIEOAwPaY/uhF+wibqleOrnyU=;
        b=QGHThyLDGzZ3thvfFj5KGruOyj0pqLiQssZwSPRShlcPTwKB9K3YHbnAAEhGNBd0NP
         JWBwJTYKiFf/n1lq7E5T6K+0UE1RRaAuFd6UXVYiDHaZA7fh0Ykb4/AvJVR/zAaj2c1u
         mkvoxboOr2DZ0pV43iGdtuLp2TNRVKss3SSmLJHfLHccwlC6KBfIgw2xn/XC5/3F9cau
         6CoHqJhMlh2YyLfgl0tfmWl9iIMfbHnex5Fjlhe0H8JEtEDKiNAm6+3YJfXcwVALwzbx
         3lvQFez71gJ+t7QeGaLY5sCFtjHdIMB3EVWT+/U1dyd1bgiUCOJAr5FBPB2WewnKNnKc
         STyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581897; x=1717186697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HalOAyLkDzegc+4kX0OIEOAwPaY/uhF+wibqleOrnyU=;
        b=FWG1WtUyVXy/+x14wWYkbsd4d64rrSQRYMXawRQWXdWeVRYxa7lgpa0u6kkBxd8Y45
         0CF2m4V1VKM+yQR3wl0ts0SzkbwIS7XInVRDK5bI8o80HOLyZ8PgSvs83RnrwPFFW+FO
         j5mbOZca+dW96OVPpGBykAM+zpBrGDGErwNgJaA0n+9x3gFlEmGq6LpJaEKyygvYNDI0
         Q8gpEyF3EKs7dhjxSvXJbVdxaIDm383UR541WpwFmj9vq2VmeFxdzSOV0vx/idBExGND
         6DnEiV7plXMVMdP6Om+8BWuJ0yZHIUJCoi9y9NmrfbGo79ioJ/z4bdf21tu14nsRSLbu
         fcsg==
X-Forwarded-Encrypted: i=1; AJvYcCVRKF0EEz2UQQcXb3dl01R1Uvhu9xhoi/JBDGZIlGf9hbJ/FXX89q6Njz/3uR18PlZYQeQy4JcK4VcTlseOAS2VeQBYtCqZIZvO
X-Gm-Message-State: AOJu0YzzOQzfLp/I0A4cL+qdydUFUUDu6tc9UXHXJ/emN4nlTeE6ODkk
	PtK/EkxYmvMNOyr8CqeQelKr4/0JR73UTOPyzz1MGzBGzi//m388POd0awysWS0=
X-Google-Smtp-Source: AGHT+IEEm310HUA19zQ7ahDsUmBpRn0zbL0JH1ZmvUCVnEHDH2QRw6nh3//N3jOz6mDMfKmDdb2sDQ==
X-Received: by 2002:a05:6870:b24f:b0:23c:3c37:a4ef with SMTP id 586e51a60fabf-24ca121d841mr3869731fac.29.1716581897398;
        Fri, 24 May 2024 13:18:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca2840481sm516737fac.57.2024.05.24.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:18:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: add support for multiple scan types
Date: Fri, 24 May 2024 15:18:06 -0500
Message-ID: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Up to now, the IIO subsystem has only supported a single scan type per
channel. This scan type determines the binary format of the data in the
buffer when doing buffered reads.

For simple devices, there is only one scan type and all is well. But
for more complex devices, there may be multiple scan types. For example,
ADCs with an resolution boost feature that adds more bits to the raw
sample data. Traditionally, for slow devices, we've just always used the
highest resolution mode, but for high performance ADCs, this may not be
always practical. Manipulating data after every read can hurt performance
and in the case of hardware buffers, it may not be possible to change the
format of the data in the buffer at all. There are also ADCs where
enabling the higher resolution can only be done if oversampling is also
enabled which may not be desireable.

To allow for more flexibility, we would like to add support for multiple
scan types per channel.

To avoid having to touch every driver, we implemented this in a way that
preserves the existing scan_type field. See the "iio: add support for
multiple scan types per channel" the details. The first couple of patches
are just preparation for this.

---
Changes in v2:
- Use union for scan_type and scan_type_ext.
- Dropped ad7380 patch - those changed will be squashed into the next
  revision of the series adding the driver for ad7380.
- Temporary updated ad7380 patch for reference: https://github.com/dlech/linux/commit/64be3de241e73b43c5a5daa44b6b97f35f0743bf
- Link to v1: https://lore.kernel.org/r/20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com

---
David Lechner (3):
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code
      iio: add support for multiple scan types per channel

 drivers/iio/industrialio-buffer.c | 91 ++++++++++++++++++++++++++++-----------
 include/linux/iio/iio.h           | 85 +++++++++++++++++++++++++++---------
 2 files changed, 131 insertions(+), 45 deletions(-)
---
base-commit: 6c46802cc0c4ff878f07139f7b7b8774fd43ce3d
change-id: 20240507-iio-add-support-for-multiple-scan-types-f4dbcf4c2cb8

