Return-Path: <linux-iio+bounces-16917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5707A636AB
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11C016E82D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC81C8602;
	Sun, 16 Mar 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="EK63qHxD"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AE1AF0A7;
	Sun, 16 Mar 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145061; cv=none; b=uqbDpdl7MeqHLkI2jvxtiL14qaKCom2jIqzLQR+rUwvlVLfpozSoGMIxXjPaDA1eL74+xhZ+ERQb4gUW4JZUJwRJh+Zpn9jilE5RgvsGiOsZ40oLK2O9sNUujNXsd6bzh3eWV4i70Rlw2Ziw1P3Vuf+ggKWZr708IHTmwuJwSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145061; c=relaxed/simple;
	bh=b4tvDPc89cTsia2kLIqz/jAi8ooEZ1PBscruF8dppfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZvQhWmU/zZIE+xZJqliLQhtEV6WXtQmjmFKAECytKbu7nCKr9w67/rHkn7sgJQz+27iGIWkxCHa8s/mGjB18CRJjlhmWb//YumNHHBWioy0x2b7YtzVhr48aaYYtvJ4H0MqENzfDaagCiYYufpViEXz8iOAKii8XRnpa8Dl9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=EK63qHxD; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Grv1JyKA9rOJDio1cxFrVBgu02WiOXJOj3sho8vZTas=; b=EK63qHxDnhSMHaHRgAtbyMyMn8
	lFAW/XweTe/jGUemMwbBahgvee+H1zaQ+aOoV7SfievPv3t676GvYf/nHv2/C0SJFyzuyjcIDKs3T
	8y1r9b7JgwCNAfLtpUs4wNrLVu/Sf+0S+Tby+6OF8LAj+27ZDXpEKpnnGtIOQt4YGQxIVs5h5EekY
	NjApQ4EnFkLGdB1w/enx2Lm76NHGOl8OCstBJkAnM3A6BQriwyvnUXQgTWTZyHkz/jrtsidzx5m5R
	pARpEEzuJvu9OC9dWh6ic9M7V/Af+X1qVRpb+hEdorb7Orm2UVpf1h0zUUCMCSJ8fXJ3mUe5XP9N3
	x1tQSiUQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAK-0000Cl-0L;
	Sun, 16 Mar 2025 17:48:44 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAK-000MlM-0f;
	Sun, 16 Mar 2025 17:48:43 +0100
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
Subject: [PATCH v2 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Sun, 16 Mar 2025 17:48:10 +0100
Message-Id: <20250316164813.30291-1-ak@it-klinger.de>
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

Changes in v2:
- fix missing include for example in vishay,veml6046x00.yaml

Andreas Klinger (3):
  dt-bindings: iio: light: veml6046x00: add color sensor
  iio: light: add support for veml6046x00 RGBIR color sensor
  MAINTAINER: add maintainer for veml6046x00

 .../iio/light/vishay,veml6046x00.yaml         |  51 +
 MAINTAINERS                                   |   6 +
 drivers/iio/light/Kconfig                     |  13 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/veml6046x00.c               | 890 ++++++++++++++++++
 5 files changed, 961 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


