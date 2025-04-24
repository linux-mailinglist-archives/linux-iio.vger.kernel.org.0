Return-Path: <linux-iio+bounces-18606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B9BA9BACF
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0247B3EC5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A810428936F;
	Thu, 24 Apr 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLarzZBI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D121FF3F;
	Thu, 24 Apr 2025 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534086; cv=none; b=IyuUjh9zO9+S5DqFzO0H5qOYLdBFZuJtDQsHjWbSOFEPujrvmiMztK2CCJsuVPU96L0dT7WEu7r97pHWlF8wiKjRGDIldF71AyiNlUALziKEFfu9EK4mEU7PWea5UwPKP4sc6JBEyZKZqK9hz9KwTrRVsMaiEIbBlxu/roCwwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534086; c=relaxed/simple;
	bh=VWh4kPPKdkOQVzxNTI4Rpz+DpHzxe+cGoaqxuamFDo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGeAL2qkld7zPjjsRIzzAMKGiJ1rnh6i503JdqLHg77h48pHGlJdaO26ljvfGqJ5jK/abx+o6JHfAyCCEDEpOlhG2qTmBW0ZbRX73qUeTJSWshI9sHuTrK1n6BC4HBf09zQ/8HbPmlwM3g+6FlOS03W3MomJ27OjFsqVH7bWyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLarzZBI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5675dec99so174748485a.0;
        Thu, 24 Apr 2025 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745534083; x=1746138883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSe1JtB1eGCQWd41wt0spQWbOOvTZzsVz6y1xhAjnKM=;
        b=XLarzZBIcIoIITz2Qt6pS2bGjs2g3HZCpfebX6ebJbbAPRs3+k5kj5LHVY8EkT9Kpj
         Jo3GRuBmjSuofvs7KPBI66RPq+ljF9RAgOrnhjchgete/1iot5mha8if6sxd3ePiS6J1
         gdIGv+ltzShyscCwYewzGXKcY7W8owjjv02SeQl7OHOsMIE3DZHMJJGE5Fag6vHHmT2l
         QJcadrhPMivBVCBdOY2mAh48EObBVJCMf9NCTaL3PL1Ew+hP8iP9L7/B87d+tQ6X4SGj
         lfk9HtBjObuyY/CMRQGpDH6Co1MMu9W3sUC/zco99rkKpc7zTmrMhA6VoQAz9SncFd3K
         TcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745534083; x=1746138883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSe1JtB1eGCQWd41wt0spQWbOOvTZzsVz6y1xhAjnKM=;
        b=AqFFrTsrTSNnCg/YYrJ+jtSgl7t1Mk5lWGADhgsCDTHi5MYx9nYNHrlJtbGUf7HRVw
         kYCz6xp34lM5SIpJxVKT1GqTsVBXE2s+OBmpLZJBpXVjkLB9Z36qu80JH5M/9lB8pLjT
         7zn2lYFQNb8eAqB0OXs1gcLYCPdIncuoOyb+WZeYi6qZiVH2FElmyMJfKEY68l2DgFd7
         S6Ka1ECCRdvlIf05FanJXLH4toCZhxt/WePTmSc+Zxzbic3R59fCM6Fwb1vdO3feyZyL
         BUQWd6ejQaSG5BlwWQbGSFJdR/EGhMTSs+SQnhJ5jZDjRaluMe1+UbzvFrANAfQ3f2si
         McWA==
X-Forwarded-Encrypted: i=1; AJvYcCVvHWJpoVsSf6trZoFzNtT84FzB+dgjKjI32D9xZAQJmZ3JbFG0JBdANBO0bYzazUJvgfFinj+BYRM=@vger.kernel.org, AJvYcCXnt5Hv+Qg2QcNz1MeQybQhao7yvGt5Dnoawo+OGg3SAB9khzrzBUmWTzbV7XAFlJx9N+3v7gnYFFUtSjco@vger.kernel.org
X-Gm-Message-State: AOJu0YwLj9Gw2DUNyg0jBMqzWRYue49KOVCQDikmAz45uLd2UaEhJawY
	WPh9Ktk8+ZQIZfJNrBa9Z+ntwp0fTHN4RxdXW0iaXaKS0eZWfXkz
X-Gm-Gg: ASbGncvNJzrVcoyYqm7K9jIt35RERBXJdMLZste3WNWZZrh60K0nTAvuwbmJFz7G4yq
	fFVjtJ7kmsnp7rbgxSV19XFQolyK6hGs+MHbhwa0LeTcTCpyUsnFK56E7OabbEUHtsIKqXT6CuR
	2oaV05+jhvHD4UxP8VBlsSZ+jJ7IBs69Rv+PN2/QXNLvSZiOismLlpZEYktlYr+oiqBEjSWRzOw
	WD+g6zzHWbYannnroyEtDgVISlThLTrIox5ERkKiR/YzFZZHaawttI5SahA12Cx+TIHyUybL4xi
	IqxiCaMCcREiQdhWsNc8AiWx+dgDkiAtUFWXv9sdykLBrog42SzdQJxmIOR1pvz1VA7+UC5EdnN
	dtm1AB1rfEzqg8Vy5QCY9WGukCFk8ow==
X-Google-Smtp-Source: AGHT+IF/3gNk72gTyd1veyOt2Ztb8OnlYKh/uOSphzG7MTtHCdbh3Yc9ARSZj/f8onW2cfcKVNzFEQ==
X-Received: by 2002:a05:620a:298e:b0:7c5:3da2:fc75 with SMTP id af79cd13be357-7c9607135b7mr42472985a.24.1745534082912;
        Thu, 24 Apr 2025 15:34:42 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea36eesm142986885a.111.2025.04.24.15.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:34:42 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: andy@kernel.org,
	dlechner@baylibre.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 0/2] staging: iio: frequency: ad9832: Fix and
Date: Thu, 24 Apr 2025 18:32:07 -0400
Message-ID: <20250424223210.91317-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 includes the initial fix.

Patch 2 refactors the code to use the out_altvoltage_powerdown ABI via
an extended attribute.

Gabriel Shahrouzi (2):
  iio: frequency: Use SLEEP bit instead of RESET to disable output
  staging: iio: ad9832: Refactor powerdown control

 drivers/staging/iio/frequency/ad9832.c | 69 +++++++++++++++++++-------
 1 file changed, 51 insertions(+), 18 deletions(-)

-- 
2.43.0


