Return-Path: <linux-iio+bounces-11661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5AC9B70C6
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 00:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE9D1C20D53
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 23:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA7217453;
	Wed, 30 Oct 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI0sOGER"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F701D04A6;
	Wed, 30 Oct 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332473; cv=none; b=idwKlPXmAPYRKRZX2B5Pg7Trwi4zlPFG7oXJGodhyHRHQtnIYvpwt+E/1h+XgeUd0SCygcoa3BBPVwF6dz5Shj4LitOxWyq+bV9QDhTCoBMgZtBR5Q5d3o76gUJRYJxAGvxW5vWzb5QFJTQHqAivKU82uu78tSzEiXXO7uxtI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332473; c=relaxed/simple;
	bh=g1KzvA+rkFS0pA2jioUE9VI1GRBOll68ZKVFZcCeeyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYBybAhm5O714eeDFAntQGxCWAp7jJwzHzPIvIy4eqgEJH0M4OsRfG7kdKS2PeGyjp/XLDziAdufFoP02a8Zyg84g7a2kJZ5ZmMWoun9SyWLyx4mHqrFK9fGB817OFJU8GSTNOuq4JdNA258XDFfHxCrk8ZvsCCdadeGI6zw32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI0sOGER; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d533b5412so271604f8f.2;
        Wed, 30 Oct 2024 16:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730332469; x=1730937269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCk1tZnGuYMayQVUmZb3vtIMuQd13ZnbsMoK5oKmxuQ=;
        b=UI0sOGERyVFg8DriWuzFcTQLOqwTPORINeSPiIvOwSBvM7G22ZP0i6vSI0dOEtVL2L
         dP2pjPF1oynn5MM/+m/frmDqIQWw1K6ixjurvkDT/8jlkJnSTGFi7+7HNcR7w1CRfn2z
         UBep635KcMyhpWI0BGMbnFvXK3ZHIz0V5hq+elgEbUu7XlpmY3kv5JyVrvU7WyCGBA9B
         wIKdrhQPF+t4BQmQPoEzovxQwD0kb4MjULHJBr5BAeqD6NoXqSbZAktVAcA/AyRMTICD
         TwEzddbZau9CFEGjWSMw3+85sIiduFZ6kGogJhSdVHJn5oJnEJ9bCcHL8xF9iOgEh+b5
         wORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730332469; x=1730937269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCk1tZnGuYMayQVUmZb3vtIMuQd13ZnbsMoK5oKmxuQ=;
        b=fn0LzmFsvjReoq5L0nbbA2w/ksI9dp9MOflvHySlcj5VKZIMnU3f9d5ygfgFztPJT+
         pAkqfmQtm5YaMgsERinDhjuW7N1q/qcsiTuT5/984DzfRfefAk2nT+Af1rqJdvK2Pc+H
         RETF2OdG0nx6Z/jbMpE7gvSDLsU2TaBWcl+PvtCQM578LGDEoYLL4d+pdCiCWb62hY3D
         uJp/bEWThFVZ3OUwaMtjRRyFAjDOXlqkLpIrWvGfZj1RGqs17wX0S02KxjV8f5AJdN/N
         M8VhW1QhCx1ubTjHi5Bo5mnglEL/2KiacgOG/GsQ45wVokRgVcfOBo6baku/AbEWSdm/
         ZQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWa5XEnBV3RjhJw5mBwrfyFk3bAKlUjiBx0QTNbQiSLT4oXLTtw0axGjoJP39IJ8IU7XdOEapMXaSHbK4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSYlw5vZCCgPl3E50wShVT6kyZjEemhK0UbT567pgqdDQ4ld+
	WiE9WCag5tLGvqTgr06UQFbMOTGLxSchoCOOOX0EZXxyB/zFmu+d
X-Google-Smtp-Source: AGHT+IFsNLD1rF+0sDkS2jT0ofYf+YKCxp1+27KQo4kavXWnFV4CIUCe2f4Jt6P+EXttsk6bewcQzg==
X-Received: by 2002:adf:b30d:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-380612008fdmr11283800f8f.39.1730332469111;
        Wed, 30 Oct 2024 16:54:29 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:81b2:9436:f9a7:d877])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e885sm362644f8f.89.2024.10.30.16.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 16:54:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: dan.carpenter@linaro.org,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 0/1] iio: chemical: bme680: resolve issue reported by
Date: Thu, 31 Oct 2024 00:54:23 +0100
Message-ID: <20241030235424.214935-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Dan [1], the previous approach was prone to endianness and
variable initialization issues because of the typecasting of a s32 to
s16 variable. Fix this, by using a local variable and not reusing the
local ones.

[1]: https://lore.kernel.org/linux-iio/13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain/

Vasileios Amoiridis (1):
  iio: chemical: bme680: use s16 variable for temp value to avoid
    casting

 drivers/iio/chemical/bme680_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0


