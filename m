Return-Path: <linux-iio+bounces-2875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760B85E517
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 18:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C4DB24D71
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562C84FDC;
	Wed, 21 Feb 2024 17:58:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653784FD3
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538304; cv=none; b=cUayGgRv1YP1aPMfG6ZIV7v4GYKdSFneIN9biNlW90JiLSFuxkfELzBehn7nfhdLs17f3tAt4RrrWxYNEtGxnkr1zq+keNwwVfHLPhU2RhbT1UDQG15yaTietiHPwv1wJYJthAHYhqpZUAo7UVSmehI4y7sYRchuD+hNNKE8jXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538304; c=relaxed/simple;
	bh=SDXjqB4wIG3XnhyFFBnM6Pd3RHudSe6ZGddZfgcxJrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PKSYFae/d/sBgq/FIbXV5IUSSOdRFg+/2IEXu8HvSW4QWF9XKgDK/1WdExGv7Yeojlj1kPVnhkcaDauFCzjqfL+f1JOl3JT7kPzSIfnRCOrMVm1mbrMUJV8W+zMK1qRUZ5Z6N8f5dZsa5PxOeWiMJbmkB5EB1WOiwjFgctAO40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rcqrF-00046q-LD; Wed, 21 Feb 2024 18:58:13 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	denis.ciocca@st.com,
	linus.walleij@linaro.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Date: Wed, 21 Feb 2024 18:58:10 +0100
Message-Id: <20240221175810.3581399-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Add the iis2mdc magnetometer support which is equivalent to the lis2mdl.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index fff7e3d83a02..ee593c8bbb65 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -64,6 +64,7 @@ properties:
           - st,lsm9ds0-gyro
       - description: STMicroelectronics Magnetometers
         enum:
+          - st,iis2mdc
           - st,lis2mdl
           - st,lis3mdl-magn
           - st,lsm303agr-magn
-- 
2.39.2


