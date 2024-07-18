Return-Path: <linux-iio+bounces-7679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575E934E50
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6609C1C22684
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1113DDB6;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnEnfJUi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9C139568
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309905; cv=none; b=r9NDgGmmi23dpkUNCEwT6gWcErXLRBPm9UTX5id0RVDr2ue7hcxBgS+vRDsnyA2OFs4jBoKJf9VQFznWEmkhelc/Cr57UfgHeA9hrZd7epWx3icnebYTDrN+ei++ZlkjoE6Pm+6LCQKwlIJGjfU+WgWvpXPEFIvYp2yYGTimBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309905; c=relaxed/simple;
	bh=8Uli0ChG4jZLPPsbSQ3WXP2ht09wW1DHRmGxM4Samzg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bkhQHG+qjd1OZEKFII9Q2HbWM4rRwSZ+NZlSHJXQb+m0SHPzRVI546jVAWc5C+Q91bUqpOEFOJpXzAb8ckrUJnQUyzDJMyPX8L0pLKE6vBB1xwR7Fv6mYHFSBlsA+w2RnIWVqW9B/gQ4oicTExZdrPC4y+men6vCVB+t81km4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnEnfJUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A29DC4AF0A;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=8Uli0ChG4jZLPPsbSQ3WXP2ht09wW1DHRmGxM4Samzg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cnEnfJUiAkD2uOwwnBZBakZgGDUgLEr5b/qbjagajZ4ZxWaPwk5LV0WI7DLJLVsU6
	 QagfDRHNUaxifFfqtxG3xxxLBR6GP39NDQPdbCMz1pqiMkUWbCmwQ1981ILna5UYnv
	 UIjSi6ICQHSEawr+UUf/BAgf1jHACpS+2CLcpIeLMAzhEyMVMJkytPFPQszIe5g3gF
	 IUdn6bNzS2gLYxZH8xSkTnltz9tAAUwy8cVFRuYLwQrrSR//bNChhmRleEqpsUkI5D
	 09Y9ERy1LsvcecVLhFsiNMWl6JQWTk4d9fiFjykTj4zDMqoZ6FKtkGa0dscD7oe9Xv
	 cI91FX2bri1yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE01C3DA63;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 00/22] iio: make masklength __private (round 2)
Date: Thu, 18 Jul 2024 15:37:46 +0200
Message-Id: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKoamWYC/x3MQQqAIBAAwK/EnltQC6y+Eh0kV1sqCw0Jor8nH
 ecyDySKTAmG6oFImRMfoUDWFcyLCZ6QbTEooVqhpURLGZkP3E1aNwr+WvCMnM1FCmfb2b5xQut
 OQhnOSI7vfx+n9/0AX84PzW0AAAA=
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=3113;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8Uli0ChG4jZLPPsbSQ3WXP2ht09wW1DHRmGxM4Samzg=;
 b=cmILg206q4j7X+2olECakoOHFPVX8RRrsI9OejMsj1+KHl7qkF6qeu22+m8ZxTkNrE2qqjw3q
 B7XY/7xuo0tBDuUpEARKmVDUPzv1AI+9ii6sisI0fjG/vt5kPrhO1Yj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes the second round about annotating .masklength as __private.

Again, only compile tested for arm with allyesconfig.

---
Nuno Sa (22):
      iio: adc: cc10001_adc: make use of iio_for_each_active_channel()
      iio: adc: dln2-adc: use new '.masklength' accessors
      iio: adc: hx711: make use of iio_for_each_active_channel()
      iio: dummy: iio_simple_dummy_buffer: use iio_for_each_active_channel()
      iio: health: afe4403: make use of iio_for_each_active_channel()
      iio: health: max30102: make use of iio_get_masklength()
      iio: health: afe4404: make use of iio_for_each_active_channel()
      iio: humidity: am2315: make use of iio_for_each_active_channel()
      iio: imu: bmi160_core: make use of iio_for_each_active_channel()
      iio: imu: bno055: make use of iio_get_masklength()
      iio: imu: kmx61: make use of iio_for_each_active_channel()
      iio: light: adjd_s311: make use of iio_for_each_active_channel()
      iio: light: gp2ap020a00f: make use of iio_for_each_active_channel()
      iio: light: isl29125: make use of iio_for_each_active_channel()
      iio: light: si1145: use new '.masklength' accessors
      iio: light: tcs3414: make use of iio_for_each_active_channel()
      iio: light: tcs3472: make use of iio_for_each_active_channel()
      iio: magnetometer: rm3100-core: make use of iio_get_masklength()
      iio: pressure: dlhl60d: make use of iio_for_each_active_channel()
      iio: proximity: hx9023s: make use of iio_for_each_active_channel()
      iio: proximity: sx9500: make use of iio_for_each_active_channel()
      iio: proximity: sx_common: make use of iio_for_each_active_channel()

 drivers/iio/adc/cc10001_adc.c               | 4 +---
 drivers/iio/adc/dln2-adc.c                  | 8 +++-----
 drivers/iio/adc/hx711.c                     | 5 +----
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 2 +-
 drivers/iio/health/afe4403.c                | 3 +--
 drivers/iio/health/afe4404.c                | 3 +--
 drivers/iio/health/max30102.c               | 2 +-
 drivers/iio/humidity/am2315.c               | 3 +--
 drivers/iio/imu/bmi160/bmi160_core.c        | 3 +--
 drivers/iio/imu/bno055/bno055.c             | 2 +-
 drivers/iio/imu/kmx61.c                     | 3 +--
 drivers/iio/light/adjd_s311.c               | 3 +--
 drivers/iio/light/gp2ap020a00f.c            | 9 +++------
 drivers/iio/light/isl29125.c                | 3 +--
 drivers/iio/light/si1145.c                  | 7 +++----
 drivers/iio/light/tcs3414.c                 | 3 +--
 drivers/iio/light/tcs3472.c                 | 3 +--
 drivers/iio/magnetometer/rm3100-core.c      | 2 +-
 drivers/iio/pressure/dlhl60d.c              | 3 +--
 drivers/iio/proximity/hx9023s.c             | 4 ++--
 drivers/iio/proximity/sx9500.c              | 3 +--
 drivers/iio/proximity/sx_common.c           | 6 ++----
 22 files changed, 30 insertions(+), 54 deletions(-)
---
base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
change-id: 20240711-dev-iio-masklength-private2-cd8d93f07781
--

Thanks!
- Nuno Sá



