Return-Path: <linux-iio+bounces-19679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38338ABC098
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B00C3AB916
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14012283FEA;
	Mon, 19 May 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFJA9TlZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A283283FD3;
	Mon, 19 May 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664775; cv=none; b=qIdDDJgqZIN4593DRKt5jMjDnlVbTEiEiftmStaim9AmVepQ0x8qHcT6QjEGgs2uMw5hvPOlDrRI0HR1UQ4y/yHTM5GQSvJ9zGs2VojQWX2g8qY6QuOzHWNP69UqXQT/3HgfX314rncneumee+oZGlrFWsMMCJbmqKGneMlBf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664775; c=relaxed/simple;
	bh=pIsXkfwmbJwpyIPN7p01NdbcZXCT8CBrk099Zl10eFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABXRqMoVnMnAx/GjOX8hTTerCYTwANYhGwWs0nIj0R2ivOKThw2YN+6+HH2ACr7G866YDtERL2rU0Bs+nzgV+jofpIqYFsscnrqe74pt4/YFC2XIMTeex3CKk2F3VDT8D1YSelX5SzEPiOjjQdffgfA9xwl+eSZdIxCh3PQgOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFJA9TlZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742af848148so2052985b3a.1;
        Mon, 19 May 2025 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664773; x=1748269573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws6NGUTrhwrUyFzENkHKMEqXVz0k1/x1kYmVqczNDF0=;
        b=VFJA9TlZyPt4Ojo/hiheBR3MbrA+ED0DUREyQOEfxDpKiSGPJZXufRWwLQX9njv38R
         jA7YnFmOOd6+4utx1NGkbO+LVp/jEZMdmP5TZHQJZiDpsnX3NgVdmfDwaDvzkTlhOTGD
         bSA9N/M2HO7caw/qXVFeEsd4FzK1ITk1snbNBBsGjuesC0ifI4H+ggbzat6CWS7CoE5U
         lrv/+n4PQck+P/jR6PciO5CoM8V9h0eBWS50JYTwr76HdINtJqhdkBnBQ7f9hTmzMq6d
         VOHJuQSRrfiJJPSz2jI4+LkvQFSkzcJ5J4Dj7YyGlc8nXZ1ioCs9DnTznoTMx9PWcifx
         49tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664773; x=1748269573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws6NGUTrhwrUyFzENkHKMEqXVz0k1/x1kYmVqczNDF0=;
        b=ZOmSyll0dfpjrk6nRLTorCnUYGrjEVk7972T7hMhynn9aX05zu1YoGoBrHKSqqhYI7
         qH9j7Bm9drrB4tqIrq2Gmf0gXliIDbYDejxuf1xtlfM+et74aDVPLE5d08r1B+mWuaS1
         Et3ZbxgBOmzudtBIo+DB4jT6bs37GxWi7zgKGYPSKxPt8Wi9r3osmqoAQBCrsi5nY9ur
         ZjP+AKtyXx82tLM3M7ISAPpTUTn2DfQ2Q69h0Uco475vdDgwtSqQYBMUl1OkrrvFhSr/
         eQhOnje1thCKNrSJ4PDQhOnvKK6ImE4pnkakl4PjXPSVOqOB3oxRZm3Ry3BO+QJyAnQA
         AJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUiNjX2kVppatVxDktencbXiZXBHwZ8lO2TbH+AI3cebo709h7Wkt0+trcFSPraOzH5AlPCoGJeQXw=@vger.kernel.org, AJvYcCXL9YXhL83o6p9CHQnkRWx/jdq63Aq5Vv/X2GiuAboo7+sRQlRFecrNeVPYkNfT/sQ4NN9cXVcFr38Wkchb@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKuKQNNjBmRj+hnKFssRTIc6wb201hKRBv6h4yorPaB199PK4
	t2v78tjigEIK8ng8V3Tpjby7ZyH8DYnzdPbDCf3i0txRFjr3MGXJqg2n
X-Gm-Gg: ASbGncvJt4LctWZtR6vbZJYDYmJJr0EXxK03dS3D+yHp50+PCw0SQPXG5G5vOs/II5n
	iEO8eUBazBQFE5rcUmI+SpLRR796+eUGfrHuzixJIh1hrt2llcbJws1BNVtbF9Bkth+0r3u0Gtx
	/LnMgVPHLJ91qRanB58tYD3vSnFyg6jPV2AfUguCblef/gc8OdSlSa+EyaExgKRdIU8bi80r5i5
	7N7xJW4e4AgRWXa7WwPE6xZPN/HxscW4+fqfvdOhBs2TA8XsX27L5ZIIY/r45m3RiVV9LbOj6KJ
	VVmJjeTXM/SH2lufuKA9TmbVsjIN/tJ5DP70C/CRBIotT0efzxdEnMvKAem8IkBN/NVO
X-Google-Smtp-Source: AGHT+IFLB86+GGsQOIbdQ6TWsM7RA3lPV1bojIEbPOR6YJ9mg5Np9dvMCVNczPoT9o9AC34ZtMj7GA==
X-Received: by 2002:a05:6a00:a24:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-742a97e0b3dmr17911736b3a.13.1747664773431;
        Mon, 19 May 2025 07:26:13 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:13 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/9] iio: buffer: Fix checkpatch.pl warning
Date: Mon, 19 May 2025 23:25:53 +0900
Message-ID: <20250519-timestamp-v1-1-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Remove the following trivial warning:
"WARNING: Block comments should align the * on each line"

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index c06515987e7a..9bf75dee7ff8 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
- /*
+/*
  * Copyright (c) 2012 Analog Devices, Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */

-- 
2.43.0

