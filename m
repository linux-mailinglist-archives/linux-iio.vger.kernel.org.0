Return-Path: <linux-iio+bounces-16902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDAAA6357C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29843AE644
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01641A5BA8;
	Sun, 16 Mar 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="c3oyOLJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2C1A5B96;
	Sun, 16 Mar 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126146; cv=none; b=lGBKiN1DAfWxhD1LLhiAbBdvb4YNBpcOtT2l59TCJ7zUwejJbfv6AGzbFkT1vefeM9cgHYXM3IRMQmhzwLgzBg7D91chjTOUh2Fxk9bzbxLCaMZq/iIDfaGylUonqxPztfGYkNn+CswdUb/Llqb5SkZc9eaco9Obx00P08GJCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126146; c=relaxed/simple;
	bh=mwRf/BXvhH7zuG7sYE9TsVwDAbvXHBd51xRCvnuiF+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXRGi6Uocxz6msPjjgItlWr5wJSKlDss37Ui+7YDYWeTFBLPQHEd1Uv8b5CzLnOEaXbSBzo1p4XDH6quF7ECVOTvXf9POHNN8JdqpbdQB5uR0PrwBmjf/BbpdywfDF/Wp9MoguBVvHitqwCG7Z22WpUqOEvEXbsrhO86AvdVInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=c3oyOLJ+; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=7Lf1k/FLn+1YDU3NpdaiPMjAxUJ9AeZfGfWOijgP4QI=; b=c3oyOLJ+ovGwc6cRu/kYzq2VmF
	d1AxjGXfXfgznl7d0TPwa8clLH3azLc0+W0cOG/RTwAybbX7j6S9W936U1gtED6gZ8wGxp0EydB/L
	8gJ2/l6riQuIj7eTRHvOfEtEBLjhbFhaYlPWr2jRA20kyG1tExkJRpk0noECLj0+RHmlDSNDL3+C2
	pbYCDOErVHR/rCFs86zyAv2wSBjXnT1QlRY2Qvt3p3ddDC/J93geUn5ShtuHjD9WEi7/tuwg+zClx
	Z2tsYlt1QiswPsEv3+mqeAkvGQ8xCisdp+TTByaRipg9wyYj5Jc1x8KFgdfX8Q/71UDWDK39IkpT7
	ReRogLpA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttmET-0005bD-2a;
	Sun, 16 Mar 2025 12:32:41 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttmET-0008s3-2U;
	Sun, 16 Mar 2025 12:32:41 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com,
	muditsharma.info@gmail.com,
	arthur.becker@sentec.com,
	ivan.orlov0322@gmail.com,
	ak@it-klinger.de
Subject: [PATCH 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Sun, 16 Mar 2025 12:31:28 +0100
Message-Id: <20250316113131.62884-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27579/Sun Mar 16 09:35:38 2025)

This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor

Andreas Klinger (3):
  dt-bindings: iio: light: veml6046x00: add color sensor
  iio: light: add support for veml6046x00 RGBIR color sensor
  MAINTAINER: add maintainer for veml6046x00

 .../iio/light/vishay,veml6046x00.yaml         |  49 +
 MAINTAINERS                                   |   6 +
 drivers/iio/light/Kconfig                     |  13 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/veml6046x00.c               | 890 ++++++++++++++++++
 5 files changed, 959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


