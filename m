Return-Path: <linux-iio+bounces-8639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF05958E67
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0431F24471
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426D1547F7;
	Tue, 20 Aug 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGDxCg32"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880A7BB14;
	Tue, 20 Aug 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180556; cv=none; b=EVWX7HUm45cR/6O5Tbdc1H2cTZS79/FCqz8B3JZa4N7yPe/OYgGE7zfCCfFE1pA3rIqdmCUlFU6tqbEAOL1waNxLbJmz38DpPbwLqsWyP+fKE4gkpv0ClDmdWD3ew6fdkD6L2ig5WVw1H9Ups32ucrgvFx7PgYEUCVMpyh6xNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180556; c=relaxed/simple;
	bh=6GZ6ktaBDlFlf5xXqnMkB8d+NP0luaR3DCxSIB4FI7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J+1CHx96RJeCzD/Texm8PCW3QSfBhnSF1m/rKcShEze3czMSi5Ls9pF74LwpUmcE5N0MY+BF6sxHDgB+L+1v3grRXtH1JuwctAM9xW7aeHQFr4VxI4GbNboI6rFx0w2D37jAt86MHuufN/t9W4J2lSATn35W2v4GvpQzfRbP/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGDxCg32; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so47385575e9.2;
        Tue, 20 Aug 2024 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724180553; x=1724785353; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3q0QmZjXATABQCpiFauAPddapHrIJAKoBzSHmYfFnM=;
        b=BGDxCg32p0Jl2FLOuw2DNDvWFI8U/Ffc0UPvcjzg5mqNP5caRkgpmobHRwIxGds/S/
         kQ+Ny8Mq01YPP3HVhDq7/HYePs1mqnrZuuoE/5HMjzR0i+yjt/QmM2tr9HtCG1q0efHx
         U8vPv+NgDeVcL0Ekry35ieRezv4U+/rS1QqScFthHOjcdeSSiXuHZ8xoFyTEwT6+azPb
         3euMvXCpLQHQg/p5Iqy/+1ZK3k3YYAdyOBaZ0h0FsTi1L+xRReOR+vRTU55jX84fnqLx
         p9g1yLMCPHap91qSKVxB1FZ7qwBlOru1y1fEobieMaxkmNs8L/tuD1Tus4IAQ8YISunY
         NZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180553; x=1724785353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3q0QmZjXATABQCpiFauAPddapHrIJAKoBzSHmYfFnM=;
        b=WBmB+xFt1DZh0GoZl1I+CguqfUQwM7fVIwDcy8Odvj5MkLvqeKrj2wTCDpMUtcaCyz
         Ntk9VKF5AI4/XI0su2w9v9wxjRGI4G5p1SSDi51IQ19RnasHlLIuY6MVyU/CBdEEPmn8
         yuiz2xRXt4yti2ZYZQ3//IAieDgAXHnts5SOJzfouWTDpyRIuVgYzuk71V9Z68JSuIrc
         ILV6w0+TDywSGDivMfrSHCt5coILBUTJ66grCTRE5TDFswRbLgxFI9fkNOmGw/Pug/ll
         Fbfij2W9qpP5wh1+UJ+3gLWiCtO2S6+Qo9ptLES3GAZ8fC1jdwfhYgPQoM11fTlMaeDb
         VKLA==
X-Forwarded-Encrypted: i=1; AJvYcCVHepA1ZbFKdiC3VasEzqJtZoSvYH+RSxf4nFSpOeOQZBvSr0Vh9X8G521qpKxlWgFJQcFZW2subVU=@vger.kernel.org, AJvYcCVMWks+qV+iqv8jjzX/zZ2dWSdKGDXr59PMhqDslsbyURSoTYjZpRWoHQ+sX/J/9kwCHNjrKTpN3OJhJR70@vger.kernel.org, AJvYcCWtvYe9xMmYPkBs6k/RuLlpx6V7y6sG1XWUTN2Nl0jTGBzE2iVw2CiU5u3bmmmeijJrutPZOHxk1av0Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdFddReUAiWH8PUT/9Q/Xpqk/qXu/zP8o9qid40i6bPNZgp8GN
	gupvSqw829W23Vve+BpSxqrClG27+ATOZ6PUTNUrzwE8bjY/Q2ql
