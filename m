Return-Path: <linux-iio+bounces-6648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C40911422
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 23:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1C1C20E04
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A67F49B;
	Thu, 20 Jun 2024 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mn+Zc874"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33F7D417
	for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918001; cv=none; b=jqyfmsiZmW1I1nvzE0PVh27vxVKfryiuw9v/4AYqWngepST2Qmtj2iiSkPec9PzSAy+Bdjvb61GEy+G6CWYM48At1NXIS8mOfgrvkOWVZS2p2YyHYdRHkDZ6m3Ja1KU8k1CdBSTObI2c61d8IFIjN7YFzwKnMZk5+zjL0Ajbejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918001; c=relaxed/simple;
	bh=4R/hmM5DhHgRr9zX/FKiuPPmuZZhyDhreZk2qsyxjBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+KEYXP6LWvrWl9Fv8S+EWdfwejz72rPauX6u/OFvvSfuSOYpSqlyYjcCRB+6V55fw73PnKDyumt4sWpOWkIJgBlOjgNuFqzZ2gkVWhCPCoFZXmIrEPfJxmq5ibmwVEiR980KRnqpCqTyZDt8zD8sjjJk2lNqg5xxUYbE3LDNcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mn+Zc874; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718917996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3F/8CvL20eESB7gcMx7eZWODBujihhNzXkhob3X1cqs=;
	b=Mn+Zc874xS2mU7SKqENdOU57/0K2/SN7HPoA9dxd3nAGUB4z75W5BJKCWFeZuDy4j716ua
	crN8yPD4/WCbpLIDXozXrNpN2Rn/v98xpVMU6bBUHWNYZaRnFeH5xLYy+fEqVGnx6ejKrx
	I7MKnQnCG5rPiwTbvuFjMIIEkGPloLg=
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/2] hwmon: iio: Add labels
Date: Thu, 20 Jun 2024 17:13:07 -0400
Message-Id: <20240620211310.820579-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for using IIO channel labels for HWMON labels.


Sean Anderson (2):
  iio: Add iio_read_channel_label to inkern API
  hwmon: iio: Add labels from IIO channels

 drivers/hwmon/iio_hwmon.c       | 33 ++++++++++++++++++++++++++++++---
 drivers/iio/iio_core.h          |  4 ++++
 drivers/iio/industrialio-core.c | 23 ++++++++++++++---------
 drivers/iio/inkern.c            |  6 ++++++
 include/linux/iio/consumer.h    | 10 ++++++++++
 5 files changed, 64 insertions(+), 12 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


