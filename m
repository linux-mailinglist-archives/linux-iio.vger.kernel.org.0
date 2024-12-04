Return-Path: <linux-iio+bounces-13082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA739E394C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC1B3CCFB
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBA1B393A;
	Wed,  4 Dec 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="nrE9G5jb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF71B3950
	for <linux-iio@vger.kernel.org>; Wed,  4 Dec 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310837; cv=none; b=iDzJYHZ5ECeYJRWYcS5u7RwIGk5wqQDGWQPhnZE8qC5Qish8KVGIVGjiyYqStlXjQ0pYbx7rzTgGYr+3qA6Yrc2Q8lwYnCMccLKGbl0+PkQTcCwj0251zx54TfKl1rDsuC4l2uyufwcFoEv+7vv8TDcNCoYtipw2pv3fsR5btbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310837; c=relaxed/simple;
	bh=fMLBMyFaM+8GF+GsOXCzjWqGB484ZqIJkcQU6sTqrLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9ugoDMJAkLI9thMTg0MpT5yM81giLgXGQeYyH38rW/UB6vVc1+VWrtrnjdWQeYsHwjQDUJfUz91nTnzll4/SQKQGEDinCXvUlJB/cBV5zXuJS7eyz1hZhgBBECWDgXdeyNC/qGWcTjDFRQn0kYUZAlpq44WFvvG2ah7Zigwm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=nrE9G5jb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725958d5ee0so196800b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Dec 2024 03:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733310834; x=1733915634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COeSzvUdKK4Vt29yvAR5N7LjtaJmGcFQIVQGosYq3rw=;
        b=nrE9G5jbrDp1XRrYFYGad5k5gAlkTIZQRBvroqQYCCXHAvRqrfYIKZKiIBDb48zRYx
         VtQ5GdH5D2Adw+lNVe3JAYRiW9wJisBXMbwJaLd/GMZgFaiZoBT335++yWtTbllVVGUz
         1cnrYz4ePt/omhy0DXj19KOjLLF+KojYmBridG8QtSJeiCDycls/9ZpwtMKBvzfGbO7s
         gF1YrzhhdyKjUKqjPYWcybBNnh865HrLwBQ5YXui6vWm4q+N2lsQpXJ4LgiTmLjiRGEh
         45eNtKSZRR1thsgGmWfxnM1L2g2iR5UNUPbKDqqagE3Y+S//2yhG5sHMkIrRkfsiYtUQ
         B67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310834; x=1733915634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COeSzvUdKK4Vt29yvAR5N7LjtaJmGcFQIVQGosYq3rw=;
        b=tlFd0mKcsoMOdYUU7ZIIMK20mn0jySIA4dX5UpnflXCRfNOEGjtgYTefIdWKZPSHx2
         UaBy1elLMmSL822u6xx6uAwuMBXIkE76G2HX6GRCZAsh/YMutWkOnP7WLvFAUfh4HpHK
         jaZWURocql5d49tSC+c3qrHVC9eBXK/h9fPppeL/6lzb/FDm+u/poQyj3pc3U/qcwfyW
         1z+yrOAMC83F0yG/fdr6B79ZVBZiTQjplHNSQnhIh4YUTyPlpx4+kHac7KQNK5MO2tL+
         nP68ScWl3VGFdp4inQFQhllZtV3dAGQL4z8tZC7zZbrOu84jeq+2834N5q8BUeop7ciN
         F+Wg==
X-Gm-Message-State: AOJu0YyEgUZin9bYTbHCNZwKvO5KKK25ftmst/P7zoVtfIIeD8KDFefG
	KiAc7bijcDwefmxRUeiF9UBFGl2K4kDoPAYjwbjz++3ZRdBaPo/b9ZEJMBoy+GA=
X-Gm-Gg: ASbGncvxc02C2T3jCTxbP0pTACFAeSerUxRV/JF5/loI7MxQN3MxLHIcmYC1+skVcU1
	DDr4Ys6vFAD1IMqCxTFSvEcWHo8lxUL711Ndt0SB2D45ssqOzKsrHHohtiagPR+pfxCOj6+IeO2
	kYzJDxHvXnRQ8AX60Vay2Km/XYnfnDNquISFF2zyAt+vAAqhRAVnltKlwV9/FPvO6D6uGCd0HKJ
	gyJUbRBmPHeytwCSNyIeSMKfriskwG9L7fFabJ+3iMAzsNr8aec3Q+BJ7bj0Z4EBmnSJ33Znxn5
	UVtE/b/CE6LUVkKvHjF/JUg8nD49Rq6SBRLZ
X-Google-Smtp-Source: AGHT+IHdHwBFiI83UzVvljJAnoa8pHjrGFbingIy3W6Vp737f7j0z9UyOvAdNkw2jiD58MOl0k1sEg==
X-Received: by 2002:a05:6a00:3a1b:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-7257fc74190mr8866053b3a.14.1733310833979;
        Wed, 04 Dec 2024 03:13:53 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725442c086csm12253420b3a.189.2024.12.04.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:13:53 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] iio: inkern: call iio_device_put() only on mapped devices
Date: Wed,  4 Dec 2024 20:13:42 +0900
Message-Id: <20241204111342.1246706-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error path of iio_channel_get_all(), iio_device_put() is called
on all IIO devices, which can cause a refcount imbalance. Fix this error
by calling iio_device_put() only on IIO devices whose refcounts were
previously incremented by iio_device_get().

Fixes: 314be14bb893 ("iio: Rename _st_ functions to loose the bit that meant the staging version.")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 136b225b6bc8..9050a59129e6 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -500,7 +500,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	return_ptr(chans);
 
 error_free_chans:
-	for (i = 0; i < nummaps; i++)
+	for (i = 0; i < mapind; i++)
 		iio_device_put(chans[i].indio_dev);
 	return ERR_PTR(ret);
 }
-- 
2.34.1


