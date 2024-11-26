Return-Path: <linux-iio+bounces-12711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F629D9EFF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 22:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97E328520B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA31DFD9D;
	Tue, 26 Nov 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb+EdiDa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98281DF978;
	Tue, 26 Nov 2024 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657934; cv=none; b=KyYv3gNBUlk/EazVTIo46M3a8Epfkzf7zjes6TiEXoPvHmwBvgbjjpnlxdo/iuL43BYcclE/W60vYT6bkH5SUQBc/dPJPCly28YRPFoCe4KNL2f/1j7HAIfJaOjLp3ku7mknQVE2OdyjYCAAD5NcB3a4tRqspbxkyLHbLqykNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657934; c=relaxed/simple;
	bh=60YY1uJHN5RmyPT0N3NyyFjI+6rugN3T5a91BrLQmog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rlcDuukrfq2P9y4B8XWN72MnPqVZGpUIQgcdbcE9t/ibRW/iOOMB0bEvW0m0MM5xYR/J94g8zo5l5otzq/c4tUGoHWiivgeTji2LKLdLPBxuWuOQoDrfl/dXlnjQuH3jITF8f0+RTQvMjZHM9M8mr6bNsw0wzZwhEJXCF6JrwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb+EdiDa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38248b810ffso4622460f8f.0;
        Tue, 26 Nov 2024 13:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732657931; x=1733262731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5gX/28xeOa4H8evb/+QhxlU0Ge1xRM184LPoeNAkm0=;
        b=Lb+EdiDavA2rbwtelhVd9LFRFxUpp7Gsy2R299kHaBQWQNMjL3FYrf8VusKoYYwaJb
         gP+9bcv1WGPsmAfAHdUagWl9RNYJG3DGvh3hKrIkVdbj8v93/G1EMxL7MzmECfTz9wA9
         FEGfj6yU0hnjzAdxtAaUlFEf/LXP+Wq4Bv9qbGf5nvMP7lq/tPBgKbxDcdEaEK79s4OQ
         /cmpEWO9JOj15fD9uKkkUJS2DC6YhkszBPNUcb7cK0sbqOI61yB3le3IKHNkqFPad/pW
         mBLszGEBmt7j4mlDhDOwKjXpusPvieN6yNay+dUbdxLFMwWgtR1Qx2sjFakkTFjY/BtM
         KkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657931; x=1733262731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5gX/28xeOa4H8evb/+QhxlU0Ge1xRM184LPoeNAkm0=;
        b=hiMY2mpASeQsc5rOn0AmEaKKVpn/X5CTgqB0hNz34W7dH4WpTmG05vgW3/rW2vY7u8
         w98FKsSuCGDZJKG/xYdQKOJ17gNF/1TZIXj/hmSzSGvN3MbDclrZ6tFjS8dz8ApdJ2ww
         C4hL+e3ivddWqKvVI4QAdu4vBZiAwklBUsyDDaRi6h978NOTuXqUiOZNKZwLRM/Ov4BB
         mLDe2bUXoa9nF10mzX1MYPM1bz8uEcTdrb2D2Imdo9PbchMllXre8cQoQhJqPRl6eYsw
         j6WIirBSu1sNMM0uuh3Nf/PE8LR7E2LmM2Qw02oj3fdn6q6ufc7vmx6MuHC0qbR2CErf
         KAtw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQbycl4rDnDSDOHKght0H+S6M3BNSUTWKhy10e4RmRQP1QJcsNx5ZYDFbNTxbdm1zudK7aydLBzuf@vger.kernel.org, AJvYcCXQvEeCVzBbqDi6ncaSp4wgoOHGN1+GjwMBDcjRbfoEfJV2Fzx8LP64hedmemJn2LMVZm4Ib94dIj9kWgeM@vger.kernel.org
X-Gm-Message-State: AOJu0YzJz3U25/E3RbfzaMGJCMbYzu8pC/fScGplGPG4ZOAPx07w7vIe
	p1t/j1Ew+Buu8HZE2EIkacy8lzZx5sXHx5up4+SUDPzW82cv9Xf6zwms7Q==
