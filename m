Return-Path: <linux-iio+bounces-11477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100579B339F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9031C225B5
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4601DD864;
	Mon, 28 Oct 2024 14:34:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942413D539;
	Mon, 28 Oct 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126091; cv=none; b=Pjf18peNfRVTm+du+JYLlSyLE9DjcvybxjFTs4aSYn4z7ueE2jL5C/SIaXhwuMqrOiZTo2hBG9oPpd4l29CAMXTOCeODFF55JSFQNtdB+g47PY6YAPc0j+1dWM15CJww1YfVlmGJESuYMBAqBnATNZIcpw/208KH9Xp2uy7P8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126091; c=relaxed/simple;
	bh=4P6QDa5Hg+4FOfA4kiB+q1cOTTIB8GQkFDRv3hRnPHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pL19qjDrMx6ouDrwpcYYmQ+EooCwIvTPVlE7ighNY6+jdeBbfTaR5k0lepsMnLWvwOOjRAO6BnhMucU8tRyBPG/vZQc8Jaz/K2pcpxEp2qrmjewiVhrgVKcPiTTTknoO4NmyCmKTyz0qQ6ItQLqLqUUQaoO6zsqwXIxaONftpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XcbT230LTz1T9Dt;
	Mon, 28 Oct 2024 22:32:38 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id CA45E180064;
	Mon, 28 Oct 2024 22:34:46 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 28 Oct
 2024 22:34:46 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<patrick.vasseur@c-s.fr>, <christophe.leroy@c-s.fr>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] ad7923: fix array out of bounds in ad7923_update_scan_mode()
Date: Mon, 28 Oct 2024 14:23:57 +0000
Message-ID: <20241028142357.1032380-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In the ad7923_update_scan_mode() , the variable len may exceed the length
of the st->tx_buf array, leading to an array overflow issue. The final
value of len depends on active_scan_mask (an unsigned long) and
num_channels-1 (an integer), with an upper limit of num_channels-1. In
the ad7923_probe() function, when assigning to indio_dev->num_channels,
its  size is not checked. Therefore, in ad7923_update_scan_mode(), since
active_scan_mask is an unsigned long and num_channels has no set upper
limit, an overflow might occur.

Fixes: 0eac259db28f ("IIO ADC support for AD7923")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/adc/ad7923.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 09680015a7ab..82b341709a64 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -170,6 +170,8 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 	 * skip that one.
 	 */
 	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1) {
+		if (len >= 4)
+			return -EINVAL;
 		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
 			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
 			st->settings;
-- 
2.34.1


