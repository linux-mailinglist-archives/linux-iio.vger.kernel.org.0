Return-Path: <linux-iio+bounces-15792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97037A3C2F4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65D418918A5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EC1F3BAB;
	Wed, 19 Feb 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFCnq0l6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651D1F30A4;
	Wed, 19 Feb 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977385; cv=none; b=Z4BVcZ/tii7MyBJ5x0WtnkpmUaQc6EuNzsWQk+TUUl+EwwmWzCwwp8VJU24r9HsLruxnE/IkZjJxtMmbs6FZuKUg9YcFQIllsOg03mhcPNagU/W4+SSq3QWFdXoEV9wf6skIjYmzDYFVOep+ER0L/eJBTQYKHDdumfRW9aTg/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977385; c=relaxed/simple;
	bh=Qp8YMepdCjGJuSkHAZYcgnzc8cQi4IfbgA9HLJKn94s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwyQTf4i4oHDRjeHEvXYzJB3v6I95HbyGQfWhFeaRRLf6JV7s4Fbf37i+X3zp0mnynz5BdDiJQo2QFtBb1vIo6JjFh+0rYqCJt9Y6oXCxj1vSkTLiskTPLEEoDkKGczePf+mRE2mE0lX6x4U3X/qtHV+U9cT451mJzY1st07NBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFCnq0l6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21c2f1b610dso175660535ad.0;
        Wed, 19 Feb 2025 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977383; x=1740582183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjFrc4YRDT4u7M4W/CbQv3sktsYWgiioerwclJbTypw=;
        b=mFCnq0l64l0hkODk4hKJn7eDYkZehDXWHmwcEocXttk/JWLqTDtaWkM02AOHDIthwq
         0P78q1/iLW0jijKYbYQ8y6sUdL5c7lsXlmmGMGwtGA/7wMQkTu3Y092dKYuCRv0YS5Tf
         d4wF6je+aOw4Nm/h5GzH/KNeIsVZiyWBZoEO+F3ZUuk8regBIpZfNw/N0Uw5XrVcDNMn
         1122eYNbkg64sSuCLgtLSlxNqhK4KhjNPRQnsYevczeca0yvY/+lHt2der/2a6+shcMX
         k7kMXDkohqCcRs05Ds5+j3epJeek+U0BZMdwfwxLN6eY+nVMncFdUXOrZCyaIGpEw22o
         F8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977383; x=1740582183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjFrc4YRDT4u7M4W/CbQv3sktsYWgiioerwclJbTypw=;
        b=jUiY//AJhFh5iDgaXX/F9XZnKZqkn/m9IDoW6OWe6t0q4RMOQmZI6CQ8lX0XjEMDFv
         IvSYhEesSvEpPJtYhKrFDEgRmJYP0dNGIVQ7TEGvPcRDCInNZfAj3OcaxXUbtmoKtUoc
         Jemj/YKmLMc2u8otpLOQOhvKe7MGWo6g9176rZexByFtKaY5cgHOhNpUVXZOrPVNIZuY
         QCpXvFvZXrmZfSZArPCEaWs8XmpHmNpsnMFpzGktWd/R7CVHbiMBHHdHGju3VZSD1qc9
         Ij7mcfzfuZmfVOpem96xo5c/aWWvzJfr+n/bTiUd0t6BAoEOOLtDXNibQWqDKkkWKTDV
         Zfjg==
X-Forwarded-Encrypted: i=1; AJvYcCVIsPWmNK7X/FL13ILG+av1mlVybCMmOBtF4PfDcEHWcruu4Fj8EVkD0vdC4EOYR5uu7AhunUpqivM=@vger.kernel.org, AJvYcCWGUQ3Qs5GwEEF5lU7xCn9oZ+l8KnLOq+2FibkOPn7md2fdVNQ5VxsySLzZoMOLDbtol/fBv6B9qAh1hNKK@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBgOXSUKPWhZnCQbaxJ2EP3Dvl5Qfnyb9Fdgpvhze8qNnhHys
	fo4UuwmY/RqTZKz4i2oTJzn9pKfJ3gM3BH54wJJE+5uOpd10RSywZ12udIZxXok=
X-Gm-Gg: ASbGnctar5ZSjFp7bAerZbLnT89zInqdtseCSzJ1IXzedrHOyeJAgFUEmhoyaSDeVeY
	vhkUeqmf3jmk/WSVe2bahKyV71XtdberRByibqUVMiVOeKSF/+cdW4vkOadfABkNSZEKaYittPd
	rJjIloOYjpuxcl3pge8GC+wl2mpIB6+SRfjZifjrmXnBmYXulhbXdcH+m0+3XLcO2jZW3UgC17Z
	BDorbbsteWdOlXmeBERhd9QbmBgRo/ki8xcCoAlzhtrd+L4hAIOMS6ADhtyeF/u3b3w7pIr5UPb
	/Eqh+voVwzh+BBLm
X-Google-Smtp-Source: AGHT+IFNncbakJFWg3tms6q4vtxIfPN4qzPAofS5b4DBYRhA+izmy2A3Lcry/uPy/wqUpwKQrYK4Mw==
X-Received: by 2002:a05:6a20:2585:b0:1ee:650b:ac20 with SMTP id adf61e73a8af0-1ee8cb5d114mr29781582637.12.1739977383143;
        Wed, 19 Feb 2025 07:03:03 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:cb26:1541::21e:92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327367a960sm6888976b3a.150.2025.02.19.07.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:03:02 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 0/2] iio: gyro: bmg160: Improve BMG160 driver with of_match_table support
Date: Wed, 19 Feb 2025 23:02:52 +0800
Message-ID: <20250219150254.24664-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set enhances BMG160 gyro driver and improve device-tree compatibility.

Jun Yan (2):
  iio: gyro: bmg160_spi: add of_match_table
  iio: gyro: bmg160_i2c: add BMI088 to of_match_table

 drivers/iio/gyro/bmg160_i2c.c |  1 +
 drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

-- 
2.48.1


