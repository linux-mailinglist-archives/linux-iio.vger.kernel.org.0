Return-Path: <linux-iio+bounces-15996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E9A41E37
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 13:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A5818830C8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE225A322;
	Mon, 24 Feb 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL85U7/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69D2441A3;
	Mon, 24 Feb 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397718; cv=none; b=kmcGonrA25y4trWLC0jyQ5no6JcGDVREencsrfF0Zk2RBxYlFjAH4xNYM5CTDkizEbcF/vedDkh7Ilsss+q2PUV5frrCOFjZp/QazrwjW/pGs7wvzT7vBuU2WzrVV6PqW8DTKosK5m29/gFyABfmx5SHmyC/Uoe5Be/HecvXEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397718; c=relaxed/simple;
	bh=7P6j3dztD40MRGc9WjjurcBvL9MdLNZfq9tKy3OQzIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfAvDQChvTZ7eV1bUwXH0TPYo8AP3uuvUcYA4+AMNuEdmaefTlI/PAxjxTTFObKPtrkd2FQpQxDIgMB3Kcg14SQcb46VNytYUPXfvGau0t9TBY5TX2GJ+NPbcVZmo6YAujkqjsrfhesOptVLGjoTZKcSrOncYD63lHIeYAyzRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL85U7/n; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-543d8badc30so5049380e87.0;
        Mon, 24 Feb 2025 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397715; x=1741002515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atnb8vT8PjjHld1I8ZHaKAb/081GPPRide+V3/o4HbQ=;
        b=hL85U7/nIrta1upV3dqWjJQNfjHymn6F/XUTcLgq1UVj4NIucwzndi0aGODjdcAzsk
         eN5I/fBAD+0vcvDqsToJr5qToMEI5DDXXQIUII8RSNUe0AIBUy6iIf30x6w/e7gUCo4f
         1kDZ/Prm9NFy+dKFrg2TObXVJnr5RtGZstg7XlHE0Wg0IQYHZGZyn0N7BvrECCfyaxxl
         IZr8ERewfb66yoArbsd6JUF7D/MEKCTSKafm5jM1NEgp1Zd4E+RXoMMKxjqVwYXBaeVE
         SjO5hxStWd+ZJJ0c2dKVeZYcRB7HbuWQkSSwmUEXl1o9FlcyjbBlpkDcubOk96RWdH/T
         fHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397715; x=1741002515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atnb8vT8PjjHld1I8ZHaKAb/081GPPRide+V3/o4HbQ=;
        b=UH/Z9vg8xzyUMfvpFDMompOUaGBE+Oq7h1M2HC6IryP/XKJOKVgtt1Dn3JVNvQP1JR
         3U3QU+xhU56n4W8eKBCGbqioqtt7cBlpGH+4f7KbxxJqVUXhIzZPl7mE+Fi8FZGUzuJM
         blW+4zwVn63gUHiPwu+ZPPEHkl3+2SPrtSnttxR+kyOHwVPVHYXIAPwojlCxhc3mbwvr
         nioiH9x2fdlW7Cy+voxQrm85cJgd6cbR8aocgGA+TGmKqw/erLu2KYju4VikSLzE1xKC
         5aRh2VQMTZH4mZPzAuCLoXR18EbyA4k96kRkQtRFIR9eXbdcVz6nIJulaSiJkBO/NZDW
         Yp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGhPxwk+mkmzqg3fgkT9OV9rjORQInjfZ0g6GGhBa/2nvW+Cl7IlEpeIM1HCaOXdFVk+MlsCQ/RyVb@vger.kernel.org, AJvYcCWDjew+COLaBe9CM70v1ow2V9IOEernRZFrB17afNSeYoJP0X/rffkJaAO1qwb0alCWhKTBve+e6nF3uQ==@vger.kernel.org, AJvYcCWe68KzgRYjtQbKrxOyFJUpNzv1989KSCK7Ydwo/ldeFkV0CDDUD+xvUOZgQle1YIPF2Zs/pG29+nkOVrqB@vger.kernel.org, AJvYcCXXzi7gv3BBmgJPSjAVcK2e7L/yY7vaLiJHUrBeoHQPOk38LymY0lE3MF3kxwRR53yjjcH0M/BB12aZ0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpTRYCjP3+W4a+9XFpaLtVCDy9nBHOH7NZbKjD33Wr+jHysbh
	fmP1ihRy9BPP1JMwThLbVoj0kn1KBwFwx5PURwVTrO19ixCGJPDa
X-Gm-Gg: ASbGncsknbCXxi0Uu0vCqU7SbGDOwLMZYEnwNN1JXF/yYQbLFdjTNxrLzfMIrYCLVvY
	rOkxbDlWQsMLzXG8FKm9FOtLzyOPifMjZsSgPyKTxOmDnjkMFiNW1xDQUxMavdWJnTuQcrAcl8y
	7K2fQScFSSmddXf8no6/xZA6SGRx1O3BeHVVUxhLsQQpqC83hjorR3T/DeK+ydbaSH+tLtiVgX6
	WlJdgrJcilR49FYtCtGejhAvjhUEXV+flEnkCMwreJQoMkpoXjRLAIu40PGke9YYgGn4n/IJD2N
	efLKA62jqBRexmwi
X-Google-Smtp-Source: AGHT+IGtaNoSRQNpqZE6mcTQCEU9FuEKP+HpNqYhMZ4Fh8GwXbsRAlQ2tLnm7O+tpwCdNz943QPcdg==
X-Received: by 2002:a05:6512:e86:b0:545:60b:f38d with SMTP id 2adb3069b0e04-54838ee3406mr4784026e87.8.1740397714664;
        Mon, 24 Feb 2025 03:48:34 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526338bf9sm3167862e87.85.2025.02.24.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:48:34 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 0/2] mfd: lm3533: convert to use OF
Date: Mon, 24 Feb 2025 13:48:12 +0200
Message-ID: <20250224114815.146053-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add schema and add support for lm3533 mfd to use device tree bindings.

---
Changes on switching from v2 to v3:
- wrapped lines in schema and commit messages arround 80 chars
- removed |
- switched to MFD binding style
- completed binding example
- restored MFD

Changes on switching from v1 to v2:
- added unit seffix where it is suitable
- added vendor prefixes where it is suitable
- light sensor mover out of pattern properties
- added references to common schemas
- added detailed descriptions of properties
- removed platform data use
- devices bind and configure themself entirely
  using device tree
---

Svyatoslav Ryhel (2):
  dt-bindings: mfd: Document TI LM3533 MFD
  mfd: lm3533: convert to use OF

 .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++++
 drivers/iio/light/lm3533-als.c                |  40 ++-
 drivers/leds/leds-lm3533.c                    |  46 ++--
 drivers/mfd/lm3533-core.c                     | 159 ++++--------
 drivers/video/backlight/lm3533_bl.c           |  71 ++++--
 include/linux/mfd/lm3533.h                    |  35 +--
 6 files changed, 395 insertions(+), 187 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml

-- 
2.43.0


