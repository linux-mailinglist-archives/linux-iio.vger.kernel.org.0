Return-Path: <linux-iio+bounces-13529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6E9F2635
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 22:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E751884279
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68D5189F20;
	Sun, 15 Dec 2024 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqofvW+j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A342A41;
	Sun, 15 Dec 2024 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297515; cv=none; b=DEmmwscJNhwmgZ1LdxmziTGmQHmVXDobzsLJMnDMazDdUba4Manr0BzvoMo9ZT84mEG++pCuBj5iRJ1KhC3j4nQSfR+NfwpkysOfo2Cd2hn433wWeBrqa9lCzHx4Ew+3Zu5y5mRujkA5LT/H025n+8wgitixzsjSF/O61s61PDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297515; c=relaxed/simple;
	bh=yjXOmhcGF2Ow/gb9PLs66Ycy5crwSKG3I8oO4kU7n4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V0hP12Iq4Iy3k5fv9hEn7jEtQsImIXz/xNK17nrJIhbPwc6F3umJUlA9Yn8S782DvNlchqkkWuOkmHWlY5itafJ2VQAQVLEjgqfvNRvEQTgPGA/Rw309bNA3TSX7QocPsoA7hkpwgpBcruZMxwHodzoP/dCpKsH9EE51ZqkCrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqofvW+j; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4363ae65100so9406445e9.0;
        Sun, 15 Dec 2024 13:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734297512; x=1734902312; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cplwf6VlgeKzXrLCBa5YAfedqfufaukQJBqLnQAJy14=;
        b=TqofvW+jnUehTRmjJtcj2xmhhcI23Xb2WOIA/V8HsE1j46ks7MPYr2AJOvNovIB4xT
         HJfwu72IcRwRX3jWWblyYsEv/QnEjFLMrPztp1JBBF8Qpy4kUzUPYFZbD1qIZtXJD06x
         YCS0qiEv+RNga/t2eTOHl72i0+WRv427Ym0LN+TtPzOX+a1DdNK3uUJHwxdQuOTEWvDD
         2WldVDYG5uEA3xEK3BlOvzmir9vc5X7FMIWGu9nIBg94Bf0Ve4YF80niRt+tXR3m109Y
         d3JPEKOm548CNatlcoyPMwTzqDcE3zlJrp5573BdmE8CVfBMfAB13Na1ImR2oF3W5d//
         QwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734297512; x=1734902312;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cplwf6VlgeKzXrLCBa5YAfedqfufaukQJBqLnQAJy14=;
        b=D5bAJGbMnybsPtV3yguBEnrVQKqZZoD7SqeSEavrP6DV3+r4jQHzkHuhWSGKZ7JMpp
         S0rHXtymuYV7Ft27raTfQcQeXkr6tOBIPSlhiOZ2OUFaZPNlFUm2hD7TXrPDtSGJrJt2
         b1Ko5RyPTxajV5N8wlEiLYPT9zeXKmHFYcn677w+KUjc2V8pRZd6H+unP0aQqmRKginM
         BtjxsPrecKEtoC8AB5dlllDRN67+pz4iZcHA7jg0w7UZtjwHBGC+7/W6KfNCdhnixIl1
         NQfMAinpC0p5HxCJ88wA8U1qMIaJh8XemP6tvQeQLTLQn4xXYL2TGUwlrauQjaHYjEUJ
         smYw==
X-Forwarded-Encrypted: i=1; AJvYcCWt4hQ4EOZtlYKuTncrQjw6NxmUbOiPB4a3UcQ5TmFDP/WoraAbpWrSK77pLCoTm3ZCV1C8eXgzjVCHS60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmrWmdMljY3Eq6RCjfcV6pe/zbNSK8CONQ1ARc3fC5aV2lhFr
	Z9+ko82zjV+SExilCVHJCZbY3G/31NL+WazyuZfSkE4OTYavzcJXipoDmQ==
X-Gm-Gg: ASbGncu/lOjWJHC/HWqg6rbPsO5MP6XwAKn2TwHAu0a9vdnartOxiRwlP44FZQCCZh2
	TGdqW3rOKTvlWwDYivnq4VW3SaR5VThaOtX0K1dZkziICpRJvxnaVdfDUmKTjiEW0aEE/oOo95I
	MZ4kG3OiTMfPKH1u9X7wf/YYvRXjZs2Y2A9aK+kjzguvIPDENpfzcZYu/ijSZM63dP1JMXYeq32
	kjLDMG5fTm9hcqwG6fvUSiSWn/1d2lTlpwtuCxp2lYrX32CnlUrU/F5kGkJ5zQhcfKo1pBwnfio
	swISNe/Mi6SY/24H0Oh5nr8cQU9bF06Z8jvEBpwDYWRcr4vWbeTf9s9SboaSvIUYH356+rNY6zo
	pXos=
X-Google-Smtp-Source: AGHT+IGSP7xylQ9nwfcEWkXJuujeAPD/nRwDLwLgpG87QWYkfxIXtT/FQNsQccdwyPyWN/qHEaZMRg==
X-Received: by 2002:a05:600c:674a:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-4362aa37154mr101517385e9.14.1734297511454;
        Sun, 15 Dec 2024 13:18:31 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a6ee-1b0b-f819-e82c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a6ee:1b0b:f819:e82c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c82sm120120585e9.35.2024.12.15.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:18:31 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 15 Dec 2024 22:18:21 +0100
Subject: [PATCH] iio: ABI: document in_illuminance_hardwaregain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-iio_abi_in_illuminance_hardwaregain-v1-1-d94a59efb937@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJxHX2cC/x2NwQqDMBAFf0X23IAJ9pD+SilhTbb6wK5lQ21B/
 HdDjwPDzE5VDFLp1u1ksqFi1Qb+0lGeWSdxKI0p9GHwwV8dsCYekaAJy/J5QVmzpJmtfNlkYqi
 L0uwxlsyxp1Z6mzzx+1/uj+M4AUkD11F1AAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734297509; l=1170;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yjXOmhcGF2Ow/gb9PLs66Ycy5crwSKG3I8oO4kU7n4M=;
 b=rIky0/qRj8PGaYe1kAEL6JO/BG/2x/S9Seq+Y5mMzhZL/6yLe987BRHjEl2dUTVciUYo6SmHZ
 BFj6w9SswL1CeNqADU4XszvmrdZ2pBlNd+wVQwx3RnX2Ij7i17GdKEg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This attribute is used for the vl6180 (see vl6180.c), but it is still
not documented. Add it to the _hardwaregain list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..c044f1608ba9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -681,6 +681,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_hardwaregain
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:

---
base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
change-id: 20241215-iio_abi_in_illuminance_hardwaregain-9e024b9dca90

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


