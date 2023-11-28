Return-Path: <linux-iio+bounces-472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE97FCA0B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 23:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43593282E31
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8650259;
	Tue, 28 Nov 2023 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZGFT/Hb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49CC1A5
	for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 14:56:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso9165425e87.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701212194; x=1701816994; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xuLFYcf0TNvhnaNMn05DlMPThucmO+PUnWnxmCggZI=;
        b=tZGFT/HbWTpHlL75cnWG0tt0A1z3WRQZ/iZFFMk35F/smV9VEHedJ5mruvYrsLjVE7
         9OaWddlsWpuYLtn/TA4/VYcmU0hEf6stJ6GSeJjFwvtH9VQdpRc/OFemWcGHl6OlHIdW
         VCktzHCfrB+kDYPwLJmmMwUdKZaU99YWvAYr/0KqIYJgZsrSpjJfX7CZjRgwsRD3v4n7
         p5Yu2tMvdQfh3eoq+zzG4qYrtRzek2KykG/2eJ6pyB/rV7kG71/VVqfiwr1dmkax3SHN
         R1AjFzmyETgqXlmrJxNG3tiNDdYz1iSEfQ0vMGVEIS6FS7vOUWVvfDJi17jOu5oSIXYt
         8OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212194; x=1701816994;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xuLFYcf0TNvhnaNMn05DlMPThucmO+PUnWnxmCggZI=;
        b=U7EO5G90uVtzTv0NfwnMcXlVrex0dtNSZHf/w6kss9Iy0vlHwixgKffN9XEYlUfrxB
         CXgAcysZQHdVDQCpLFYsSiIxikxe8XV6GsSeXrX13xt20eu2eS0YapmzB4BVsNn7NFFu
         ecnmI53ZiQfz0t38shE9Jpr9sHX6cYpr11Jbo8SU21W3L7nc/P9ErZ85hbYsfWDb5Xeh
         vNLj7j6/p7w9o5VYwSEostw824tDJ2FN/eWc3SgzCANmypecSazWP24zHIuKvZbngSfK
         7xRD//30qXKtwlXxq+Tu694IbWfoOVeZDrjYpdEy+yPoW3Bhxa3elUZB5VBHaYLj0hoR
         dTAA==
X-Gm-Message-State: AOJu0YywMQMLDqrEGjhVpB6kVmYqeXJiKhafXH/ssXV56RM/CygccipU
	dsIe97HEy5mMp1nizbyB57Mu6g==
X-Google-Smtp-Source: AGHT+IHsR0VwQA4IHasXgAGq/EHOQVJtBo8gaHlxH/zBpSKVYWB8W7dA5ok7G4m3yTpFtwdPU9zyvA==
X-Received: by 2002:ac2:4acc:0:b0:50b:c062:92e1 with SMTP id m12-20020ac24acc000000b0050bc06292e1mr1513725lfp.6.1701212194002;
        Tue, 28 Nov 2023 14:56:34 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512309400b0050aa9cfc238sm1963698lfd.89.2023.11.28.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:56:33 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Nov 2023 23:56:32 +0100
Subject: [PATCH] iio: proximity: irsd200: Drop unused include
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-descriptors-iio-v1-1-da1e94755db6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB9wZmUC/x3MQQqAIBBA0avErBNSw6KrRAvTqWaTMhMRSHdPW
 r7F/wUEmVBgagow3iSUzgrdNhAOf+6oKFaD6YzV2owqogSmfCUWRZSUGzpnPK69swPUKjNu9Pz
 HeXnfD9ntx/FhAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Waqar Hameed <waqar.hameed@axis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The driver includes the legacy GPIO header <linux/gpio.h> but doesn't
use any symbols from it. Drop it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/proximity/irsd200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index bdff91f6b1a3..323ac6dac90e 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -7,7 +7,6 @@
 
 #include <asm/unaligned.h>
 #include <linux/bitfield.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>

---
base-commit: 05b5bdf18a6ba2dd9db82b6296d4edd6465b6210
change-id: 20231128-descriptors-iio-67062aeb4637

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


