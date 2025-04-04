Return-Path: <linux-iio+bounces-17608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DEA7B777
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 07:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496903A6EBF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 05:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41726146588;
	Fri,  4 Apr 2025 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViWQgd7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A933FD
	for <linux-iio@vger.kernel.org>; Fri,  4 Apr 2025 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745708; cv=none; b=jTYtGuzt0DWZ5B7tbMKRl6XUOam6ydo2e2e9Y/p+WdNEPbqn5Q4KSs/JPHC1jBUO4KBtrJ1OUJAP/9tHewKXclTcualrqtNHa9ZgmYpHd3T5Ew/WLnElRxIjUdjO/wsgCRxfrniUUwIA2RgO32xpLlgSbWATxKeNzwiXEcRy084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745708; c=relaxed/simple;
	bh=gEfbIOS49tvFyxXADsU8TbJC2xaKAb57QQ5hctMwjVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYzFZafP9RmqobDWWi3tVO5d0fOBFo9poGVuuGZNobhsUtf/gawdRDgTjmfwiMjx2Ut13bRV8imJjLuS6HcwGAXSFc3AWYPWum2BvRe5Tc25rZ6N1uQyIQOEKqMU4nhldCFqrUP29CGyLfL33FBjdq99NHr2supCBe8gjt2f/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViWQgd7a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22622ddcc35so22172015ad.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Apr 2025 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743745706; x=1744350506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTcWaO6eBYlej6qUM/WPyXXrSN9pkFHtRACE5MUPFd8=;
        b=ViWQgd7aoc5pAUALYQjDkgbGHJ01I3kqGJRV58Sfc3VANXTIKtEEGEszPrTylnLDOl
         Be+y0cWgLlxwx1mEgWObqXU1KexjOAKNtDHYcLTVve7O43D7upEfSVdwy0ZT+RPyjF/l
         KCVk7yo/Tt+R97gEnwODYHYmpy0PE1cDKxwpNkYfS+6plI9LTNetKA69dlB3Ymj0Tfjo
         rgroFxiuIFjbpHxYTA8vr9OxpzYSk4FVT2PrSVrf2Pb+Aaiqv5MDsU2W/gH/Aw4kMEUa
         YInrWCc9mvykwCR0D2xCm0ZkQtkj8m0UfP0c3KiOzh4wBKgUtsvMwVcycmXqZF1Xt4xR
         YxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743745706; x=1744350506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTcWaO6eBYlej6qUM/WPyXXrSN9pkFHtRACE5MUPFd8=;
        b=u8hTsLA6n9TKL5KFUH3ZOhoK9eur9h2jVb7YrZ2DV1Ph+h8NL/sOpxMIQuDiXWQmw0
         5nukngf6+eBSiKkpUe5yqDc/KYG+SKeBtNdMRmrcVNvIcLLdzs62z5RHD5HDMBeM0Jc0
         4JuTm9AaI6qADrXpoDcNjDZTTyOavdUSHox7BhH+3lFxdsz/ScL9hW+Tq+SSYityMCBq
         69qSsZDj1qxpOZnWCun7cEp97Of0EPwmuz5dDhHqgD3RrmMpOiiC5MXRcY5tRNeX0yxZ
         lqWTFNlXwj06+ppZAslDJO+ZrPwUhVgn4AQgawPlMAPiuZ5HsbB54Usk7Mf+kM0HhnCK
         seKA==
X-Gm-Message-State: AOJu0Yzt/x5cbsFt5dnI7Iv+mz4gdIz9unBI53rCGcSkpiXYXCN6VFq9
	58hYDbcw/4t1shosuQDWQwRDLRbCx1RSOzUlUIuwO8iMCZPGNWze
X-Gm-Gg: ASbGncuqxolkPM1ocVsUWATFCq59KXJs3jH50b2mBbI1h6xighu3qH2H/YVYcHAveeR
	cgoZpQkH6U9HhoY1eEevHMPzAfcyetc/J/aDiR/7+fq+trJo6LGt5dKnW8072nwgleajPEA2/i4
	Z7GiPds9KQsbVNi0ur8hLYxNj7QwKtJvMFWtbd2BhnlTHXEx+FJ0GO3JYi1iJiBO/chxsCfI8bA
	wskK2fEhHQDIkl84+1JRSaQjkMB9uYuNpSsKugY/WZEhjyjxY3O2T3copojFYsNgVIDetA8/d0d
	gJwlP/loQ6+VXwydTOPlS445tWhsB6IpsvEwEUAlBbMmGsFd8LGPnt1NWTLQ
X-Google-Smtp-Source: AGHT+IErFLeISeZtf0yqmu+b+A0mYBQdMGfySycVblx2pto437BzbWuKDneliOgRC0Kl9s/5VEHK9A==
X-Received: by 2002:a17:902:ecd1:b0:224:a79:5fe9 with SMTP id d9443c01a7336-22a8a07cb49mr17593035ad.30.1743745705476;
        Thu, 03 Apr 2025 22:48:25 -0700 (PDT)
Received: from localhost.localdomain ([172.96.160.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7c82sm2596670b3a.178.2025.04.03.22.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:48:25 -0700 (PDT)
From: Yuanfang Zhao <yf768672249@gmail.com>
To: marcelo.schmitt@analog.com,
	dragos.bogdan@analog.com,
	alexandru.Ardelean@analog.com
Cc: linux-iio@vger.kernel.org
Subject: [GSoC 2025] IIO ADE9113 Proposal
Date: Fri,  4 Apr 2025 13:39:48 +0800
Message-ID: <20250404053946.514132-5-yf768672249@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

My name is Yuanfang Zhao, and I am a computer science student
interested in contributing to the IIO subsystem of the Linux kernel.
I am excited to apply for GSoC 2025 and would appreciate any feedback
on my proposal:
https://docs.google.com/document/d/1uSaM5B9ubh4ccHz7EghQBBEcsIZSUSCRgu6PTIncj94.
My goal is to contribute to IIO continuously over the long term and
look forward to learning from the community.
It would be really great if anyone could comment on it.
Sorry for the last minute submission, 

Thanks in advance,

Yuanfang Zhao

