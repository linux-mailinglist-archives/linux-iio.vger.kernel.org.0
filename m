Return-Path: <linux-iio+bounces-16725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E96A5BB26
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A873B01CD
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE14227EAE;
	Tue, 11 Mar 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="dFIVocYG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E38226CF0
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683079; cv=none; b=PycGWt8nsK7aYd5cqiWoa+JJqt4Gh7Jq7ZYc8/e3UnvKuNJMPGlhk8oaJneqRwfBrLaW4/s+B8Bj1+AArsmig78Y8KTknXU3uxf6jleYMD3rMRRKuT5qW0cNzquGdp0hGfsG2gv0D7Yu3EJH7CI+MHABx6aNRD7SoDFH5b8Wu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683079; c=relaxed/simple;
	bh=epZ57SOX5YzHnFy/WkFcRwDgjbiMWrHimD4P10IE+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goaOGb2DDfb4a70ke0idYq3seWhbLitsJjWjsni/hSq1kBA8YYQ2PZfZGX3WHsDoEEnNT55oi4S8feMcSn73oYvKcoZ3H49edDinRJXKmG7T2Y0uWigmmQXJTV89pWH4ppc0WxAhtaN+caOqfYrt6N9b4HFxxIijkwp9Y4Sju/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=dFIVocYG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2768667f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741683075; x=1742287875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta529X7Ec9Pad2vo9YncNZsmhmxGAhn1X/QNcXk60qQ=;
        b=dFIVocYGa1Vyt0kXvyBJIFO6wKMX/V2nTVe9RgKQ9NZjZ8B1Fr8/YnxJkGP3gNtAbu
         zJ89TC4NRkeGREUvzDRtZRRCujsN3gYKDrGJflzlM3cMNglujkMgS6ZuDY/C3itmRaIr
         ZiufEgzKOuKmGzPGNZQVQ8kIZGWMqPOlwzicM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683075; x=1742287875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta529X7Ec9Pad2vo9YncNZsmhmxGAhn1X/QNcXk60qQ=;
        b=ba8YT+LjZRGuEpvYb1KXl6a0WdUY3RcaD9mSYzK3qFr0E+K+KaXrKM/N1+toGOO6lL
         cKMpxVWasSx75E8SIsZKcaoCKFekzNdBjjlcSw3vV3YLlhsX5d4rNvyQCCsOw/omZtAb
         b0Ki0eS46Hg11EDgrOCJZwQxUqHBMBQC5SxzSyOlP10V/TetLaLzcCM3dMzFbRWYvaKa
         BsmKROUdPlGCeLIfiEZI9uyIaVOPrnPf+fxkHBmKQjS6xmBXpr9jL+C8U5QWJr8MlIj2
         lxSTy8W/PL4cgeozuaCTEKufiU6QxLa7P/PXP6TLUTajGkAprycYkOF1sQeG/E7qtQX+
         qMFw==
X-Forwarded-Encrypted: i=1; AJvYcCVzqKGjEYVH4WwEXYa6wg5qUWznCJ3myT9FiSJzzzq/f4GNlemP9GoYBWppUv9Y/NScsbvo2PavIsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/em+f3p6YxPcW/isv3XFGJdJRn4p36t/3UYJvi1LEBAYZFAIT
	gwWXlNJd0WZjaFTIYuLVZFz5KeozA7t2HpMy6cieUbOmE6Dgpy/33t0OkIUj0w==
X-Gm-Gg: ASbGncvMpLnv9sBcopethOIO46wRnqeImByigPI5EE48wMMWr0knuloovaGDX0mfswR
	4reCrGpSdA3g3VrVcy6MipDHgCwsu/Hus7IGpAJT0X/kL7lvHiG2/hzFdRzC7RiPLum5pJmVD9D
	zDuhrbOywKrqJAvHWjxQIwk4BeWG/XIYZOE9SjUFGZlVqRup0etyHlHP/Tb0VFAEFVQ/iPyFEkg
	tfE6yfid4AAWMDHhopEksNikv0kJuKZpZg8pJ9zccS+r77KdsAO+hznMbm5av9CWThGkE4TmI41
	Zvti5NQd5DMAxWcdJymlpyq4mKCqKuYAMfTlqGrsLfK+x8QOziPG8gGpGdnd/g/wydhwRuxHGb+
	AXjbXitI=
X-Google-Smtp-Source: AGHT+IFdw+TlvJni9KvGZu3iaRvW4wpiEd8GOvdZeIqppNlFn1Z9pxj7+SuF2DYXmjUR1ceR3bTYEw==
X-Received: by 2002:a5d:6daa:0:b0:391:2d61:453f with SMTP id ffacd0b85a97d-39132d71099mr11193196f8f.24.1741683075439;
        Tue, 11 Mar 2025 01:51:15 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cdd7sm17746333f8f.56.2025.03.11.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:51:15 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: jic23@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo
Date: Tue, 11 Mar 2025 09:49:49 +0100
Message-ID: <20250311085030.3593-4-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311085030.3593-2-s.seva@4sigma.it>
References: <20250311085030.3593-2-s.seva@4sigma.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_tagged_fifo from falling in an infinite loop in
case pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---

Changes since v1:
* st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
* st_lsm6dsx_read_fifo: dropped check for zero fifo_len
* added Fixes tags in commit message

Changes since v2:
* split patch in two parts, one fixing st_lsm6dsx_read_fifo and one fixing
st_lsm6dsx_read_tagged_fifo

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 480a9b31065c..8a9d2593576a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -626,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
-- 
2.48.1


