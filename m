Return-Path: <linux-iio+bounces-18582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6377A998C3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 21:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1021B85544
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75B2949E0;
	Wed, 23 Apr 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmcbrclN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A0293462;
	Wed, 23 Apr 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437295; cv=none; b=JuRHgsRv+2z8uwfu3mkidu+Nv4w9ExmXK62kkR3cIbWQfHi8N1nbyKYQwQTmrDLel3Crd86SGZgWdlOOT2AnFDvO2TXPxvEuESqrHw/6vZMmYyTlkbG29GSVVxkcBvm8vvFqhBXOihL7GjZtGy+u1UNPGaLhTPyxMli0PC6wOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437295; c=relaxed/simple;
	bh=scxHf4Kd2AC7+X5XHMdBIrmzzHAOMUtunjlcMSeOIsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH4/uTDXLTwne0K3obT/d2civitZ47wbA/Gjyp4zIAfj3std/DohpvCvPEseYPildny3t1GozkyDZEJfXy5mV+nRr/nz/5nQ09oKqY/UHgzSBA2KpA6+oW6lb/JFU54dej3wxF72qtc573ChMLcH18KbF8AQs1UZ+UmPF+tL9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmcbrclN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso144945b3a.2;
        Wed, 23 Apr 2025 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437292; x=1746042092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTIK98tab5rOndKkCc1l9dIPtMDYdx9Q4AKn3Dm0cyY=;
        b=GmcbrclNmqPVehGY95AG14AMa9NsWXQhXZbN/NOOETNImZMFPPmn9jgQ33PU88F03R
         h5jlHf60H9hobrFZIj77V0MD0ihcEFU7Z1hiakpjtJsIdQMoLFPJrnYEwiFtuwXLeciU
         o/o9vTy5RdTvVV80fduGHif1Xe5zkvTi3O/7UoV9r+9q1gTiROTbkqFll/vIgN01wf4G
         W75WBK/DoeYSjHd8IpIBdiYZAA+O8J9x8cLiaK9UYvjH7oxV1nQTO3hn9/1SbVljVF/8
         q7pKLkmBR8G++sEWKt4mGxKGJ8YkoGNAEn5gzdyOIl+YWv+9SksV0rkzCGIpaDjonnLT
         ddRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437292; x=1746042092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTIK98tab5rOndKkCc1l9dIPtMDYdx9Q4AKn3Dm0cyY=;
        b=BzZhFfRviKHbObJI6JqSYUDg/8TGwRVyli4Ab5rOEpsnSaVtRTIbBjqQQDk2YI9kF5
         8iBL7YFB3M6mKrCDFowdH1sbvjF6Z8O3TK8uK50N81zbo7EhtzZ/VFlbojHtpm9SF/aJ
         cjMHvzDlB8oWaHe9GdxjUUko5moKh3gFOcuZu62nMlx7nt5Z0Rk/8J9hQExG05XF/8g2
         uHrX9WQkN0xTUNpt3vKq9vMUkkpW9WOVt0x4Sia9wjJApq7CLjU2Sii1xqQVNwJwCHwl
         UoD2PAlCeDktbH3kDAwgKICf1HfWQ1IIlFyY1U435KvQ8H+WUb1USiNgIASSp3grkANU
         aUIA==
X-Forwarded-Encrypted: i=1; AJvYcCU8fFkoiinqiiuUlB7NVdzauBdhyOo5SJsvTAQidJIZtczdpqTHwIBGKsq1JhcNWOsFjfd6BPKhFLB6@vger.kernel.org, AJvYcCXBplsC8C5G+orylLU6YRckCsS+N3k1One2+FvO+rB6ImJ34kkJDkbSHmpXmjQbxcY6ZO5jPpxBqm26@vger.kernel.org
X-Gm-Message-State: AOJu0YzOA/Unx7N8jyKwsjcrs70irf16zuSgSk57Tss9A/lt7ejkuwUQ
	ZAB29/vbvFV81By3M2X5d1Xz297PuQeUbtSR62tzQ5BjfhDCip0A
X-Gm-Gg: ASbGncv7CAbAXFIWhMiqfMiPk9yGHkUTWk88IedSOcjwYDMLQqk0KOG+QMU8ZtfufM+
	KbA00hKwgw/oP1998wzkuTxcp5PUPHTrlgQy9b8ulkb92sVnyLCZ2Ee5hXz3qjCv0fz3GbUu4jM
	KS/jM3ocommHR8p2ouBzP1foh9Jt6o8R7PXvkJWUyw9+yVC+D3SPLyGdRTMhMPLW8aaOFxrW1xk
	JnzU0/62x1uENSVrwaAfSMlitqSKZFURuYJgeYY75ucieCsLkIZhWLz1VAL43oKch9blGaO4NSP
	30GuFXrKgXtS2v1SHOONZ4TJ3QSBHAt0B47M2GgGV398dDA=
X-Google-Smtp-Source: AGHT+IHf8Oo1UVjH2/cqJJLrrsK9/zGpDgiwV3mrQZdHqaspRRBLBswKPp6yDSRiRGj7w7wfrcFnAw==
X-Received: by 2002:a05:6a21:7108:b0:1ee:d06c:cddc with SMTP id adf61e73a8af0-203cbd207b4mr34869273637.30.1745437292349;
        Wed, 23 Apr 2025 12:41:32 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf6a2dbesm10938291b3a.0.2025.04.23.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:32 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add WINSEN MHZ19B
Date: Thu, 24 Apr 2025 04:41:00 +0900
Message-Id: <20250423194100.53934-5-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423194100.53934-1-gye976@gmail.com>
References: <20250423194100.53934-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add undersigned as a maintainer for the WINSEN MHZ19B.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01079a189c93..4a0089db6670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26015,6 +26015,12 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c

+WINSEN MHZ19B
+M:	Gyeyoung Baek <gye976@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
+F:	drivers/iio/chemical/mhz19b.c
+
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 L:	linux-watchdog@vger.kernel.org
 S:	Orphan
--
2.34.1


