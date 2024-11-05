Return-Path: <linux-iio+bounces-11919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D708B9BCEDE
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9014B1F245E9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3B1D9340;
	Tue,  5 Nov 2024 14:15:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051281D6DBB;
	Tue,  5 Nov 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816105; cv=none; b=VaTf6wGoQ5eCaLd9Ni5AZ60ANCqJOWRg+yz+rsJ6sI/qnLX2hJra0wzUahZxj4gdTU9fn8v6I5CrY/DNk1LHklvwuX/DFPM1q9fdDnZRBhbf1XFl9qLY8uXrIjcUF6jWewh8KMBD3WMFIzNV/A/mj4x9ZPM4ZTjhb/pn7FkqELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816105; c=relaxed/simple;
	bh=u37A83b7u71UReUwZ8qF3KJR2fr9d/q7tVyBROUwb5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IAVg254nBgEi4+RTjemreMcifDK7mzxp9may5OmhvULr5M0qF3NYmlPDkwC13dCHiw3iQoVOtesZjOlVEbyu5kma9oSV/Ogl+hc+QSkuRm64iXsYf1glYiUcyCdRA7RK6HYz3VH++7cP9DgsvySxC8qjpsMj+jpw2dBAdBiaOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XjVgk1rbhz20rYL;
	Tue,  5 Nov 2024 22:13:54 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 425B518001B;
	Tue,  5 Nov 2024 22:15:00 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:14:59 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<gregkh@linuxfoundation.org>, <cristina.opriceana@gmail.com>,
	<daniel.baluta@intel.com>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 0/2] Correct Phase Range Check for AD9832 and AD9834 Drivers
Date: Tue, 5 Nov 2024 14:03:57 +0000
Message-ID: <20241105140359.2465656-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi all,

I am submitting two patches to address an issue in the AD9832 and AD9834
IIO drivers. The current implementation allows an invalid phase value of
4096 to pass due to incorrect range checking. The phase registers for
both devices are 12 bits, meaning valid values should range from 0 to
4095.

These patches modify the condition to use a greater-than-or-equal-to
check, ensuring only valid phase values are accepted.

Zicheng Qu (2):
  staging: iio: ad9834: Correct phase range check
  staging: iio: ad9832: Correct phase range check

 drivers/staging/iio/frequency/ad9832.c | 2 +-
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


