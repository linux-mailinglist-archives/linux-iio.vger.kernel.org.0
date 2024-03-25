Return-Path: <linux-iio+bounces-3793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD588B17E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08181FA5DD5
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2605D73D;
	Mon, 25 Mar 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gEFOdryg"
X-Original-To: linux-iio@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FF5D467;
	Mon, 25 Mar 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398783; cv=none; b=IZShWkxqB1xh9Rq381MWPJRYM5Yfj8O053osmdDx3lfrOeT0Hx9Py1EaemNdWJerY5q48nT72ss/FES9Kopla2wgLY5murxp9BtUeAxWRKkb+5csvTtBj8cF2Zfn5+2wvVOj7bYvP2uSHfTSPxSvJ9MZyzXBu0Lhy4T2LsJxDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398783; c=relaxed/simple;
	bh=TjKhLpwPmXx7r23Xg91b2VloxY3CRHnTN6QqSUJ5VdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkLbVgOhm9ZDcWJBStCMTLGuUbXDN7IMA5kDqmmuT693e8WNihzR24nmludgzrLr4J2MF77BwlxtoJCkYsYZHwosbgrdgFmtJpWfAZpLBEuXISdDfIM16HHlg5DRpbmZp8N/kn7v92VYy4lpyM0PhDDO2aIAdxNc0WdSZOx2eZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gEFOdryg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 924957E4;
	Mon, 25 Mar 2024 21:32:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711398741;
	bh=TjKhLpwPmXx7r23Xg91b2VloxY3CRHnTN6QqSUJ5VdI=;
	h=From:To:Cc:Subject:Date:From;
	b=gEFOdryguv9TNX5gLcLe9ClrrY3mkPOb9b324BUVv7GCbgH2RcU2RAG6YovyLJHcX
	 rzyC7EQa5YTNFhyAR4JDEWCUJBPM+dkOtdQsZZDRTobguAb3pJIxk8P7/xwhxnGD91
	 w4e7RBCzHzehcYuOMtObse2DGGXl34fOfERkZCLM=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Trevor Zaharichuk <trevor@au-zone.com>,
	Greg Lytle <greg@au-zone.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Nyekjaer <sean@geanix.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/5] arm64: dts: Add device tree source for the Au-Zone Maivin AI Vision Starter Kit
Date: Mon, 25 Mar 2024 22:32:40 +0200
Message-ID: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series adds device tree sources for the Maivin AI Vision
Starter Kit developed by Au-Zone Technologies in collaboration with
Toradex and Vision Components ([1]).

The first two patches add a new compatible string for the DAC081C081
present on the board to the dac5571 DT bindings and driver. Patch 3/5
then adds a new vendor prefix for Au-Zone, and patch 4/5 adds the board
to the arm/fsl.yaml DT bindings. Finally, patch 5/5 adds support for the
board.

[1] https://www.toradex.com/maivin-modular-full-stack-ai-vision-system

Laurent Pinchart (5):
  dt-bindings: iio: dac: ti,dac5571: Add DAC081C081 support
  iio: dac: ti-dac5571: Add DAC081C081 support
  dt-bindings: vendor-prefix: Add prefix for Au-Zone Technologies
  dt-bindings: arm: Add Au-Zone Maivin AI Vision Starter Kit
  arm64: dts: Add device tree source for the Au-Zone Maivin Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../bindings/iio/dac/ti,dac5571.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mp-maivin.dts      | 236 ++++++++++++++++++
 drivers/iio/dac/ti-dac5571.c                  |   3 +
 6 files changed, 250 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-maivin.dts


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
Regards,

Laurent Pinchart


