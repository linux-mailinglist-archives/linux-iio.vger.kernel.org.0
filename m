Return-Path: <linux-iio+bounces-18133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0661A89F6B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155F1190309C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E5297A76;
	Tue, 15 Apr 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MpNTpxTH"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C232820B0;
	Tue, 15 Apr 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723701; cv=none; b=cHgvBGAIv3SmMjBR89mjIjHFGdJMrFOgcm5E0sW6qDYweeUJH3FX1j8EED6QLoP8KaZXosLTmsaGo+Uj4jVz8TN/A2Ep7D+57m5jajf0kVdMDPiS7c9NNquS6BQVRmXhaKyBgHSorOPyVkC58ZBfMi2iHAYvPMJoZZEC4CbvEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723701; c=relaxed/simple;
	bh=V/BhDzTsrxt9PX5MhppqtTzNW6n2ZZrG7wF79nVHOyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IhEsXPKSHI0iP1QzfC9EE+8iOSiSRy58IjMyq2JKqVdo6j/juZguaPjSj9GasHbdBvvyoPFWjK4jVWat1aaSEualgpTW7RmjfXvoui3zZmrf9sjtC6jIhaYM6FIqU9WjEtGDv0b6XOq0N9Iuab3WMwAHE2r7rr6evHiKwTCT3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MpNTpxTH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744723700; x=1776259700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V/BhDzTsrxt9PX5MhppqtTzNW6n2ZZrG7wF79nVHOyw=;
  b=MpNTpxTH1GmcQE4HwAtLncRamzj72OYynaEMopohcBsz0eiKiZWauS6D
   Y+PtU4o/kmkb3pwlHFSrpaa6v1R0qNi+UvMzoyIlsMKoqCW1LYFmerg9Q
   XBL7WxgmCUVT+/i2eEHjph5UJNki4TP/73U3Fo6Cwt1byIiL9x1kT7Kpo
   abT4VSiiUwTyrCdWHc59KsTG5d/oAFl3b0641mCP36CYeMuH8M8uhtoJW
   OUs3t1rA/g1rYfNAHEhJnOPtrIMKBNCmPLeKIUPnKSZ+7NBXKrK90jTJP
   PMw1KPxX11fgC9mMFMfQQE6+kReQvwzvPr7TVe2Xyt+da1H8puv7XK5xA
   Q==;
X-CSE-ConnectionGUID: Ib73720AQlOOLHXW61IHCA==
X-CSE-MsgGUID: Xor4WrdwQIyy6khYgSDu9w==
X-IronPort-AV: E=Sophos;i="6.15,213,1739862000"; 
   d="scan'208";a="271861952"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Apr 2025 06:27:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 15 Apr 2025 06:26:59 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 15 Apr 2025 06:26:57 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>
CC: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<victor.duicu@microchip.com>, <marius.cristea@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] add support for MCP998X
Date: Tue, 15 Apr 2025 16:26:21 +0300
Message-ID: <20250415132623.14913-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

Add support for Microchip MCP998X/33 and MCP998XD/33D
Multichannel Automotive Temperature Monitor Family.

The chip is capable of monitoring temperatures on four
external channels and one internal.

Victor Duicu (2):
  dt-bindings: iio: temperature: add support for MCP998X
  iio: temperature: add support for MCP998X

 .../testing/sysfs-bus-iio-temperature-mcp9982 |  17 +
 .../iio/temperature/microchip,mcp9982.yaml    | 182 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9982.c             | 794 ++++++++++++++++++
 6 files changed, 1011 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
 create mode 100644 drivers/iio/temperature/mcp9982.c


base-commit: 31c52fe3b2efeebfc72cc5336653baaa9889b41e
-- 
2.45.2


