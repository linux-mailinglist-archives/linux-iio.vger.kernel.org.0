Return-Path: <linux-iio+bounces-6830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E19155A9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABF32895E7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68319F46B;
	Mon, 24 Jun 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ddbnn60w"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2713DDC4
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251188; cv=none; b=GLoV8AcVBe3PotTfE0XrdfOTYgWpRFZ8hl8RmcJZI4HZfm6sPzPDKc+9anhaIlb95qm5tnZrQ4M1Tvtx4x2iX48urCDwyDMsGYQ6vvt/v/UEJxqdm2eRR5Djdx6ztuzHdG/1tjJWsck+YTgpAT8Q6lOYr2d0av3WBN+NZinFT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251188; c=relaxed/simple;
	bh=KJGCsFmhkqnxn3llCnTfuFfWP450qdCXSSwJxcawRIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwD2ZQpyoSZNPT+5PzuJ3m9s4w4kupfvrNwxJylqWScEt0dTuX0pL65zKlN9hqJjABc6MtedfaSpB3Y9irp4SeP44nKiQqBL2TJ/YXWDN23j6eyTwYfODDu+HmTju25pvP83Na47F4VpJsqeqEo+4vUUnFsGoCDJlj6Zgb1uxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ddbnn60w; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719251183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qRmcQBFuWsPTqKpm4FXHlkVwKO5dFEa8B7NhZYqTzuQ=;
	b=ddbnn60wckERqVd4VGyRRJrrKZfBhlCvFjLkdROpByRmeTigXeF/9c4dKbLOkcOAdC65DU
	vyltokkbZwTGs2t6x/DEzdPLHO+GVWy+96tsk4uVlStaRHnoSzQ//e7iucRLjxE9meKBj9
	cXkB2Pfg2FxAsKlNCtr4l6vQHWX0YN8=
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 0/2] hwmon: iio: Add labels
Date: Mon, 24 Jun 2024 13:45:59 -0400
Message-Id: <20240624174601.1527244-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for using IIO channel labels for HWMON labels.

Changes in v2:
- Check if the label exists before creating the attribute

Sean Anderson (2):
  iio: Add iio_read_channel_label to inkern API
  hwmon: iio: Add labels from IIO channels

 drivers/hwmon/iio_hwmon.c       | 45 +++++++++++++++++++++++++++++----
 drivers/iio/iio_core.h          |  4 +++
 drivers/iio/industrialio-core.c | 23 ++++++++++-------
 drivers/iio/inkern.c            |  6 +++++
 include/linux/iio/consumer.h    | 10 ++++++++
 5 files changed, 74 insertions(+), 14 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


