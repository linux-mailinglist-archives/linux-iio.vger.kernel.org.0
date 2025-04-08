Return-Path: <linux-iio+bounces-17836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5ACA81726
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200037B0CF2
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE724EAAC;
	Tue,  8 Apr 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sYj25Yay"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788023C8C1
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145436; cv=none; b=WoVt38QUuOOKOzBuJH4KBDHfjqn3dD0SeqqtPi+kT0TTxRaHDG/XR9YSkSfxNS9lStI5L/JGy+wZsqlTUxGg0XeCL/dFi6ppQH+pNrNF0V3O3jUyIm0n6yYwJjrdVUl4NeAFHQTiqeoQaOKVLvBMUPbhe/Xzlz1+fHs6dsYWEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145436; c=relaxed/simple;
	bh=8P9HdtuuJEcYjisIpBzJjU4A/0Fv9PbdTpy10z/2Wwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dWl1W2NkZOCLkLRT0iFeMHdLvtB1xPbhtlY8Xw0/k0YCmfPVBtMt97fH7MCaEp5nVVoIlYUpyEfOdxtHFY5OywBWhhweXMDuTU+pdC2X1bFFx+OBdhaoPcuUJFrg9M0Ba9HeO2DzsqX2qBmqqzHUZYkFkMb9JR3fK7epajyYOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sYj25Yay; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so5029874f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744145432; x=1744750232; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISeBfv1lorqaekgIceJMICGTv4GtIv7vI6GAFDIKa+s=;
        b=sYj25Yay+6M0fYGj322VyqjTmQoJZ/a7NXQpdXXCOSf9i6rE7ii5GpyIUZ1WYUZin1
         XpEJad8WwhLwzvjV2cvxvUZVYktoMpgoElFAaZdoEX8RfXyoBJcYZhwNJlN2fDJYDYm9
         PGUvDisSa99StrJ9wn+LCkQrj0506qcN6YunLVWbMeJFGbIX/r9DKu+ei3BK8JaCPHnV
         DP6Kub4LmN93Z0aPHFdgQjs1T+nR4hKAEKiKm996ydnqvCLcdeaI4JLpUPbePHH9vRyS
         GxHFuFqYcGgqccvPLlQXWu/i9Mmqw2lT3Gogx/nz6szMzotF2dx1c+nwdK6Vr18LU0kf
         Tpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145432; x=1744750232;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISeBfv1lorqaekgIceJMICGTv4GtIv7vI6GAFDIKa+s=;
        b=pBdBW4XNYk3fq5o86Pfg7K11jS0Nen+A/7zbCY5A0FE+MogxWUgABzlGTQ3Ljt4ya4
         yZ92pf0bj09AifJp/e4LXLQa7nEhhh7arBuUCF+mSqfLtbgw5za6lGBlpUi+gt5bFKlN
         HfjZEb3VLi04zU8CJwZfjQLtcg+Ajw3aWHPMtSdzVpVf9oPiOE2124HW2zv0R6yilDRh
         Z/YoxO8inKjnIV91w8w0Is6K/vAg4+5FPc24cQYB1w0gvDMoYSQ7QfLxGbwWBTQzupJH
         t27EEJNJ9iQjButjUm1FZvnKQjW036TaMipjALLgJ5o/pR4lgH4kU/WGaQsL1lhEDaru
         yXVA==
X-Gm-Message-State: AOJu0Yy3E3FMvTiaCLn8KcR/cqnOVmve4BSi+I7GUInPv1sseRuojYIo
	SYsyWYV7dou236PoWAW5lIksJD6N8Tiwrvd8dNhw1o7XGF+S5KLX7/5/C0uxkUY=
X-Gm-Gg: ASbGncvc2VND3Dsic6/bCVdo96BOfqFs5VxX1l4qLjpuRv8jBY5sWrBjO3yA1Ki6sJc
	PiPHtwwVliTH/cA7gNSyAMrjaHSI0iH9P7oDbkhtuUk8u6bvCwtjp4tdGWkcce+slEsMeCAoLJy
	tBbe4pau9AB5il/WW0W37OUks7ogsZgCjfYBHacha5rZMyRKcbV0/dUyoJevBFT0bGZqFIWS+Pk
	XH0yL/iRcaB3BF2e4UwR+WyuOChAX/n5Dc3eO12l2RH/wnuNGQ4/rG3oAsbjFzRA12tEEENyWOc
	00AgTM9rd81oeCUDmcX641LDJHk9nAtnYVlKRWJcWhkuwsUNmhJDGqz+psW5Sd5gPEzYGGvpAuM
	rbcTc7jEyQKd/iwwgGdWmXJfH2/9j0wtb
X-Google-Smtp-Source: AGHT+IG5W28GZiheanSviQoo3X3XSZbhL0agfFNkdxCO9+pBFRUz1xd/X+1aybGSx+mUbqFZukSxCg==
X-Received: by 2002:a05:6000:178d:b0:39c:16a0:feef with SMTP id ffacd0b85a97d-39d885617e8mr103923f8f.38.1744145431309;
        Tue, 08 Apr 2025 13:50:31 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226da7sm16367156f8f.98.2025.04.08.13.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:50:30 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
Date: Tue, 08 Apr 2025 22:48:59 +0200
Message-Id: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuL9WcC/x2MQQqAMAzAviI9W9iqE/Er4mFzVXuZ0qEI4t8dH
 kNIHsiswhmG6gHlS7LsqYCtK5g3n1ZGiYWBDDnTmh59bJwjxUVuDGdGZR/ROqKOaAmRApT0UC7
 +347T+37aals7ZgAAAA==
X-Change-ID: 20250408-ad3552r-fix-bus-read-1522622fbd2b
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=8P9HdtuuJEcYjisIpBzJjU4A/0Fv9PbdTpy10z/2Wwk=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/2n0o45aYa62LS1JW7YIepQmeyTaqlTcrz/DN31okP
 p3DUMu8o5SFQYyLQVZMkaUuMcIk9HaolPICxtkwc1iZQIYwcHEKwETydRgZHv5+8vduyevlYfEn
 XDvsGxXedwSdnGXpYB9045Ht6gNx+YwM3yYed7RKy089vpYt7PI0rYr4/44cEdfevn0w4e8bxsw
 SXgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

This patchset is intended to fix a random wrong chip ID read, or a
scratchpad test mismatch, tests done in the ad3552r-hs driver probe. The 
bus "read" operation must always check for busy flag before reading.

First patch reorganizes a bit the busy-wait polling code, second patch
fixes the wrong bus read occurence. 

NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended to be
applied after the linked "ramp generator" patch.

Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (2):
      iio: dac: adi-axi-dac: use unique bus free check
      iio: dac: adi-axi-dac: fix bus read

 drivers/iio/dac/adi-axi-dac.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)
---
base-commit: 6fb85f14853ddde06d57030c753168402bf69cd9
change-id: 20250408-ad3552r-fix-bus-read-1522622fbd2b

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


