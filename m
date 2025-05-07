Return-Path: <linux-iio+bounces-19255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA2AAEC33
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4323F3BE668
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870EF28A719;
	Wed,  7 May 2025 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f18ruBDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A628983F
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646351; cv=none; b=ByFbN3eAAuw0A3vyFs9qGIkr0h5mlBTmaMQ5VKSr95KOcXPdYZCV8Y4/zDHFkMv8f4SasQBueJ5X1+a38ODyt4ULTWnXZ2wG8H7wMRHoj0RYMHUMkagAxR2e4S4ma4kQW+2pkbNe1yc4bB0EFWmgF+95zSTlnR/Via+S4XuMMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646351; c=relaxed/simple;
	bh=Xqh+eHhG6cVMYpbB9f3sJM7EIGlTqKm8RHJDW/DFK9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KMSLx8t6tdAms70VW3ckSw01B5+OpEYRFK3Pq1Aj94kVnAEdOQlETmLcPhwUd47duJlOOh6ly03BlMpUmidlVB42w7T8RxhVlwMyMM3I3XhH6VYy/mwFMd4Duku253j5lkEAAKeQhxR28E6n94ddpRD5hmIvQTa9xg8qVeMUkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f18ruBDG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33e4fdb8so2643855ad.2
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646349; x=1747251149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqh+eHhG6cVMYpbB9f3sJM7EIGlTqKm8RHJDW/DFK9U=;
        b=f18ruBDGIAM9FZkLC4PtmDFeUlA4lqTo0qKThctXUPlQzRFxa1XGEt6iaa7xzEK1xt
         DRCvVtilakbLWjeAaA8aGF4e4xjsqVQDKKtvjhfoUcoKkwDV9NnXZFPF+8/xj/7bHVUk
         D2dFIn+0hYO/f9fuh1DqeC1praoW7j1EtMt20woJdgdqW2hSO55qya7oLS6T+3bF8GVL
         nAJQL4k4A6UbgnDaOMsW39oh3xxW0cO5oiAc7xBO2GXo8rBlUX81eg0SD3Yn9W7Be4Ar
         Je52zbWV09/Kt6n68fnoY7O20FovvyDUGHKLYyKdQYD2RwCElwJViVp1x38DtvEDRi61
         pdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646349; x=1747251149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xqh+eHhG6cVMYpbB9f3sJM7EIGlTqKm8RHJDW/DFK9U=;
        b=XTUT3CZCmhbomGvUicNgWnlOXeANpL9A9FIX4GAfhDogrf7jNAY3OGySLOst2mA1Tj
         ilOAyu2XHlffKqG/Aty8qF6bCLnd6WKB1RM5z4odN7VoVOj1VmsPceE2wSN/OC/IhIV2
         67p4IN0SG0t7eNObha1BeKhZlfj6pf7Px0hc39gMHEiVD8sCedIX1tacdw0OVzj82Oeh
         HwL3tdx6NTRiCbJt5jliJg5jvf8Akq1tanRFQXj2ley0LHyoLAMtwAv0/LgxFnnKPR7z
         zUBdFa0TLarRxbp9/TD8UGvOu9sS6YNTpZp9pyIOC9bbflOUoQTaUqVe7uBVJu5VTZ5Z
         cDtQ==
X-Gm-Message-State: AOJu0YyWw8EdKRk+m/U/cDFH43NXpg25Zv0x5AEbBg/YDX85GkWE0bKT
	p/9kVpszebMHspxTCV4nbm3x0NjdrwN4fCWLG4/p8xD2akkfl+yFLLw4zbwT1aM=
X-Gm-Gg: ASbGncuIp6CBXKqOMlFkTbW/FXmqg7Lgg8HJJfwcgDgnZ8vY9nNZf0eYAIGgHGaUT3U
	YaPmdD9a7pL/BYJJGm9Xq0Ww84qqb5eMnvm9mK5IPJxn+dWf4SGznWqtPcISJHX70ZJoeYNILPS
	/gST4umDjVUOkpQFLINztTuZq/TQZR5QZvtUl8xgVJqRsNPLndXjurn3hZlG7Kbj/Rmte4OzJIP
	Mbhmcgd796r5FGd5gbrAozVr0TOPRKa6qMpd75RRJCWRM3cYAXV5qJaRsvG1XVLJzXS4e9t/mt7
	kyFsI0RmSQL+1NOsQR6g3T6FOsuMp4g8I678tNQ6kU4e8Lsf8aKit1lr6KwmVdSnQvNQVvs=
X-Google-Smtp-Source: AGHT+IFYTMaf6Jdt1FdIBhLipNUtYulJLjGaG0nou0vpACnlpnbvp7e0OcdKjsXZ8YNQyMdlcKCLxA==
X-Received: by 2002:a17:902:c94f:b0:224:2207:5130 with SMTP id d9443c01a7336-22e86707fccmr8088085ad.45.1746646348735;
        Wed, 07 May 2025 12:32:28 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f62sm97769815ad.168.2025.05.07.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:32:28 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v1 0/3] iio: magnetometer: qmc5883l: Add QMC5883L driver support
Date: Wed,  7 May 2025 20:32:16 +0100
Message-Id: <20250507193219.52965-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces support for the QST QMC5883L 3-axis magnetometer,
a magnetic sensor with I2C interface.

The implementation follows standard IIO conventions and includes:

Patch 1: Device tree Bindings and Base driver implementation
- Basic register access via regmap
- X/Y/Z axis and temperature readings
- Triggered buffer support
- Device tree bindings and vendor prefix
- Device tree bindings

Patch 2: Enhanced configuration interface
- Sysfs controls for ODR (10-200Hz), FSR (±2G/±8G)
- Mode selection (standby/continuous)
- Oversampling ratio configuration (512-64)
- Status monitoring (DRDY/OVL flags)

Patch 3: Advanced features
- Mount matrix support for orientation compensation
- Power management (suspend/resume)
- Control register features (soft reset, pointer rollover)

The driver has been tested on a Raspberry Pi 5.

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>

