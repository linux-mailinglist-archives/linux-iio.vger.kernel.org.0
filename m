Return-Path: <linux-iio+bounces-10454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0C99A306
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 13:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B669BB232DC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D08A216A11;
	Fri, 11 Oct 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNuOc83n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450920ADD3;
	Fri, 11 Oct 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647684; cv=none; b=vGXseV2mCkswmRdWhzemNCk6OnACdnhlrC8l+I9Dy236Muxss/y8m1kx05HNVMktIjR4ndwi5CYV6dklt4AMsSUa0KEKcvvFoFyEyat226M9vwDivWpQfc15Z2KSINXPEHErSTbgEuLYbZ2oJF8CfbDdYiXMxlpp3Sn9QxIOa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647684; c=relaxed/simple;
	bh=BH4DbbmMQUbDmGpkllQVRVVJhPfwORuNLGg9TXD6Tiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgPsfWg30Nf4Ka6pgcOkIdKkKjLaDUX/UJUDZzWYZhXbxiXwQ/7TrVQVacGLm7Izd28fayrj4Le9lr7/cyGKNWKXarBvXExljW1VTTesTBkZ1XrC6HOQrbHMIPNJUYWVTAquaFccRWU8S5l6PFGQXQvY81alEfh0kqocxmaAgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNuOc83n; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c767a9c50so16591935ad.1;
        Fri, 11 Oct 2024 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728647682; x=1729252482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0M9rAFbcV+izFFMOP8m5z+SO85I3Ch0rIJacPyB8ek=;
        b=DNuOc83nCI3Rxq7BamMp5N1ixePQMB2MrOF4m9u9pc2oemqzz8zAp/qhoDNhYSTCll
         lGnzGpAdPW8+/CBWhzEM8LqazSEp0YwdsSKtucWkPsbfIWVlfgUPJI8FeJ//MgzlOtHL
         HDfTwtuSlHKgn4uSJZHLwmnLJH3ZKxEvxfvULbHGWeAQNdWAcsWt9T7x+Nz+inNq/8cR
         E5NSjITT2zEpAy6+t6Zsc3JTKktm4LqSY7pIEVGeFIBBhrM92HMoE93zi6STeSpM4yBH
         jMXsFbLJXkV07r3zz7gAnJRWB+zVpDHhcdhTzXeenmwS0036BqfAT77IFSsvEjxK0UPO
         RMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647682; x=1729252482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0M9rAFbcV+izFFMOP8m5z+SO85I3Ch0rIJacPyB8ek=;
        b=NIfYvKjSYp1rROxFHlDrnOifqyKh2TYc2h1cvdTdKypf/DcKu+SqoLV1Sl5QVycOIT
         HoV+UQPV546dAc2s/cjqSMumuy+J24W97a7vKipwHZOdTJsPbD0sISucHskSCuibJ4bc
         wOVQGcEFbLDc/sHwA8dfGtZAuvvvUmuwsPS9wai0SNiKFvvMQPB4cb4NNn3kHtQam1rz
         DuTvNKuN13QvX/W8COkzV/UoIuyQu8WXH7+CoHn1iSkoxRygEbe+S6Y/nz9a69SiD4H/
         SksRarsyQKj1Ehv7FiRqe2KWR6w4ABzf9yquI5RKRhv8wwFjMBoJniAVLLmM8KZCLbW4
         5slg==
X-Forwarded-Encrypted: i=1; AJvYcCWRByVI1BkUj2z0KGJK7gmRkhC4oe6wTB0nWLtxJGXG+dmXDKvjGubwOmmwsVWi0IV2azl+8N04T9c=@vger.kernel.org, AJvYcCX/wg7ZDCDyEs4p6cIIzmobOuDw3zplBn0GtV+Jd0sT5bZ4OpZ4hoGzS3dHtqtHG1eyV8yT/4vyaxrtBJWv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxv2SjtTU3Xflgpe3K+RVb66parTPITJlt22Vyz6vqV4JjpbIo
	/zwoAWyTY1FEeEPYlObkIuIgHlVDR+Fw+WbFTyTN7CFrwAD10cQzgURXreFW
X-Google-Smtp-Source: AGHT+IFWWVOZXb6Mget6b+bWzMDShsv+T0KKOi2cgOJQlaJd94yNCHHf+KVc/uLTiV9ebyDumvxcIQ==
X-Received: by 2002:a17:903:191:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-20ca1458e3amr31858825ad.14.1728647681927;
        Fri, 11 Oct 2024 04:54:41 -0700 (PDT)
Received: from ernestox.. (2001-b400-e2af-f494-1c09-712f-68dc-c3fd.emome-ip6.hinet.net. [2001:b400:e2af:f494:1c09:712f:68dc:c3fd])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c8bad32a0sm22298575ad.11.2024.10.11.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:54:41 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Adam Rizkalla <ajarizzo@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] iio: Fix uninitialized variable
Date: Fri, 11 Oct 2024 19:52:24 +0800
Message-ID: <20241011115334.367736-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011093752.30685-1-0xff07@gmail.com>
References: <20241011093752.30685-1-0xff07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang found that the "offset" in bmp580_trigger_handler doesn't get
initialized before access. Add proper initialization to this variable.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
Change in v2:
- Make value initialization immediate before its first use.
- Link to v1: https://lore.kernel.org/all/20241011093752.30685-1-0xff07@gmail.com/

---
 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f4df222ed0c3..682329f81886 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2222,6 +2222,8 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
+	offset = 0;
+
 	/* Pressure calculations */
 	memcpy(&data->sensor_data[offset], &data->buf[3], 3);
 
-- 
2.43.0


