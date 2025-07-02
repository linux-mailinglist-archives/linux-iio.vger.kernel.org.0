Return-Path: <linux-iio+bounces-21257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F12AF6458
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2575A7A244B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA74C24061F;
	Wed,  2 Jul 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="FGUQmwg2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48492239E76
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492923; cv=none; b=Rpl/BgbYAIQ6Y+9QcPHvt4tC8uyry3Och76NerOpnq6QxuSed4hneZVZHPrVGZP4ffp3wiZ2ynC40+l5IouKZhgo0gP0ld2KCLg6aR4MdWKFDOt/y413b9ooztzCBzNDQn0ei9TJYYSURyxDJ2f7bjQ0o0rQz6ooXx8oQ8Z/xHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492923; c=relaxed/simple;
	bh=e+HqgpkvhRskkCcjr4bwXspxdDh6JWME0eMmo2K1kwc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WCCLts7rvBQuBDW4m8Up4T1/DLEdzB4W6Ty4vcvoUWr6BzzD1t2RFGW8ck+oV7ZMQXUaY5VWVIbQ7HrJD5XdF9Cq5wYqq+Q4MhfU3u4yuJpao8w3tWBpE0D00ACystUg5FYksKVjzzG91WJuXH9o+DvtOFc8qTLDNW4MfZneIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=FGUQmwg2; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 32088 invoked from network); 2 Jul 2025 23:48:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751492912; bh=QkGp+3Fu5XVnyvQn7eeIzbmUQEGbR66f9BykQ6InEVE=;
          h=From:To:Subject;
          b=FGUQmwg25MZJfDyKf2+cF2PhiPOB+37g3E5FT3rMQcQydFO54zwxuDyzU7uFrAztD
           KvvuhPyeVWkqZpy2WqHUOW8EmjsXDdAjanDvF3k2NyWHTW7glIr5pY3S1Tfi0JdVEH
           TJ9M8cfvKFWzm8uCEwEt5ujFQbvww9T7IOokBRnKoNMHgy3MDdUfUXOZbJD7uIaTOi
           PmUYxv7Cn4alRfUlRTF5PIHSzvbn13coAP+RvxvjjILw0T/QXhUCVpITLyMmrZyvSy
           NzntldPX6C+4buYcZrfHm2Xj/WJqTDTtpi5sMLKAJC9ijQdOWUcMwo6jBXDK9tNKRl
           bD4EBh6RsiXHw==
Received: from 83.5.239.54.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.239.54])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <jic23@kernel.org>; 2 Jul 2025 23:48:32 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] Add thermal sensors support for MT7981
Date: Wed,  2 Jul 2025 23:48:28 +0200
Message-Id: <20250702214830.255898-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: de0d4fa9d5cfaba10f7407784c50ddb1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [UYPk]                               

This patch adds support for the temperature sensor in the MT7981 SoC.
This sensor is exactly the same as the one in the MT7986.

Changes in v2:
 - added fallback to an existing compatible string
 - removed second patch as obsolete

Aleksander Jan Bajkowski (2):
  dt-bindings: iio: adc: Add support for MT7981
  arm64: dts: mediatek: add thermal sensor support on mt7981

 .../iio/adc/mediatek,mt2701-auxadc.yaml       |  1 +
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 32 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.39.5


