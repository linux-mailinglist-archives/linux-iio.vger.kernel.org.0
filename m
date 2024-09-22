Return-Path: <linux-iio+bounces-9700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41997E25D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4D52810A7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6F7FC12;
	Sun, 22 Sep 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUnNI9LO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06535E56C;
	Sun, 22 Sep 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020994; cv=none; b=SFSANkn40rmB5TW+TidDRb0vrDDjm4hXN6mYp+Pqyh2W1KFrzb2VLH5aT+G5IH1kHGWgaC7s1R+6brfniPZjrem2EPf83EQpsAeE/PifveZs0kEI4aiQUU7RmdotOTiXKX4795WL2NkbXmb/hoFNfDB7KoXb5ht5QmRySvsDvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020994; c=relaxed/simple;
	bh=bLgmbJrlXzTC26BUBqVsPYui7JKXvnFDAfBU6H0YjMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkPSnrw51/UXnwcvmILuOanwZO4KL6PRpMYa3ukVfxtUicR1TswjJJeM88SNOizMudMcMeH06UywHAbry9gbrWiCtb6FZR5X5CzXx1zdOTZCKO4PNym9ovSlnznZOKSKUsXKtuiSRXOs/HMmfti/RmaIYkf3XwfN64rFVu1Hop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUnNI9LO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cc8782869so33618355e9.2;
        Sun, 22 Sep 2024 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727020991; x=1727625791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqI1jIpGB/9i7JhkSUUNvinxYMKn1Unc+ArdRcm+oEg=;
        b=HUnNI9LOUgkSUggYd2/DH0toPVixIqEcwIMQBIilVqMcljtVG/lCXRQU2a469ID+qS
         /oub5ykL+pv1nfGGJgG2K1gx+rw++/1ozEdIcLjViJITX4Bq38MnkPt31T2lCmMwcHxt
         5VtBElt43W3+JsK/bFQ7hb5hrSv9qzJmbcR05W5TLRxU/SHt+pPbn95UCDVtXHL7SITR
         9ht7na3Z7GomNSKMkZOyg8Qgbews+e4VquelQBP7Cb9X7RWdJhHompqDYHAsWxJVXE1V
         N2+dK9iAqr6+fn49mB+NZrGsZv0/pcoZBDjajhlL7YPkBTHX5Obs7TeKoBjvN8/ixHRx
         cj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727020991; x=1727625791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqI1jIpGB/9i7JhkSUUNvinxYMKn1Unc+ArdRcm+oEg=;
        b=owFd40M5wwZ2LqeihMzc5YA2Nr4gg750x8wMJoYO6cOF7CRlPEUWjNp0iPCiWG4UL8
         XxtppnBgcQPaufY/wMLqVqb3+UfjSSlpwu96BgbTbV/2C+zcjvamOAs6VJjtgUwOFtsZ
         aItsh5W5j5vmPo6QvP14YATsE9DMR6N21CV8e4UWB/2Uh0IBIvIQ9KxuxjFWk2YJyYDd
         glFW/qcySJTTthV+Fq+ODYrQC0SaoKdljW5pBxP41Z5YNuJa5BvMI6IL7Mzfi9Y4Kpwz
         e4fMVVxIIjF8+3MH8XNjUuOehbDoTNI/XO1kUJF54OIZio+hmb1c3gFurE+tNS8mWMsd
         WDoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxPB+DaSJUYrOfWfFfgIqz6OjrnzAZsUOZgeUlvTvc4u2adHwUpGrKjtmm5rHMcPyhVrzVu4WRc7Y1tLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOxBIK3uWW1s7JSIIn0Z6wlbFgNuo2EcgK5dirJLMLfFH94rHQ
	YK6Nw/Jv0ogU/SKw+oG9S0UjUx3jW0SIRKzmt7IiHzoE68kAz3Y0VK9altDh
X-Google-Smtp-Source: AGHT+IEraYJtq9v4iQDXgj20rWsJqR0ecJLGs78oANH8E/ApZG4VTsM+T6HLQnohxJUTZaTuGhDIZg==
X-Received: by 2002:a05:600c:5025:b0:42c:bd27:4be4 with SMTP id 5b1f17b1804b1-42e7abf43d0mr72045715e9.8.1727020991153;
        Sun, 22 Sep 2024 09:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:7367:3ea8:c47e:88f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm22310719f8f.49.2024.09.22.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:03:10 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 0/1] iio: Remove assignment to pf->timestamp by using elvis
Date: Sun, 22 Sep 2024 18:03:03 +0200
Message-Id: <20240922160304.520613-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking the value of the pf->timestamp and determining to assign
to it a new one or not, use the elvis operator to save some lines and
to simplify it.

Vasileios Amoiridis (1):
  iio: acpi-als: Use elvis operator to simplify if statement

 drivers/iio/light/acpi-als.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)


base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
-- 
2.25.1


