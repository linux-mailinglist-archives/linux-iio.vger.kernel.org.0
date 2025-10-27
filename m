Return-Path: <linux-iio+bounces-25481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8880C0E7D4
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA81519A66CD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BFC299954;
	Mon, 27 Oct 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKg/wNQP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF721E505;
	Mon, 27 Oct 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575938; cv=none; b=G6iwN5nzPJolx9EuZN67TiIPfbpzezCcGI3wPrWLsISeLJ4HYDSu1Zfwj3Ay8TU7XLkxwpErlVJoFw2ckhX9k0PAsEXIehebe7XItciVVj71oNN/QDIEwq4PvXqtd3ZRlVADgtd5g8to75xgn0ZytoAsv34n/f1DvB3mH/G7FZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575938; c=relaxed/simple;
	bh=Vedc2M+pgV+Nboq192K0aq56jCuROIM/iusVyBk0mrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TqziQjYKpnseeQKFaYrhAh5qmw9wX/tkovr3R889oHIInj0+2/AFao1lEmAZ5+xpKv5dhoMHIX4vGihezNEfXX/VFsX5Ky7MVwFltoWwqJ3pH5TGpHayQBE7KUlgmaSQ+cQBlFD2pzC0R0HozfattnXzK48wZa4YIqeKNBwKVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKg/wNQP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575936; x=1793111936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vedc2M+pgV+Nboq192K0aq56jCuROIM/iusVyBk0mrk=;
  b=VKg/wNQPw5+b3P5HfuNazYsI6Qkv0mn9r/yokRnXswvDTLMeyZZt0eAO
   0EwcM1RIOD7ZzsBoWeZmgDih8iNEA8J9tXOKRIutsWmmyDHnTmfOHjwFM
   C3rpq4LoMbOKlP6zHN+Pd7orKoGHLtqfzd1kjBdxWpOXBExJne7GjCQTe
   daeR1gMlrxuAzud81qxwB0mdrlMoHfadBOboUe4aE9gRzD0/fszv5pIgm
   EkfbTFQwLWfod/inGlK3iAdxVEq6GAK4X+WxAZHde9OvemnXLvkyNPy7J
   n4VsWjLr0hiaKi6IqzltHdooiMyHAu2bBe1RWRcGrWkAComjbbwCZxAt1
   A==;
X-CSE-ConnectionGUID: +NExYNqYSPaMY/th+2CcLw==
X-CSE-MsgGUID: XtzU+orqSCCfEzdUf21cJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63692657"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63692657"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:38:55 -0700
X-CSE-ConnectionGUID: NYjZjO/URNuRA6ZU/kXoXA==
X-CSE-MsgGUID: 5cAUlfKeTFeMC14jyMvDZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="190191657"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 27 Oct 2025 07:38:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 28C0A95; Mon, 27 Oct 2025 15:38:51 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH v1 0/6] iio: Introduce and use value of π
Date: Mon, 27 Oct 2025 15:34:49 +0100
Message-ID: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
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

Note, the respective IIO macros are not converted as it might include unwanted
churn, and hard to use definitions in the initialisers.

Andy Shevchenko (6):
  media: vidtv: Rename PI definition to PI_SAMPLES
  units: Add value of π * 10⁹
  media: dvb-frontends: atbm8830: Convert to use PI definition
  iio: cros_ec_sensors: Convert to use PI definition
  iio: frequency: ad9523: Convert to use PI definition
  iio: position: iqs624-pos: Convert to use PI definition

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 4 ++--
 drivers/iio/frequency/ad9523.c                       | 5 +++--
 drivers/iio/position/iqs624-pos.c                    | 3 ++-
 drivers/media/dvb-frontends/atbm8830.c               | 5 +++--
 drivers/media/test-drivers/vidtv/vidtv_s302m.c       | 6 +++---
 include/linux/units.h                                | 3 +++
 6 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.50.1


