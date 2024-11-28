Return-Path: <linux-iio+bounces-12777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB329DB819
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 13:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8717280987
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228E1A0732;
	Thu, 28 Nov 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk1LxKSn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3C19EEB4;
	Thu, 28 Nov 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798711; cv=none; b=bP9UDjAf3MVrLkisCAsL/auxzB0BML1+QzdbDwLInGpMlKBGcmTyRAqDLEUDDF86mQlc0sXaDVl5o3N0JdZQ26cRppZ4BkFDpnJeScWih2Jij1zWJ5lmMdIN+ffxPMfBj5bbedNyYQJ0Z08RXOe8RhCl1kbooyEW/6RLvY6dnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798711; c=relaxed/simple;
	bh=MY/2TQcMto60yq+PjkjZ0gsljoNTmn1gxYU7NoDeZSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGoc1ei5FPGa8NBOPHOW+UpFQfsVe1nb17DmoqcHv3hHHd8IWwQNWxoxIzNSExVucEI0fOIsCc8RKn/b6123XJzcM8Rs4w3PHrpk7Mpg7JT9OGzUCCvBwRpUOTcV4ikpJuqQZhc2K1HOWqGv/1Vi+FLqNGIfcwERr2AZr+Aa/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk1LxKSn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349f160d62so7089215e9.2;
        Thu, 28 Nov 2024 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732798708; x=1733403508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MY/2TQcMto60yq+PjkjZ0gsljoNTmn1gxYU7NoDeZSY=;
        b=lk1LxKSntOMjiaFvcdYZj6OZecH0SeeAflOMOCz15XFkQUiksn5TBIN//DVpgoZ1vY
         zr3bzgRnW3RiH3Mbiv8MfL8PhCiGSfhw0mQH3MiOe7Qt0A/IU7DtEEqJXCSpzSqzmO/e
         bo8JCfHjWlrvVLFHCepFbwqyOjEcAexsXexmOPHqASsZy9ifBy1noQBdIoNt67bcOZ29
         hMhDTzW5+9mwWQJriClVSiyM7d4Yhz91Y+ZNnaaI4dcLJflOWHM0L9mQHz0ZEk+EhJqD
         p/g6GTsOFmf9RudTApVyvkeX/Ul5DLHMVRXQ6GIdy+A5RaR+eCWg/TiqIRduz209l/B0
         1DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798708; x=1733403508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MY/2TQcMto60yq+PjkjZ0gsljoNTmn1gxYU7NoDeZSY=;
        b=oRwbIs1cKHBuEmDEdaK48LhnEmAA9VMy08eMVAhGBsPxL4cHl8LMtxABo1mtRTXNb9
         ysmMkHBGuH0/h/iS7BHkrOIqUz17AajAQ48upWu8dza4rOkpXzmB0MSYeHmW3zDSbA0E
         t1FhL72ChNTFjLgswxB2wSNkYJ9m+iQ1fWQ9aHGlxom5EMMyxfgnr/oOT0j5qrqCVnb3
         jj1vq8HUn3gIyx1RL5SNjv1YK7elAmjUw5tE+Z/dOij3euZfsHpSdjWS5hfZL2aRNf0c
         ZGlc1uiNEjZuBggMkcXYLs8n5M0eI8Kb7IsINZMD3TuL7/TTBdcDD184cz/CrgS3Gme9
         pkOw==
X-Forwarded-Encrypted: i=1; AJvYcCUX8KJby27eAMlJ7MTYIhN8bhfd9wdJ7YVFj/ngR5hhHulZOwDltd/Hb0lODbCcnYMepk5tmlpwmwF9uXLS@vger.kernel.org, AJvYcCUklgjhtA4KsbosJq1cl84dNy+rKVv97TxAbngMBc/u2IIrvHYrwibSmmNvlDd4QMkIVd+uUNt6b2D5@vger.kernel.org, AJvYcCWdw4LjiKTE69gBPNlTv06H0Wp6xMVfrqnXMQy8SeS2BS1hMW4D+Hg/hNG4XwQbH5A3ooc3OqMOdlu8@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdRf65dDF1PWZ8ZNwpb0eLdNNa9au+qHM4tHv4AaMN+VCxsdN
	aqnEf2S4oYpXaB4qdO7Ddt1fj2uET6bSX4u5rM3MR68LQEbAjGhynTl+YCZ2
X-Gm-Gg: ASbGncsfjzjxmjWgyH3yS3NQhJKtVBwylCBJYNEKUTR0QCuFf6ZmY97OBirFVVPWR9f
	6IkzFv8BXqj6FWq0RKZT5wx7SEGo7lfOlAaodSdqUmc4BvwIx030W8dwohzzdHGD74x0bZnT+pq
	J1bvUlLsoQ4KfOsxHzjKh0TsHz4EgiKmVGNMrj43nUPU2CPs4Q7IsjlkwHZWYBFtW5Mj70j4n87
	XyM/oGuj+H4OdFZOUZab5Pzi3odHQlOjEf/KmLdZKftjOYl/Jjh
X-Google-Smtp-Source: AGHT+IHWEclVPxibF7H7TIsSO1/eCCP7RGrYvLR5lsbGNhs7Wmblxe5RXPDVB6HQMhxtDijahKJ5MQ==
X-Received: by 2002:a05:6000:402a:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-385c6eb8d45mr5943230f8f.9.1732798708100;
        Thu, 28 Nov 2024 04:58:28 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:3506:d600:5f69:ea1c:6c79:3753])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68d08sm1611853f8f.70.2024.11.28.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:58:27 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 0/3] iio: adc: ad7192: Add sync feature
Date: Thu, 28 Nov 2024 14:55:00 +0200
Message-ID: <20241128125811.11913-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Here is a little update for the ad7192 driver. I also added myself as
maintainer for the bindings.

Thank you for your attention!

Kind regards,
Alisa-Dariana Roman.


