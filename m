Return-Path: <linux-iio+bounces-18306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67DA93F24
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF30A463538
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F723A562;
	Fri, 18 Apr 2025 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTh0ni4X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292752356B1;
	Fri, 18 Apr 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009426; cv=none; b=J0RZBiM0yjFSRA14syTyY+CAnxEc8RAW7FiHErERQqHvTxi23BrJqFy1K4turGNUPGbZjAgUdLQSvBfB8KU6j9655qwU1C2u/lZ2tqmzu0gHwtyC4tqnPFQ2uQz9V5jGocHiy7HavLr7FHePk0PLWqMVO6eOo5vUg3TxQP/WIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009426; c=relaxed/simple;
	bh=W9segW3cJMe7VP3WKWL2Rpm9z+MOBA5Bz2bhSFPcUHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsbvRF+p6J5FkTIrKZPl/F6/jFDeMByu9/CvV6qnxGiA9SdMZpof/tFfE3W+jyOKMV9+dDiuvZ8cpe2LQfQawrt7tQyA48ZtkABC4xyOiY93K9DrfKsQsPQn3MOevfJVN3XeQWkCpvhEwHivfRlyhl74/rDo4uKH/bVOgojz+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTh0ni4X; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500d08cso218412485a.0;
        Fri, 18 Apr 2025 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009423; x=1745614223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBS+gMuCbxo0lQQXgb/9PCP46mLZ8s4XB03eoOWWGew=;
        b=KTh0ni4XoZTckpz2941ZQBGdpxgBNKRnVM48cPUjcw3AXlXLLgqJVlpd/dEZjb/NTr
         ovpMYt8i+NlRFzIISlGh35E9Ohb03muKpCUqVKD7reWY5BddLOC9n/uQMZYAiqsMOwue
         H2Cxlbkmbb7GLd+qK3iA0YBbTqTNTZmDSHEzJ/pCoE7sra4moOEvwDP08w6hCaynTqHB
         b7mimYoLhKRU7oqp6MKFClEY1gTnsqjtF1HQAuq1dqdNwoeIsU4gzYdvodJAXXghNOTH
         o8SdmzFbyyAKLpW1XClyGpRZzBj1SlAm+VZZ2NCUgBwIicfq8ajm4vC/OM6TaEBhXdZg
         xOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009423; x=1745614223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBS+gMuCbxo0lQQXgb/9PCP46mLZ8s4XB03eoOWWGew=;
        b=QMqcmw6DcGcMENrQg987/AW0SNEwpI6eGiC1GXBSifvXXNTmimBczf+MJyPKbyz3GK
         rAzPuiDIOxeFpdw5dXpLaGt3EaFKtWiMmYALs3P/TFvrQn0LpvncxEa3IBQcOfVd+r0r
         7o2sH6eMvWh4YrAMMxfkI9ANoKqpkGbCHbkYfhkRXM9WS4uoEqn84i5g5ME6smppNdDC
         ok3bWeBXrEh2DSIbB5FnePIKvMtAXTYX5PsZFNcORsYNn7bvu0UXB7nDjL54LIPm8LUo
         seQlprXzU+HLC5373JuchDxTede1RMusR7VhnMJUV1wHRR/gCQxLZIFPhkdp+2nZND8O
         oC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUme1mQv02l/cNnLB451OVhRXbajOVHKj79+B0a1p+v12vMPm67YGvKqqmY+lsvK51UFYIwzj2rynADdyaX@vger.kernel.org, AJvYcCXjWt7GGMomBCVZSl8z6vkTuhVAyeP0pe+NKmuUIyDH3wyzZJDDCmQvp51qMGm0osYPdzAqaqcFUgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoq5Ltc4l7hVs2eeLuJU4G6dgmSlfN9sK0XH/QwKmi4pn+K56A
	aRFAKx3WMx4/fhPjjRkaGyD/6hTbv+aI/ehnqjjL8qcavpzTk8dO
X-Gm-Gg: ASbGncvGRaJVqBK2c9RWT6SGtfilrsxf1742AwkDc1RJPe8ytTmsmYqSWLob0z944df
	6d3/3/myHWwtm4HNSusZe2Am11UdDfXpU3Hjemkg9CxF9HzyGPBrhjQHxs3rpwH2X1Ym5AK/4PJ
	bTeA9DzBnm922td5gR3IdrmRCkJ/c+ryTNZ5jF8MUAuT5jQXqHlzRB83pCqnvWG7z4SInvaZkWF
	p2JobfOgWUa7P6Bq37yEi2otZ2GNGtRCNS7d7l/dmEESUawPijPVIhP/nLewtqzav8pxpXcs9kT
	d9ZhEAO//a073tEoEyJCSIVfRfv8BfdF8rV1fv7OBQim/GJdFGv4VERcFwhPgrMgk9x3q9huL4X
	AN6Yn9lnco6+8BRBBVNhOXypEVKP0gw==
X-Google-Smtp-Source: AGHT+IGfxKsSAmrL28HNu5yl4e6s2vMKqHnmp5LNwavPA9VlB2hFWprDYSQDcjsuRTkffTYQCc6V5w==
X-Received: by 2002:a05:6214:20a7:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f2c4687fc9mr82895486d6.38.1745009422700;
        Fri, 18 Apr 2025 13:50:22 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af11d7sm14355906d6.6.2025.04.18.13.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:50:22 -0700 (PDT)
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
Subject: [PATCH v3 0/5] staging: iio: adc: ad7816: Fix channel handling
Date: Fri, 18 Apr 2025 16:47:34 -0400
Message-ID: <cover.1745007964.git.gshahrouzi@gmail.com>
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


