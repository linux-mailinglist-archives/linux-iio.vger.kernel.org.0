Return-Path: <linux-iio+bounces-18956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A88AA6AA4
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 08:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC691BC0BBB
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 06:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9F01E7C32;
	Fri,  2 May 2025 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hlQ/0CZo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429EE1BE23F;
	Fri,  2 May 2025 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166525; cv=none; b=dcgdPh8bNZYf9qtTo3679sz1v1eYDLWz+JBAoRFkNpyd0CSTrZl7+ATqzZ/zjGy9rJKKrs7ON6+FMH8fhSRywn/gqKIWdpQbUUJbdC7gJux6PGhH5OB0pfBsbfJ9ZTvcEQlwRDmj5BDxl56gDc1pRyRt70sEHJyYmE9fKLTu+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166525; c=relaxed/simple;
	bh=1+U7k1uu4ZEIxfCJ4vY7fP38e6Vr6Aa+dU9k6vwQ3iY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MHjEkTaf47Wm1ykFCD9QWnRiXalhIer4rNtMifPD4SBL/o+GiDaN8rYgfQe5PkoLR29QOOvWuOgCFnY2En66pqDtEykbS6p+q1//lqQHKfQaZmJTik+1cP+zG632syqfjfgiOghpRk6iFy3tT7UyB6i9X5S4ZkM4os7m3mH+4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hlQ/0CZo; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746166515; x=1746425715;
	bh=LQgJqv7XvYN7sjAjV3lO64pbY1ek7RsMOmZ1MnXYMn0=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=hlQ/0CZoXbUpuW1ygbBvdOCXmu/osBxIWcQW+oleBV8fpdjQty60iFamzzjZXYrwe
	 GOMIhl6F5paMfwqnWdG+0Zszk26ZE1Na3gV1mgt9+VRYTGTl3UGjhwgEBFGvfDx/lB
	 Rs9SayrRKPmkc4xg97YwdZ9nMKVUWtz4XtJIklFQd5RPa/bEr66SXltglaSNnEXNIU
	 4AFyPE9dmRct7A/LO+U0rs9QuTSKX+p6gYrmAnpGOWlKbGrsmdy7Rad3ytEG0hjIeS
	 MY8VnQL3a4mkgFFv0Qy3ewZlDNJj1UBwF+OcbgRqSXdcr7AUwauhA/zV8LHnlmmQnT
	 lP7Mcw+CwfUEQ==
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 0/2] iio: accel: fxls8962af: Fix temperature readings
Date: Fri, 02 May 2025 08:15:05 +0200
Message-Id: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOliFGgC/12MQQ7CIBBFr9LMWsxAhaauvIfpgpShnUSpAUMwD
 XcXu3T338/L2yFRZEpw7XaIlDnxFhqoUwfzasNCgl1jUKg0apTCl0cSPQ7ke2ccGg1NfUXyXI7
 MfWq8cnpv8XNUs/y9f4EsRVv6gkZaHHAcbwvZwOU8b0+Yaq1fH1YC2pkAAAA=
X-Change-ID: 20250501-fxls-307ef3d6d065
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Add the correct scale to get temperature in mili degree Celcius.
Add sign component to temperature scan element.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Correct offset is applied before scaling component 
- Added sign component to temperature scan element
- Link to v1: https://lore.kernel.org/r/20250501-fxls-v1-1-f54061a07099@geanix.com

---
Sean Nyekjaer (2):
      iio: accel: fxls8962af: Fix temperature calculation
      iio: accel: fxls8962af: Fix sign temperature scan element

 drivers/iio/accel/fxls8962af-core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
---
base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
change-id: 20250501-fxls-307ef3d6d065

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


