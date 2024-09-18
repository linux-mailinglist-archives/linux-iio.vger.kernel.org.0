Return-Path: <linux-iio+bounces-9633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D1F97BFCA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2782822CD
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12D1C9EA4;
	Wed, 18 Sep 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkZwDLs/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AA1C7B83;
	Wed, 18 Sep 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681417; cv=none; b=i/90sAX+OVeNhgVuUxhMqkuRnIz9SYkxBrpuZSTUiae43FV5Zz8U2UfdK4jyXcE5h9I3/Yi1yKltPof3n8zJLNi1vr2a/GbKC8LNN2MkYQgrCaD7P6EgGYZZVDZq7FfJx6Mi0t3VrfqnxzFcEbuFUTlE9XCxhTTNdux9Y97Y5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681417; c=relaxed/simple;
	bh=HZWIUGqAdp5opNvUgcJZvRCFDfEnKj8ueoB3pKFPLrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBavdWrVtcz2hbA1/y8eV9lPqmBSoViw82L7Lt4b684EiVFTn/FO2VFnXQk4dNtpQFKgszfHlKo5Fv2/00Xa6+bywTn/68PGx0wDxBc3F3IiTEZqkjVGl92IZO+Ah4jVYupg8iP67mJ6GACLO77mUnYU7w9QP0mYgaLs2L73it4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkZwDLs/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so5249484a12.3;
        Wed, 18 Sep 2024 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726681415; x=1727286215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NewsmfFD9SNzAw5qXDFX6JZyu6pAwHI8ruQIxxu5ZnI=;
        b=gkZwDLs/Q4ChCxzZ0UDOrWWMy0sfVIZqHXRys33oJIVTw1O01quSRzC/hNC4rb+bzT
         0LvH1roHZL/7ZuFhXI/HmLhmGK0bukgF39BL+a8M/4193EwtP5iBXXgZ1A5j+GpfLab7
         49Fh/mb/1u7gGyQp9a6a5sejC5XXnNnmEhrhkeQibaLR2Q3TxzP0O3wR5uNbWQe96qFI
         aMmG2K609l7wmMmRyvmeGOzULjsxo6V/ZgzbjaP/VNkpPM1p03P5ZnQEy9I675932gXA
         wdsJCHrcxfSUY0+0BGt6u8xjaTT3uCr/go9L84ssUobKk0hpH5SZC9BG8H7HdF1jwfDO
         xDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726681415; x=1727286215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NewsmfFD9SNzAw5qXDFX6JZyu6pAwHI8ruQIxxu5ZnI=;
        b=ZsOFESz0BABZpAV36Cp6Y+bcver85MeYO2AGqCW+Zom2WZOuKC04hWI93Uyt+f0wem
         wHuzaZHBVWIpnsBbuGOzG7VjDnZLosQ340wFXQp1pcTD1jrvfB+ZemHwM6vwjc6ka9vK
         CYQ77S/meumx9Iq1TdYdHQXkbWt2JO2oHcERsuHu1b2qTkam2ZGuIC+3auFtmFPJcKOz
         Ei8i/2GbOvdhteCWJdu+2sMSDk+6uC5GwnTqkk7MCx4cpEd92f/xoN8gATDa8Wserexo
         Dv+3Acl9wKEc95YNVqVVXVTdSzctv/btVWlXOW0J0+8EGP6G5CoVjump2poYUol8hyrp
         626w==
X-Forwarded-Encrypted: i=1; AJvYcCU6EJmjjRm31Mtd6boaZA7d8jPsdzjFku52EYKpjcKqM+TBhKHw921lLNKPkE/tZDXKgKCHQufOKz6cC2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCoGlq8vARL6TmMgiOCYkcuRazFufTiSs6Ky67ZRpkzr1KnG0
	vLWSBl6lIfGyaIKyTNA9KNmhvF9YGhwqVrR9v3oYoAsQ0OWXITMi+lul4VY/ZIo=
X-Google-Smtp-Source: AGHT+IECRx7460qtzCoGfGmJhASYc+z4HYaeEbdspR9sv/W2BaLtyUS1Y5CgEfGw8H9Agg+4qLz95g==
X-Received: by 2002:a05:6a21:3a85:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1cf764ae838mr36572984637.45.1726681414691;
        Wed, 18 Sep 2024 10:43:34 -0700 (PDT)
Received: from Hridesh-ArchLinux.domain.name ([59.92.195.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4fc846a4sm6286178a12.39.2024.09.18.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:43:34 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: iio: Fix alignment warning
Date: Wed, 18 Sep 2024 23:13:19 +0530
Message-ID: <20240918174320.614642-1-hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 4ae1a7039418..d5544fc2fe98 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -628,9 +628,9 @@ static void ad5933_work(struct work_struct *work)
 		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
 					       iio_get_masklength(indio_dev));
 		ret = ad5933_i2c_read(st->client,
-				test_bit(1, indio_dev->active_scan_mask) ?
-				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
-				scan_count * 2, (u8 *)buf);
+				      test_bit(1, indio_dev->active_scan_mask) ?
+				      AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
+				      scan_count * 2, (u8 *)buf);
 		if (ret)
 			return;
 
-- 
2.46.0


