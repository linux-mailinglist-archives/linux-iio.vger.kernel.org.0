Return-Path: <linux-iio+bounces-8898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F6966A47
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 22:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D7F28458E
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041E1BE24B;
	Fri, 30 Aug 2024 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noU9z6Bp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666081531D3;
	Fri, 30 Aug 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049022; cv=none; b=A5Vas7HmBZPkkiAjGYyHua87x9sauhKPfVfb7DI2wEhKo6iSvaNb0R9T7Q0E1umgJc7tRrCK39YwKu1iRqXCzwzz9KjTmX3rLew0CPRMqTqVOjcYTZL4yzAbAf/edNoskaG+PjviWidiH4qQuywBqsO21VQ/Xqie4LVXUowlHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049022; c=relaxed/simple;
	bh=HzBCujGWFzfOd5BmjgO5KkDCBZ4GHXAp9LzELZN+Y6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiwHtzJSUnDGNVBm/Ts02Un5IRMlisDV4xggStUSL7N4fWKNU7A1wr6IAX7hhL1Qu20PrZj1HFUSh1TdT9kuBWLIHwkMgjylt+ncAJ0xRQcq+Akuzt9YlixWS+XOoiWqD0+EX+8s08Cf8Cal4ew8Sl41qk7fK14W7hEszt02ZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noU9z6Bp; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5da686531d3so1396087eaf.3;
        Fri, 30 Aug 2024 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049020; x=1725653820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDhaX7oBXrjQRCJVsp+rzW7MPrAAVpU5PK4VXaUGOus=;
        b=noU9z6Bp9NfQoCzu5aIue1QJXQxbuVNomIqMQsikZIeWhjWmWttp996Wx+eioUhJ1G
         vVZurMtk8XddaF0BJJzfS/uu4AOQt2QUCJu4lVGDlxCtXlBmd3tNPYLBNAA0TmCLekKL
         DeBw5LPxBYtQgTpzvpOv2T/lssa+bWqH7QzCOtSNvqiU1In52XEDmqY8KxgJmV4KHzF5
         KjZsk666iFtZXDt6iVS59iNBfMIOZYKuvjxyoJutgQ+R2SaZ3jZRxSRe4vbGL+75RLCs
         A5erPxsxo9bFa07iMgtQ66hLqF7XJjgpez3gW+yAoA1OWv9kUUOwJp+pkdXxasVgvgl4
         0EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049020; x=1725653820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDhaX7oBXrjQRCJVsp+rzW7MPrAAVpU5PK4VXaUGOus=;
        b=PpwIuIzFDxEXXVM3SgpEtg2mQija51gcdloJDTzXAhs0W2f2mScG82L2YXwx8k7QHJ
         4kGd6lLOf7UuG+PkLnn1ECV8yOGcNyd3LImL0KZ+D7yOCkvxlqGyNtURkJLcsYROaY15
         Ldx7WOCDWOCSD8WDvxQj09JzHikLheRxxXjAjd5TfewiaWSckWGKmHhQJ6i/reUE3Kvb
         smfjUBokEW9rhTB2B/kUGh9xFZROkhe2IWPQldV4JT+n5zlvYX3pvxqjfkWDuGvQy6vS
         FnNtEy5TJSIt59zsgkdb8Syj8d/cj5mIVgAyI4zu5nQJIFUeAeOcDXUgi0arM9Q2+IiZ
         M7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWbHYVfB38wNooN/KyXU05V5by9vxKGgfjUcQ3rjuWYci5jGDFXbh/Tb7aMnX17aMaDaS6x5cmoKcaSZuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylvlK37CtaPv+PkEOnOPlKULCEOuma/SO/s77+7lhq4Pmq8smm
	AWaNEQo3bN55NLVm7iY5hUAMg/dZdk5nPBeZ0RP9QObCMwcef34JC4j1x68f
X-Google-Smtp-Source: AGHT+IEhZdklZzt100oAH5ja4QzVJeruaaRLFlumsZEjq5qDndJFoRUc5lsOhKoBk7hVMwu2/WkktQ==
X-Received: by 2002:a05:6358:724a:b0:1b5:fde1:d00c with SMTP id e5c5f4694b2df-1b7edbf9fafmr99527655d.25.1725049019759;
        Fri, 30 Aug 2024 13:16:59 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([2401:4900:608e:fa44:845a:20a9:791f:c32b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56e5c23sm3257476b3a.172.2024.08.30.13.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:16:59 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 0/2] Continuous mode support for VL53l0x
Date: Sat, 31 Aug 2024 01:46:24 +0530
Message-ID: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for checking the sensor ID by reading
MODEL_IDENTIFICATION register and seeing if it returns the value 0xEE

The second patch adds support for continuous mode in the sensor by using
buffers. We enable the sensor's continuous mode in the buffer_postenable
function.
Replaced the irq handler with a threaded irq handler in order to perform
I2C reads for the data. The continuous mode can be disabled by disabling
the buffer.

Regards,
Abhash

Abhash Jha (2):
  iio: proximity: vl53l0x-i2c: Added sensor ID check
  iio: proximity: vl53l0x-i2c: Added continuous mode support

 drivers/iio/proximity/vl53l0x-i2c.c | 136 ++++++++++++++++++++++------
 1 file changed, 110 insertions(+), 26 deletions(-)

-- 
2.43.0


