Return-Path: <linux-iio+bounces-21095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8108AECAA7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 00:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704163B986B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F1220689;
	Sat, 28 Jun 2025 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="K/FNRWU7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7D1A0703
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751150332; cv=none; b=TAxUKR+gvSfW37rwl8Pe2EAfh9t2OeUWM2/VblWeoH/iqj3Phwp80bUl7l7yN7qhBEfx7Zhi4YpcFTqHI/i4I5qXOSQUjB/7uxtQMjle01iG1fz1MsxagS/WlwC1DUHqlHWi3HexDs2vrbtMPyOBcshM2gceQoeCL+NE1U3KX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751150332; c=relaxed/simple;
	bh=7G0+FpKbZ9GaPLV5BcrFUCj+7GnonYzZAuHe72qYZkI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QUFHjLtT0gH7HoYiLoZg+SQrN8BhhI2rAjYoNuGbtKnny/ugd1AdTSJ4DTpc+TMRWKPKgUOMjHrY+wtgI8+jJThvdObBJDDiTiGV7Y4IBA60arbQuG9FooAD/cfg9GzPut0feNBYS7um+tr4PkZ7xQnAXpr2hcgbo13lyxRI/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=K/FNRWU7; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 29690 invoked from network); 29 Jun 2025 00:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751150319; bh=1Kv/5FIXJr4w7f7JBuDHHoZ7UQF55jJFpe21AqRti80=;
          h=From:To:Subject;
          b=K/FNRWU7zM9HVqBDxaqZKuZqrcf8NBx4gZQKCR1NaMbM3e8LVAYyZcT8SbFdmVOAF
           3MfJFhwI2Q6hQRIf43qP2SiZfhebNSe1BVjg8rW8v9NfsBmnnOK8MtoevrRM4Iff3E
           WJNIPjumyEPJ26UbmwVhk9tjQBUw+OW6vbE3lXxwzWynH9wuygI7DelNq7lmTraXVI
           HMJ4B0rwju5WHn41jls9oaPfv78qeVbfXokqCs85ufqLZkwcTZ7lxLQbE/2CT5lSa9
           9OZvSEkdqvI3YMiFDMYn2CN7g9xkTCgOH4Xqw+nR0U6Jb7CYNOeb+sqtwarsWD1yky
           3C9s35tSRffeg==
Received: from 83.24.145.121.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.145.121])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 29 Jun 2025 00:38:39 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jic23@kernel.org,
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
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] Add thermal sensors support for MT7981
Date: Sun, 29 Jun 2025 00:38:34 +0200
Message-Id: <20250628223837.848244-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: b810258631e11cb24906138186427c35
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [4TMU]                               

This patch adds support for the temperature sensor in the MT7981 SoC.
This sensor is exactly the same as the one in the MT7986.

Aleksander Jan Bajkowski (3):
  arm64: dts: mediatek: add thermal sensor support on mt7981
  thermal/drivers/mediatek: Add support for MT7981 SoC
  dt-bindings: iio: adc: Add support for MT7981

 .../iio/adc/mediatek,mt2701-auxadc.yaml       |  1 +
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 29 ++++++++++++++++++-
 drivers/thermal/mediatek/auxadc_thermal.c     |  4 +++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.39.5


