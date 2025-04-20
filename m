Return-Path: <linux-iio+bounces-18381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727BA948C1
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608EC18900BC
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5720D4E2;
	Sun, 20 Apr 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApKXY0iZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008651E98FE;
	Sun, 20 Apr 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172636; cv=none; b=QMr14bTSbc9zandHuWlYbqcQuQmOi+oe3Mr24u9jKUoyD3+9rndXaXXe7nwZgiFdkNiIhjydkSi6EXIzwgUxAz8c0YW1+GePf9H4+9nMlalLLdGxgoBFBR2uHeUo2G+S6cJDKRuTEbfoR2Wvw1cGd9J8wLsj9oSCBlaccsKe7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172636; c=relaxed/simple;
	bh=avHCEpDZ4bib5CJU1pIwfUGJuIEJRQVCIOpgOuSrQtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nWdXy+b+0gtc7Bqse/OYEzrmj0zD+bOq9gd1dUrtH/TkrNrnl4FRRoc2GJZevhwaLm1gtJpE46hS1IrnSioyEEzmz0rNULo8JKMMIN6oFNJ6nbqO3+/YaxvOLZDmVT/YMB1yl51YgFkSrISR5JKB5dM4pSZW5iqM0tw9f/48W40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApKXY0iZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224100e9a5cso38713425ad.2;
        Sun, 20 Apr 2025 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172633; x=1745777433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sClu2TBUbFQVBJCgH+1Gjk5xgnHg7bad1lQwdprFbwo=;
        b=ApKXY0iZaY+JtmfZVpj678phgnFBjLXLqi2rvl/JmBe+9oJ+wtAHzx00yXr3j1Sl4G
         UZrO3gLbNnhdhGxjVYwjTFJ++jHngsIgArO4vkshvsi3+H3AU8OyoHIyLi9gojQjnhpN
         i2Sx3oJInqu1jBKV2+DT6PMjs5PFQ0i9dJ53aD6dggE14711nXuykNi6S3JeRIfKsb24
         2paIGfFOcWGcR2H9p2W/CzteL7+46ZPXymyiS3ojt+0OPEqArwe/xMXZ9qI2jciTk/bz
         1XsfCX8OuJnzVC7IfNpXhd4xEGhA54Cd/dvxFkFTE6FkNAwmfeP/wbHUr2sW1/B0TkV5
         00Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172633; x=1745777433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sClu2TBUbFQVBJCgH+1Gjk5xgnHg7bad1lQwdprFbwo=;
        b=MlN0owEGgJ4b+Jch4LON9ZHjriVFPfg3PmxDlDBV1405zpeMmqgotn8u5yl91K+Fzr
         dGeCd7vnCWg5/eMjuVVxZ0grFueJ8dvW5i9MeoR1ZFJFU9N8X9OlA9SJ12aGh5x2XlIE
         MsN8paqqN9CY9+bp6QC7gcurauYcb2S+Qd3c5ULDhldg0DvmD6Nf8y+B6zNxOsx5WPpP
         GVBaZh2cilHKGyXZ6+1VwOrYJOx1r5BFw3bu4mdY1YzCAEQlB18876GxIewZDfj0HrcJ
         EJoSqIy55lWcJqiiKcH/8c6mi7Rc+KGgxJ2+oj5uKJOARKYFN/qwibUZBBCmfj14GnAz
         qNcA==
X-Forwarded-Encrypted: i=1; AJvYcCUQga5jaLpCZukJXRZFXwArBpV5DxZOfDDHk6XCgI1Uk9zSWwdMD612r8GtE2PiyqvxOwAjsPCucUYD@vger.kernel.org, AJvYcCUiABqYuZfJmNafuhvYiqZe5Mj+7k8d4Ioah9iYWki631v7E90OMxARR7NxYFEhOfJSM6kgfFOC374p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+PCxVYD8HAzOo0/+MML9UJFyKvfaqBWrBKupu8HZVU0K0fyaQ
	pX6AL5SP8hgBXLNCLjteY1jw+igYWQVBGYruYWtBn/QVX3QYDg87
X-Gm-Gg: ASbGncsn2rbdcbClCjcFqxfPWOW5V2yZJMV6HQIjMNpVPriQjrPompp+0e3uXZwopsz
	kwvAEBNoGH+rDXGZQix6eBcyK2jMJZZgHp6jF86trzQwJrfiguvyYkn5Su2kEmFL18+iCjf89tk
	I1RcHmxJbPweQ7f6QXAG1D+Z0rFBW3N7pcnnKxIpvAoWWZovR2ve61/Wjq0qxvPYSSG4k8l0mVs
	aADXtisbrXTBpbVZ8bl9ervIwi9k1phjBUQupy8WMutZWORzvSO3gIPYWq7eaZgy/9pmfwTzdQZ
	0jcf4tJFk3UVSlo7q+vBsFPtiBHd049Fzzt0nSjtQj9K7DY=
X-Google-Smtp-Source: AGHT+IFFljKVqyWXPwqph5asf5mcE+PJ7cqjuO4OfsusIAYFM6tio5fZwIbL4GphcLrOfDnA+/1DVw==
X-Received: by 2002:a17:903:1ce:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-22c5337ca0cmr120932085ad.9.1745172633113;
        Sun, 20 Apr 2025 11:10:33 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8c05b0sm5009347b3a.35.2025.04.20.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:10:32 -0700 (PDT)
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
Subject: [PATCH v4 0/4] add support for winsen MHZ19B CO2 sensor 
Date: Mon, 21 Apr 2025 03:10:11 +0900
Message-Id: <20250420181015.492671-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - Ensure buffer is aligned to the cacheline. 
 - Fix coding style overall.

v3:
 - Add vin supply regulator.
 - Drop custom ABI.
 - Drop unnecessary mutex.

v2:
 - Add ABI doc.
 - Add complete struct to receive UART transmission successfully.
 - Add undersigned as a maintainer for the WINSEN MHZ19B.
 - Modify to comply with the IIO subsystem ABI as much as possible.
 - Revise the coding style overall.

Gyeyoung Baek (4):
  dt-bindings: add winsen to the vendor prefixes
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  iio: chemical: add support for winsen MHZ19B CO2 sensor
  MAINTAINERS: Add WINSEN MHZ19B

 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  33 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 307 ++++++++++++++++++
 6 files changed, 359 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

-- 
2.34.1


