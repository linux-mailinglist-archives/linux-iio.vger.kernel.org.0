Return-Path: <linux-iio+bounces-21259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C07AF645A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881A316E295
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FF23D29C;
	Wed,  2 Jul 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="kXJookvA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878723D282
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492924; cv=none; b=HeBUQ/cv0tDWRkwDDr8Ja3vAVWRZ7TfHeCPBY0liPyN+sgy+z3D0nFRl0ESKbD2Ymz2yO9J1VMalgOG/MZ0Zjvec34JL9MURuBhE61NolTwssVaY70mek/Zn6Sen0rMncCe07M26im2MdOGgUibHEALHKHVjK3bKwx/Uh2ZmuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492924; c=relaxed/simple;
	bh=G4OzgqOi+DfuYxwpdc440Q3R+U7l0MLCB1cML+K4nuQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRadBX2P2UFTzMMHXrfhl2rE87h+F+ZkliVmOAMtaOShEA+kdrRXLCiILllMIfb7OhEvjgwiqerLqoyb/oGxt99tUOSPP7tno5p0GjlD1kB5G9NuoLJAq0mQ9OZdUlDpX+7uj/vFHfDcw4O8mefVFH18yFNozDbwwv9U0qK5YX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=kXJookvA; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 32885 invoked from network); 2 Jul 2025 23:48:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751492914; bh=iYgWJ8J7BoGFxKck1RjrUitwIQvjD7tq0nYE84HRdJ4=;
          h=From:To:Subject;
          b=kXJookvAoghUWQJckr2S92QLrUOqw6bSmwcRElr8a9q+J5sv11Q+Fnsrg+CLavybB
           jr6rLaP3YmenP/R9z2VDjiLDV2fogADZSTegegBIHEGhvp7p9Poog1qe5EaMUWmFa4
           h9CZDu3ScZCaA/srJCA2dG92hiaIBKO47mFFx0MHvaXoCXKsQXoP07ypCBHD/4QEx2
           JbskowpLQDLbmmP7vKB31A0F3T1/ZmxgIJgIKiguARHWbD+XFfUH4jah2NgPK32Own
           a4QAlSRj9yAjFNIKssonYCo/1RcP9RzMS5dUQF4yjqfWm4a8qKpx7ddQTTlGUj8JxE
           kBRDD5rTg4EYA==
Received: from 83.5.239.54.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.239.54])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <jic23@kernel.org>; 2 Jul 2025 23:48:34 +0200
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
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add support for MT7981
Date: Wed,  2 Jul 2025 23:48:29 +0200
Message-Id: <20250702214830.255898-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702214830.255898-1-olek2@wp.pl>
References: <20250702214830.255898-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4531e8972fbbdfc366c72f9ccf260a9d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4UOh]                               

The temperature sensor in the MT7981 is same as in the MT7986.
Add compatible string for mt7981.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index b489c984c1bb..ceb914dde15b 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt2712-auxadc
           - mediatek,mt6765-auxadc
           - mediatek,mt7622-auxadc
+          - mediatek,mt7981-auxadc
           - mediatek,mt7986-auxadc
           - mediatek,mt8173-auxadc
       - items:
-- 
2.39.5