X-Gm-Gg: ASbGnct2vC9ofcm2yKfHosgtzrIvNqV5Dtz/mPkppeS8mJnt+AxiNB9GDCs4zn8YDDE
	/9DtZzFrCq3QgZuwS1rQyFiCb0cQbiy0104eRRhDJkdUSHWW/F1KSnVVQN7rFjUKyqrcmHJixeC
	yvOHS9Vt4MRto4azEmZP/nAyLh53daZcLm3pveB40ENNemhZXEVk/kWtZp+wE+QNDK5yR9AFhOB
	iQnxXdC/0fDE6Mk+C/dxyX3qPGRnrBG3h9NrlH7O9gfjObrZJPSlk7oy2NqehhlA012EUb43qaA
	ps336HMYtones6G6oCjRtMCK/k1kdEwxQBy6BxAepWw4Zci9zViVEhV9eZ8xtwAyP1q+Wuc=
X-Google-Smtp-Source: AGHT+IHx9E6n645bJw+ZZMCpLPj3WAsAZR5gALncm6d5O3N4akt8jlgIOb9O5YKY5Ed0Cyk35sfEvA==
X-Received: by 2002:a05:6000:491a:b0:385:bc42:52e4 with SMTP id ffacd0b85a97d-385c6eba8bemr439856f8f.24.1732657930933;
        Tue, 26 Nov 2024 13:52:10 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d42c-04c9-936b-d14b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d42c:4c9:936b:d14b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafedbcsm14570297f8f.41.2024.11.26.13.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:52:10 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: light: add support for veml6031x00 ALS series
Date: Tue, 26 Nov 2024 22:51:53 +0100
Message-Id: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlCRmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNL3bLU3BwzA2PDCgMD3cRESxMz45REAzOTRCWgjoKi1LTMCrBp0bG
 1tQDIlbMgXQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732657929; l=2445;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=60YY1uJHN5RmyPT0N3NyyFjI+6rugN3T5a91BrLQmog=;
 b=nLvxAp1Flieg+ccgqL+pbACAzaYRC5dw+toK4qOvYTs3/tt7l0V3fBDyk2t9xVu5l3TiQ9v8q
 7tNtE33MXayDhk0Ok9wl7MvMSdC5eE6MhYnlzZ1wupurSG6xFVUFWRA
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These ambient light sensors with I2C interface provide two light
channels (ALS and IR), high/low threshold alarms with configurable
persistence, and a data ready signal.

The devices covered by this driver have the same resolution and they
share most of their functionality. These are the differences between
them:

 - Device ID: accessible via two 8-byte registers, different values for
   veml6031x00/veml6031x01 and veml60311x00/veml60311x01.
 - I2C address: same grouping, 0x29 and 0x10 I2C addresses.
 - AEC qualification: AEC-Q100 for veml6031x00/veml60311x00 and
   AEC-Q101 for veml6031x01/veml60311x01.

The alarms and the data ready signals share the interrupt pin, and an
interrupt status register must be accessed to identify the source. Such
multiplexing is not new in IIO, and I have followed existing examples
for it. The persistence setting (own attribute) to trigger the alarms
uses the pattern that has already been used for the veml6030.

The device configuration is in general documented in the datasheet and
the application note. There is an exception, though: the activation of
the "active force" mode that is required for the data ready signal must
be carried out in two steps even though the affected bits are located in
the same register: first ALS_AF (active force mode enable) must be set,
and then ALS_TRIG (active force trigger setting) must be enabled. I have
added a brief commentary in the code to explain this behavior, which has
been confirmed by the manufacturer.

This driver has been tested with the four supported devices separately
as well as in pairs where the I2C addresses don't overlap.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6030: add veml6031x00 ALS series
      iio: light: add support for veml6031x00 ALS series

 .../bindings/iio/light/vishay,veml6030.yaml        |   23 +-
 MAINTAINERS                                        |    6 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/veml6031x00.c                    | 1129 ++++++++++++++++++++
 5 files changed, 1171 insertions(+), 1 deletion(-)
---
base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


