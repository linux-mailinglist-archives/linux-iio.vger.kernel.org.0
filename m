Return-Path: <linux-iio+bounces-11658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A853F9B704F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 00:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48832821FF
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61661E378D;
	Wed, 30 Oct 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFYxGTcm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1501BD9EA;
	Wed, 30 Oct 2024 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730329807; cv=none; b=aHgbtSkpg10hAlnnjmVuxWO0vdni24jHJDneG6sbm7pqsBYXiYvvPIhCzfhzGcFWSMbZuELtnC5/cLKYn8A9K61UaiVCg8lh87YyifBMZwMz/3BhF60cBPonjqhS0ZNjhG30fVoVjq3g7fZhjxi3qlH/LfzF4xKH2UTJKxU+wEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730329807; c=relaxed/simple;
	bh=auAiNbXfgIKCEEDea46U230t6q8u6kIkwuEuHfBdFBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fxtJGDxPSdAmZipJyKRZX8GGhit5iSfXlcdl3xCm3/fJ2K6Z2jox1ryAP4nAeJo9ztC6i0Db4ZMJUSCcEurSEgdlE5zC4PKt6s9+YTMebM5tNMgE36JSNfubBOSmU9K7w45wRrwERb9Tujstn4YLwwyzpV6fowspHiGcn4DrhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFYxGTcm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so2752395e9.2;
        Wed, 30 Oct 2024 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730329804; x=1730934604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5WzI5HxfSBqQEgFz9hVmlgATX39LKoP9nE0o2zk+Jc=;
        b=mFYxGTcm27MW8a9dZC//n812f1EGKcW1pIdO4UVIarEjvk554RFZDXxLo3XNvGwx2q
         tOzprMt3vE/O6/z6b4bQHefXbGHQQwHXT0AhIG0ZM0aKnmBRppHi89TSIvZx5TrWx264
         0fkyig+Z9G8FrZ7pUGstQ94wwZmlB5433xnmO+yNi8EGYv9L8wtNapCtZ9jIApvfPOl9
         1UAZyTsS1I8/fQGu9zOysMPp1lNTSjD5KrxYIp5UqEh/NZ5hP1CGEyo4gLCnGEymMT13
         bUct6c2mA4ZNIXxXVtxJnZpxg2gfkce3FkQgQP5erdjFABrXcvqI2PWAqTctsSe3+EE1
         AjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730329804; x=1730934604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5WzI5HxfSBqQEgFz9hVmlgATX39LKoP9nE0o2zk+Jc=;
        b=huwJ6Y1WgYzSw4r5JyHfdi9TGJUTVfc0iyzFOaY55vloHt0WAghOrKaI0mU0b3O8Wv
         EJi1KEW1691Xhv+I3GJz9OId7Jebgp2T7M8DZpaNcQM2IItXA0wLNLKMU2G8nE3e41r4
         w9iYX9BmDPH0x1vYtK6Inlh9YdSHYthCBdCZiM0pEbAmnT550y0sMwcqTGE4R4QxnPWt
         NEiJu/xW86j7li1toCj41mCfaCFNdn3uqdTUcPgtV2c+b8zTj1MZWXYyNKhzTAI2yizw
         M08YfyQQ5Hu7w9Hr6OTX2XPSYHlGJom+On/ZGILwi3yoZu9QcHCOvwc4NhAtC1QwBgzE
         C4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUCyY7uYoLRjfDFLMKjegmiu2zrOxHMZeAiAK9iIPD00EnkQBvSlsmQEDwbRR1Tm0aai42QInAGjn/4@vger.kernel.org, AJvYcCXljq5vTcSApJGZJRdH+FYw5vxdqEkjjHe6CEslGo78q1fsEXEb0hudkK2NH81XZfqULjqfM+GqUMqDP98I@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6ZjTPFfyRcFeOdZKYjl5T7QJTmmsYKgvlfVfMLehhyXZ9Y8A
	aS8HXZuUuqnws17l9YhqAhTAEV8yz2dPz7AP8akgAKmysgT48lhA2s4gX3sZ
