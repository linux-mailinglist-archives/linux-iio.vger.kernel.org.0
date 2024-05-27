Return-Path: <linux-iio+bounces-5326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AE8CFCAB
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578A2B203E1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45129139D05;
	Mon, 27 May 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="mIXKbnT9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B38BF0
	for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801635; cv=none; b=cCsJYNCZkFBuVFibQ1kppketkfLxvfAJ1051b9DuZhQH0rbSC2M2FV+4JOYzEvN0sfd/ILePfHCWeIYj23KC3F2Hei8eFEmUhPhKuCx05cTL3HnoYxSd92Z+bClsCnyLpslo5hxJ8ckj/MOm0YHsyambfiU8J1ByQ3KM9u8ZDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801635; c=relaxed/simple;
	bh=OHN/IAzOwDQ3KJIFqz1W6xo25EiShF/8i4Enq++VJWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nt9Cq6EueDyqa0LnUWFKFYneLO4Gii7fbNGnnSHn92vKDrQ8NevoJKAqfbo612DCYmLVvGe3C7uACy4AZTm99mKeGK6w4y2tX4d4SObgY7/zCz2j/bVRla5pN3xJeof/+ocDx6/X0JFoPUsZ1dcardBKiFmsVJWrNkHofRb8ZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=mIXKbnT9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a6a54416so3253845ad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1716801631; x=1717406431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAawep2ohP6ztgwKK7QFf4ez0qZx5TLAK9XAOHJA5Zw=;
        b=mIXKbnT9Sz4BxNzOKEqruOQKxH0mOP1jkO2BT/9jAwTOcNGo3YXeyQPLUnSAMSIJMl
         1nQ7t7lljFfLznfMMmPFghdyGD5uAaqfdw81ztfHws6DjO+HFNnjBf9bNzDectsge8Cm
         FqIvga+bz/VxKxibrAqqV3T8xxFrP05mKX7CZAP+neTKTpjH+LiH520Z1v3wLsp+mjlI
         LHB9mVCue9DNKAij9I9b1h7rmxbTwIMbIijOgKLtKfm5CGjgwitXlylcUf9fHVxVov5P
         txxEeVWOjAqqo405x9OXv2fIWtCeqd7evLazL6ZJZNcL59Oq0cXFLbX5z7KAaIxUj6JG
         NJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801631; x=1717406431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAawep2ohP6ztgwKK7QFf4ez0qZx5TLAK9XAOHJA5Zw=;
        b=RrGGOo7ZRFZ603fvlWCOAHdJtTj8ltWcxI0m/97Tqy9pFAmQ14lNHUuEzLPGeuxPIn
         LCVWfssv0Xb3NbS7hW6zMzwpVIzN8LXAHA4kJDjvfsRHU/sqIswOYIQiBaGqF1fEQRQK
         1QX1K4I2PkWT+ZoJFbLWqcAzANKzO2aE//TdovoR6V19OD9fM8Gt9AaHl/lUxBd4tEIj
         eY0Aw4vT4YvndAekPtjxavrkjO21I75lBbaUQscZCQBBpRJrUGjwveFv6dSvp3oYFyj0
         3RDuhedPcYqyIwoXJCP+Mi3ZvwXnrWGTgnJa4NwJ2NyC04fc4kd0065NRL9kAOI/ii9V
         Ir4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMplH9l7D+LOTtzHDirOwl5K9sNjl0Eqn3f0WvCiVNfpfpIIOjEgx+qBlobDQnGyi3Lb3IBeuXQKzb5ozWkKJ9zmUHQgm3wV3n
X-Gm-Message-State: AOJu0Yyvbz8tLGcrwn64qzSt9NsVmZLsX6CYvlfXU784K566Efscufif
	IBcKw+4V0ngrRMqCdlSmR6Va6EIoBg+1hJsqgg0e6PB4Qty1I81VhfuDfm9df8U=
X-Google-Smtp-Source: AGHT+IEq88ydFy9TAOBH1E01Fp9p1g9n21J45BUISJwSAEKRIsD79kzH8P822omyL8QkEjaehrrstA==
X-Received: by 2002:a17:902:ea03:b0:1f3:81c:c17 with SMTP id d9443c01a7336-1f4481f22cfmr128503305ad.23.1716801631067;
        Mon, 27 May 2024 02:20:31 -0700 (PDT)
Received: from fedora.. ([2804:14c:154:9a8d::1000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9d2a22sm56099015ad.293.2024.05.27.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:20:30 -0700 (PDT)
From: Gustavo Ueti Fukunaga <gustavofukunaga@usp.br>
To: jic23@kernel.org
Cc: Gustavo Ueti Fukunaga <gustavofukunaga@usp.br>,
	caiodantas@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-adc161s626: make use of iio_device_claim_direct_scoped()
Date: Mon, 27 May 2024 06:19:40 -0300
Message-ID: <20240527091942.53616-1-gustavofukunaga@usp.br>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make use of iio_device_claim_direct_scoped() to make error handling more
natural and simplify code.

Co-developed-by: Caio Dantas Simão Ugêda <caiodantas@usp.br>
Signed-off-by: Caio Dantas Simão Ugêda <caiodantas@usp.br>
Signed-off-by: Gustavo Ueti Fukunaga <gustavofukunaga@usp.br>
---
 drivers/iio/adc/ti-adc161s626.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index b789891dc..f7c78d0dd 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -137,17 +137,13 @@ static int ti_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = ti_adc_read_measurement(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret)
-			return ret;
-
-		return IIO_VAL_INT;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = ti_adc_read_measurement(data, chan, val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		}
+		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(data->ref);
 		if (ret < 0)
-- 
2.45.1


