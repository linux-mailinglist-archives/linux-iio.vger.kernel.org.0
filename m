Return-Path: <linux-iio+bounces-10668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F879A14F1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874CB2850A1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB621D2B35;
	Wed, 16 Oct 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg7dDesa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514711D27B1;
	Wed, 16 Oct 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114787; cv=none; b=K5kjqGYugETRB10a2fTeCG4YFVxsdqVwStQkP2rflbxW1iT1ikBXpoW8txdsNzDVES/y5926F6qnR7QGAMAX9BBa3VCwbgwbCC2OBDiXer3xWe6yDGlHEAw+i9ji/BH2Q1XqkPasjZ74Z8xQ8xIy1DEPu1P3MrjkSabMymxsKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114787; c=relaxed/simple;
	bh=+ilbKW5/Izw+Tmnn15mQvwvMmPEp3T3X16iSSuJvEQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qHQbLaqKqAOR2Wx0OaA8jNMurJyLgMPIhwEHcBqwzcMox83vwSlY8nnVrQmXG/nVTsLdWzDpZgYruB9PHXRjgw7akXS718rhfhhpomXjV94hwj8IYr2NoO7768R3que0DHaOIdCFnzA7xuYmciiuNhaNOMYUS5KItMMqZ1+oBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg7dDesa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314f38d274so3883165e9.1;
        Wed, 16 Oct 2024 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729114785; x=1729719585; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27bU3p4hbLImM8qPVdk3fPQaa3aADWP46pmDCK9Bc1s=;
        b=kg7dDesaVj5uLLLGixhHcLmbUMNUMuDvjX35BaB8+woyyPcCDhMBF6OIbPR0klGGxu
         kf7eutNkx836Exzcu8bHOBt4K2kssLxlsvrkZXEthErq+sSB69BNB/HcB5suiWTX7q7c
         tqnU+e+7SQn7xllJ8HfwlhFBbVqqGN9PvrEoaH69qMn9NRT6X7ZvtUW/ndddtmqcb8sq
         J5Cj7EGTFAIxdlkkmUd5j/G/pcFoOR+HvCqI+Bd9Kaqw8VibI9qP5oZEGUQFDrBkdTIh
         X17CrmhMgqaKzZX2/uLI3vD2QpHoN5FVTckrSIrnNGDPd/FqIN7OMHDvS8L9u6OP8gE/
         iGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114785; x=1729719585;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27bU3p4hbLImM8qPVdk3fPQaa3aADWP46pmDCK9Bc1s=;
        b=jnbY3uWEa1sz+gInBc43kfJWrNuRLxEOxit1T9M4Q9e8tjvdsefGa4OY+uoQ6nRDIK
         qXQrayah912pfi709WwqvqBwLYPzBaOxy7BRs/uc7YPPXhiEUOkWBLeL0/dSltrb5a84
         c+0uWnR5GgzoG17w23LIpjcyv7faFpv+abW/u36ms0AYunPRVnBcA3xDMREtEx/gvHT2
         +rM/7mINAMU8ghqS6tAZWzQvnRIjtWGEnwClpKJBb7HV21WX4f0QYjfOb+UmFHmJ51cI
         1ICRQr0+MCDgcEul0WgJcShCfPnSMxm2FSJ3TZqAUayH7ihDCSaqq/R9hmi8zW1oEipg
         D0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVMefDjNH+rJK7UuyQeRzxCBMpaJKGCAFuhjE2BQ/uYD11TvnmFQ+98cpPp3t2dgY7OqAPmh8uWU3Rr@vger.kernel.org, AJvYcCVbqfVrsgfNTy1YbcGS0vtuRFDiLopm2V87XM6p2gGfFes4gcK1yuvinLqR+Rf18m+su2Dr4wK5p2JL8Tx6@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIr/M/LrP3laXNwIpVxVdvu03UnpYvdYzXrnrdI09olnbhgU3
	3vl7x68mT7h09/i4EA8U1XezLoWbXTDkIiY7FK4YAVdKOsUCLBOr
X-Google-Smtp-Source: AGHT+IFGKG8zdbvzgT1YY7YbW0uAm06Q8y4QnxhSnnJVWUzObETGUdA8ErF1Asc1Iap4bHPzZnDHYw==
X-Received: by 2002:a05:600c:4f4f:b0:431:518a:6826 with SMTP id 5b1f17b1804b1-431518a6994mr30295085e9.19.1729114784386;
        Wed, 16 Oct 2024 14:39:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-33e3-844f-063e-de99.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:33e3:844f:63e:de99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c37f36sm5632715e9.7.2024.10.16.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:39:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: light: add support for veml3235
Date: Wed, 16 Oct 2024 23:39:30 +0200
Message-Id: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJIyEGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNz3bLU3BxjI2NTXYNEYwsjM9NUy6TEVCWg8oKi1LTMCrBR0bG1tQA
 QaMEAWgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729114783; l=1707;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+ilbKW5/Izw+Tmnn15mQvwvMmPEp3T3X16iSSuJvEQU=;
 b=Tk+beh3m8ShkbWr5Of5CL+Kd+ItVz/0vM0FOe8pZVQjtZPzDskyGkTYSHvXP94//erBG119hJ
 2c/6S0/4FfHBo8cE1Ah3u2i435/XGaSZwII7wSyqQ2lN0C2tM6MtooN
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds support for the Vishay veml3235 ambient light sensor
with I2C protocol interface.

I attempted to add support for this device in the existing veml6030
driver, as it shares some operating principles with the supported
devices. But given that the veml3235 has different register addresses,
bit arrangements, and limited functionality, it ended up making most of
the driver kind of device-agnostic.

Instead, the proposed driver is based on the recently updated veml6030
with multiple simplifications and a few clean ups (e.g. regfields,
right definition of shared-by-all info masks, which can't be modified
in veml6030 as it breaks the ABI).

On the other hand, the dt-bindings can be recycled as there is no real
reason to add new ones. From a dt-bindings point of view it resembles
the already supported veml7700. But if for whatever reason new bindings
would be preferred, I am willing to provide them in further versions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6030: add veml3235
      iio: light: add support for veml3235

 .../bindings/iio/light/vishay,veml6030.yaml        |   5 +-
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml3235.c                       | 534 +++++++++++++++++++++
 5 files changed, 556 insertions(+), 1 deletion(-)
---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241007-veml3235-0a38265e9bae

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


