Return-Path: <linux-iio+bounces-8431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA694FD4B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 07:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDC91C22562
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196833981;
	Tue, 13 Aug 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZgVaabZf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AD249F9
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527659; cv=none; b=VdPPM/9lAITpHiybOe2+OZ01EBV5/kFukqiIShmS2ce2ulJh2ueUZdzQhp8EztAKXezneNDFmiGWN8bmR14H3b1vPbCF6aGhcZSx6Bnq4iIeGwYCjtSvMzxOce0ZRfFBg7+61vqbfQr84OiNHP3kKrBk3YyrKmt/oaGT+q6xGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527659; c=relaxed/simple;
	bh=VIk0lEaUUhiW+DCj1n3E+zXyXxxpb3hN9JClSUe3l5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqPtLFIZjOKlAupgNqDd1P6VlL79O2cNraRz1/KMYQFw31f2VJ1r2mffsmXoDZfiTh/0a/WjXxA9/wV8WLv3lQlaUfRudbgMPOOALlsQPmvY5rrZht29XmPjcTfkSqlDnem/BRXOC3z/F2CeMX5ZJ68zZNKgooSF9U9jpmGET1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ZgVaabZf; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240813054052654d925db234ff4d99
        for <linux-iio@vger.kernel.org>;
        Tue, 13 Aug 2024 07:40:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+M9zDBvZEdUOGRMTAG1WyDuOh1X9fBikCvLdUnq//OU=;
 b=ZgVaabZfsZ/qY0KA/YUCMIcZNxCjmXJFcYG81JkcZlHtyBtN/gU3ppXF/Bh29JBimXAGbs
 nMFNE2yULb3fwmwTi2gH++tvoYiAVgrAF/4aX+2dXmkZ3eTKeeMk8DKNJUSvMjdzL3D0d7YU
 KtZ+VulSwLr8F7aC4J90E27Csl+2D2JbLbUjizwikJbbMxuF48CHsyOJzklZ4j76i/n/2XFk
 cyQzunkTS475egshNGb+Ln7/2H5SIBMPyWUd2loDzOKhTkVwgul6fxsnpLALId36A55WlhRx
 CLwJpNs6duNeaWKY5vwUB9kZACv2sOv2A93HGvfp5UEyaqwhPxV14WfA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 0/3] iio: Add Everlight PM16D17 proximity sensor
Date: Tue, 13 Aug 2024 07:40:39 +0200
Message-ID: <cover.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

The Everlight PM16D17 is attached via I2C and can measure the proximity
of objects optically. Model it as IIO driver and include it into the
device tree of the IOT2050-SM where it is available on the main board.

Note that at the time of writing, the datasheet link is still work in
progress at Everlight (product listed, link still broken). We are in
contact with them.

Jan

Baocheng Su (1):
  dt-bindings: vendor-prefixes: Add EVERLIGHT

Chao Zeng (2):
  dt-bindings: iio: Add everlight pm16d17 binding
  iio: proximity: Add support for everlight pmd16d17 sensor

 .../iio/proximity/everlight,pm16d17.yaml      |  95 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/pm16d17.c               | 324 ++++++++++++++++++
 5 files changed, 433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
 create mode 100644 drivers/iio/proximity/pm16d17.c

-- 
2.43.0


