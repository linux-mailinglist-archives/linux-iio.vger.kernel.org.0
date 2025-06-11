Return-Path: <linux-iio+bounces-20410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C927AD4F17
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39DA17F2C3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE3253949;
	Wed, 11 Jun 2025 08:59:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B040253347;
	Wed, 11 Jun 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632398; cv=none; b=BoVx672Zyn/2Hw8/Omn4xpbDoHyf0qQ7MrPwg06J6vLYiVBbnLhuV8Lp/8351veUpPAx1AG8p4BHjRD1oSwUJSpAVm6z0oZc1umMpX2jkqBIEgMEgqYtdaQs6Cv1jSBkJ9nGPSsBIO4ToNERXcEhk0OvUnFyjYrsbjCpLid0NjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632398; c=relaxed/simple;
	bh=7yls8RTqjCychy5J1UnejAVT7PgLZUjjuCxLZTqdq+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ry3OvXBsDGQ67eZLrvIgb1g5ROlOhnf9H8NKBRlYLoecEAwvgwKZ+kjsmoQYAx8cCoyZlnpyFSNCZ6dBgZeT4FZpoE4mqhpXhLr/z2Yw1z7LXBmHIvedEYPqcvMSUg9rJARzdZef1OnY0M2cZcFk8m7H3nWw/Q6RWI3gTGEsU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201613.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202506111658409031;
        Wed, 11 Jun 2025 16:58:40 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201613.home.langchao.com (10.100.2.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Jun 2025 16:58:41 +0800
Received: from localhost.localdomain.com (10.94.12.179) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 11 Jun 2025 16:58:40 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 00/10] iio: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:28 +0800
Message-ID: <20250611085838.4761-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025611165840d1a31d0baf7bc2147b65058e4232cda9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

chuguangqing (10):
  iio: chemical: bme680: convert to use maple tree register cache
  iio: dac: ad5380: convert to use maple tree register cache
  iio: dac: bd79703: convert to use maple tree register cache
  iio: health: afe4403: convert to use maple tree register cache
  iio: health: afe4404: convert to use maple tree register cache
  iio: imu: icm42600: convert to use maple tree register cache
  iio: imu: bno055: convert to use maple tree register cache
  iio: light: isl29028: convert to use maple tree register cache
  iio: light: ltr501: convert to use maple tree register cache
  iio: light: opt4060: convert to use maple tree register cache

 drivers/iio/chemical/bme680_core.c               | 2 +-
 drivers/iio/dac/ad5380.c                         | 2 +-
 drivers/iio/dac/rohm-bd79703.c                   | 2 +-
 drivers/iio/health/afe4403.c                     | 2 +-
 drivers/iio/health/afe4404.c                     | 2 +-
 drivers/iio/imu/bno055/bno055.c                  | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ++--
 drivers/iio/light/isl29028.c                     | 2 +-
 drivers/iio/light/ltr501.c                       | 2 +-
 drivers/iio/light/opt4060.c                      | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.31.1


