Return-Path: <linux-iio+bounces-15417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43452A32049
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACB63A4BF7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295A20469B;
	Wed, 12 Feb 2025 07:52:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA51DACB1;
	Wed, 12 Feb 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346755; cv=none; b=XBds7OBMCx67Z8s1NfsDWrhwKU3ylEZ+0CJ4cu3gYwXppp0uAdqcbtGKoNLRdogDg92qzd/CNOrFrcMareEIaJPJ/QUxzjrqHune90BYkrs5559569/NWsE4lmCDVr53uSJFFrT7kuA1LZm+SEXKm2TqWBykRVfYg2LYY5YXFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346755; c=relaxed/simple;
	bh=ZLRCtk6QuTg28WDZKjj3yQQ96rGnHIlwZKVRG6phBAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iqmota2+8Jmh+v0d1BpakuUizWeChvSxhHEJEdl/WWeahbnUZkM05Y+fso7zD1fbDcVeN8nuuX3Brm4Ag0cruKzlqCl1wR6vEdSGEGWhJ1O+d1iNQzHI/P8QWlds3PacYtC3cN39lWY0bPe0I0lMXG8uo0d/nkR9g7OAHYyTyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JZM00123;
        Wed, 12 Feb 2025 15:52:23 +0800
Received: from localhost.localdomain (10.94.15.56) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 12 Feb 2025 15:52:24 +0800
From: Bo Liu <liubo03@inspur.com>
To: <dan@dlrobertson.com>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 0/4] iio: accel: convert to use maple tree register cache
Date: Wed, 12 Feb 2025 02:52:19 -0500
Message-ID: <20250212075223.4164-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20252121552231e45a39ed07fbbfc6041159b89807240
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Bo Liu (4):
  iio: accel: msa311: convert to use maple tree register cache
  iio: accel: bma400: convert to use maple tree register cache
  iio: accel: bmi088: convert to use maple tree register cache
  iio: accel: kx022a: convert to use maple tree register cache

 drivers/iio/accel/bma400_core.c       | 2 +-
 drivers/iio/accel/bmi088-accel-core.c | 2 +-
 drivers/iio/accel/kionix-kx022a.c     | 4 ++--
 drivers/iio/accel/msa311.c            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.31.1


