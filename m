Return-Path: <linux-iio+bounces-21495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0740AFF6B5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9056C4E6F61
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2E27F166;
	Thu, 10 Jul 2025 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mnt5Fah7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9E27F00E
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114033; cv=none; b=n5g8EcEeYqBAkOg5wttrxXBT0hI3IqyYlIIzOfn30/ehkdIu8G/fD06PZfqh+417WSbw2PjmyFYfGAAcSiXXEBPeQwC+eCqfuDeax8Is06JHuHZfCbxRIlwgIBRlWf6ARLXMJTLJial1KYIuRn7JdwvU38opaXMqbayf/2QFYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114033; c=relaxed/simple;
	bh=byk0dIPW8EI6Kypmsp2QYrm0JAnJSTpIQgO0vQYYNL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QEMrcPddNlNTad2NpZi4zpqdQ19uYE+YCtbSiht2aj9uPSVdESC+lEcD5wwfGPA7jCfIp/MnY0gmD8GVmueVjGXLbwUxah2vctTX4Lv8WBkRQEVyztT9bNMPFCzI6QotejpiIZucxSMQctctS5vxYLzVfsr06FgJfn50VqaLJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mnt5Fah7; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-611b246727cso266094eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Jul 2025 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752114030; x=1752718830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTsd9cGSO6BVj+ztL8QhdIsCz8olqodjVBaXpuBpzYM=;
        b=Mnt5Fah7nY+/gSazaSUsy91Qe6Irr799UwgsKE9yhroD4M6JlvspCPFHLspBEef1Gx
         yCKR2Rg6ujC+RyvPxnYCVAOV7eE2saB5SpjL3ieeSiFVJMcYhN48mmsnm8p8pPWpwEu0
         9r48K6q1q6buWDDyp4/TgPz+sAK+U9grwfezIFC4LHEiGiOYUi2n42NVvBAgxG6KJZs3
         z0aXJ4B8/1EzDtkhN8C/cD7Gti4sRUWEuSunhjvH4N3bLTx3mUMJOJuhQlQAiJNMxe1l
         1/gUjZB9a0/PDbbm0Q/bSefll6XNgduEeX+YnXfz2osXFbVu2WZAFs3xPBBDszfSO61A
         q5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752114030; x=1752718830;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTsd9cGSO6BVj+ztL8QhdIsCz8olqodjVBaXpuBpzYM=;
        b=fmRwhDxicNK2r3K/mB1kZB9fXNEUVSxG0n8GtVJwRou9SZbOP3Y29bvY93uenS0GhQ
         DrZWzrqL2nYV8liHW01GV7yZgv2aHqHFxFKc2bMeF+ToYvD1EHYaGXkCF8BAxT9hN4QG
         1eK+BWjoa++hCNzOUFbeBIqmffqfEytMJ1tuqko7i9Ci9CWBww/Z1Ao34CW5/5gXoamH
         kAfUMTaRw3BZLUnqlTXHPNgoIh/I5KGhzL2+p8phZ/tOW/PqpG2c3lSUMdAXU4fWMblz
         sbw6ekNyUllxIXt5zzkaxO0aptXhgPpn2UwI+nN+m6cdVWboJvOpTSVzN/Fp0sjfKZaM
         P2OQ==
X-Gm-Message-State: AOJu0YzlULrh63MNVvbPzsr6euBnBHSGShJ5fPJmhKcDItoIwO53a4V1
	QoIZbBGyblD+MdBpGEHTMvKRLcWCQYW2ByYIHgmFfgV5nKlpoyNIsO/tmdo4Bfgp5OaTYo0MZpR
	5AVeOm0k=
