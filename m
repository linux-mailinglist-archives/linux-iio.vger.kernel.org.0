Return-Path: <linux-iio+bounces-5505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49848D4ED7
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6295B2879BD
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7E187545;
	Thu, 30 May 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gGjYHH6H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862E187540
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082071; cv=none; b=kZGc6c2YVCEK2rhZSUqahij75onqVwE3N1TyO7LOsOiN84WfmHZWx3RM2p79+stKXhpGM+7pRfRfqmLUIUHpmoZna2+L9LmVrcztU5ePzXMthCNP+OLNxVyN2WPfxvAprDhaMKBeGIWFOfW5T6DuZ8F7rr//Z2DmFnimGv/YIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082071; c=relaxed/simple;
	bh=I/jkTMXlLafovZFF919I/1URD8ND1uDK1lvXCQbwghI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=reYjTAw2saJi7W8FVDmmfaCMEmubb5wvgFjssZlwzjtVbeEFrl6qdvFJii2pNprA5EAybXJED7fsI/JUAkLYVvfCy0YcjF9JcpO0o7sSqKxhkoglrLQ5r01N1c2okuSXwqfg4LWcII0o6nDXc3c7Ip+I+ST9n8h1ms32IlkALFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gGjYHH6H; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f8da5e4850so548299a34.0
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082068; x=1717686868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4w88jG14W8tbyoxnuDjksObbCEh378HI0SyckpcTik=;
        b=gGjYHH6HbPU2D47dAacFXaoCeli+SU3PNzAk/9KkZPx1010w2m1q8UIXntxhnC9cH2
         FTX+HVMwqPbElPmhuQtAvw6TjZvtE3Owd1ZdqoKiXLYZgdh0VdQdwdGMnwQP/NdLsFn/
         nehs6glapOgjraOvtgyW8QkBqMoz5cx6jUmojF3LgZQV/+LU24Yp76TQF8z+LZ1ZJCK8
         ua6738IEXnyxErVzN+KpxhTPT30w1LmKcBMyMCJ1cwNEindZhpqi2oRQ++E4FnEzRnVe
         WHk8fB6lx21iHczMbYxgMUbmZQl4ciFK25SUsIceyf4iWvo6LGFAbs1988EI+xyF/CGh
         bS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082068; x=1717686868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4w88jG14W8tbyoxnuDjksObbCEh378HI0SyckpcTik=;
        b=C08p3Z5t0nTM7lWqGZuONebeXawurJql6x3er4YSX5+G3HGMNOuvF79Gw+G+0hlCoG
         /mbCqKLzytMY+uAA6LnOGIGDFeT/qdgCbmGQ3uiD39IsELhn+ZTKnSePMcUjPmJJgk0i
         wokX8YQOIlnCAbtIqHqaDJ+16oLR25cD7FxGCFvK8/rCIRevDo9FpNPlBEjG20FdJF0R
         /T/r2k0Y9o1Ds0WzK2HoJvKHJJXA1GEljnOBMm82yPB/TZB2XqWGwQkFU4OsSkqoDuvu
         4xzc6v7rkWgSEhgtElho4s7qmJ/5q2v19NtIFIV2S5T1h09FlUngNVvotAR9mTdqX83g
         qg6A==
X-Forwarded-Encrypted: i=1; AJvYcCW0JzN3sR9J9OwrAaJPC1nDJzZiyPIcEFy/giy8poSXw4Jx6MQA/9n0fBFiLhUYxLHz9o9TdbWo5qgf+/rkpHNwrUc5jsD8SBm+
X-Gm-Message-State: AOJu0YxTnl9rv8ze6iwrfnHO4Y5F8h3GmaaR4KUmv4rEoD8bSrPI624H
	0u+oWKCAknMjB+sSSArVVxYLKJwA/+zJGrCIiNeYR8erIoakpKupIJXCZubvVkA=
X-Google-Smtp-Source: AGHT+IGQYC8yUAVHAhnnRRnJ1vpbAhA0W+JSeKMckRN9t+uYMsNbBBkee95Lh3PLRajn95fiKo55OA==
X-Received: by 2002:a05:6830:1bfa:b0:6f0:3c3f:6893 with SMTP id 46e09a7af769-6f90af7c168mr2421658a34.38.1717082068271;
        Thu, 30 May 2024 08:14:28 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] iio: add support for multiple scan types
Date: Thu, 30 May 2024 10:14:07 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
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
ADCs with a resolution boost feature that adds more bits to the raw
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

[1]: https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com/

---
Changes in v3:
* Changed return type of get_current_scan_type callback to int.
* Brought back updated ad7380 patches.
* Link to v2: https://lore.kernel.org/r/20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com

Changes in v2:
* Use union for scan_type and scan_type_ext.
* Dropped ad7380 patch - those changed will be squashed into the next
  revision of the series adding the driver for ad7380.
* Temporary updated ad7380 patch for reference: https://github.com/dlech/linux/commit/64be3de241e73b43c5a5daa44b6b97f35f0743bf
* Link to v1: https://lore.kernel.org/r/20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com

---
David Lechner (4):
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code
      iio: add support for multiple scan types per channel
      iio: adc: ad7380: use spi_optimize_message()

Julien Stephan (1):
      iio: adc: ad7380: add oversampling support

 drivers/iio/adc/ad7380.c          | 335 +++++++++++++++++++++++++++++++-------
 drivers/iio/industrialio-buffer.c | 129 +++++++++++----
 include/linux/iio/iio.h           |  94 ++++++++---
 3 files changed, 450 insertions(+), 108 deletions(-)
---
base-commit: b4bfc5f52090336f5f5b65bbdac394ac1001952d
change-id: 20240507-iio-add-support-for-multiple-scan-types-f4dbcf4c2cb8

