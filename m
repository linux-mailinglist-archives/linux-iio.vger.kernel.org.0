Return-Path: <linux-iio+bounces-14933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D7A25F7D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659187A2786
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B720ADD7;
	Mon,  3 Feb 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjlS5vL1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96020A5F2;
	Mon,  3 Feb 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598762; cv=none; b=kE/PgpeRhXbMyidgHWcVutSRMuwV+p16a0ToLcatOGF79r99InVFDY9ZEscDLLDDIU+QZsOu1G2P7YoVEVbkiGwp0KTqaXkrCtCE7ESUBPmcY07jobyNHsI5Tnqa5FKZRajxtlJayIjvqSvsPa45FN7v0qpuJGzfQHzF4AQNYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598762; c=relaxed/simple;
	bh=WF3iTpTaDpemLGXBFGUlmr3VNu1X3//xIGFLNaCWevs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J0w/vzc/wFpFCAsdqFa+UrphtxvNokT1zwCYMFRA12uIpq/KP9drIVL4IUhM8FplagCb/z7OoAwVH4y23rXGXhPqyxQkNA6rVMwuolEk5wYwlpenHPr56vz5YxPzPbgrlUsal5bptZyH1cbQWWxrwbYb8gB9GiaMnuBYkYeVOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjlS5vL1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so7916329a91.1;
        Mon, 03 Feb 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738598760; x=1739203560; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ig/wadxR03TolZsEmoz1h9uCBqHgHNfI3FvNUfDw7A4=;
        b=TjlS5vL1L3Zrug3Eh9l500ddmTE9J643sVP/YbV2/m445cpcJriGs+aZIPk2oLXDGt
         5594Ts69clV62AIQsXQBEXKHvH78dE7SjIB3rv6shiHF13DRKLJaRWA23dtmTHH4X/Ey
         frhuY37BuCGZjMwK8zxfzuFD5u4/UzDTFJYtR9jJxnlx/XWjl7n/WJLP67O5P7gR/OqK
         NGNFfUlGql+i9bR0P3MXh1C28rFuWUgyDq3nSUbsiv9j5cSEKtsCp8pgT2k/29Q9DuSs
         PI8E2bMIIMCvsG9zU8s2A/u1sPoHF/s97mPvttZ9HQksY1jo2sMuMqebgYP4v2f7JoTk
         tQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738598760; x=1739203560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ig/wadxR03TolZsEmoz1h9uCBqHgHNfI3FvNUfDw7A4=;
        b=PrwYvUyjc2N4XhXPoWGuSs9aopdY/K9qSYqb/QB7kX0+wDkrufV4VivBOeuMRLFjIX
         O1NGRlGJS0NtSby8GFt8PzchIYq3zlN6LDqgqxIw8uqKklBNjOHsVon9WPDTXY2j9J5J
         MWqpmLSaVe73eQfa+rNuFvq+nrDZTQp9J0LNbPP1pP6HzlzVnghhtvTc1N9j9D7sk4hP
         +rBySmycYS+Ews4JorrYoto67zWIWBW2xzpRMbl7CSrm2XsuXzR39c+F/2nkYfg7oobM
         9aCBZjQ9FYQMUmdAOZlWN+ZcSVa2qizu3n5iG+1DJTasWKdQuC5iKdvPj92riYAjMax4
         WNCg==
X-Forwarded-Encrypted: i=1; AJvYcCW5kKXM/I9POsG/a+aB22okgXVDQF5eoERNOl28o9h6vk6tjQbcgZPZXR2eag1+zdSFqOKLfSzHbBfPiX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKDuFjx2lURZXMBxeRsYYeUtsxF1ZHmsVT9XBmuHDKaCjuer5
	D4KjjWLLz7cOu56tWtBIJFMkybCux5GbVxnJp1U+ueoC1RdBjymPTiPzZnrw8iQ=
X-Gm-Gg: ASbGncsAWbtihmKUc3g12TD9JC3IrqzgGDgZBGfj9Zyv7Y6H76fy9yDUcNkDQrFNJw5
	vuX0sgwNfLp1hs6Lgt57q4FlTIKa5SrOhGXyWZpqT0trNRWBFID3Be+RzJ4GQvCeCuQkeqjDyRw
	KdvmDt6Jo8baBsTOBgYhAe4X3KOFyM+rb9zg13Q0ZLyUCa7Vgc4NbJ0HFFeFDPu2e6IkdY5cc1d
	3aD6HesZQjdl8mxKlwbzHLLIThXfeUqGPHsuP4le1KKc6gEJfIXxh6KyI824ksqrukgEqZliWTc
	yvXLTyWDiqepsg==
X-Google-Smtp-Source: AGHT+IFuDsJ0WA8LxSnhDCRc21v3vfqkG0OHp+h4ubDAQsMhCq4oJjXSaP1St8X0eHEZxlJ/30tBgQ==
X-Received: by 2002:a17:90b:53c7:b0:2ee:7870:8835 with SMTP id 98e67ed59e1d1-2f83ac83791mr38446474a91.33.1738598759816;
        Mon, 03 Feb 2025 08:05:59 -0800 (PST)
Received: from Emma ([2401:4900:1c97:4d02:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd0a2e1sm12698835a91.26.2025.02.03.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:05:59 -0800 (PST)
Date: Mon, 3 Feb 2025 16:05:56 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH v2] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Message-ID: <Z6DpZDJPDtiDzxDU@Emma>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The array contains only 5 elements, but the index calculated by
veml6075_read_int_time_index can range from 0 to 7,
which could lead to out-of-bounds access. The check prevents this issue.

Coverity Issue
CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
elements at element index 7 (byte offset 31) using
index int_index (which evaluates to 7)

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/iio/light/veml6075.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 05d4c0e9015d..21de193ca09d 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -210,8 +210,8 @@ static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)
 
 	guard(mutex)(&data->lock);
 	int_index = veml6075_read_int_time_index(data);
-	if (int_index < 0)
-		return int_index;
+	if (int_index < 0 || int_index >= ARRAY_SIZE(veml6075_it_ms))
+		return -EINVAL;
 
 	*val = veml6075_it_ms[int_index];
 
-- 
2.43.0


