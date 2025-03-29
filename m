Return-Path: <linux-iio+bounces-17326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244AA75731
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B7816D880
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE4C1C3C1C;
	Sat, 29 Mar 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHTx76mj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4749620;
	Sat, 29 Mar 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743266737; cv=none; b=UmRW+gJCs1oMFPwhtHxF1VmoOvX5CdQPv8a8EvhLgXE8jEiItqXMHZei0CuJtGQe753qNeSKS/gKCqkhTYKuDOX+/f4zK82FJ1FpyPJdBHo53tpmgV5lAkfbCrcrqNB+UPQhgd8475eMWVAoVE9mdESbU2/e3gOfRpbJFvJ2wbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743266737; c=relaxed/simple;
	bh=Q0AqhTRu8I3JIwz6XEjzjmMKjXpp2QvaC/SC7OwckyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zex7HBepqaWcxPgQgpd7FpWG8pkUBFboZ1HyVmEvKfB3M581XCjQ9Nk/2ylE+5otnglXGUTNpyAM5XF9O3sxC3pVXumN/NffPPJd+hoAE16E7Tf0loBBK7Nubqy52XJe7GvInjkYZFIRslNC6s7rUyzF0LPTvuRq/dex1Ox9hHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHTx76mj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22438c356c8so67785175ad.1;
        Sat, 29 Mar 2025 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743266735; x=1743871535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ5NMxcHXS4j1Y/cyNQH2lM00ZrZuZiyjF/fhiQFYvs=;
        b=IHTx76mjdyEb9q/B9Q0QHMmWdXM+t9Ct9b6ZfucUFpkqKa2BoT6aXwGvgeB8DRQOpD
         50uIgOe/WE3pZ4XuBPxcMOMPCpPm2L147Z4WN9gnvWSsud93SM6wYBCXV0Km4c/wLnnQ
         TPM2ccizpplrEWkI5BiZvbhCeMCqggtcjiGV8UKRbzzFCc9Sv9r1QZ/DtBMIeQeioJnN
         ZB01zYf47meV1JQSnyrQ/L5fH1M5VF4aEDfKbrztI40oY80U5wSr1Q08ISZbclhhykGE
         zHvtC/6aYHEYwlv/GBQGp0kWvb0LSXbVJcfuTeVWAO5qZ94hZywkgFza/s2gEwpdhaIa
         VvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743266735; x=1743871535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ5NMxcHXS4j1Y/cyNQH2lM00ZrZuZiyjF/fhiQFYvs=;
        b=RbVfkJzvU2TIjMmrx75gxoBgCEkPieZjGrKwDI2g3qN40+ntXsP+oc7XrL+j27H4fD
         IR8hWZQOrGDVO/2UPaUW6LbGgTHJU9KdxgHp68dRXzIWVgHr03kTrMNqMS7B8VQMDV8l
         Eendg59dBX+RpEQ+HLqa+8AG+qONOdkltpix6KdlA7hOw5ZB3oadU4i/LT8yD12UpwFV
         x4+mjFfDqzhQQgWKD9phwn78S/18efAJwFwVMpj7/b8OQIPYDa2p5GMXtpAM6Z9RWTgP
         aw3zoqSUJwlbX8XsjG4Z39Aa/0RGRFV4M1Rl/ArBIgEapr+3gDwPIS9MZSHxl6STEe8S
         4QXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOfv3ThDwu4CscXeU/UJAIt2qijYw9JXPHZOSak3nq00oa+x8o05GtxLw6CFkajXht107O0hlvGuvJ@vger.kernel.org, AJvYcCW15VjtN0fLanIzOdibEQ2jV+XqY6elhg9b/dRLqAAcZBIZK7GEhnUhlOP5Jt6F0jbUSlZxSto57HpC@vger.kernel.org
X-Gm-Message-State: AOJu0YyGshX5+vxI77CJlqxJJaYNJZQjz3lLRZfPN0CKcuPF00aZ8BDS
	H42UxINr+B5gmmE1MjFlkK8ytmt9kN0FTg50osurM/9haUt+RJSylZQMgg==
X-Gm-Gg: ASbGncs9D/+4sOKMAL1rAV97k2aJtPBok7GJRQ1vlkxg4gGxJPR5rI8Q27z2A2fhfBP
	475x1MoW4F0LwimVqo8EQ0fshlJRQtbZrEdkGjX6vTb1BmvDi/5/Ib8W7gka4DtRfkF20bNFwrt
	1V9w1BCvNM5Uv1WJTXZHrYvd14yxkJ1U/qNLMfk9z2Z9/mJA8QzpKcdLEPuw6hBXZOxEVavsGM9
	0eRLdg6Qx/VjVNi3J2vhHJxhWqLyu9lv3Ep7UC/9tgCNYs7GRWpHu7nBXJRRNZsSxwFNi90qX9b
	qXRDe3mtp2wVpP8VPN+SJKFMFs4sBunhJX4l3mVsnunRYmOvOfQ=
X-Google-Smtp-Source: AGHT+IGyWWcvJ9EvlN25pgkkNyyYLL9Z2LxE0fLb6aFVpet4QjMVOY6Zc41Ke1U/JILiGmWF+ZSyzw==
X-Received: by 2002:a17:902:e549:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-2292f95d954mr48479655ad.14.1743266735155;
        Sat, 29 Mar 2025 09:45:35 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291f1ded45sm38170735ad.163.2025.03.29.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 09:45:34 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: 
Date: Sun, 30 Mar 2025 01:41:32 +0900
Message-Id: <20250329164135.631824-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Sun, 30 Mar 2025 00:31:21 +0900
Subject: [PATCH 0/3] add support for winsen MHZ19B CO2 sensor

This patch series adds support for winsen MHZ19B CO2 sensor.

Datasheet:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf

Gyeyoung Baek (3):
  iio: chemical: add support for winsen MHZ19B CO2 sensor
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  dt-bindings: add winsen to the vendor prefixes

 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  31 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/chemical/Kconfig                  |   6 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 354 ++++++++++++++++++
 5 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

-- 
2.34.1


