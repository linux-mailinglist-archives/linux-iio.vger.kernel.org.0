Return-Path: <linux-iio+bounces-3792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011FB88B5C9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 01:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FDCB2BF25
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B035D723;
	Mon, 25 Mar 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CfdHKp9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799865D49F;
	Mon, 25 Mar 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398782; cv=none; b=gwxAjVklwYRgnTEBOSvTE5HqgeiBLxoW5NGeVtPKOsN+zg6tP30A9xLZb5EsyUWXPdCxZrEW2zyMAaL0G7+rHLA/kPpbBT458uCJKepzd9m+GpX+WZwPfEjY/R0r/qNZUeogbk3EXQM7eqiImkyEC9d4kkua1H6LXtzt6Tc1ECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398782; c=relaxed/simple;
	bh=7yTT8lPe0pPP8LRjiZ20vvt0WYq95+MUh+JgWuseALI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxbo5D4gLcGG3crrDV12mFCO1qqp1ofF89CswKU0vbG7+kWvXy8ZDuDpM5uPscCCkn8zIHQ/5g+zCWfzQTTXZPv4ugze4KxUHj0Ovc9E07j6gU4iQDwGt/v+ZQqUYu1Go84np7Oqj6MuXp7rwj62YATBnDMhibCQh3JMgSG59/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CfdHKp9a; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 316BB161B;
	Mon, 25 Mar 2024 21:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711398743;
	bh=7yTT8lPe0pPP8LRjiZ20vvt0WYq95+MUh+JgWuseALI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfdHKp9akJkF8wW6xzJg67xD1PuIj8xRl+f76JTz/Sm0o4IVI7x5eXq89+8FdRk9d
	 sxdas3OgsZ8vwBpMGZ4BPFDh/ozFReWQVQYvbAONCClM4JhKpnkiHPEh4zuw/5HuGt
	 YZX4wVGzQ9dyH4XwBhKpoNqHbdWJhw3Arvn7Ho9Q=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Trevor Zaharichuk <trevor@au-zone.com>,
	Greg Lytle <greg@au-zone.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081 support
Date: Mon, 25 Mar 2024 22:32:41 +0200
Message-ID: <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAC081C081 is a TI DAC whose software interface is compatible with
the DAC5571. It is the 8-bit version of the DAC121C081, already
supported by the DAC5571 bindings. Extends the bindings to support this
chip.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
index 79da0323c327..e59db861e2eb 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
@@ -21,6 +21,7 @@ properties:
       - ti,dac5573
       - ti,dac6573
       - ti,dac7573
+      - ti,dac081c081
       - ti,dac121c081
 
   reg:
-- 
Regards,

Laurent Pinchart


