Return-Path: <linux-iio+bounces-1839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE728364E9
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AE4B25FF7
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691873D0C8;
	Mon, 22 Jan 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jku.at header.i=@jku.at header.b="Ytlc4IR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from emailsecure.uni-linz.ac.at (emailsecure.uni-linz.ac.at [140.78.3.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEA3D0C3
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.78.3.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931952; cv=pass; b=qNbF7JSvLsbZs1u5t2Nh/K2RdPeF/7qcHof0PJDY121hVoBULUsLfeCAtsoFlubVc2xvCyrQDepnj3YvKY/metRq7WxBGBcr3uVkJZhavnAY1TLbGRWcaXiv43zhkKPDgEaicW3pQk9cRVAx3RbSMAOddeYVA2czsrXPmkJuAoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931952; c=relaxed/simple;
	bh=WJc9nqMagzP3Juhle/1lTUrvHfr8R7l/QH+4Gl09Xxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kfd6YyPhFvovjus95opzrw3IKQeFj/VcT4+5xEn0/R/NabJkn7pdeXYNT5D7Jv5uGfBlDv/qm+lXMwxvw1/lMIClF8Nps3Ehc+6Pl4nK4/7Prm+c6BNRW/4w0uBrTUjVma3TEcCxc16QMvgPjKZoCXnIeCBvAGqrOdXqXXynNtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jku.at; spf=pass smtp.mailfrom=jku.at; dkim=pass (2048-bit key) header.d=jku.at header.i=@jku.at header.b=Ytlc4IR+; arc=pass smtp.client-ip=140.78.3.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jku.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jku.at
Received: from localhost.localdomain (unknown [140.78.146.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 4TJWpl1CGNz4vyq;
	Mon, 22 Jan 2024 14:51:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=jku.at; s=202311-arc; t=1705931487; cv=none;
	b=RRhOd2hTHqV2UoLZPdbfwLv/vTdLxuhVsWuARYHDOh1lVs5ASdg5YZZQxP1xYwR5L7W4jODljdQrSGGz+IkdMalAxiDNg5C+TmuqHqyD7hXbRsxEndJxyUd9aZHoULYWtQ+ODOG37H0c8GLlY2K2/Xw7zuCX8YCODbjD7hn7PLHpuPPvfX3kFUvRiMRXlq6G52H4Bz7IUFg2ISTwAQ62DJsPUwoRZ1et/KaY9Hje3jtdR4Pk45iqCYEETk/ua5w3Ogo5S1VdYherMW4f59QAWo8UWrvkMD4/if7hatI4VHwXX1KBlXNFftwrEgNBQeZ6t8U3otGov9oVdLCm3/f1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=jku.at; s=202311-arc;
	t=1705931487; c=relaxed/simple;
	bh=WJc9nqMagzP3Juhle/1lTUrvHfr8R7l/QH+4Gl09Xxs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=OPDXXDZHqLVMcaIqxW/qyzTH2je8RZ3lSOjYSO84uqXVrHLI3p/+dyhy+ZmnCWGS1ltCyGXrJ3x9A+8YDkv7gIjHTgRbBet1HwJiq8MgpA/lnUIf/hYUfTI/eLnykbnDl1Ng83mtREzZs0YINlc7/YKVBjFhNtzenGRmxmYD9lHRpi/de97X4mPj0ZwU1o1lstKnuO9OlvO1ca7SCmE74glz5P/mS+1gPhEwF8jeu6VBKbeERXHkHcw/JH/iTBg7tTuZl5rObDQ5bQ/w2CA0nQHlnEP7CtUULo6RzO8qyjLYQQs3Baz30ZhFZYdkukoN1b+5jx5JbBMmbPmBW93YCA==
ARC-Authentication-Results: i=1; emailsecure.uni-linz.ac.at
DKIM-Filter: OpenDKIM Filter v2.11.0 emailsecure.uni-linz.ac.at 4TJWpl1CGNz4vyq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jku.at;
	s=202312-dkim-jkuat; t=1705931487;
	bh=6P0Vrn/CIEeqniYVsNK3MfnIPj4k3ouBAVfHwKqbP+A=;
	h=From:To:Cc:Subject:Date:From;
	b=Ytlc4IR+AGyiUfqOLJ+/zcGx46VyL8W4cRPJV0/IyeV0kHiDXAIZXqg3wuafU/ldE
	 YDzMJvghXKVz24PkFP3INv3sSaZncINXxwXrQsoqUD69LxnvirpQjpNQ2stGfnYSAH
	 m3JkCKfdkeR+WyPoanopo0fOZuN5R5KqWxIxkTGAWvnT9DfNJz+wnC6MdOdnBErQVC
	 1qHdDojrqhd8Kb7q3mKCdWNyH6IDWq9q/dgrAakRlnRg0NDuVpVJp1lgG9hrEJAR+x
	 +MszMP/5M5wejvqQRPFp7bszqSz/JzarKkJ+lMpgQtiu6dTt976wL5W7yFSJJZjgVv
	 UjR5/OkVVM3ow==
From: David Schiller <david.schiller@jku.at>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	David Schiller <david.schiller@jku.at>
Subject: [PATCH] staging: iio: ad5933: fix type mismatch regression
Date: Mon, 22 Jan 2024 14:49:17 +0100
Message-Id: <20240122134916.2137957-1-david.schiller@jku.at>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4c3577db3e4f ("Staging: iio: impedance-analyzer: Fix sparse
warning") fixed a compiler warning, but introduced a bug that resulted
in one of the two 16 bit IIO channels always being zero (when both are
enabled).

This is because int is 32 bits wide on most architectures and in the
case of a little-endian machine the two most significant bytes would
occupy the buffer for the second channel as 'val' is being passed as a
void pointer to 'iio_push_to_buffers()'.

Fix by defining 'val' as u16. Tested working on ARM64.

Fixes: 4c3577db3e4f ("Staging: iio: impedance-analyzer: Fix sparse warning")
Signed-off-by: David Schiller <david.schiller@jku.at>
---
So apparently this has gone unnoticed for over eight years. It appears
that I'm one of only a handful of Linux people with access to AD5933:
https://lore.kernel.org/linux-iio/20230606113013.00000530@Huawei.com/

 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 793918e1c45f..b682d0f94b0b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -608,7 +608,7 @@ static void ad5933_work(struct work_struct *work)
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
 	__be16 buf[2];
-	int val[2];
+	u16 val[2];
 	unsigned char status;
 	int ret;
 
-- 
2.39.2


