Return-Path: <linux-iio+bounces-6407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC290B9BC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CACD28564E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA2196C96;
	Mon, 17 Jun 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="vWtO04Qe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00577134C6;
	Mon, 17 Jun 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649153; cv=none; b=j/T2B5bBVF40kjh+WBwXkRlZnAt28oLhFmqV2pR8Fhqyql7WFDQDj5MlexoYCdTslAiS+i/YdSR/KKFEJFs1qNIaSYteyKUhHR+IZPYXV2mBNCX9HFYk9H8qUi7fFXR19uC/fpeVzz2wHRoVn9lgJgv5Z9zEpM17UzrGKv6dHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649153; c=relaxed/simple;
	bh=pGWjbTAKNqOzg8e2Scbh8f5LQiuhvGZ3A+snYPtzMP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hrDTHeFoAlsT1uAe/cLpByNQjeHDNOTidaLhYD1dFPv8JP91+mJuB/MVeRXqWhyzc/f5gmEaO2PejhvWHiemGVVXyBchbI4uMOr2YMOQr5r3r3lGJZzoafjDXNd41p6ypNX+iSG+ApOlGMwMXu+4VdLPtfzwZq+wiRlaVs+sLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=vWtO04Qe; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 617AD1F83F;
	Mon, 17 Jun 2024 20:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718649141;
	bh=X/C/DPPLKu5EhgyAttcLE+Rp6AWTsiiYoJNQhk8PG+I=; h=From:To:Subject;
	b=vWtO04QeNjRlnea5rtEj2/etU9CL5npUDrdkIdvQ2cil5RJ9zbv3KiMYTRFfhXM9X
	 4+L4sU92NmzbKN1tJKjw+T27nvnlECcpmzjRkHUYCbD6ucgqoThI0tazJygKaASAp+
	 U1TTcDWFHcEh/62Uga7puRcqeI4uHHuAC5JbfPd5fw/d5qKxRJGi8iM3cdDWfVz3Bc
	 7+zkqSeHfyhhQHOv+3+1+oF41kJgVfH6ZqLJPoFb4+GFU7YJEake4FtZQTaSgcvsk2
	 ttsvmLUL2f5JftoahzlF1kmcU1jG+OoUfhSeBhAakWhbruTCCrTHdLIgkDxZgg6LO1
	 z0tYqaEzaF/sw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: ti-ads1119: Add driver
Date: Mon, 17 Jun 2024 20:32:13 +0200
Message-Id: <20240617183215.4080-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The ADS1119 is a precision, 16-bit, analog-to-digital converter (ADC)
that features two differential or four single-ended inputs through a
flexible input multiplexer (MUX), rail-to-rail input
buffers, a programmable gain stage, a voltage reference, and an
oscillator.

Apart from normal single conversion, the driver also supports
continuous conversion mode using a triggered buffer. However, in this
mode only one channel can be scanned at a time.

v3:
 bindings:
 - add avdd and dvdd supplies
 - add Reviewed-by: Conor Dooley <conor.dooley@microchip.com

 driver:
 - add MICRO constant on necessary places 
 - add devm_regulator_bulk_get_enable() to handle avdd/dvdd supplies
 - add power down action with devm_add_action_or_reset()
 - add buffer setup functions
 - add iio_validate_scan_mask_onehot() to guarantee only one scan channels
 - add support to other triggers than only the adc irq
 - add device check to adc irq trigger to guarantee associating it only its own device
 - add a cached value for the config register
 - change ads1119_get_hw_datarate() return  
 - change return location in read_raw() and write_raw() 
 - change return location in ads1119_read_data() 
 - change the scan buf to a local struct with correct size and alignment
 - change ads1119_update_config_reg() to ads1119_upd_cfg_reg()
 - fix over wrap in read_poll_timeout() 
 - remove unnecessary goto label in ads1119_single_conversion() 
 - remove unnecessary empty lines 
 - remove scan mask from the driver state
 - remove ads1119_validate_gain() and call it inline in write_raw()
 - remove all ads1119_cmd functions and use i2c_smbus inline

v2: https://lore.kernel.org/all/20240606163529.87528-1-francesco@dolcini.it/
 bindings:
 - add diff-channels and single-channel
 - remove ti,gain and ti,datarate
 - more details on the patch changelog

 driver:
 - adaptation for the binding changes
 - changed i2c read/write to the device (not using regmap anymore, use FIELD macros)
 - more details on the patch changelog

v1: https://lore.kernel.org/all/20240527154050.24975-1-francesco@dolcini.it/

João Paulo Gonçalves (2):
  dt-bindings: iio: adc: add ti,ads1119
  iio: adc: ti-ads1119: Add driver

 .../bindings/iio/adc/ti,ads1119.yaml          | 155 ++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1119.c                  | 839 ++++++++++++++++++
 5 files changed, 1015 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 create mode 100644 drivers/iio/adc/ti-ads1119.c

-- 
2.39.2


