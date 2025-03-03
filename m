Return-Path: <linux-iio+bounces-16294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52653A4C39E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 15:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64E218933B0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE2214225;
	Mon,  3 Mar 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTJX1luz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B621420A
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012805; cv=none; b=qnN58reWjI9Hc9+Zy0Ndu+ADoO0c4VYT6SaT9aT4OW386vLiiop2oDsR2h1ptJT5+7dT7+ApDiW5ue96qrxqXHK/ytx0JfLod6qobVGe56+BaSdGgW5gpw7/igdtjw2BN0k1XCw9efNoAtQ7k0l+CbqIMJAc3ibplD0b/ykBKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012805; c=relaxed/simple;
	bh=huTITU+3NLOlGIQKUO1Q57DNwMMY/Xb18Ro9MUcuAZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oSyo91ebKXTfmxTsBm0jzGFEl/AV98tU0QQ0L6kKOOm4c2yG+TijSai5M7ykdCSbz0KjjJLq4PbDQdG2weVyoInq1Ziw2tDIAa4bgCbgiIlKnP2uRAv1MKG3JxCkwDHp0FvtdQLv0atdcMl2ELQ6VROj37elJuYS2AZEKvRQ43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTJX1luz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f403edb4eso2599475f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741012800; x=1741617600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCvz2PQitaL3G15KvIJkAOr8tNO1gvVwjPom0Ibxufk=;
        b=dTJX1luzeTmtWi+dFz9agN48SvJXrKpiLJhBzXIU4vnMm/QGn9sE1ebGiC2PWA4Vm7
         W+byrAciKvEzUmYrnNZnVTvhN8H0i6Enllf4Um9v5AnDxpbSnnqJEth9ze/KBUntGs7y
         ZeNQENI8t1kg3TiO/bQgBZDoFe/B66F2AwEy9TOEF3e5i99vVIrwmxG2ZWmkyM3zr1na
         Ir69Z7r3ylWpWVLJXEzraoDHnMiWiY0ok8UdcNDiQk8wkB8qGfLWqaulKvAtqX6zxxPU
         nI4N+p0rNJD6T1fInxNHi9IzyP6T5nR1r1P8GgqRZ/N3dlcBrJg93oKDT6vxow5Rif2w
         xgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012800; x=1741617600;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCvz2PQitaL3G15KvIJkAOr8tNO1gvVwjPom0Ibxufk=;
        b=oeCwzfhDYX5+q5YTMq6Sv7uZgkb5MiOZ6vhm9Rl6uhzPJK4QvY8QwBXa6a1Lx3eNFd
         C1gaXSNyktIPG7HSYFDmCq/LfypJcgz+wu81X96VlT/9oGhqAcMI/DdYU5Or2AD6U0OE
         E18nQBnSDnNv/8KWk7O0tbL2a34lYRnpJIbXsoVLpWibgslHplx7IbO6OVHqO/J+uslQ
         L+ORQK0CE1+jTiQ0MEZR4kKOCCH87I2MEIdAqfEoKoFP7FRelJf+7K4NlxXUaE0qyEQ9
         EW6DcIPM8p7f3+LVO2OCUV0grlO/0OsVjZBUrPXI1W3483NdE+ir7nqwsWlDbwWN1tD7
         9Meg==
X-Forwarded-Encrypted: i=1; AJvYcCVTG/pUkKlMMjgdjVmzSjhcsQv9V6/lzk9PbBv6Q99TaejYd+Fh0i+FnWeNqLhhSS8OFGdUKS7Bxhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ca7cMlKfQNbRnowyErKLPH9Z3W1yTNxf5TIiCcRLR7rxjFY5
	ImPY3EbwWA/ISTy7AMZqiNp6nUcWia92TqAVarsuJaKydqzez8z83oA7Ao492N0=
X-Gm-Gg: ASbGnctRHY/KDfFTIY5WjDK42ljVGtF/phz4wIyoCMipUcxeKjwks2+fspw9i9u1hCu
	1K9Kj75oqDzgtd4KppIsZIb8taXQQUxBi4kH8HrrxGUluDmy9ZDxq81g+spQxtiAeTuc4PwtAVV
	1B1pEW2LZajJaji7nqGQntGl1HaV0fC9S9NKj4jbH/YhLqMJ33kDqwX8pWoPcbUKJaHqLBFpwFn
	hchJGSk5/iBZk8/VZDnufsNN///gSLpcCqoDS4/LRBakJhVQ/IQxxR16cXXN+s/jowz+6fycQka
	y83QeCbZDL7CBTRODgvtNUcGfHVJ8HGCom4+cOl1dEv8AbLju0Z0Zzi0y4wrs2EKwlrn4A2H5+s
	8XHMSZenp70/NasWCxAC2wMREJ45N
X-Google-Smtp-Source: AGHT+IFGoay4YJM6YSXz0DZ05o3quafyCNLOWh8vQu4Eq4apk6qCX8ogXLL13gs5Zle+ply0NrLrLg==
X-Received: by 2002:a05:6000:1f8b:b0:391:ccf:2d1b with SMTP id ffacd0b85a97d-3910ccf2dcdmr2532910f8f.49.1741012800564;
        Mon, 03 Mar 2025 06:40:00 -0800 (PST)
Received: from [127.0.1.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c43sm14394801f8f.49.2025.03.03.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:40:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Mar 2025 14:39:57 +0000
Subject: [PATCH] MAINTAINERS: remove adi,ad7606.yaml from SEPS525
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-v1-1-a4e4f1b824ab@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADy/xWcC/x2OywrDIBAAfyXsuQs20Qj9ldKD0bVd8BHWEFJC/
 r3SwxzmNHNCI2Fq8BhOENq5cS1d7rcB/MeVNyGH7jCq0ahJTZgdl61D0lAo153QBe7YWc34dTl
 hlJqx0drMaDD5gL6WTWpKJLhYG7TXSzTaQY+sQpGP/8DzdV0/McmlB5AAAAA=
X-Change-ID: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a
To: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Remove Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml from
STAGING - SEPS525 LCD CONTROLLER DRIVERS. This was likley a copy/paste
mistake. There is no bindings file for SEPS525 since it is only in
staging.

The removed file matches Documentation/devicetree/bindings/iio/*/adi,*
under ANALOG DEVICES INC IIO DRIVERS already so wasn't just misplaced.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This falls under FBTFT which is currently orphaned, so someone else will
have to volunteer to pick this up.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0e33544fa373a4978b7dae18c040c..215dbaeedced8473b5b339329b3596a2fbfd13b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22512,7 +22512,6 @@ STAGING - SEPS525 LCD CONTROLLER DRIVERS
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	linux-fbdev@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 F:	drivers/staging/fbtft/fb_seps525.c
 
 STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


