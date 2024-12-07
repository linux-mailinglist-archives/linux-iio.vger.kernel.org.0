Return-Path: <linux-iio+bounces-13193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812E9E7E34
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 05:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD99C16A90D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 04:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDC4C3D0;
	Sat,  7 Dec 2024 04:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="auE4ViWe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0C82C7E
	for <linux-iio@vger.kernel.org>; Sat,  7 Dec 2024 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733545855; cv=none; b=QAwPIYsg5ZtiJuXNaqXqx1q4h/aChHM++P4QPtbfsFghkmF+1CLSCzYjvJmQ16XvgV+lkbb80Cufz/RzRI8mDV+zS/ryszpEotGq+C91r3uiLfh9Gg7vWkNoR29M4x+jfkP4Qj/X8r+PXxKoxQhrf/WB8Yrza26p3DLUPVzE/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733545855; c=relaxed/simple;
	bh=VLjCnaWkCYXYmZe0hdq42GhTmZTOPnSeqq+v+GhcVIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oxqeq7Tfp+ND+ouSccveq0mDY08+MaQIOtEuHO4yqCi+mKFfUpUbzXMVyZ6frnpDUUydwt5ZemFOJlonHBUUyrfwCSkPIVrU1wWtDnK93E1qA8r5/3knpLiUKXCnLoeXmX1Fv2ylFEuEaW0rqZCAk3K3UgsaPBsZroRzBo+lkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=auE4ViWe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215ac560292so27077225ad.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 20:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733545852; x=1734150652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lq4YWN5y5TmzHjXTNAtd6DRXO1iqJQIXOPm5MGyln9A=;
        b=auE4ViWeg4rPfm/9k6eqDn3wA3AVUDEV1M9TuLwLbEeg3vaYd3BipEC9o9tsgfyj8R
         IGvFLLqzZI8EeYDTFgWn0/+D7As7OtbNrqRFq5nhjleJ+2RF+gjJ3bDukHer9V2NZBec
         zvq+X94yeBRU/zKXSCe2cTLDS+T3ighEqPVKSNGBc+RTGOq1qyh2ixqrbb5jecWNJJb2
         skoCVlV2vM9sWO4U2yUMwH7n9niGkwU4Rh/gklMZzrAtpCDjvknzfc9eE0tEEOdEwUvy
         /B8gbE6uzxY4EC+cpd1NPL89vdXYknKY4Y1COXpZTGy5VuuGmyrtvrLpyZ9N+AjenWn/
         Grmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733545852; x=1734150652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lq4YWN5y5TmzHjXTNAtd6DRXO1iqJQIXOPm5MGyln9A=;
        b=YqTfp7GzKIXPzRQpL7UGKYss+Jk4/om8/FL+7yi1a76L2iLGpToSHjmVv6bS010Mer
         jM8PlA8p4irzb5feVsDHd6WbOYENIycwHESwThhkaG/VIzoQz7jxfFy0bH20t61Tb1Eu
         KM0Q8fImhtku0+CJk2nuPpxjN4DFchlQyQb4ERsM3H7afOBslWckQoyrWzycon8ayWNV
         9UtSXknMNMee0FBN8mxIsJF7sxxLpLCSu6TY9uPaBkECSI4tdAqgfHIgU/mb3KGSOZfb
         tD3ELSFGuNCNFonVVtrHNoZc+adRu05Bg/7z9iZHsz10Uv1Y1hcTwTY38MRjCJRyTpxg
         L2SA==
X-Gm-Message-State: AOJu0YyQE8rAKEVmGFfFb6wWdWCindODzBPdviziVmjqwxTzSxCbSSnQ
	2fCXIQtZ3OGH82fiwvTp4ntEesoBUrHPrpr/2eXCFBVhMZFDrWZXrnwZiU5F1RbXA863kdImo2H
	JtLgGCQ==
X-Gm-Gg: ASbGncs+T0sldZhFbHcVNA/V3Is/8Rmj2vCEUR0iotZlSUOVdahpIXxY+wf/YZl1ezw
	Gw8gcsdWt1xNxG3v9etPnnp/pv6e6Iz1MFeXu6hasH/Jb9uTK3aCeiA8gXaciPBX+KitE5jkOY8
	88MwdlvHF+G7pn1cptXYIq6bv8fPgdgNb2qWpcM3F3nOndNSlld2JdqKWqBIPZZeczmaciweKTy
	86m3MPerMG5hVqdZ26OMtMori4qxkQMQJmmToafPZJpyFyKly/SRT0rQYqVbIBhL/SPeUELYgGK
	YleEN+/IKTtnUp/6pPgIDQO0O7P9PGrKKsMj
X-Google-Smtp-Source: AGHT+IE8Yi0yreQPxMznoMDGBLJPhDyZwwLrumvYD8+bNRrLhbEYVveANvgK5VjJHQaG3NBQWzm2Yg==
X-Received: by 2002:a17:903:2447:b0:215:b40e:df60 with SMTP id d9443c01a7336-21614d81439mr90629345ad.31.1733545852602;
        Fri, 06 Dec 2024 20:30:52 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3ec6esm36117005ad.52.2024.12.06.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 20:30:50 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: jic23@kernel.org,
	lars@metafoo.de,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-iio@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] iio: adc: at91: call input_free_device() on allocated iio_dev
Date: Sat,  7 Dec 2024 13:30:45 +0900
Message-Id: <20241207043045.1255409-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of at91_ts_register() calls input_free_deivce()
on st->ts_input, however, the err label can be reached before the
allocated iio_dev is stored to st->ts_input. Thus call
input_free_device() on input instead of st->ts_input.

Fixes: 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens without TSMR")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a3f0a2321666..5927756b749a 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -979,7 +979,7 @@ static int at91_ts_register(struct iio_dev *idev,
 	return ret;
 
 err:
-	input_free_device(st->ts_input);
+	input_free_device(input);
 	return ret;
 }
 
-- 
2.34.1