X-Gm-Gg: ASbGnctNHjN+DivI8fe9YWotpCYZAO0SNHrq8e1jV6solV31SaUHbEp406DptDFzmd4
	4D0x88VxjK4iXDW8KaTQkYFpX8bQotmKLDA/JLg5kZ4MG18TeHDh7VGCq55r27sU/vFHtEVE2or
	QpBOnjxpCG5D2vzeiAWZro62+jexrBm1kxWdCj2b6Vz19+7UNQxdNSmfYHmTxfC01cxwL0DVbaj
	43jvuj4K/6nkANSloCTUD9fM+vvj3V7zXN5W0s3vWv4XM8e3+J7/v81Y63Lf3Oju44GuzhP64Kj
	l6+B0wj0p6Ocfs2f7C05FuQ6wJQYy3rVE5zCHccfLlRmO0VDveQei/65M4JoLhbak4CE
X-Google-Smtp-Source: AGHT+IEYerDdvL3f++kvnKr/+HGsrbYuohXXgybSf2S1Plehh85S9qBXWVfJ8hHUrCZ2C94/FmKB6w==
X-Received: by 2002:a05:6820:2114:b0:611:75a8:f6ca with SMTP id 006d021491bc7-613d9f3f86fmr492387eaf.6.1752114030075;
        Wed, 09 Jul 2025 19:20:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f00d46sm66972eaf.22.2025.07.09.19.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 19:20:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: imu: bno055: make bno055_sysfs_attr const
Date: Wed, 09 Jul 2025 21:19:59 -0500
Message-Id: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8jb2gC/32NSw6DMAxEr4K8rqvYEr+ueg/EIiSmWGpJlSBUh
 Lh7Uw7Q5ZvRvNkhSVRJcCt2iLJq0jBn4EsBbrLzQ1B9ZmDDpam4QdWALsxpQW8Xi9Qit40zjc/
 1WELevaOM+jmdXZ950rSEuJ0XK/3Sf7aVkNBSLbWjaiDm+2C3pw5Rri68oD+O4wuaI4BHtQAAA
 A==
X-Change-ID: 20250628-iio-const-data-19-298c08d506f5
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andrea Merello <andrea.merello@iit.it>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=byk0dIPW8EI6Kypmsp2QYrm0JAnJSTpIQgO0vQYYNL0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBobyNSxAszHVBBAjGXg+o+2w0yRlrYzW+KqiLvj
 a5mkLxPxciJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaG8jUgAKCRDCzCAB/wGP
 wHopCACR16rhaZo8uG9l5rCqYqNkJ20MOWJ8QxaQ8HBRv68s58fYJuXGfW/svISADRR353EJ1M2
 PNiZhyDqrwrlkwUZ+B1WCF1xzsIFiNlq/B9IEAR1BgL/Iu/QQfEGFwIJtddeAujr3VkOO9su4FY
 ou2+k/l8vJLdy31Gk0wqMDI8S1JkmfGaitn/+tYye7SCWVFURF+rWVFvgvJqpKbhrsEe82MiqEV
 H2qJfIEnBc/VbEqRtoS4KpL1Uaq2f0DBq4dYe+UksuQhjHiqPt2vg9jgyJW942KzzHh9MkKnmjo
 Ls6z6PvmvqLS5m3BhIpvn3JQHo/crJ8GEzZLCSSs7q2DoQXH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

v1 of this series was already applied, but we got a cryptic error
message from the 0-day bot [1] that that made me look at the code again.

I found a potential bug that could be what triggered the build failure,
but it is hard to say. I couldn't easily reproduce the issue locally.
So I've included a new patch to fix this issue along with a v2 of the
original patch so that we can see what the 0-day bot says about it.

I also noticed a mistake in the original patch where I missed one more
place to add a const qualifier, so that is fixed as well.

[1]: https://lore.kernel.org/oe-kbuild-all/202507100510.rGt1YOOx-lkp@intel.com/

---
Changes in v2:
- New patch to fix potential issue found by 0-day
- Add another const qualifier that was missed in v1
- Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-19-v1-1-a17e7c16b122@baylibre.com

---
David Lechner (2):
      iio: imu: bno055: fix OOB access of hw_xlate array
      iio: imu: bno055: make bno055_sysfs_attr const

 drivers/iio/imu/bno055/bno055.c | 56 +++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 24 deletions(-)
---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-19-298c08d506f5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


