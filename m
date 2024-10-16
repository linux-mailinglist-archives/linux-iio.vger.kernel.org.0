Return-Path: <linux-iio+bounces-10663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09169A104B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F60281AFD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21420F5D1;
	Wed, 16 Oct 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLb+27Qt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBF136358;
	Wed, 16 Oct 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098278; cv=none; b=qYc5IXV0g+aW4608CLgHJdLsYigf2LjBKsvLvhIcGYc1RqLc99WoEAIZZ2xcahYRQ9U2845wG8O+dvowlXULQPrrLeb5LCkEnHW8wVQiElKDJYkGYaLH8YdVSOkClIkgn6UMvwzEvJ+Ep9iJ2MwAUS4bF/d304GARed4DY01F6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098278; c=relaxed/simple;
	bh=kcB/YzNajviFCtfzBnOBHr+U7b/AsbG1t0t4RCfqxm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ozz5yLXuzBuhZTa4ETlGmUrLfriuh7hl1Yus0iZpA1yQWUQKNh6Civc1N9POMQ6K6MtwGxuvrrkFVK9DxXybd+BXa6LCrcC0+nfMsOB1QnZsfzUVhhpgEdyiKl4sfRUk7ZSVPT5V5+mUyTT2BJk5B4Z/3SskaZ76kgTNbG3FKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLb+27Qt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d808ae924so6869f8f.0;
        Wed, 16 Oct 2024 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729098275; x=1729703075; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P08mcokF3tnHnUdGZEWpRqKlXEmDsB19KTc81gbPrvM=;
        b=MLb+27QtB5ElvH0GCsHUVEcqSL8DCgEPOyPGR+hVpEgeugSRFW+Dom6UD1Bh3FrSHu
         F71zIzzUPC4ZLkBjuXMsf/v3YrJfCgbPmHzHbYOff/M/AX982IMXa8ItIiENcOmAJtXb
         fSKX3UKGdElyfrh29vvXNH1ORWFHsJta1h05InuuPkhteoqNaZSN5OISd5zqzhE6MWjB
         UQwLY70kCDl0MMAvI5GnkK0zxeuDj0dergPw38MwJuI4cyU/hevPxHHrFXVpNQay3me7
         er1HGFvDE4g/Ss7x3Rwe3IcIf7tfBt17O1tfViN9tBBWmh+iNs5gBJXD8Kxf8Lsb0rDs
         egbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729098275; x=1729703075;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P08mcokF3tnHnUdGZEWpRqKlXEmDsB19KTc81gbPrvM=;
        b=NUxX0H9n7+QI6+OVirBGZ1E2gp6+a6LY1Qscd+ZmtPT3IeAinlKthmfddZAsnsIaCK
         oURw9rzWBqiJR4pIfLvi/V8ubjtqj59lvJvNNj2L0GnklhgJL3T0O2kYB2bW0PIByE1P
         TwrjxG0B1eJRH9pSNowUGXmZQnElxEuvXPDOOrVsDJW8Mqrv4BZC/bppRe9t1dLJfPby
         /3MzWQfj2Knt+CyWIMQXTf6LMpe/pz5LpeySWbRkAV8Gr6SbWgeFRXf7VMOsUAYf4j6a
         S+EGtA27+sWSdKlgAqqGgFYs7DRaTz+jjZJY4g9Iae3W2pFupadZaz33W8SzpwkMX2f9
         c8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjKsHq3MWksCU1LFfTUokDemqLgkhjRjax+6TwhZPrUWZhhOqm4mZtTKGW5YLnuH9mKt9RTb5fFWA=@vger.kernel.org, AJvYcCUzSSJk8hdE5H1/Ke+dLHLxx1b8B7ozuRYOOVnVy1n5tJxnfHQzfDjk21zkJoy/NhEfRYkrC8Gh@vger.kernel.org, AJvYcCWAMhTPcwSlERGb3gT6OkVbmheUqxyzsurzGQNkJZMU2PnuYi7qh90XUsjkol41YDYj2A4e2Law0zo0nuZc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pnA0S0fSL02sDWavsnBsCXAhTbpmDuUNtJCUHrjvCbl3fU8C
	Wq/mq7H+Z9s58WC/rUkzzmLctgSOFdefZR5Pgz9WJCt0H/2VvVlC5FgiWw==
X-Google-Smtp-Source: AGHT+IHbFd8Z5bwxuthBcMlziOgmWykdpd7TiV2cyqQiMyd5YK5D4CrALefqEeFU7g6RINmYk4GAVA==
X-Received: by 2002:adf:efd2:0:b0:37d:4527:ba1c with SMTP id ffacd0b85a97d-37d86d599c5mr3445108f8f.49.1729098274504;
        Wed, 16 Oct 2024 10:04:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7238-7970-7b90-44f4.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7238:7970:7b90:44f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a055sm4842390f8f.1.2024.10.16.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:04:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 16 Oct 2024 19:04:31 +0200
Subject: [PATCH] iio: light: veml6030: fix microlux value calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-veml6030-fix-processed-micro-v1-1-4a5644796437@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB7yD2cC/x3MwQqDMAyA4VeRnA2kzvawVxk7SJNpwLaSgAzEd
 1/Z8YOf/wIXU3F4DheYnOraakcYB8jbUldB5W6YaJoDhYSnlD3Rg/CjXzysZXEXxqLZGqaQmIh
 jjJyhLw6Tnv33r/d9/wCNGzllbgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729098272; l=2074;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=kcB/YzNajviFCtfzBnOBHr+U7b/AsbG1t0t4RCfqxm4=;
 b=ZfFvcJeR6Ju7H8ZBMZv3g7I0G4ApH4xDJ+Cksu8rNogieLQHxkPvCNa34JE4J33VB/hCht1ED
 xYMIAfVK2iMB3giJQkwTqmjd0EPhETdziYEUvQYtlhguhpvxoP22kkX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The raw value conversion to obtain a measurement in lux as
INT_PLUS_MICRO does not calculate the decimal part properly to display
it as micro (in this case microlux). It only calculates the module to
obtain the decimal part from a resolution that is 10000 times the
provided in the datasheet (0.5376 lux/cnt for the veml6030). The
resulting value must still be multiplied by 100 to make it micro.

This bug was introduced with the original implementation of the driver.

Cc: stable@vger.kernel.org
Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
I found this almost by chance while testing new supported devices. The
decimal part was always suspiciously small, and when I compared samples
to the expected value according to the datasheet, it became clear what was
going on.

Example with a veml7700 (same resolution as the veml6030):

Resolution for gain = 1/8, IT = 100 ms: 0.5736 lux/cnt.

cat in_illuminance_raw in_illuminance_input
40
21.005040 -> wrong! 40 * 0.5736 is 21.504.

Tested with a veml6035 and a veml7700, the same will happen with the
original veml6030, as the operation is identical for all devices.
---
 drivers/iio/light/veml6030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index d6f3b104b0e6..a0bf03e37df7 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -691,7 +691,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 			}
 			if (mask == IIO_CHAN_INFO_PROCESSED) {
 				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000;
+				*val2 = (reg * data->cur_resolution) % 10000 * 100;
 				return IIO_VAL_INT_PLUS_MICRO;
 			}
 			*val = reg;

---
base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
change-id: 20241016-veml6030-fix-processed-micro-616d00d555dc

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


