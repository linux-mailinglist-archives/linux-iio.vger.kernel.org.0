Return-Path: <linux-iio+bounces-19921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDDAAC3C05
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9041896902
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B21EF387;
	Mon, 26 May 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="Ky+HBJTP"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F91EEA47;
	Mon, 26 May 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249488; cv=none; b=uMk3lXC7Dv22KXs5xklvIgJHC9WX4qGx5ENgHRqQbYR7U+UqRFbkZ/Kd4YXYkwZ4zM7rwv6HtPAD5aOOygB6YWOAqq015ZvJvF39QQJ1N8iRDgDZy9zTNufOt6J+QlxYbGco1aOyWSUKz1aE1ZetIvrVY4NkDw9/ycVzKqSyilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249488; c=relaxed/simple;
	bh=IDkEifP/ECIx4HCcJ3KVZJy4RtQfztssOHDisYPPwTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bOQBRJOvqI5n6UuVe+kUaBMr5ussnD+DqM8WW0mEOPA/47q8maqXlDoyUg0TRRECJ0ZAJW4JUVgfS0DVh5u51fYXdwNBHQvi3EpDM9vnAHndRAcOFJhdZdt/tQEQMcgE57A1nHwedJ3dhSIceR57xWbE6T+RVnIT3TOvQ9tWUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=Ky+HBJTP; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=hRzdxS19X09vLm7U2fkj9IPgR3UF3IGS8v5nrEYKLXc=; b=Ky+HBJTPeDaMvtnKxLA1uMJ6bI
	WzFsSg3lq64kyAWOk2pNWlO087hrAeTNxfXaewMtK5+LB0K/p1j/bN182qWIYOIF4aBMhllImD3KN
	p0FFcQ5YhQPb+WVhDRiTk7V9ukQwGsLJrc/swLPxFuoNzMPHEn8FdgGwunSjSs1XHe5D9p7A6n9kq
	ZzLwUDpholBCxQuj3LMgrV9SxJtl3s9xRPoArN7tQRCJFsab+EyEoY0eJDBHzxrCBi1TSmcTPHNe8
	RcXmFeuSY+S46VYciilss8JtcCsZO7djLgLcj94gWLcjSKcd/OwMTYqFLSy51x4WLEO+F5UatSfpH
	m8H89YuQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uJTYA-000Cpi-0R;
	Mon, 26 May 2025 10:51:14 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uJTY9-000C3y-2C;
	Mon, 26 May 2025 10:51:13 +0200
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
Subject: [PATCH v5 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Mon, 26 May 2025 10:50:38 +0200
Message-Id: <20250526085041.9197-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27648/Sun May 25 10:31:16 2025)

This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor

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
 drivers/iio/light/veml6046x00.c               | 1007 +++++++++++++++++
 5 files changed, 1078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


