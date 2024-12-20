Return-Path: <linux-iio+bounces-13730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913B59F9A7C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAF216384B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D9222570;
	Fri, 20 Dec 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmd49BuM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226072206BE;
	Fri, 20 Dec 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722926; cv=none; b=LzFj8MRAHNlQC58pkPKMWS+oCw+bb8fvs1k3jiHU+lazv54bYONwJOITmL/1bFn6Svg1lCG4PXwXlEtbX81WU1joIxCUCNiEotkjghEGacXr8+V0OSO/DhHk2aG3/e2+iAp405Z8oMBd72zcp20rcXdiUXyXXOZPlrLuJ8QMWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722926; c=relaxed/simple;
	bh=Wwa6UwXNbl+DrQxFCklOmu+d6IK8aLYDi9Gr1IKlYtI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkdbqRXixoaafRvK+aIq60IfyFNlrzXuJM0abcdl4jBzBklXhR8a5BhHxTFcQwzWuH9dViMffd+nwc4SgJLhlT4jaFD4G2Z1Ug6HZpaI67WV//c8Qa3qy5YAop5nqjLt4uK+jD9Z0JJFSJkHt0OXnqh7VuZIKUeUrWt8ojD4A9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmd49BuM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so16762735e9.0;
        Fri, 20 Dec 2024 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734722921; x=1735327721; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5B9kO2+0kYh3Ray8TcFhLQEdI47zddBnVLH0Vps83fI=;
        b=Wmd49BuMqU4+UK9k39lumPYcoPvZUuPvN+BPSm67OUnULycFQwFvWyLta/DZXM0V3A
         x3vXhtNRgqn9B6WdHJllyJMZrgCA3xKhmmYN24dZClR8V5/TX5Pi6zRIqpXJtxzJ6ews
         q3A0zhLys7d+Jy1I6FK72h9CRFbmqjUb+9Ypsgcsn2lj6sRLSI1MHzm1BIFjsO0cctlT
         Nqh8jQRzjo8HMcS/LcBRXKIIjA1E0NERitNIPEjROkaPNvGJ86WqkDDVoaqgyIOusDkm
         HrBaG4+1fw9ECVs0pDh12tYYsDhvY5e1z+Bd/gxI9eZ8pIqfPtdQGaMAmWhMC3tfLRwO
         ukDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722921; x=1735327721;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B9kO2+0kYh3Ray8TcFhLQEdI47zddBnVLH0Vps83fI=;
        b=bgO51RQpldwt5okxirg2f7xJ3LzA0mHqug/RWkvvzO3YWLsJG0mDv975oyCqaiwzp4
         ELmS2bSJkK3S220gYu3+QVY3MVQZhO1AR9YCeKi2sb7en6EU3QPhH5E5DyYVS1h/e+A1
         Ly3uHMZHG8kyMTdvYBGi3xr5DvwBlAIUc3Mj+aC7mSzhwOIJGM5LzrlxpldjDtFGHbah
         1sUFNpydMCLWEwkoblyz07Quu1fu4OJLrDnQ+NoERGPsLgQyNEAv23AkMz9JDBv42CtC
         uNK4bwn7UhDELcvjD8vw4gRtHTzLpHZnPVr28A2gTNtHAX8WMD5mugp7mJBAFPY/6OmB
         PXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8D1Jaee8hvrICas8EYaanoMmREua7MOjWpHLQcCYi9ePZe8muayL9t51h6r5MJEsATNqjx2PtSbPVkeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFFVCHSyKNM67o/WAMdmUt3n18gFAiF+Q5oSiLYBgSQ7u9syo0
	6L3+Dnd4VlAOY5tX1cpqjRdNt55sacxPVNSJxbSPRnA/6U+6iAddkLFiZA==
X-Gm-Gg: ASbGncv8HyZyh3jCVeOSAXNu1sRDA+x6lNFoirYbuYrUQsYybHHKen9YjWyfQmezwO1
	jC0vHygoslEm0d5vjWOUTUkGU2CFeoDWyGQa7hD/z8Mtw21dcJxJpR5E0MaffxLNDaCOfb1ZspH
	ROXSHA+t3jqHbFqPtPpBalSzTO2GIILBul+M5nehNP1i0Id3Xp3jQhkFujAXchKii9XdpG6ISji
	dKhuqt6hFS/zoEiga/9AEkOaFhYi7OV43pR73fqUhagqHv7GgkF4Cmg2kZ40K2Wcv56O839Fc98
	0lwtyV7b0qn05wbbtvj/BCyYRglXdjDAUxJHVcE4kbCFTtbgPRKY3J6lB83gxP/HmewdjyqnbjD
	Gzdc=
X-Google-Smtp-Source: AGHT+IGStNKPKkez5zWUQ/tUc/GIOGi6OjADIngEahae0VQ/pzJDVw9E92SOk3d61Rl/9l86iv2fhg==
X-Received: by 2002:a05:600c:1396:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-4366790cd9bmr42898285e9.0.1734722920629;
        Fri, 20 Dec 2024 11:28:40 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e9bd-7e4a-34d9-3ba2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e9bd:7e4a:34d9:3ba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm4674274f8f.59.2024.12.20.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:28:40 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: light: fix scale in veml3235 and add helpers to
 iio-gts
Date: Fri, 20 Dec 2024 20:28:27 +0100
Message-Id: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvFZWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NT3bLU3BxjI2PT+OLkxJxUXTOjlFRLi2TzJNO0RCWgpoKi1LTMCrC
 B0bG1tQA+hpoYYAAAAA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734722919; l=1666;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Wwa6UwXNbl+DrQxFCklOmu+d6IK8aLYDi9Gr1IKlYtI=;
 b=AfrswMOffOX2HMt97zhj6uRsPJ3baaiIMWgzO9PGa9gFgEp1QW6sEv11JJmF+wsvDAc9L8h/G
 5RaY0I3GhrWDugcBMFUmHV+TWxQD4TKM5+uy2+6AkoICYfejKVdDUV7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series addresses an issue in the veml3235 that was inherited from
an older driver (veml6030, not covered here but probably addressed after
discussing this series), where the scale is does not follow ABI.

To simplify the gain/integration time handling, the iio-gts helpers have
been used. And to further simplify the process, two new helpers have
been proposed to address repetitive patterns that are found in all users
of iio-gts.

The additions to iio-gts are wrappers around existing helpers, and I
have tried to keep their names short, as adding more prefixes to the
existing functions looked too cumbersome and inconvenient to follow the
80-char/line recommendation. I have not added any test for the new
helpers because I would prefer to discuss them first.

This series has been tested with a veml3235sl under all supported gains
and integration times as well as with a few unsupported values to make
sure the operations fail in those cases.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      iio: gts-helper: add helpers to ease searches of gain_sel and new_gain
      iio: veml3235: fix scale to conform to ABI

 drivers/iio/industrialio-gts-helper.c |  74 ++++++++++
 drivers/iio/light/Kconfig             |   1 +
 drivers/iio/light/veml3235.c          | 252 +++++++++++++++++++---------------
 include/linux/iio/iio-gts-helper.h    |   5 +
 4 files changed, 219 insertions(+), 113 deletions(-)
---
base-commit: e25c8d66f6786300b680866c0e0139981273feba
change-id: 20241215-veml3235_scale-62de98c7b5fa

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


