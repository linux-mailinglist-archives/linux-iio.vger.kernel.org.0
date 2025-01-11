Return-Path: <linux-iio+bounces-14118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97784A09F40
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 01:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BEA7A364C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E977483;
	Sat, 11 Jan 2025 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GqZpUvX8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106131B815
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554949; cv=none; b=mPcVRxcIlSPr8sxtQT1OgjbHAhlGsfbqzzAr14xpPqtrfJ/gFz+oHGPMzO0aJiPPZgDd90dpF6dvVyvdRw0TN2Ap5xczR5236kqRQ299tOqrvgQwRET+ZopGU3NmQlguzFLkb11DQzZOOIQPtjYxoy+A2vGJEVLZLeWRdwbAHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554949; c=relaxed/simple;
	bh=5hjs71Q2Qvi/4/+FzHizTz3U4RvPYkjjzUIkHxwgZOU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pM+XGrs8O9s+JBzUZLDLe4//7XPqPlpK9MeIL+nUFvcHjWMkJxWbJraH8B64fFuHDoV03woX624YtXIKeq6r7BTEhZGDZatDA+b1Z33MYwCq6sFAj4BUyJEa/MaaIt/oC7G4AVsgK+z5c8lcPLnbyj/El9tuXkNih99Z2eBgnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GqZpUvX8; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e3284f963so1278694a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736554944; x=1737159744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJx2V9P1rSJ9fo0hY6rmZSfYcr2sE1x8/CnNE275bJU=;
        b=GqZpUvX8H5pfNo7H7B6nIbqVY3kHCalQ0V4BBqse85ipcQ/mooYPWvYR4Yq7XYre2c
         6IFWhOYlpSSdjjv9QrcRJoNC13lUsAGcVdxWMr7ixWEmGEPQ25fWiTS+JGdVqMH7vGdB
         ue1GTxFF7e3sLrF7MwCXEL4jm1L8IvSO/ZT26oVaJqD6TS8rFiLSILvVH6jjnmZ1/lru
         46PSj0M6l0UYQ8LDjxJ4DgIEk40ulVxlalos6ZRLn1ARkUlvUUc/PsPRtAXXvt0pSzWh
         tgkkdCVhhzOAOU3rP/F3EsJR4WhgNtknGjepbZUAbVi9Wa5S1bxfKaJt04z1YFZ0doOm
         3f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736554944; x=1737159744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJx2V9P1rSJ9fo0hY6rmZSfYcr2sE1x8/CnNE275bJU=;
        b=qntmku99RTfJQxTRDDiRIpB16Jvm18NV6m+eRwQpysCPcs0bq8prjvj50SPzSEFxCx
         gOGn7VVjY11LG8PE/NN4xV4ShHSCCA83IVtvBX/AJr6kQebkhdjZ5VHAGL9Z5G9lFh0f
         2lztJH+V+eV2Qk0kvBMraxSplT2UTZe865ArwW1qjZNKbpGtaVXlyYQUh2jAbMwllYUp
         G8YEI7QriV8nbrvgeN6o9T8v1q+WEDpYDPpzbTzR4hu72SggVccvPJICyJ2eYEFO+eV5
         r+EFwwCA0+cYykI5NXi9c694ScUgUxjtLSQvU5iA5a0ghepj36T/eQOiC4Ag2W1jkYSz
         c94A==
X-Forwarded-Encrypted: i=1; AJvYcCW8eMSkNE8TsGkPybnjS2PUu+lqIeem6ye3aGOu4jzFzVL5Rbwmd5ok6YtxfjobzQeJBMzR4yZMsQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLokIdUtWcLNRUIfhPPdRNDPq0kvPDepyNx4Zj0vf0HbrGE1V
	oG2MVGMCTlj5Oj5vxj9Ddvw2ZGzQi0L4DJOtLbojZmd575zPTpSC+BJUuISNtwtVlVU3bKfUKP7
	7
X-Gm-Gg: ASbGncu/Hg254F4y5FtHfy0En4uJ82RWbu5lr4o+gg2E5ajwnyYb8yB2sowk9ZZ4JXS
	++sbv1gPg4Gb7NO/zWg4ltRmlVBJMa1zoyDFU6oV3zQqcoqkPeztKuhMHq71MzE+wVegWkY/OLU
	pQvxS1U8fXY8FNyhzKLMrRkfwvi5FmSfrwbtJ6rfrKHmW1U9pgG6xfePvxqlI9Dw27TWltljDof
	AtY8pPtoYRlEoqhObFr0Uy7MNvERUhpcluN7g8QJHEwUErxjh/o3ReVPhQdRsOzpLsamNgPaUwH
	0/wVxJ4vPROp
X-Google-Smtp-Source: AGHT+IGW82wCgs57JFGMPAuRYlz2DyZ2BmYiMI3L7K0Y9CjRJ1hAPxPTlbs7j+rn5hQ7yZhO5fWLig==
X-Received: by 2002:a05:6830:25c2:b0:713:ce15:d4d1 with SMTP id 46e09a7af769-721e2ecc96fmr6609727a34.26.1736554944100;
        Fri, 10 Jan 2025 16:22:24 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723186280easm1228941a34.59.2025.01.10.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 16:22:22 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] counter: ti-eqep: add direction support
Date: Fri, 10 Jan 2025 18:22:03 -0600
Message-Id: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKu5gWcC/x2NwQrCMBAFf6Xs2YUkklL8FfFQs0/dSxI3qQil/
 27wOIeZ2anBFI0u006GjzYteUA4TZRea36CVQZTcCE67x2nsuUO466MNyqvIixqSH2Y3LZai3W
 Gj/Esi7vPy0yjVQ0P/f4/19tx/ADFpAOIdwAAAA==
X-Change-ID: 20250110-counter-ti-eqep-add-direction-support-e1553d80b686
To: William Breathitt Gray <wbg@kernel.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

This is dusting off an old patch [1] that adds direction support to the
TI eQEP driver, so calling this a v2, even though it has been several
years. :-)

v2 changes:
* Split out core change into separate patch.
* Removed extra blank line.
* Rebased on current iio/testing branch.
* Add patch adding the event to the counter_event_watch tool.
* Bonus patch to fix a missing gitignore entry.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      tools/counter: gitignore counter_watch_events
      counter: add direction change event
      tools/counter: add direction change event to watcher
      counter: ti-eqep: add direction support

 drivers/counter/ti-eqep.c            | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/counter.h         |  2 ++
 tools/counter/.gitignore             |  1 +
 tools/counter/counter_watch_events.c |  5 +++++
 4 files changed, 40 insertions(+)
---
base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
change-id: 20250110-counter-ti-eqep-add-direction-support-e1553d80b686

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


