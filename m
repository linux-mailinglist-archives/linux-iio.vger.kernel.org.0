Return-Path: <linux-iio+bounces-26658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD1C9DC87
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 06:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 616204E03BD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5417279DAE;
	Wed,  3 Dec 2025 05:10:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA00433A0;
	Wed,  3 Dec 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764738604; cv=none; b=SOlu91ZmTID0MnJHiLmwF47w9Km80YHFgUZwNpwatWsZSSnIP9eeC/B1e1oGr2iclHENcrb/G61o3AKuc+dKe/SyhK0eMtmx7q7xXPqxdHlHS0LFQMFSNNQKqcvzYKEMVgCzu6sQWVrlAnBWDYYrB3UNV0CuKdpoY5GkGCoVQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764738604; c=relaxed/simple;
	bh=2SqMWXw3Ce5tIZ49apue0fY63jWwsxwbIPpGV7y7fZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPycisTpx85zZI4EhzHfmgT5Qh7r/Ekk0hMFMMBF2JGQImCl20OIiUSx+2aB+MzmhGKWy9svt+LGAfqe/rqwzAfFeAd+HFSMQq3+KNHegjWYLuL79mS6MJ2x/eFesTsPvPF8y3pdOhD4Z9M6BPqM7nvqHXa39RNdRwml1Dnt6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAD3+Wodxi9pFFMMAw--.32383S2;
	Wed, 03 Dec 2025 13:09:50 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: lars@metafoo.de,
	michael.hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] iio: adc: ad7606: Fix incorrect type for error return variable
Date: Wed,  3 Dec 2025 13:08:44 +0800
Message-ID: <20251203050844.330-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3+Wodxi9pFFMMAw--.32383S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF17uw1rGrW3AFy8Jw13urg_yoWfZrg_Kw
	nYqan7Wrs2yrn2vr42qw1xurWak348Xws0kFnYvr13uFWDtrn3Cr1qvrZ8Jw48uF4xC34D
	ZFy8JryrZr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwFA2kvgjD1NgAAs7

The variable ret is declared as unsigned int but is used to store return
values from functions returning int, which may be negative error codes.

Change ret from unsigned int to int.

Fixes: 849cebf8dc67 ("iio: adc: ad7606: Add iio-backend support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/ad7606_par.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 634852c4bbd2..b81e707ab40c 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -43,7 +43,8 @@ static int ad7606_par_bus_setup_iio_backend(struct device *dev,
 					    struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int ret, c;
+	unsigned int c;
+	int ret;
 	struct iio_backend_data_fmt data = {
 		.sign_extend = true,
 		.enable = true,
-- 
2.50.1.windows.1


