Return-Path: <linux-iio+bounces-14662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2AA20A12
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B05166AE6
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9119995B;
	Tue, 28 Jan 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh+1ipWM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687011684AE;
	Tue, 28 Jan 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065695; cv=none; b=GEXsJSH3HUj8V6Dk5zNKEI3u4RwdcP98NkzMe6b4XK7ChU4H25un4CCEpoNSxogTxEx0HemRjdIG5U0+qhnlQcYKljiAP4a0LraMbMLUz1NiUDKVfloPlaceTFajKRPDxs+11orKqB1UwlvF3hPqgg6VP+Z1+RHcZbCOkgjAr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065695; c=relaxed/simple;
	bh=TZSf61UO0AtG7UFAPQAqPW9jCjl8TqnycgmdImFRLYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJHCRweoljc39xjDnDkOdbx+f/DZu2TK/TVyzkMqCyxtA5lU5qQAd3rIeFU4MyGawq9nFdGBwEIKXQ6MsmAm2ir1I92yOsDhJDDgppTIMaO810ZHKyqT0Yiz92yOzk3TVs9rqfxhSwSJhYOp+rryLOflfzvX2ayxu8BKAq8X/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh+1ipWM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6a38e64e4so93388866b.0;
        Tue, 28 Jan 2025 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065692; x=1738670492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CGF6tsATIgcmL7bErhRz+iC5XvMeGcSpXVp93w+zCE=;
        b=Lh+1ipWM7eDQJ/8FhHofkxmbhkb/R3aCa8RxAlNq3n9yIW8+p1yk0HOvApQOR+r3Bx
         Q5GiTp8u+qonqrpu5uBs1ZrECeRYfHII9BAqTvTkheZQmjS8JrHhqsjCKUhWNaCYl3bu
         J8tl/3aCyuJd/VSHxK1FQiAgPraTdnJ0F+Mgrcc4ImzAtLmcQ+QjURt+A/TnqHmFQWYb
         vL8JxkdeoN/RqTzHHryGEj6iy+TZXBbPJBYRswwJwJqlcD8Ak7KySjjGfryEhqPWgA/d
         i761KH0TFM6I5drOnsYNFsbCUirWBZ2yr/n7+CAIVRd82MqfH3zIPL7ed3MbWtSBvOwW
         b64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065692; x=1738670492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CGF6tsATIgcmL7bErhRz+iC5XvMeGcSpXVp93w+zCE=;
        b=cJX6Pxeoy0G668zSbmade0Aq0m16xt/o7jsVm8yNvoxqaynGJ56GLlDEJRkjQMwAtH
         R2Pn+DEEc/jRA4/0FAj7RVfY/gnj6WVmiLc5NsUVd8AC2OT9dVrSkN175f0qeJ1C6OoR
         WgV0MGX3XNHAOTDaMquDAK2sdQ22ZurTwJiHC95pl+Ma8dmNMGdf0gKkWybuumwn4Ywr
         aV/M6I7yNRMja6ylRwz0xfgT2J7u+lSUXBNaNNwzzBCjLlICnmq0I22aSZyxOD5X3gC6
         rMPIHzAHeRv47OeHRt1751j5VO+Vd8lnTFz3JJnBckIs9/JgrVE/+fFy3kjiSVI08GR0
         feow==
X-Forwarded-Encrypted: i=1; AJvYcCWftGhLvCSKr9VCKCkX4IkxaDWODSbNporPuVnw3jl0dYgrHnfbafL1Nyhx9BNKK3F/uacWpLi6CZ8vf3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcpRkEg+VlIdjl4Z7U9vnC/Gn5JIbIb/htHa7Rwd8mo2RMfPh
	GveKFuXxbmDE2fe7hugtuz465A5K9QfbHgU+UEVp0l8KAjWHzeO0
X-Gm-Gg: ASbGncs9aZelEJJPv/fG0Zi61q4qqfQmn9bmIX68DiLYnsAyHlQ52+8dCnGWlW8dkLg
	mwGIzilZB/ytVNz64+Q2IAEkfKL6l4+HTEluxe8xxBuOCHjLezLo7OTQc4DC8lhrd6KeIy2lW7e
	zhdNZVgkQVM6RAFyhLd7LSoVRC7bta7YgILCJZR0p7WylTv7fDZC6NG4IEQoqHcZej/uYUxMNI5
	asi9gJCG/1D69/gLGmc7+UZ/VtJMfwIq1in6ykEuqaXGGonP9ezZngojpkZxsjw1qkedrOO98NS
	bvLzWrANDZTQgI/Vs5FYoniXd5ak+EhVVAx7Dh218hB6HWkKrOiBJj69bD6LOhNsdVr2sg==
X-Google-Smtp-Source: AGHT+IH21rRA38M/WImO6gVUwLLfZ6AiXQZh1T5rax0wATYNGQU9ufhp45sayEMr6ysErJQs/EHFAQ==
X-Received: by 2002:a17:907:1b20:b0:ab6:92dc:8b98 with SMTP id a640c23a62f3a-ab692dc9244mr478912666b.8.1738065691365;
        Tue, 28 Jan 2025 04:01:31 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:30 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 00/12] iio: accel: adxl345: add interrupt based sensor events
Date: Tue, 28 Jan 2025 12:00:48 +0000
Message-Id: <20250128120100.205523-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several interrupt based sensor detection events:
- single tap
- double tap
- free fall
- activity
- inactivity

All the needed parameters for each and methods of adjusting them, and
forward a resulting IIO event for each to the IIO channel.

The sensor has further features still not covered:
- g-ranges scaled by different ODRs, especially for activity / inactivity
  threshold is not covered so far. There seems to be a particularity with
  the ADXL345 as annotated on some analog FAQ.

- Various thinks like low power, sleep mode, etc. are (still) not covered
  here, others (ACDC bit, selftest, etc.) currently are hard coded or not
  covered.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Questions:
- Do I need a mutex/lock protection as this is the case e.g. in the ADXL367
  or the ADXL380?
  Actually, I understand those cases as protecting access to the state
  object by different channels, temperature and accelerometer. I'm unsure
  if this is a correct understanding, where for the ADXL345 there should
  not be any issue. At most, a currently displayed value on sysfs is
  (still) not updated. So, IMHO I can rely on the internal protections in
  regmap no further mutex is needed. Please, can you give me a feedback
  here?

- FIELD_PREP/FIELD_GET: I'd like to use arrays of enum indexed elements
  to allow for more generic function implementation passing just a "type"
  field, e.g. at single tap/double tap or activity/inactivity handling.
  When it comes to filtering out bits using FIELD_GET/FIELD_PREP, it says
  that this enum array element is not "const enough". Is there a
  work-around?

Lothar Rubusch (12):
  iio: accel: adxl345: migrate constants to core
  iio: accel: adxl345: reorganize measurement enable
  iio: accel: adxl345: add debug register access
  iio: accel: adxl345: reorganize irq handler
  iio: accel: adxl345: improve access to the interrupt enable register
  iio: accel: adxl345: add single tap feature
  iio: accel: adxl345: show tap status and direction
  iio: accel: adxl345: add double tap feature
  iio: accel: adxl345: add double tap suppress bit
  iio: accel: adxl345: add freefall feature
  iio: accel: adxl345: add activity feature
  iio: accel: adxl345: add inactivity feature

 drivers/iio/accel/adxl345.h      |   86 ---
 drivers/iio/accel/adxl345_core.c | 1150 ++++++++++++++++++++++++++++--
 2 files changed, 1099 insertions(+), 137 deletions(-)

-- 
2.39.5


