Return-Path: <linux-iio+bounces-10679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCC09A1E37
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F11C26758
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD31D8A14;
	Thu, 17 Oct 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="o3H/1ZkE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FA1D6DB6;
	Thu, 17 Oct 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157084; cv=none; b=I+Em6trsiqJzZ738jxcV2ApzywYmJd62/CJwExulhxqFlaZ9jgMkH3i+DxFiiaHuI5Ji3C4NEUUhcPzuhF86YCrwo5G5Z6rJbL6qealScKuLsK3K3TBKWRs+CPzOU15d/0B0R8IptMNHoxjq64+NPu6D+pUCvmjzgh31Emr6RVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157084; c=relaxed/simple;
	bh=M+CZBwHFQQVnw0wKiyS9et3jXzRYYEFZJRWpdCs4vLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qApcBRcRE8FCgcSQjuYaOVHEFoh9bJACF1W6nGe4B1wJku53BlG7oNyyFXx9z/g/bSsvGu0tra13DBWnNCzY+9GFZrD986z7lXDCcNF+eXtoRGHXgiS1Gvu1kdhqM7T9v+Rx5SrD/8XRD+mZW3qTtVX0CNtPpTyX2wyRWjbXqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=o3H/1ZkE; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729157016;
	bh=loAcfX4M69IyudaFwh1BHHZrjzonlv4S1EdZL66rgkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=o3H/1ZkEr6Ioh5BsK6brPboy9+AasDTIJ3mW3/KHxl7grk2STysU9/KL+IXk78lXF
	 iBGAuijVykEfjqODQs1BD8SP0Ft/e5xqR4HyPytIMTaxThG2hr8ShpLLpvCMHjSGsD
	 FyQavKIRYvWGLnka/JjZB1+6HqT1dsm2HppGG/Nc=
X-QQ-mid: bizesmtpsz9t1729156947trfrha0
X-QQ-Originating-IP: gnbZjf9u8w3eKUsFgs6fCGR4vr8zspU9QMv7nTXXxFs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 17:22:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7113092225127235405
From: WangYuli <wangyuli@uniontech.com>
To: puranjay@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com,
	Jonathan.Cameron@huawei.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] iio: accel: adxl355: Fix typo "accelaration"
Date: Thu, 17 Oct 2024 17:22:21 +0800
Message-ID: <9F137828F9F185FD+20241017092221.361511-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MyKZhUs2HEHf+5uQ7KL7ugMgNJeTvaA/pSmy/x5Xa1L8KU4hDL5IL4bM
	KOEflUA7j1jo80+uk09sIElLmDSAoJ4izmJKey2Gpxi8VdS9SctZYSzcgcQPvnzVocO7yQW
	HCF4NvokzcoUyi8y0FMSzn5V6T0f54y8p6wLcwsZ2V53VE5AeFsr8+gq49x6+10E4ZHwksL
	z2iaDTVOrVrUkt3UhFlB2xtTBG5hZMLOlWcEIYOir8L6jGkoubuLioCwAYAxc0VqP9IYwJj
	7uxOMlBRwo4Ikuv5e8kZNfOspYBABuw2/q9jr5tPdX35Hce9RB15kd3klSjq7/4O6afteae
	p6ePb30Ma+7v10IHaf5qH0IFM/hl0Iho+tAcCN/WMFLhmG3h4f7uRXS6WWfiZaFZNWtLs/K
	301ThyZ+IrG/qjsXg73sdvngTLQOMPKX+RozMwIRzmiDuTzDOWOQQykp51ShZ9NpNIFUap/
	2LqTsk6AFJ+9Obor2bYa3FwmWWOQZYiOMxFo56Lixd/VUhgeIFiPZrMx7EEOCyhWnU+FPD8
	doFz4ldcxDaSbZS3MXDOcomIDEZvwxuZCBtu4RdBkQ00t9yKD8xyQ4Y5u4cVaFI9OVN5MPD
	GWTPqOHzRv2tL6LzoaQ03KK4pPz6iRU1NrNIEbz8/XhN34vejpSLgr4XeRjX5yQnCkrMzzf
	WpftfmfacRRHlt9DV4nOu58wPgPhYCAdQikf8X9tVTFUV/B26R+vxSrixUQcFTsi8mqA0ZV
	Kn97T+f60bAkMaSyI445Hfgpj5T8ormNs4FQ4JwVNvJcqZ77D3Qh7af3Ey/yA1qTtVNffmk
	gzKxMQQbgbhMK+VkHbEwQutY64E+58rQHzzVTGUgBbnTL8NkKwnorZr+KP6bjz7sX3Vs61H
	V9b4qiXly21+BluxI1BK+0AOdGBkVSCYF1PAx1lWX3RpiErKuZMllFxTZJCUKnjY9fuyHNp
	dWK2YEAZnh6QCDjpgbjMJpKsi3NBlhOei27ToeGELmQJDlnuOpLb4YLTrgmMMH1N8+Lc=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'accelaration' in comments which
should be 'acceleration'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index eabaefa92f19..7ccd2f653b9b 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -643,7 +643,7 @@ static irqreturn_t adxl355_trigger_handler(int irq, void *p)
 	 * The acceleration data is 24 bits and big endian. It has to be saved
 	 * in 32 bits, hence, it is saved in the 2nd byte of the 4 byte buffer.
 	 * The buf array is 14 bytes as it includes 3x4=12 bytes for
-	 * accelaration data of x, y, and z axis. It also includes 2 bytes for
+	 * acceleration data of x, y, and z axis. It also includes 2 bytes for
 	 * temperature data.
 	 */
 	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
-- 
2.45.2