X-Google-Smtp-Source: AGHT+IEj/yV4fDw3OYd3zmVyJk3KOhBcxME+PIhT0t8qvtCMrWrYOD40bDOhxipMsz7DyOLFNjb0ZA==
X-Received: by 2002:a05:600c:214d:b0:431:b42a:2978 with SMTP id 5b1f17b1804b1-431b42a2d0emr70698115e9.9.1730329803609;
        Wed, 30 Oct 2024 16:10:03 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e848csm34819375e9.3.2024.10.30.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 16:10:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v4 0/2] iio: light: veml6070: add integration time
Date: Thu, 31 Oct 2024 00:09:56 +0100
Message-Id: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMS8ImcC/33OTQqDMBAF4KuUrJuSTKKRrnqP0kWaTHTAnxIlt
 Ih3bxQK0oXLN/C+NzMbMRKO7HqaWcREIw19Dvp8Yq6xfY2cfM4MBGgppOYJu7YURnDqJ6yjnXK
 BT9QhN5W3QaO1HgLL/VfEQO/Nvj9ybmichvjZppJcrz/VHKhJcsFVIYyXxhcl2FvdWWovbujYq
 ibYSXD0X4Is+UKBAXQi4PNfUnupOpLUKnljHZYQdCX20rIsX21bJ8pWAQAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730329801; l=2740;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=auAiNbXfgIKCEEDea46U230t6q8u6kIkwuEuHfBdFBA=;
 b=xVpLBN1JVnKOJHl09uieorMsbNja4Izs68vIjs2FDbs93KUHdRw6iCPZDwtCy+nW2Zk2fl2cF
 40gTfwkGkTLAOHiZyUxR5t4A/Tj+DubHAFUxCK3g/2VGdWoOkuqz/UJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds a missing feature in the veml6070 driver to select the
integration time, which also depends on an external restistor that has
been added to the corresponding bindings.

The datasheet provides a Refresh time vs Rset graph (figure 7), which
does not clearly specify the minimum and maximum values for Rset. The
manufacuter has confirmed that no values under 75 kohms should be used
to keep linearity, and the graph does not go beyond 1200 kohms, which is
also the biggest Rset used in the application note. The default value of
270 kohms is the one currently used in the driver to calculate the UVI.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v4:
- Add vendor prefix to rset-ohms property (bindings and driver).
- Drop default values for out-of-range rset and fail the probe instead.
- Link to v3: https://lore.kernel.org/r/20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com

Changes in v3:
- veml6075.yaml: simplify property handling (describe it completely at
  the top and add block for the devices that do not support it).
- veml6070.c: use int instead of u32 for the integration times.
- veml6070.c: refactor default rset value assignment.
- veml6070.c: drop comment about default Rset and IT.
- veml6070.c: use units from units.h
- Link to v2: https://lore.kernel.org/r/20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com

Changes in v2:
- Rebase onto iio/testing and drop applied patches.
- veml6075.yaml: use documented -ohms, top-level definition and
  per-device restriction.
- veml6075.yaml: add default value.
- veml6075.yaml: fix typo in commit message.
- veml6070.c: adjust rset property name and convert from ohms to kohms
  to avoid overflows and work with the same units as in the datasheet.
- veml6070.c: change default to 270 kohms (already used as default
  value to calculate UVI).
- veml6070.c: calculate UVI according to the current integration time.
- veml6070.c: re-calculate measurement time (i.e. msleep()) with the
  current integration time.
- Link to v1: https://lore.kernel.org/r/20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com

---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6075: document vishay,rset-ohms
      iio: light: veml6070: add support for integration time

 .../bindings/iio/light/vishay,veml6075.yaml        |  18 +++
 drivers/iio/light/veml6070.c                       | 131 +++++++++++++++++++--
 2 files changed, 141 insertions(+), 8 deletions(-)
---
base-commit: e2687d0723257db5025a4cf8cefbd80bed1e2681
change-id: 20241014-veml6070-integration-time-78daf4eaad2f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


