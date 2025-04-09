Return-Path: <linux-iio+bounces-17849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CFA81B45
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 04:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DA41B819A0
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 02:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0191ACEDC;
	Wed,  9 Apr 2025 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTVijmDH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB410E3;
	Wed,  9 Apr 2025 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166707; cv=none; b=bL+QZZ/bsIXGrZuRxAvDrczfkAO62d6BSyBm9RAg14Sy4B/GHN3XMT5rqMWHBNp/KvCPofaNygPRsRclsT0XjAW5sVPsMQbIwDWL9/tLDLHy+gaJGLlxD0GcHWgYkSPLn4Io0gHM0Yt3n/SpNOWuDPkeytJLZS3rzfSyFC6QJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166707; c=relaxed/simple;
	bh=tw6H1xLtOVYh7S/iwsffCZ/m6HAPAqRPYX9ZP5qwnwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBlE+jsrhPbe5bC63UZSYoarLzN0PqXbWXeSlqsyD1JFcbR/ar1Ofj+8/roGCF8fIDencz1yRF1aXMseUnx70gHZLRoA3lYqRlGbN2yxhL5crNj3Ew8CXQC9IctEJK7mz1NxqdED3mCSC/sdBjmTIZt5W811mqiE2VuLTpzbWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTVijmDH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736ee709c11so5242069b3a.1;
        Tue, 08 Apr 2025 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744166705; x=1744771505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zx/eUsGggMkH58+ue/SK5eQbqgj8QkhTocD4L4C3oE=;
        b=DTVijmDH0IO2wV95Tu/kaPHiS6qOpRTGPNC+AGn4IPUgdI98QFj/noejp1ERQGiSYj
         Vuim/WPplj4YZepTnXsY2vGlrNPMHBlnfRw9m/kiHC+3GLUm/cI598PlHwFDtYCCMliN
         Q6GoiS6lfl51wErp3yQa3CjkfEpfm1ZHkezbliV+rdeOFasrxcWYQPTi/pA0hJhopZF8
         TWWZFo8o6eWRdxx9aTH8QbbaZXHyoKLHZJbaslVOd5A6Skjom/Dpovfw9fJn3L1d85nG
         5KBlZMYrdPH19xgAWD7M6eb9p0LjqZ///VQmEgO82/YIhnqcBfyncV+dw0rQJ0QDsYBz
         /ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166705; x=1744771505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zx/eUsGggMkH58+ue/SK5eQbqgj8QkhTocD4L4C3oE=;
        b=WL/kQ7nqe7t17QMZbKu+TptRM7v2oAPdDFhj/EAAgVIKCTlXFKWJRmF8D2nOjjjGdM
         oChL73BiYjm/LMX3YWkWAR/pN8h5PcnEhEaCRqxpVqjgqo5yCCmoHCIkK3d8SYds6189
         0CHaJS2J5Y86rR0zB9ck9x5OKVnk7prdTQxP2LW14s5AyG7OVVHq22rbj+aC888IyNnt
         cO3iLgGYKAq5oKbO1TqW4ZAq+N+PUaL93cf/uLrSIT13KGy+iN9iPOE7prZiTEZk3jTC
         UjqX5r4S8LUO13TY9o+uQQXv3pK9fKR5qd4xYsPksgTqDBOka4x8SwSyQ7lBLvTlrZqj
         ycAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW02LaZAgPnTHOxZZR2p00A8+dHc9BIMApZ9uNkdz5ujPeTlYRd3RDuYCtW3iRHjn2ScUJyGYMmUIP7@vger.kernel.org, AJvYcCXewxY2ibQmXsT7Aib0Ou/c+DRgfl3nYqKbhphQ1nuzoZcGPe+lKBpsUw4Us1QLEEHP3T+dg85sp9XC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9HSmjIAKT0VyBZbBU7kMlr6pYYghJWcCPB4BN4PvpdygQU8I
	aWOP/lS8xKsrs1lafCbVE2Fucs1r8XfuIveTLzpV2+EGOCjN2Au1
X-Gm-Gg: ASbGncuZKu0+bHFfzqMuBeLVqpV7/uZxFmg9dkXH1L2q8z2n9WGnYFkzaI1gFDT4EuJ
	g3n3yn31iy4+nFG6BWAs/zEqEhne/k3lVXTW5tmn2Dr5GgcOiClcGV307vf7YmGzbxDc1CafR2+
	wzdskxcstyGoC5XNxziveM4wDC+2sffRk4VkXN30ngj1yKAblw7W3Sv/Tiaz6EmvpjnrKdmtrR+
	xcZ4yLpkp3IZmWEtusOFhN2+XOV8lC7hbZQ9JNZzRzkmCaAE+kQtvltPYogSV1wnRkHN/uvi+E6
	jT6qwK5ZKiK4X6azIbSe47k7xhzpWT230pK/N22GX3Hiw8xPXQ==
X-Google-Smtp-Source: AGHT+IFDEVc0OImbQAR90RoF41pfJKqrYEOPT606mekoU7emBnqkiK1MsUQhiYNREH5h+6yuwK5eSQ==
X-Received: by 2002:a05:6a00:391d:b0:737:6d4b:f5f8 with SMTP id d2e1a72fcca58-73bae5272ddmr1555377b3a.17.1744166705252;
        Tue, 08 Apr 2025 19:45:05 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b02a2d3abffsm114028a12.48.2025.04.08.19.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:45:05 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: Add WINSEN MHZ19B
Date: Wed,  9 Apr 2025 11:43:11 +0900
Message-Id: <20250409024311.19466-6-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409024311.19466-1-gye976@gmail.com>
References: <20250409024311.19466-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add undersigned as a maintainer for the WINSEN MHZ19B.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 030d90d38341..8135d1bbda68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26008,6 +26008,12 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c

+WINSEN MHZ19B
+M:	Gyeyoung Baek <gye976@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
+F:	drivers/iio/chemical/mhz19b.c
+
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 L:	linux-watchdog@vger.kernel.org
 S:	Orphan
--
2.34.1


