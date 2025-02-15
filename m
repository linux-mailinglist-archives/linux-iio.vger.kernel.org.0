Return-Path: <linux-iio+bounces-15547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24358A36D51
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 11:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1BC3B0125
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E619E97C;
	Sat, 15 Feb 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7sJS+Ph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AC748F;
	Sat, 15 Feb 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615547; cv=none; b=ezUHrJl39Hz/wkQzlWAk+Y4REw6Ea5lWhnmKBXf5ysm8OKdEhpTvuHJk+sRJ9Gm5Hmrrlk1ZIxTma7tKZy3hbsfPTMwSOWSs7JXItPaV4CfrNMt5I5Sf6dODlS7Ysx3KsNK4/csK2beAICXufiVeaHY9Wxw4R8/ZcCyi9/KiLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615547; c=relaxed/simple;
	bh=PBgr8FLz5oLAqGvU0Ww9gruaAbHJmlB0I5+cST1gO04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLvrD7pRLRDcCfGwYPOPJHB23vCN61QlSwvqfe6+dbilYhj/FKBfKIp3zU1tWvv9vGF24gvS7oc7LGECE1N0/TzXEQA2CzDM89ZyTVyZBS3B+6L9flRnHwMv49tJJzUAaRInM/JTRIzhobiHU/amJxFoExZ0dzpMwlEYSIUnQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7sJS+Ph; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5450681b606so2821494e87.0;
        Sat, 15 Feb 2025 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739615544; x=1740220344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IFODiovVbi6js9JilOujPK29SFBBxZbaFpvul0+tsA=;
        b=S7sJS+PhERUdjraYQxlrVbOkq8L4cRCHfYtxsfup4qudbUAMw+nKK+nIGVgXC3VUCp
         X+jDr+KpEUzr9IaBqq8ae/XnI4jAk0CReJCAk2awAruFbCOw3qSI7au1EyXnUg9cXF4J
         vl3Hn8if86Pab3XBX36gjjVX/iZ77EVA3xiYUsFIXoS8p07BeBmVtVrlPnR1MoPdBCqe
         nmlCWGDy0baehxtqhI58W77WOC/9lvb/VMYt+4dIbd6c7lDvFEj9HPEvFLtDcBOo0oYY
         ZPmIBHM5q5V2ik1Rq57+1sZyOnKj/vRZBja8oPDftPkUFNxYNQlpqQPGsA8MA82p5PTN
         7vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739615544; x=1740220344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IFODiovVbi6js9JilOujPK29SFBBxZbaFpvul0+tsA=;
        b=dzOLb5uoQteqbQGxoZ8BmrjvubiPipfQB4jO5CWcnpKK2WorotGsyqC+g4h8+ieQEZ
         NzDOD0/ab269vvBgfmBqWyqWAEJyHWtxcIQP++ycCPFYMEgpJWMKNA65FOwKRno8z4Ub
         Ecm1fMW9xrjvkmpssiBneKcUcBY/VfKYyYhPz4JdtjKf8566C+S1yte6VGZj73LbMnG5
         LqIVsv+6iarNz/R4ryfSyh1QIOCpAjFFvgKlRNW6P5qg5Ajv84L3lKMjQa5S4ZW9SmPr
         w/fYn52S7N16zBDSrml/fITGrILj68QxY8AFbQCE+qAhGmk1OO0lZGoxxqFJGyd19V11
         /MCg==
X-Forwarded-Encrypted: i=1; AJvYcCUBrZIH77uwHBo2We4A7I5rUyXsyODWIr1muurubXRHqlhsde0EWSHxU05Fs9pKxIBnVaZoPNID8WNMfVgh@vger.kernel.org, AJvYcCUDz+6CYLnxlM6hCihB2yq1vHZC24B1nbkCVxOJqxVjDjioRuT4Js9uX2T+wkMAb1xMwcn12edzIq93etc=@vger.kernel.org, AJvYcCVX8VFkHyUwENx9FZUKL7A/iMmqpgN1EsUN+jarH5WZSlPnhoivDORCFRPEfW4pyRnZ7VzTKvE8AvEG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8QU6BFcZc693icb7jO8h8b4kSX5UJy/WwnRTOtetyPG25vz8
	gJtqAwrJv2AYF7Su9gm7OguhUIynoudthV5CIvuj5k4oRethmLhQ
X-Gm-Gg: ASbGnctp4dcVkc9oVYtgmijssB9gKke/TDkW9DL0XA/h5wNiwcqrYZwiOcj8DQXs9Zx
	1JobabzmCzMG6Ky+NyukvJA4mii1C3WgwNMZ68fmdgYKlbYXijn8TGuV0g1CpdC9u6ay6gaVjpN
	SImiwxk45yDON9oNqU4zu1toniFAnqcchTvchOKz+5WCPaItfJFqe+KpjyTe+LF5/QuwMc91VJQ
	MrZ6cI6tr8Z2LSd5Au2F5lyHOpfTqKIl0C0dlsECjlCFN507KfL9cvNzf8s5FMcicZHGliZNo9Z
	ubRRmNE=
X-Google-Smtp-Source: AGHT+IH113Zt+sUzS2Ps9oWib8/GKvxz3e6n6frTNjstX8eVnnrEEQKhdQnxlnIAeaOGJTRH+rvo2Q==
X-Received: by 2002:a05:6512:4025:b0:545:ea9:1a11 with SMTP id 2adb3069b0e04-5452fe2738amr746168e87.5.1739615543524;
        Sat, 15 Feb 2025 02:32:23 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309298dc5eesm2201571fa.95.2025.02.15.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 02:32:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/3] iio: light: add al3000a als support
Date: Sat, 15 Feb 2025 12:31:56 +0200
Message-ID: <20250215103159.106343-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is an illuminance sensor found in ASUS TF101 tablet.

---
Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
- clarify commit descriptions
- convert to use regmap
- arrangle lux conversion table in rows of 8
- add more used headers
- improve code formatting 
---

Svyatoslav Ryhel (3):
  dt-bindings: iio: light: al3010: add al3000a support
  iio: light: Add support for AL3000a illuminance sensor
  ARM: tegra: tf101: Add al3000a illuminance sensor node

 .../bindings/iio/light/dynaimage,al3010.yaml  |   6 +-
 .../boot/dts/nvidia/tegra20-asus-tf101.dts    |  11 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3000a.c                   | 221 ++++++++++++++++++
 5 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/light/al3000a.c

-- 
2.43.0


