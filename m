Return-Path: <linux-iio+bounces-19748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FAABE77F
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6343BC0D1
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266225A322;
	Tue, 20 May 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmENFF7W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C44219A80;
	Tue, 20 May 2025 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781440; cv=none; b=AoWY3LWFlZtQaMvLOUkfGog9RJtLQd8Cj8C3W2S7CFvrlQZBzzsqakFYzuAhLtKLvVBfgH/0Z3XKbnFy6SFa+aG3YwoQh2vkFi8bo/pXWkSuo1i3IC4ahvZ9J1IEqgFWMPzfNnAoqMhpym8Pb4dA0hx/qfWXDZ0emRolIH3LEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781440; c=relaxed/simple;
	bh=2/OIFjmwq+riyOvRUGqpFShvIoJFI5zO46oI4YEh3Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J8saE6mmmS4jokl2PLt6Ef5C62ES+kYxUWpv6yRoeLygRu/dHUaMKyYuCaUyi/lihCQZU0DT0OtizNcxdA2XaO0F+vZCXZ/ubqO04I7YyNYHV8UT1yKnSGo8eoLm4sRTGGgHkKTRw0ZsATWDNnYSY5JRjPdswEPaOh2tPdoSvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmENFF7W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442f4d40152so6708675e9.2;
        Tue, 20 May 2025 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781437; x=1748386237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojzw/UeRGpiMC2qAUta51BQ3KrOpPXeDDbwrtQc+tiE=;
        b=FmENFF7W2YaT0JZC3wWDg0dU760hcG6Dd9SmU7pIkfeXPYhqzjIRO2tuND1qA8wZGr
         GRUIAdfhVne8NkT8H5s6q/u18pvOjvcv0TxXO2j1elW5Yf4HR05udSJupErsn/UB7lNK
         gBAAIrtvJqtYb2iQqTMkWL5Dg9VVs+8zQJK+xEoB3KqzMUYpvV+0CcyJPmpYo5t8wK6H
         l0ZKwixitlB+EHp9I8HlbruyZkrzmEWcRJtJ+IrBsAePeFz32ZGBYkoev8RC+amdhAZQ
         EF0ClhxA/slUGjg0KSi/9qi2WlQvEb0SLD1kx9f6UcaiHr7fJeT+VRXZhGIuXhdxPXJV
         h9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781437; x=1748386237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ojzw/UeRGpiMC2qAUta51BQ3KrOpPXeDDbwrtQc+tiE=;
        b=m+1VIIjvOceCY0opSoZAKeZ+fzZlng4IVY6FmPRmqg00STUOiE7XebSldusjEBh/Nu
         eTKFM9+vThtXNtG5uQQoigsYe+1ohLIWuPSiN9QgP6O0qonQRNNh6FGbxBVXarXoPqe1
         iNW4CAVBoM0FxBfQRWfIKvywsE4lHEVzQfeqqyZf4CAyUxbOQSz5kALveJh4dgdjpzLI
         TQQ/moLoqe+CH9kMpaKmg+1k1wHRTURpGcdatSbsme7ccGrni8mFVM8VFiUtJRCKH71A
         ZuBg7KpV7DP0Kmm8+16uQqaLTAY0I2j8wgiqxiBDsg2LJ4L1iMQS7uN2h/VKURyOtcYC
         aWPg==
X-Forwarded-Encrypted: i=1; AJvYcCUBgHvgoAjQqUM0FhqD5sIDs80NneuThMm1mpDbugu5li+ZJItZ9hnPyHvz8BBF5WfIoxam2/yDGU8=@vger.kernel.org, AJvYcCUkBufQZm0LY764P6H0PqMCY3e8GW67J5rh3NcNZJVH2ud0qPXCvOy9J67VvTXbiygne63Csu3L+BGVl9z3@vger.kernel.org
X-Gm-Message-State: AOJu0YxZL1XScreAzEpWNUitA7r9sZlQXbBQqulxlemShDoBF+aMMLRY
	MvedR7mqtL7KyttMFyA+BVBCbbcAuB3pmxB/4JSmOPYeJUWh1xIOdfYW
X-Gm-Gg: ASbGncs6uffUPKUSBviBVgThFjCYJAHkg+7bFY4mhcrnMpNE9R0Al6QM4LD8mCqZBLk
	zSdnse85rS9d2MBZf4Kpz4VhodLWax44dL0xhV4D+d7EhWci7Q1XjXZAMI0a7j+I9KXi1euFpiD
	pEM7hfVg9+KqB6TsnJkIlJ6UgqWMXgyPQcrEZJXug9i39/mNQ5sytR8cH078QSj96Xh46Mos5u2
	fEetaTzxIls5gjtGTW0Nz34u/VQORA5ZAGiGz1jjYGWdUL6eegJA5Mr1Ob/8ylQPt9nTf34EyIl
	L+aee64nvtPtPlMQw5Y5Rs0VPpUQURqvf+LNy2f/qPILvZfcVvgCWW9YH4KN0zadMOePST6cyGt
	LcOOpxuo1YwUQrYrzASC+5A==
X-Google-Smtp-Source: AGHT+IFnZVnz91E1aMX7ARDwYwg+BARaYt6e05+1A6Tv5WdtL6O5XLGtiPAePXWaNL8IZcemymeVgQ==
X-Received: by 2002:a05:6000:184d:b0:3a0:99a5:237 with SMTP id ffacd0b85a97d-3a35c825937mr6267676f8f.7.1747781436956;
        Tue, 20 May 2025 15:50:36 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:36 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] iio: accel: adxl313: add power-save on activity/inactivity
Date: Tue, 20 May 2025 22:49:55 +0000
Message-Id: <20250520225007.10990-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch set covers the following topics:
- add debug register and regmap cache
- prepare iio channel scan_type and scan_index
- prepare interrupt handling
- implement fifo with watermark
- add activity/inactivity together with auto-sleep with link bit
- documentation

Similar situation and approach as for the ADXL345. AC/DC coupling might be
a pending option as it is quite the same as for ADXL345.

Since activity and inactivity here are implemented covering all axis, I
assumed x&y&z. Thus the driver uses a fake channel for activity/inactiviy.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v1 -> v2:
- usage of units.h
- simplify approach for return values
---
Lothar Rubusch (12):
  iio: accel: adxl313: add debug register
  iio: accel: adxl313: introduce channel scan_index
  iio: accel: adxl313: configure scan type for buffer
  iio: accel: adxl313: make use of regmap cache
  iio: accel: adxl313: add function to enable measurement
  iio: accel: adxl313: prepare interrupt handling
  iio: accel: adxl313: add basic interrupt handling
  iio: accel: adxl313: add FIFO watermark
  iio: accel: adxl313: add activity sensing
  iio: accel: adxl313: add inactivity sensing
  iio: accel: adxl313: implement power-save on inactivity
  docs: iio: add ADXL313 accelerometer

 Documentation/iio/adxl313.rst    | 196 ++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl313.h      |  35 +-
 drivers/iio/accel/adxl313_core.c | 625 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 860 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst

-- 
2.39.5


