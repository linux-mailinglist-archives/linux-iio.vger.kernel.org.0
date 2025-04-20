Return-Path: <linux-iio+bounces-18362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54868A94661
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B841893F1E
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B186EB7C;
	Sun, 20 Apr 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J28sh3+s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AA15E90;
	Sun, 20 Apr 2025 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113754; cv=none; b=hkCSZzYkBinyf8ij9unIHAtGdnMG87dpl7sXRCysZk7d81lqv/ojYdS/99P6qFgxU2kaMLHn4O6R2GJ0oUq8izdccocTqCWGmJhknD+cWYnQZ/rRwaopddaDT33vldV8GbC4v3L5fLu9NW2r6VcsuWGaVmI9yKfdWhUs8dzYXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113754; c=relaxed/simple;
	bh=XR8VshVCBjCpDK/6MAQll9UllzfBm361bXzpA28liZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DacNtzrpKV+uNxZSY7g3EbfoU3iie9oDgnxI4GIGrJO6w33a89rBJ4/oKdGyqdVMUltlAJIk1YekPqGbj4neTXBRF8UPB9eNgjMntgsIoHjIy0cKVPpYCPB88Ebop6rD/owcNA8IlIC2STn1CoG6uJiSM0gQZ9wXSGeXvouCB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J28sh3+s; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso28093886d6.2;
        Sat, 19 Apr 2025 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113751; x=1745718551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BkK7sCqoYgkV7vHHu2iYpaek+AUiihEoUOu+lvG/1bs=;
        b=J28sh3+sBGEqwr+y6FV+hMxSkmSZMlVVG/edg9AcgR3rb7ZKV24rjIOTiCyxUfe5pA
         xfT3LtTDXx2XJtrwYLLR7C6fCj1gBLT7aONNS1dnGAk6fVb4P8r/4r7B73FxVySzsVFp
         MNHdToyXelTRQvKtD8SRpElhoSt3dLRUGc9h0DfdwBah3KVFWvzxv+TwH0hT1RLrW871
         G+x4RNE1Cbo+gZqDLT3VzikEbSIq4TSa3svyGzE0bU5x9RSCIuOv/0mzNGbcXKV/uu0G
         Vb8pV/Le35Zmu19tVgeoen2In/XoQm51bNcS8Gsklv2QDAFTX3Y84vqWW31OX//9OmBo
         6DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113751; x=1745718551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkK7sCqoYgkV7vHHu2iYpaek+AUiihEoUOu+lvG/1bs=;
        b=pPUPZJrGP738TmrI00KR+acmPgZnSu+njOeoPbIfqtjBHBKMAk/qTVTETgSY7RBk9t
         xcQsVXanncHqBKY3PDtT/ffCS3pSzgbFdpdN0hhJJLum3UvgM5dFyyC4NuA1msP4oy6g
         IJb2gk5/mWSrlpBBb+7lX/pHJZerrQCVtUubZVLQARD4O9zs5wOEK3Q9RnxdSrgwDK8b
         Y4p/nrLpqBESndRvEjxUHN+tPtbFmVZ7+zztAoX1bSAS8ZpxJncWZi8z2uXKEUFeq4w6
         ECh8fc+Z2q9jqBkEdgWyE/VnYBr4dTFLT4VyryilsDPI9H0XY+Gw6e2/wZ8gVpGLWQgB
         TLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+P5IA95mGvUAJ4qLG5SKSb8zb/fkFrSkUsg4b01RZNZ9HuHXhbAXvSHfIGDqfJTHHXc0q26JngCET1gtx@vger.kernel.org, AJvYcCVLYjYDi+ILUCyXiSy+vR/Cp0dzJIv2UsntMJBmWC0HLbEy0HJmeny2nhYdapr5utvgh1Mqwox4wVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCG7qu662iEOTAOCq9dABkvxK8mwRn5pHGO2q6X4FRGr5yoHv
	QcOntqK68ynH09SUjOh1OYvkYaOvCKZMWLjue3j0CBfOtKRptyMI
X-Gm-Gg: ASbGncvSU8Yowv8oNfipy/QKhv9whbiqTzqZ78bARzcYB7K0Us7/xIhX1nyVLPT4ntx
	xhgJ69Nj69xPjJfzq7YxREpnI+4tkGbUCdUbt6rnyS2BqP9SE5eFTnXLtVYHiQ0/z0yRfDDIQKZ
	C737qztq2KvzTpeWrZEpzc22ccE7UPOwW3Csm9z0mGeuD/n2zICxS0cybDtIKPl0bUnA1byt50c
	wwe7MsmabFNsOvjd5JvIIwzl8imm/EvxH66iermEEEfMPao58GJUPaWLIuoMLcUnvxs1EZJnvS/
	tELZwr5Qd7DV0iFy1txeeCMzvdGu5XXUwBt8Ak3mpJUa/tIota069b2ce95nzsF2KUlP/rQgr3/
	kq1O97nRHisw4vwzTl1M=
X-Google-Smtp-Source: AGHT+IGk3d9R1YYZht1x3p/xAxJxMVx6pGTt6Bq2tXXeEnpnQ2jZXnBusb/NjFh7MeNLG0ibHtjl3w==
X-Received: by 2002:ad4:5bac:0:b0:6e8:feae:929c with SMTP id 6a1803df08f44-6f2c4570259mr129930536d6.21.1745113751486;
        Sat, 19 Apr 2025 18:49:11 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1283sm27583846d6.23.2025.04.19.18.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:49:11 -0700 (PDT)
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
Subject: [PATCH v5 0/5] staging: iio: adc: ad7816: Fix channel handling and refactor
Date: Sat, 19 Apr 2025 21:49:05 -0400
Message-ID: <20250420014910.849934-1-gshahrouzi@gmail.com>
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

Changes in v5:
	- Use correct patch version.
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


