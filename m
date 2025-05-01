Return-Path: <linux-iio+bounces-18929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54464AA5CF1
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26F04A72D4
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354B22D4E5;
	Thu,  1 May 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egKBVfra"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F6205AD7;
	Thu,  1 May 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093716; cv=none; b=oRQSsfGz8hu/Yev/oCsJn7T3bxBE2vuFi9pwrn6DHah6/ur8mZC3utwaGp6Vq9AvnjSA0Rp9V1D/UhIPp0DMNrYdssRNEFTH6qm7ziC56q6RNixcC9pRnA+poOVwl/21g88V+hKVaPhUBXORZB8MXyIgVaI0aJIeLM7XS/cD7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093716; c=relaxed/simple;
	bh=bsFADKzCsBPFRFVZGLm+HaF9sAzzeX36q6ZLD2+qCEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GojBmUhGFF6wYToN6OrH03mncho0sVFdfqZfZ6ptYm37aTQTPk4dr3pzWVxtI7f46O7B6e0ORFf0osGKV1KSicCl+dSz/XU0dMWWlxJsQdkERC1MAlxdjHvv/g5fhGIepQ1MsgyyTs8K6lFbZH0r16WF8tmrQaGy5GgXpdviskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egKBVfra; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301e05b90caso847923a91.2;
        Thu, 01 May 2025 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746093714; x=1746698514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fTjcDNUoJQ/2EOekR9ouneUx2gFRLpQvcgox59bA3Q=;
        b=egKBVfra1RtSJSS5t90La1LQHdy2xvOKt2/2h5DqqqX5jrYMMVMex5Nmr/qlv2bFbJ
         CWelQaWnyO8i9Rw7zOhVJb6iM9/GkSLHAe8piv5H5QjWNZCRPOVBZOtHaJd74MEfoyeN
         NwoGoMZ5z18U3IxbrIfWgfjGcVsGZ1xE5Ers8YcyFmHfq4omi5G7duqO+JVQIx5svkqM
         wVZRc6bG8dt37FgLPuhb2fA3ftTizhuEERgDTfoEcOfS3EHd+cLtz7b63FsTckQBrEQT
         VzpRIvcc9IkKAc5g5YkCwqSCOwifPWq/MMr2TO6grbRMUkWs0rKTjazK1LlT7++Mv0n6
         rCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746093714; x=1746698514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fTjcDNUoJQ/2EOekR9ouneUx2gFRLpQvcgox59bA3Q=;
        b=hpkjOOkMKN8fgIyqc7Xvy64oJUyeWkRoexh3c7QCRXMeb1PitTzkj2shobUAnX+Ptq
         E627YBAx8h1zh9hpmZUZ634/C4CSBCpNV31Mt3OJynvXdW4ZwfrhUbztQFc9Z1ybAnOR
         erKmmgnvQ//QW/yHDLFt7yp083SMsAuiqRaVmXy+VzgAFZWWrElnSlovbDZFTMb9VbRM
         eDytbCcWZ1s40kE3baFrZ1DnbRDGFEPNjsHWMWJ7eG33LP1c6R59q5ACyc6ZuD52RTpA
         FxLtZyCNQdMiGTH0mbonuvmSKPC0/bpiRmyyWT+vsZexM3PREL2jbtb1DhEAtO6Eq7NX
         /v/A==
X-Forwarded-Encrypted: i=1; AJvYcCXU+6aPazj8DsPAPiw/a7qZfVzn707FsimbHTp7H+iKRV1nsQ0eYhlLRaKofLR2wb5PBMqDsmnlLfXs/X7j@vger.kernel.org, AJvYcCXaIYkuHWQ59jx+YFLHtkSIL1cuRiJPS29umqGOqjMeLY5/hD2Yv3XcWXyjYv+oXSJuGu6U5RAfTZdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCB4cQJCWrHlSUAOBLKXSFL4zlqBPMfSdSb2pU0kofLsfBUNft
	zbRkbNmjeOR3aFbHkjtAzYHu8+PEiuDX0SNSGmAPm6sKvIdHx5IPS0+4WFs0VwE=
X-Gm-Gg: ASbGnctvBMHz2XdHlXEbYYPguCWrtwGICwEI2MW0t6wzyNLtyDorPeaBbkRFx5Yezqt
	/OhDKs8JP/yTFlHjpLsAOeS+SrVtGReA0A0N5+iiH5gNpKCHVQWxr7Uscjoq0LMLILAdZRbhcUx
	BRWDOj/KDsclnwdbks2GJl98kGD0uPIWZjWAq7zr2S/vARx8Daz4ckpcpTa+v09gA4h1MmK1zNF
	pxBvxRYhjCWrCpCQkw1//vpv5lqsRtMgY1Ny/ZEgR2wcuAbfiko9AOMai6b5JlCNcy9rgmafVQu
	OT/7eAMqBQGvANkJPyDOuMDPRNyXG5UeOcJllqyOuikQlEsTXM0d+aC+/A==
X-Google-Smtp-Source: AGHT+IG8opicxQ27hu0i6sd/nOnUNADQYiucjyDpKm4LGBctaQJQll5RbOTmLNPD2DWHEy8x1B/CWA==
X-Received: by 2002:a17:90b:3806:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-30a343e80afmr9939843a91.7.1746093714052;
        Thu, 01 May 2025 03:01:54 -0700 (PDT)
Received: from debian.domain.name ([2401:4900:1c45:13dc:af05:2012:1f6c:ed34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47476120sm472477a91.13.2025.05.01.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:01:53 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-iio@vger.kernel.org
Cc: sayyad.abid16@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	olivier.moysan@foss.st.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	stefan.popa@analog.com,
	ramona.gradinariu@analog.com,
	herve.codina@bootlin.com,
	tobias.sperling@softing.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] iio: adc: Makefile: add compile support for TI ADS1262 driver
Date: Thu,  1 May 2025 15:30:41 +0530
Message-Id: <20250501100043.325423-4-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures the driver object file (`ti-ads1262.o`) is built and
linked into the kernel when the corresponding Kconfig option
(`CONFIG_TI_ADS1262`) is enabled.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/iio/adc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 3e918c3eec69..14192944c225 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
+obj-$(CONFIG_TI_ADS1262) += ti-ads1262.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS7138) += ti-ads7138.o
-- 
2.39.5


