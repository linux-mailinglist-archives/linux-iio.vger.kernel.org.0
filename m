Return-Path: <linux-iio+bounces-22770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E878B2844B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BF93B853D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D2257851;
	Fri, 15 Aug 2025 16:47:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6F257837;
	Fri, 15 Aug 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276435; cv=none; b=kmy83JBfWDmZ/5iFXgfo3ok2ta+KgmcmkjKa+SIEM5ueP5nD2MuMQQ3yUweyLy2uwCz5q3DRFV13lcU8Ws19BbBkOSa4IQcpGuta9OQDSQqnWfRF6AA2ZnOsJ4LsBoS65Dj7AZ3TNRhWn3vG8z6kV21HZt9VDe+vgGPgLx9bxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276435; c=relaxed/simple;
	bh=x7tndlkYkK0f+ND5GLHBi0hV+UtOcv3u6wqalLlGpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FreLBEHGoaREj8yNyjRxsUc3/+v6YKsIOPfMYNtLmBdFT+KmJszQlo0I3/2lqjLP84fP6MGGwfP4S+VPdJRiXd+iC7PDb/BOs4tZoz5Na8m3rBa/O0HNlX31qaYgivzAZ2Ui+AT9GMHo2VF9ozHsTTb6Wbq/sNPxmufpDoasUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Collins <bcollins@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: [PATCH 0/5] iio: mcp9600: Features and improvements
Date: Fri, 15 Aug 2025 16:46:02 +0000
Message-ID: <20250815164627.22002-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ben Collins <bcollins@kernel.org>

ChangeLog:
v2 -> v3:
  - Improve changelogs in each patch
  - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
    * Set register offsets to fixed width
    * Fix typos
    * Future-proof Kconfig changes
    * Convert to using chip_info paradigm
    * Verbiage: dt -> firmware description
    * Use proper specifiers and drop castings
    * Fix register offset to be fixed-width
    * u8 for cfg var
    * Fix % type for u32 to be %u
    * Make blank lines consistent between case statements
    * FIELD_PREP -> FIELD_MODIFY
    * Remove explicit setting of 0 value in filter_level
  - Based on feedback from David Lechner <dlechner@baylibre.com>
    * Rework IIR values exposed to sysfs. Using the ratios, there was no
      way to represent "disabled" (i.e. infinity). Based on the bmp280
      driver I went with using the power coefficients (e.g. 1, 2, 4, 8,
      ...) where 1 is disabled (n=0).

v1 -> v2:
  - Break into individual patches

v1:
  - Initial patch to enable IIR and thermocouple-type
  - Recognize mcp9601

Ben Collins (5):
  dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
  iio: mcp9600: White space cleanup for tab alignment
  iio: mcp9600: Recognize chip id for mcp9601
  iio: mcp9600: Add support for thermocouple-type
  iio: mcp9600: Add support for IIR filter

 .../iio/temperature/microchip,mcp9600.yaml    |   6 +-
 drivers/iio/temperature/Kconfig               |   8 +-
 drivers/iio/temperature/mcp9600.c             | 209 ++++++++++++++++--
 3 files changed, 201 insertions(+), 22 deletions(-)

-- 
2.50.1


