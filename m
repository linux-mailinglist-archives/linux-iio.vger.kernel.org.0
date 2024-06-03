Return-Path: <linux-iio+bounces-5688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0268D871B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286A11F259E8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EBD136E28;
	Mon,  3 Jun 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/2Dbx2r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21A1369B6;
	Mon,  3 Jun 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431731; cv=none; b=TwFbyD2iq4zYapnfvDBzxSW+/bALIVzDB8VnMBXeucqZAK5Q64RfpmT9Qax9vqq0WvNgfUP9vMrgkWDgYjCs8rLJUNKrN0Zhi0srUN0b0NIPr+tZbaRMSdQH8OiJucN5MGENmSmSxwWZ6p4K/aqsvdAdxEkwC3OsTg8B7OHWky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431731; c=relaxed/simple;
	bh=uOq2wwonnoIeDNB7KiBwQekjKfF4+YXkhCCCFKocjco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeP61j/3NfL2CtqVXDSOuLpd/LSKjUUvjRHNosB+fmkjMfk76AT6XUBVsB+MRDttWFjiXZGqVNOB28fI+auWzmCuM3DSq7i5xWdUIx1QQAAMw7rDG+AALr46vO1hU49ETOIzt/lVftoV2t2B1VCxgzQXXiTceVqTptiZQp4CO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/2Dbx2r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so11758835e9.0;
        Mon, 03 Jun 2024 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431728; x=1718036528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSOZgXkLBqi0s9ZOhDPX0N704MA2FI+Bjhl7w2ceLr4=;
        b=b/2Dbx2r3/iVvFF0qj5YfbNFoS1NpwR42EEZwP+DiUcx/I9IWZGJTjy8TXdLNvoQKC
         eUf+0VR0aNyNcMj3kfJnm0i98E+5Vs1YpCnkujCOl2FhMJdYaJKS1vj9AJzqVxL7paX0
         599XtcLKfRUkb0YHndmnVx4sG7cDjgk05bBjgjpT4V9Lrr1lNXbn1/PMkgKDnggX66ug
         tG503/y2i179iAgcemio5fygEBy4hQDFnc8bGGxMxoBi3zGUtwuW8DN6yV9iYXZScvUR
         x95Jcrf0s7qWKBx4o61sPGzfse63BlkSdOe9DXPxL6hILeAwIoEVuQLvYa7bkchsBA8v
         nsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431728; x=1718036528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSOZgXkLBqi0s9ZOhDPX0N704MA2FI+Bjhl7w2ceLr4=;
        b=UuKWIjMn3zo1WVMoz5kvR1WLkcgIugRG4xjDzVE9osNG6CY0KimtuOoA4bIKQYpM5s
         7t0yQVZ+qsigwijLPdbR8M544hrLiE2rfgh3kVgFVNjXCESSxOgLlVtiEUyZAivfnxMM
         H8C99iFtpB4D7g+A1Ex4FLGh03cN3bsswlk3FL5HDtH3SWtriKMGzWHZCfkW8Bjorjoa
         HBmgK/6dU9kwG+3CNEBg4JNiZr4RxeDZ2CsitkKV67zjR6d4XlyIXegbjltMIkA4Gx9p
         a/CQXoSwca5eHz8Tdn1RK7jo5+I5t0Ezj2Lj3yqAnsiOkDCNtFKi3g+KpMUf2WCZV7E/
         eaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCln0R9rF3rZ0F9QjFRTukWQr07pY1Y4Mof20uwrZUH+sGhoSN0zusKRuO9TR6BEBePK9wSXQVknoisdqIMsl30BhrJNviE+Be4n1fX5V+OMmKAh4xgXqtJuiFcrwzBRV36nlgdJKlFmmobIrpmyZRR0vZ+xLx2CVq1B6Jk3brC/vSvg==
X-Gm-Message-State: AOJu0YxQWOo7gGzA1CS4DhKl88Fvs/dqCH60AznusqqMi8q+18dJDgxE
	4AMo0EEj7PgUV5YLwI10Vcxvr0w3U761YeMSagc4+4tMAjKYy7CA
X-Google-Smtp-Source: AGHT+IHDBDsQyCg+U04Kmw1qq41whiKeSWuC0v7x+wSh5auM2tMpRnk79D3vrZpGyc+eLk+6L7dD0Q==
X-Received: by 2002:a05:600c:4f8d:b0:41b:85bf:f3a8 with SMTP id 5b1f17b1804b1-42138622459mr41753775e9.35.1717431727974;
        Mon, 03 Jun 2024 09:22:07 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213cd1c075sm43697765e9.0.2024.06.03.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:22:07 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: ivan.orlov0322@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
Date: Mon,  3 Jun 2024 17:21:22 +0100
Message-ID: <20240603162122.165943-3-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603162122.165943-1-muditsharma.info@gmail.com>
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for ROHM BH1745 colour sensor driver.

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
---
v1->v2:
- No changes

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..945873321fef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19407,6 +19407,13 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
 
+ROHM BH1745 COLOUR SENSOR
+M:	Mudit Sharma <muditsharma.info@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
+F:	drivers/iio/light/bh1745.c
+
 ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.43.0


