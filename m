Return-Path: <linux-iio+bounces-8132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBF944E31
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17421C20C91
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7701A57F3;
	Thu,  1 Aug 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiT5bUPj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E561A57F1;
	Thu,  1 Aug 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523157; cv=none; b=nF6vOALE/6FdYn8gSE5jXUIMq+RmBmidKf/zmmFmWlHc2mSw9d+o0lKqnE73DuEUJ/eSse40zqhl4O1yUIlQFhbOSoVe4NwVoh4mHNwzwKY+/8G+/E0feNuLB0VS6/Gq+XeZRqL6igKaci+YWRdSpz1UUWyEORY8kWIhQRYk0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523157; c=relaxed/simple;
	bh=G9HtxKdCspvTdt7SWFMdCVGM7sRODkA1sGeUTi+my+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfVU8d96mVTkBJyt2M3fC8w5W/CLZSLiKvCsvFb5rtsEqPKAcKE7EGzaaUqwztv/aN5f4QKIYka7LQkk+Xid8O6AdUJ6ZQpU4lsMFULstMiY6fMrZ/xAtMR9r+yp5Jc0ptvh5DrSbDcZAN5TiTEUDRAroCUNIcmC0BvRpBclYhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiT5bUPj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc569440e1so63445775ad.3;
        Thu, 01 Aug 2024 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722523154; x=1723127954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbzafF7avxRIPZ6txzx3Gb7FIT0SoBNd4I7j1z8J1D8=;
        b=EiT5bUPj4kEutm/FiK7ujhjVq9VlrUdp2c4KqddFl69KYqfm+YKpe6VxNMqatTWqHS
         4o0DHCKCyJh3ifxUMKbMWY0JsPmaFxRO5tv8FTmxc6h2fNk64sD81LnzCpnyE3ToilCB
         N8VakGOylWMogjWndjRXXDCVQojII+jWWHam2CvsEoponrEuK0pXmy9eNZdpiaECyL5l
         XDGpZe39g1jEj1SYbGZMWfH8dMCWOIjoShPbOz0xjYymbtZ+678cKNW3X/yVr9/cbJgd
         ZflUdROh5kzD+DH8DoFhgtDIHzMyZuP1R+64HBqoNtzHeOpYQn63eEQtx/sT+je/SBzW
         ub/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523154; x=1723127954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbzafF7avxRIPZ6txzx3Gb7FIT0SoBNd4I7j1z8J1D8=;
        b=o3pNWWGq10IakHaxq9GAnTVL1ApxyCCUsZ3Xyt5BoQPnOwdt/k7uW5YIOo4VMageoK
         aRlA5jJGwuegEGQv9E3T/XwaSXFlQInEC577Z3t6LPgtDepH9pkUJCeAPk5OYw/iBjD1
         T8CoGv90erDzH2afhn6k0juPbu9Lupuv6/CPefWuzmJ0EgDW2qN842vD+xugqZj9eiUy
         uOHnw4iW5+R0u9VJ0xWCrMQB512t5WXCj63pwdrHiB2W2H4qPwfMXHhzJ3MJJPtyGRsl
         wob3soPj+aUFCKvXddGtSc12WC4O0e5CmFbOr1abRx0abprVdpCRTH+UygtmkZ0tHzhf
         Uwdg==
X-Forwarded-Encrypted: i=1; AJvYcCU+x5ktYOkfuqQNjcDDwXU62pc9jFMbKZVirQZOluG86NqZmTTbBGjP3NFZ/gzixWHjgvQY5IQY+kZqNMbhByjq8VF3CfM5D+6aO6ji
X-Gm-Message-State: AOJu0YwQANI/fU3X7oQhU04Q6Y+7P84DfuBZaqQ38bcFBlkMl1sEnL5q
	ZN4Cl1/nPpGjpzIgUkzg9PS0+jNwHhx6VRB85804pQ5ln/4WGVY9MoYPagQb/u8=
X-Google-Smtp-Source: AGHT+IHWRUVRvZ/e+DpEcXnVHP7B0Zc01C9Y+D5lbzKWZ2xmcHp4uYpuct/oN2r1oVx0Lx3p5Jk6jQ==
X-Received: by 2002:a17:903:2345:b0:1fb:48c6:a2b0 with SMTP id d9443c01a7336-1ff5722de9fmr4436865ad.5.1722523154444;
        Thu, 01 Aug 2024 07:39:14 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7c7fc02sm139825765ad.31.2024.08.01.07.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:39:13 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 0/1] Added calibbias to perform offset correction
Date: Thu,  1 Aug 2024 20:08:56 +0530
Message-ID: <20240801143857.16438-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patch adds support for doing internal offset correction for the
proximity and gesture circuits. The correction value is written to
the respective POFFSET_x or GOFFSET_x register depending on which
direction we want to perform this calibration.
For the proximity channel we apply the offset to both the DL and UR
directions. And for the gesture channel we apply the offset to the
respective U, D, L, R direction.

Changes in v2:
- Used IIO_CHAN_INFO_CALIBBIAS instead of exposing custom sysfs attributes
- Used enum to choose between correct the offset registers
- Corrected the formatting and style errors
- Link to v1 : https://lore.kernel.org/linux-iio/20240707171357.709d9e35@jic23-huawei/

Regards,
Abhash

Abhash Jha (1):
  iio: light: apds9960: Add proximity and gesture offset calibration

 drivers/iio/light/apds9960.c | 69 +++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

-- 
2.43.0


