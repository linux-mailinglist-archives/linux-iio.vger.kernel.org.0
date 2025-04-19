Return-Path: <linux-iio+bounces-18322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1BA9439E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C7A1894F03
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287D1D86E6;
	Sat, 19 Apr 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKCxz706"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C519E975;
	Sat, 19 Apr 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071003; cv=none; b=u5stVYCNRNMmPloo8ppb/B8ZXVNVNqbBOsYDtITLRfLf777V1ETItovXRcIlo7DgLk+EOvkmxogGIC4F675Ya8nxEhQ6xJNb0m7ajPYVrmb3cAf0mS6R+OJBKzaH2AuC+g6KumzF8gfbbzn3b46D2EWqI4DRI4lVbGA+6FWhTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071003; c=relaxed/simple;
	bh=32CJ5lqsP6SeFL28byG1FmT/OVtQTHdseuVPntwIxgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaCUAziUo/b7GXdfWEy9ddCgfVTApoCDQIF31m8hn5tZMwKBU/hmsSARVl2uuIoLV/cqtYX9s7E+uvObm1m/WK8X97SIKFVmsK/I9IROWEdSe0/gjGwj9gCsMiHt7lhG5XS7ssibhzSy7RxcoaHDwtd/Buvi4gxZkEIjPxpvvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKCxz706; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so38875436d6.1;
        Sat, 19 Apr 2025 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745071000; x=1745675800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1T9iPTvrhyH2WPe+v9UKop2Oe53Fi14F7QzLPmeRS8c=;
        b=iKCxz706tNORfoRwA8lMqJixxe/rs7TJGjZwvPZ1PnFvR7gTCjZ+lheosxr8r7cnyN
         1Pb5RhnULaVWnaBGVO8sTP5qofhhlt8hN1kQvoigzt7zIs9i1FGOunom40PATCZHCLhz
         4iwwGtMuzaAVZ1smXAZ4RZ6qHbWXhAuZ6KhY6NjIXlYSyQYox9yg9DtSyp5Ck0Ne6btE
         DfpVw1ue4jzswZRsuRmY7gG7JQVn7gTdf2yrPMl5QJPVGEC0n/Gg8nA4M+Muw7HzE47A
         +/u5Ni/Rlso0oBgdIdZRu6nakQpBqIxmaiX+HqSRSV7GQM70cYevjQC2+EcbULXQl/WC
         rABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745071000; x=1745675800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1T9iPTvrhyH2WPe+v9UKop2Oe53Fi14F7QzLPmeRS8c=;
        b=antt/edY6tZWEmt6FiL8+PB/isyeuOL6SxUFzGTRE3W6Jbn1kjTyOwCkYsT0SZnF+P
         MfXHngpOuyXmhFPvR2PyVsHiw1d8U+PEUZLNqGWP5q1oNdUBfvNYWQvZZD9PjM5daU3e
         pvfZg1mK+XKs/8XlQD2bp9Z2EuYjp/VTGxMC1Cy+3RTstxKSb6s06ZfO2u5867lw2+aX
         5a9nE+XnEvhV/lJ4+7SkuCaZhI5rJ1JZI06BHZsOg3pxZNwYQ4CAyCxEWBTKduP9HjqS
         r+FqqsFRhRH3x+MYIyG6v2b+sZJT6kOg3JTOc+lBPLQ5cFnjpzl+T4zuTNI0CV9VIYMP
         ahkQ==
X-Forwarded-Encrypted: i=1; AJvYcCULMxmTh3OCnMIJTLoU5NwSghzJGhL7lB/I8n+sCjkX7n1HJkXT3Cd4JfBRIVyvYYXrecEOwAaetfqR5khz@vger.kernel.org, AJvYcCWGEGj7lDh5XrHxg5AEnSxjidD7MDXXDqM8w6Vcc1iQ31QyqJyKU/LQgclNols7wbCGg6vuFoSuM7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pjd4vTLePeyI2IiJBv+ArL9WYpiPwhKkz6apfQQU7kYJLZUM
	4FEJor7RaXN9gmWBR/+xr04TcklWtbySIbzL0pS5iTOCz19jBChW
X-Gm-Gg: ASbGncsY1vm6xFEo3uvExG26a+fa/GY7ksYBpbg0ZhVKbgvVcVNU12OHPfPIZY8kFWv
	5JKN7q58NAmtbT/qku8Y3VMxyLSMoOYQJOLe8WBkMg6DUiGnoHimO96Ae5qFNRwjhTsFgSNaqiH
	1BvSNEDFdxm3imGb2/6ruTb826tOdp6rAnfqWRu1ieq7dAdQKCgjb3hiIK4w1GinxrYOUJX2tmj
	cqRmZ1Jp2k78bW8FljmuNlbs/t5gIi2iQ3Gs81SaAMsUxQPjMEpHbeumOdvtpKJ4jSWI3a0Ztir
	l8wF2peh8Asw2oXWlMf1LZD9xXjPMOyR9T2pE/eSYn45XTLETLyE3bg=
X-Google-Smtp-Source: AGHT+IF6XYWp7StUvpSliLtmghbyco2BwMZGL4YQPcUII64a1QaKlsmbRaUVtyMvgWQng1VnpCCOXQ==
X-Received: by 2002:a05:6214:519b:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6f2c27d0d27mr115357786d6.19.1745071000485;
        Sat, 19 Apr 2025 06:56:40 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac4749sm214350185a.59.2025.04.19.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 06:56:40 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 0/5] staging: iio: adc: ad7816: Fix channel handling and refactor
Date: Sat, 19 Apr 2025 09:56:33 -0400
Message-ID: <20250419135638.810070-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original patch combined a functional fix (allowing channel 7) with
several refactoring steps (introducing chip_info, renaming structs,
improving validation). As requested, these have now been separated.

The series proceeds as follows:
1. Fix: Allow diagnostic channel 7 for all device variants.
2. Refactor: Rename the main state structure for clarity before introducing
   the new chip_info struct.
3. Refactor: Introduce struct ad7816_chip_info to hold static per-variant
   data, update ID tables to store pointers, and switch to using
   device_get_match_data() for firmware-independent identification.
   This removes the old enum/id mechanism.
4. Refactor: Add has_busy_pin to chip_info and use this flag to
   determine BUSY pin handling, replacing pointer comparisons.
5. Refactor: Simplify channel validation logic using 
   chip_info->max_channels, removing strcmp() checks.

Regarding the 'fixes' tag: I've applied it only to the first commit
containing the core fix, primarily to make backporting easier. Is this
the standard practice, or should the tag typically be applied to
subsequent commits that build upon or are related to the fix as well?

Changes in v4:
	- Include missing bracket for condtional statement.
Chainges in v3:
	- Split the patch into smaller patches. Make the fix first
	  followed by clean up.
	- Include missing channel for channel selection.
	- Address specific feedback regarding enums vs. chip_info data.
	- Use device_get_match_data() for device identification.
	- Move BUSY pin capability check into chip_info data.
	- Simplify channel validation using chip_info data.
Changes in v2:
        - Refactor by adding chip_info struct which simplifies
          conditional logic.

Gabriel Shahrouzi (5):
  staging: iio: adc: ad7816: Allow channel 7 for all devices
  staging: iio: adc: ad7816: Rename state structure
  staging: iio: adc: ad7816: Introduce chip_info and use pointer
    matching
  staging: iio: adc: ad7816: Use chip_info for device capabilities
  staging: iio: adc: ad7816: Simplify channel validation using chip_info

 drivers/staging/iio/adc/ad7816.c | 94 ++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 40 deletions(-)

-- 
2.43.0


