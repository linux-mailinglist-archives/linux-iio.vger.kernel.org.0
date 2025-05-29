Return-Path: <linux-iio+bounces-20000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F320AAC7AD9
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414FE3BB80E
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238BD21C187;
	Thu, 29 May 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xMwwPT9R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09ED2FF
	for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510161; cv=none; b=Qydhe+ZEjsW2mtQxxTxCMoh2ORPRyJ196TIwjyLXXTsDoxeHpjXdRx2s5B4ffcxFncC6+GkEr+FhToXO9S5dxO03gonk8xzfZ2LFuwFRYwIOLWZwGhZSF7MVo7AXAyBuUCwI2NeTm9ct76Ak57SLPATphipKzwvqAzQZliA5v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510161; c=relaxed/simple;
	bh=dgQwzlZ78BgpNxIj5EI6KF5CPzlkbHaCeBBTWQKGv/M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLRCWxmUzDR2U8AIQc6AtLQy8N+bYpdKugmz+ilvSUqCztTOA7xy6eaDsKVn2Zh9lTojg3LVzEXFwBgs/JN6qN8vUXt6LaJZEz1vJ8ayBv193BFBwUSRZYWuTh6MD6LkVRI3/Y+H14T+08YsTIrJ4mDdGcHiMIyrEm8n1eAgxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xMwwPT9R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441c99459e9so4872875e9.3
        for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748510157; x=1749114957; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri4BKapRmsthsSzIIgwhod8a8EzAqSCrIVP+j9E6hD4=;
        b=xMwwPT9R9QelsDYEcjdDnBsV2+gZuw3WE8Tr/QSMsxSWrRBypvsABR0rhNXC8uCiXL
         rl6ziNmLSosXiiIl46kGUx4pLXtK+VPNLwBA96pt6q90JHZigZy8DwujbSO3vbJXLI6y
         JxA4LrQcNdcbmXZ/rGGAvk6uhwZvkUeiUyNexR7WhfDs5NBuni209c2IkMC/2GDGhDGW
         vJfVThmUIMnTuangLjNs/FqKY2rdAfbkQ154+op8LFQ6MbkDrzIGx9Rwfq5JHcKSLDFL
         Ng4zmoUxOMAxd+gdezPE3M1CpYNkwF240qscVpnrHjA/MlVOM6W6rYuCgRhrwWW58fgM
         KGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510157; x=1749114957;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri4BKapRmsthsSzIIgwhod8a8EzAqSCrIVP+j9E6hD4=;
        b=FrsKl1Ss7Qwvg1UBVNJI4WSH1XHkcP8axALURM6f+qn8jJb/qWRjpky7CE3f0MeceV
         EO34dgPTQPaHI3xbXnvAyYi9fNvzPlw0xT5PQcy461ri5J5WGiv6F7h1fWDrrJm55o1t
         TbRwZ+odoCIbMm0vBBBlj97ccPIXQVBlSe/nxydbfOOoiByFJUIeCDCYPC81LKeok7EE
         VToQ7/IuXdbqnTQl6S6AhoKKr5vzdXfH68x2ZTyloSOo4EWQyyD3OcNEokqJaIy4VOlb
         Ets3sIIc+DMev2CVp7woIPWzsNfLD7MC0mgE65lsNKYzBSJpcJlli/qN8+U+9Mui7/Gj
         aTbg==
X-Gm-Message-State: AOJu0YwxMsLJ26P9kDolcF2jU1Ei/OQcgiP/O1ZgcM+KowceoV+BCqmd
	X3pdPschS64UnLTsJEoJTHIHM5DtJDDgi8wj920rxXcp6G47gqiOUhLY3M5R8bYlnMg=
X-Gm-Gg: ASbGncsB8qOTQ1knUBsCTDclU2SP6WHACaRgQl7Y3iDZuEY0y69MYUt8OxpJBmKscR8
	nCKA8KALnJMkWxeaCNsMJZ1RVGnvG38AtIGQwhlPsRsJYx38r9fYkYRRSwDNMZ27p1JSbdvzmJr
	fadM7EBFx2vmHH5i0hxXm+OovlIE4N/VGVQcwm22adN3KY7IINJE+LwAf790upT21RHCeA9D3kY
	J5R6Uw6itBhlDCRC8WptBIWmM6d6fym18Q9bDm2/+f2Rcza1nXlG7NTFHgMSNHsR00hy2XElEvr
	OKHCeH9NVDjmYic2fS4IKFuZbmTR6M5ViIAFKPNsC+V37HkFbDeYauBu1T7H1EVzJzKCoLrFyhh
	5HgCxISl2nTKH37KmcFiHgd1aKQKFMtW6ErJek+to3g==
X-Google-Smtp-Source: AGHT+IEJjdD4jVw4IBSE2F10tS3OahqEngmAPlCUh+JCF/Lrsh11gYsYhNMqeg1R7hRVjK3TitRUug==
X-Received: by 2002:a05:600c:34d2:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-4507256216dmr43854925e9.19.1748510157028;
        Thu, 29 May 2025 02:15:57 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc348bdsm14318475e9.33.2025.05.29.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 02:15:56 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/2] iio: adc: ad7606: enable Vdrive and Vrefin power
 supply voltages
Date: Thu, 29 May 2025 11:13:53 +0200
Message-Id: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFElOGgC/x2NwQqDMBAFf0X23IW4NCn2V0oPMXnqgkRJigriv
 zd4HBhmTirIikLv5qSMTYsuqUL7aChMPo1gjZVJjFhjpeNdV+5n9vHljOOMARkpgLdl/vkRhcU
 Nz86Kia0Eqpm1Onrci8/3uv5EBNs2cgAAAA==
X-Change-ID: 20250529-wip-bl-ad7606-reference-voltages-26f49520d12c
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=595;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=dgQwzlZ78BgpNxIj5EI6KF5CPzlkbHaCeBBTWQKGv/M=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwUA2RYpptFNLRc25xvkLwRQ/73+wm6cd8lmW8SJl+T
 m/DyZZtHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACYSsJ6R4fiHFyfPcPnlaXr/
 8NmlUHH189aKdztb9HbMDT2TeaBSZTbD/0SN336yDou3TjBU6jFZVWISxsh2kLP3wZWFhtU7r/7
 VZQMA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Enable Vdrive and Vrefin power supply voltages. Related fdt properties
are already defined in ad7606 dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (2):
      iio: adc: ad7606: enable Vdrive power supply
      iio: adc: ad7606: add enabling of optional Vrefin voltage

 drivers/iio/adc/ad7606.c | 9 +++++++++
 1 file changed, 9 insertions(+)
---
base-commit: aa1b3efb8425b572d67df2f5d47ee4ed25571428
change-id: 20250529-wip-bl-ad7606-reference-voltages-26f49520d12c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


