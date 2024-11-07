Return-Path: <linux-iio+bounces-11957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2089BFB49
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 02:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38DE1F2196E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06457BA3F;
	Thu,  7 Nov 2024 01:21:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C228F1;
	Thu,  7 Nov 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942483; cv=none; b=DCLV9WC7N+caUGb6Ym1pIS9co0HVBnuA0sYfqTw+orAkIpjKyeTjpfQJ+jqHzjU9Gi5TsY3/l8sIKHw7Jt8vhviBeWzzSEtRfh8U2hyVz/K76kqYgJgfq2jRprbYwq0Eots1+XatmSoVW3xP9eJQd6KCQDNurNAW5DsPkHEMGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942483; c=relaxed/simple;
	bh=QvZky2T40wp6AqKdgMoAhK1oEDqU/ujLzvX+/avy5KM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVFDLHNejx/tIhJKW1H3oXYezotoU3mc1X56UIX2AmX/OjVMGpGcA+bKrxW+y7FerMToxLGOZWCdgRIa9z/RyF6KT8dMZN7RBCzTUt2I1+hpD/hR7+J6MzFQRgV741mcAGJ3BlXSE43UMcDHYI/c76axqEQhAVMdfeDVGmUkLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XkPNf0mspz1T9rq;
	Thu,  7 Nov 2024 09:18:58 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id D67941800CF;
	Thu,  7 Nov 2024 09:21:18 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 7 Nov
 2024 09:21:18 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<gregkh@linuxfoundation.org>, <daniel.baluta@intel.com>,
	<shubhrajyoti@ti.com>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH v2 0/2] Fix phase range check in AD9832 and AD9834 drivers
Date: Thu, 7 Nov 2024 01:10:13 +0000
Message-ID: <20241107011015.2472600-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105140359.2465656-1-quzicheng@huawei.com>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi,

The previous link is: https://lore.kernel.org/linux-iio/20241105140359.2465656-1-quzicheng@huawei.com/T/#u

This patch (v2) addresses an issue in both the AD9832 and AD9834 drivers
where the phase range check allows an invalid value of 4096. The
condition has been corrected to ensure only valid 12-bit values (0-4095)
are accepted.

These changes ensure compliance with datasheet specifications and
prevent potential issues with incorrect phase settings.

Zicheng Qu (2):
  staging: iio: ad9834: Correct phase range check
  staging: iio: ad9832: Correct phase range check

 drivers/staging/iio/frequency/ad9832.c | 2 +-
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Thank you for reviewing this patch.

Best regards,

Zicheng
-- 
2.34.1