X-Google-Smtp-Source: AGHT+IG4q8fUhcsVqTdr2NMP7R1QVeLtXLBHIx2DA5voz9952t/GK1TXQt4v/b247do24i7TpJIkvA==
X-Received: by 2002:a05:600c:34c5:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42abd24578amr2080735e9.28.1724180552559;
        Tue, 20 Aug 2024 12:02:32 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497ffsm13685375f8f.27.2024.08.20.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:02:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/2] use device_for_each_child_node_scoped to access
 device child nodes
Date: Tue, 20 Aug 2024 21:02:25 +0200
Message-Id: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHoxGYC/33NwQ6CMAyA4VchOzuzDbahJ9/DGDK7DpYAM5shG
 sK7O/DCRY9/036dScLoMZFzMZOIk08+jDnKQ0GgM2OL1NvcRDBRMS0ktXkJsIHO97YZg8XGAGB
 KtKqELMsTZ0Y5ks8fEZ1/bfT1lrvz6Rnie/s08XX6RWvGf6MTp4xa64zgd3TKiUs7GN8fIQxkR
 Sexh+o/kMiQAy01gFZKsj20LMsHJzHXSwkBAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724180551; l=2203;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=6GZ6ktaBDlFlf5xXqnMkB8d+NP0luaR3DCxSIB4FI7c=;
 b=Qpdn3Bzh98qlDzUycuq/wUsMzo820/JbaAFsA/3fKYUZGkvqWixj2+h/ZSIJNcNOLkr53+22e
 Lv7Ufadm3YIA2UzK47RtOYw1lCDc0eCZ15BViPuso1BoPF/zbwhdqry
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series removes accesses to the device `fwnode` to iterate over its
own child nodes. Using the `device_for_each_child_node` macro provides
direct access to the device child nodes, and given that in all cases
they are only required within the loop, the scoped variant of the macro
can be used.

It has been stated in previous discussions [1] that `device_for_each_*`
should be used to access device child nodes, removing the need to access
its internal fwnode, and restricting `fwnode_for_each_*` to traversing
subnodes when required.

Note that `device_for_each_*` implies availability, which means that
after this conversion, unavailable nodes will not be accessible within
the loop. The affected drivers does not seem to have any reason to
iterate over unavailable nodes, though. But if someone has a case where
the affected drivers might require accessing unavailable nodes, please
let me know.

Link: https://lore.kernel.org/linux-hwmon/cffb5885-3cbc-480c-ab6d-4a442d1afb8a@gmail.com/ [1]
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- leds-as3645a: swap the parameters in as3645a_parse_node() to have dev
  at the beginning.
- Rebase onto next-20240820, drop upstreamed patches (changes for
  coresight-cti-platform).
- Link to v2: https://lore.kernel.org/r/20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com

Changes in v2:
- Rebase onto next-20240808, drop upstreamed patches (changes for ad7768-1)
- xilinx-ams.c: drop fwnode_device_is_available(child) (implicit in the
  loop).
- Link to v1: https://lore.kernel.org/r/20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com

---
Javier Carrasco (2):
      iio: adc: xilinx-ams: use device_* to iterate over device child nodes
      leds: as3645a: use device_* to iterate over device child nodes

 drivers/iio/adc/xilinx-ams.c      | 15 +++++----------
 drivers/leds/flash/leds-as3645a.c |  8 +++-----
 2 files changed, 8 insertions(+), 15 deletions(-)
---
base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
change-id: 20240725-device_child_node_access-442533910a6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


