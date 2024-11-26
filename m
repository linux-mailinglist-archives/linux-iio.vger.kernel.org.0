Return-Path: <linux-iio+bounces-12671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0949D92AD
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 08:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCBF166FD6
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112D1A0700;
	Tue, 26 Nov 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1cqj3Uc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C019DF95;
	Tue, 26 Nov 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606866; cv=none; b=OhEYVBS+poUWGtq8QA4zimhoWa5rqWgI22glrJ3TALQyJWw+skLtVqyHW2+bez0KszLRRk3A7IxgR7CjQgvrFZYDEL+0y52NJbKvN/qMI8G7nu6lgbjoJ5j1xFyqZrvcc7/hid9mqsE+lNduBo02cBaxy8Jk9JN3C6V+XF5o4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606866; c=relaxed/simple;
	bh=xmcGANBbYx8U9Oc2hAxfU43aFMPEK80VYQRv6fWucJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDvpgAqceF3rLzeTp0bnG3vxeOm+5AzElmouGPouMrgGi62TPQoY0TxqIFEvVoyGDt6kwmqcpv3KwxKTHe4mFg83AdrT3V722znhYSUFHbs0Yd7jzsr8BJxQ6llp+OAWG/y2qxMoaNBrGfdjuvuBUhSpooMhe1BjLKNrrfX3CVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1cqj3Uc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21260209c68so46831635ad.0;
        Mon, 25 Nov 2024 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732606864; x=1733211664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0do3xIX08EI23Nwo3gSEngDSFZl5kjEd0QKnt9UEFo=;
        b=F1cqj3UchC+OPcYF6AvGcN7HZCn4JzdtYRruNsFHIgw7LFm1+gYHhoJ4q75yuUxMbp
         M+5AK4n0EiN4KQxUpv2phhSy5RjKXL6hTCy9/3H1vQuyBjWQ0vEetIFkdYq24+7u3+n4
         roERbx0E4SxukDpvPivXR+SzUFAtLZt48VczwpxDuHvnbQFDCtg2BVh4BDL4aFFJm3UC
         +A4Hr8kzBiyfQwaerCxC/EsaFsAKwWAh2nm0Xd8k5duiyScJ0mw7f7GN1EvOXMB7yx8E
         xOqb3MIVYdce8y2Fi1ceiAFtGYyB/uQcOrbhw4BmvKCJSFZCh9bdcm+HsLn75UN+dBEf
         wNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606864; x=1733211664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0do3xIX08EI23Nwo3gSEngDSFZl5kjEd0QKnt9UEFo=;
        b=CzGCJ3Y49EGksQFKt/zbHyIBNW940Q1eoNgK3bk6+8M1aoolLR6bW2uPayjr5pI17T
         d3BxqTL/hmE4csCDS3cQzPpPODJaBJrFncYl4NVhC4Dz7T7xYQwgfhLt7bHM3AwCA0kT
         ws1l9j2WRAJTQFxt9rYwBjVvhCtX9rqmOvy5I7Q+kB2sKWne3j+XP0Oe86P71MylikC/
         1azIxlzhmTS8TLP/1JpZPiko0nFOr+ZuJn4DntIv+pHfz/b941LbeGTbdOxzFZFjZXYN
         RwgvpycWfLA/CqtTaLnAm8Vdmyqt0ufWtBxwX3NFwE//GTZb7FDshMzCoIh+IXKcnkgY
         4KNA==
X-Forwarded-Encrypted: i=1; AJvYcCWPeep4Gz8DBFfzu6JvsyjXu8jQQPC+eOMkX6QzohOLqJoy2jrci/O2HlrB+7Gxmljvru8ufB3XrWjWJrdq@vger.kernel.org, AJvYcCX0ILirNLMzqLUsD2JtsAkZ6jyhzCFhDwmQ8QD4kg2+wB+onYZlk6NS8P3481Zwt6Kpcjrc+4aszW6G@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vuoUxZ79las0jn+AzlI29MSq7qgBKSgjWNEYOaQZ9T0B80uy
	ajb4qPJTgel5YNk+Rc+Z2aG/pN5CXim1r7xpSdBbccuLtZ8je9IzyFRyiw==
X-Gm-Gg: ASbGnctXAiK7QT75SkKxKfzD9A3a4XSnZv6Zgj9EBWYSe36NNSumaEhnK5d/rfCWrH9
	j7ZwRL3Hl6YQumFz9zsI/xDTZQUdOoCQVVZG80NZ8wdB05bgegg+nI8BUW8mJD7nQXekdCVbv70
	dAKI903qejhia+cKlk80mtyJm/J+EJ3df2qZyR1PGK9z6iTIr6/MRNxt/MPr+jYUKTiapvA5lst
	h4ibAXrTkpiVbSZsovBYd4h5WV888W45s7rWyRQfYNaqFaDPyMxw0zDQcdlu+QqUXVPKMqLtZS8
	E2+5W3F4tWF6
X-Google-Smtp-Source: AGHT+IEXu0RzHAn8JmIBD7SZUxxEKmR31zPCYUCN2vwQ+Ur2d2z/T893kcTpvmrQWqcV5bUp2bUSmQ==
X-Received: by 2002:a17:902:f646:b0:20c:e169:eb7b with SMTP id d9443c01a7336-214e6ecb8c0mr31980755ad.14.1732606863483;
        Mon, 25 Nov 2024 23:41:03 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2ceb3sm76237235ad.283.2024.11.25.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:41:03 -0800 (PST)
From: Ming Yu <a0282524688@gmail.com>
X-Google-Original-From: Ming Yu <tmyu0@nuvoton.com>
To: tmyu0@nuvoton.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cmo@melexis.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add Nuvoton NCT7718W IIO driver
Date: Tue, 26 Nov 2024 15:40:03 +0800
Message-Id: <20241126074005.546447-1-tmyu0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCT7718W is an I2C based thermal sensor chip from Nuvoton.

Ming Yu (2):
  dt-bindings: iio: temperature: Add support for NCT7718W
  iio: temperature: Add Nuvoton NCT7718W support

 .../iio/temperature/nuvoton,nct7718.yaml      |  44 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/nct7718.c             | 505 ++++++++++++++++++
 5 files changed, 567 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
 create mode 100644 drivers/iio/temperature/nct7718.c

-- 
2.34.1


