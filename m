Return-Path: <linux-iio+bounces-22085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A867B135EC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8128A17891B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550F22222A3;
	Mon, 28 Jul 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="udgmHHNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FD21CC68;
	Mon, 28 Jul 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689324; cv=none; b=ujVhwHMoNHuEJgWgfnYom2FQx1NEDu8ShcnLZ1PI5R0RJ/prwwunkiCcbIvqPwE4rWoUYU6Lk1faAK112C95JgIZ6PWskrkzVPXtOne0V0lGt85jGj71YLi16FWqFbALRhe6XbPwYtgEql31UqRidWpTdNBUt0j65w2oyzHUHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689324; c=relaxed/simple;
	bh=vyTswW5mBU8qP9UGZBd+Yz7rbpkaOC9CmV5ZJm37XsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p6+odBz4tF3TdL/NMkYcJD6ie2gYJdFyYVQ/FLukihTQLygXk/11I8qx658T2sh5itynU1aUykuSt+bE3MPcb/qNkfEJYW7f43YJIHnnLZ+1USWps5GR/DAPi6hHSGk4meMMLAlzseYbEZxrqsh6AAa9ZbnW/hWLK0fhrDpOtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=udgmHHNq; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Bkr0VA2OrZmPbs1hb5HnRRtZ9Uq4gXLZICTeByE38r0=; b=udgmHHNqU6niL8ZaLUpM+juNr9
	pQ3QrVUSALGs5td5djdjQN5jKpmxIngs8hiDghH/Za1XH8vdZJhxm1FkgRtOtIKKe81AE3r7BKf4F
	hsLjTTkp3718ZtW5L6ki+W639CW1OJhMy4CDljvz2e8aJtLsuajiEsjUUo9M9fc0l6qWKT4kbxy7G
	9F9dlrXvJ9EIvkFyXozlky8T0a4eUjd79HRu8FDUKZHVhOI3tT5/VQmbV1/OWWgxJ1lrAYGQWnoMF
	70gCdCdFu0wK6NusoZ6yKtr1xK3idIu9Buzr6Gu3jONg2vLtEt8myKLPBz+Cts0UWzK2/QskO5eaJ
	jVwXl5VA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ugIhR-0004Wh-04;
	Mon, 28 Jul 2025 09:55:09 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ugIhQ-0006b7-0N;
	Mon, 28 Jul 2025 09:55:08 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arthur.becker@sentec.com,
	perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com,
	muditsharma.info@gmail.com,
	clamor95@gmail.com,
	emil.gedenryd@axis.com,
	ak@it-klinger.de,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Mon, 28 Jul 2025 09:54:43 +0200
Message-Id: <20250728075447.338725-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27712/Sun Jul 27 10:35:17 2025)

This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor.

Changes in v7:
- Thanks to the reviews of Jonathan and Andy improvements in the PM could be
  implemented like removal of pm_runtime_mark_last_busy() and consistency in PM
  handling in some functions.

Changes in v6:
- Thanks to the in-depth review of Andy many datatype improvements were
  realized.
- According to Jonathans review change the channel types from IIO_LIGHT to
  IIO_INTENSITY.

Changes in v5:
- Thanks to the feedback of Andy and further explanations of Jonathan many
  improvements could be implemented.
- add documentation in kernel-doc format
- iio_push_to_buffers_with_ts() is not used as also testing against
  linux-stable where it is not available so far.

Changes in v4:
- implement feedback from Andy and Jonathan
- implement feedback from vendor (reading interrupt register as bulk read)

Changes in v3:
- implement a lot of feedback from Jonathan
- change scale value to real factor of lux per raw count instead of hardware
  gain  
- optimize code by using more lookup tables
- remove unimplemented threshold functionality

Changes in v2:
- fix missing include for example in vishay,veml6046x00.yaml

Andreas Klinger (3):
  dt-bindings: iio: light: veml6046x00: add color sensor
  iio: light: add support for veml6046x00 RGBIR color sensor
  MAINTAINER: add maintainer for veml6046x00

 .../iio/light/vishay,veml6046x00.yaml         |   51 +
 MAINTAINERS                                   |    6 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/veml6046x00.c               | 1031 +++++++++++++++++
 5 files changed, 1102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


