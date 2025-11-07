Return-Path: <linux-iio+bounces-26031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F74C41887
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B140189C8B2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A030E826;
	Fri,  7 Nov 2025 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIIwf94A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EF30AD0C;
	Fri,  7 Nov 2025 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546219; cv=none; b=pgOBQNxIfhj3VjST4SfHj7zz/B3+UwRlhfS2aeOB/32dioE1d/7V7KPtKAMuD0ATBntRHrj1dIXevHdaZlZJZY5/Bwpp37k/VSIqRGtPmYGN98+I8ayYaazzBf5LcRNQzQRWfjhNyfQ5N4xpWIqFpPTNEpfVOj/p880SA2Hf96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546219; c=relaxed/simple;
	bh=ONGv1ACjdjp+CWs348+vBQ+93sUiFmM8XePjcDa3Ops=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yd39Q4UwHLXFCRNn21hJGct1lD7ktxfvV/eKshG0ZvUpMEqM2OD8fMkMKBz8EE8dHu/5TJDdEX8vByGnv6mOT9tVSwM7Hj7p3KJs+Ur0i0p3FOFvpjA7qOvOUhkQvwiihGgvYemXtqaMB1kUBnP2m0V3PC6e86nJXAJzaUCu/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIIwf94A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546218; x=1794082218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ONGv1ACjdjp+CWs348+vBQ+93sUiFmM8XePjcDa3Ops=;
  b=oIIwf94AQfl4Yx7Mz8rNnJYt9BI7O+LPxbnx5AJ0eAl/oTzKNF6UJF/t
   mdEHnI3FAmwfyPbp0oL+wiSfkoHpRBYoVT/+9ICq5KtzT4Khu6bI3dP+N
   GKGt73wcibJqGQTRz17SuoQR65dz/0z0lx+b9vTbLVx6sbcISGpsDMNO1
   qMNNQtBp8EbuiduLcy/CMTJipQ03Ys8TXqM8+KMYascavCb78vhdRTczn
   7hONlsp8Y1hQ5ofrNQu/aqYRaBSTahvyWEjc8wJyGfGlRGUSf5Jks/NZK
   y3Gfy9QnlqTk8iDaqbarBEUUXHl0idvnpEyWEtpAiYJRlnMbz8c8BL5ML
   g==;
X-CSE-ConnectionGUID: hE1ArUulSI6bae1Jmqpq1w==
X-CSE-MsgGUID: 3XzIvEhsQUaxjwEO1XBJ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64400151"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64400151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:10:14 -0800
X-CSE-ConnectionGUID: yfRFfQbYStqUYagdPJaGzw==
X-CSE-MsgGUID: 7AIunAwJQwKfzYn3aVp6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187422699"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 07 Nov 2025 12:10:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D6BB695; Fri, 07 Nov 2025 21:10:09 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: [PATCH v2 0/6] iio: Introduce and use value of π
Date: Fri,  7 Nov 2025 21:02:58 +0100
Message-ID: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are a few drivers that use value of π (small Greek PI)
of different precision. Instead of hard coding over and over
convert them to use a defined constant, which one of the patches
in this series introduces. No functional changes involved.

Note, the respective IIO macros are not converted yet by this series.

All of the converted files were checked in disassembled format before
and after the change to see that the value:
a) pre-calculated at compile-time;
b) is the same that is expected.

I didn't put the power-of-10 into the definition names as now they are
the maximum that fits the respective signed type.

Series is supposed to go via IIO tree.

Changelog v2:
- redone to avoid unneeded calculations
- collected tags (Hans)

v1: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>

Andy Shevchenko (6):
  media: vidtv: Rename PI definition to PI_SAMPLES
  units: Add 32- and 64-bit signed values of π
  media: dvb-frontends: atbm8830: Convert to use PI definition
  iio: cros_ec_sensors: Convert to use PI definition
  iio: frequency: ad9523: Convert to use PI definition
  iio: position: iqs624-pos: Convert to use PI definition

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 3 ++-
 drivers/iio/frequency/ad9523.c                       | 5 +++--
 drivers/iio/position/iqs624-pos.c                    | 3 ++-
 drivers/media/dvb-frontends/atbm8830.c               | 5 +++--
 drivers/media/test-drivers/vidtv/vidtv_s302m.c       | 6 +++---
 include/linux/units.h                                | 6 ++++++
 6 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.50.1


