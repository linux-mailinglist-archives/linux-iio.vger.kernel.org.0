Return-Path: <linux-iio+bounces-2727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EC859822
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F71028169E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82A6EB50;
	Sun, 18 Feb 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnWNgGpU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB61E57E
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277265; cv=none; b=lpi9M/5q+gyX6HZvs6Os9vNE8dkRkaTTrRTPMEefLnBmnQrTN0la1G2kIZdKDMKuHvtdhuoLWub9Xq+W/eAg7TPaVVU/QzpOpkIVtOrBb6mkbAWG2U9ixUamK0dHJty05mrIlQx4FNfLTOfzfGG9urq5KNMJSw/M+3hWTpLvEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277265; c=relaxed/simple;
	bh=DFZXgu2m8CIKKnicq7E8EghgO4hQ/juT9RadYTksj5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ulxQhNPC3hTW+rd4GkcipidV5CJj9iTIWVeMj3sXgMcYWTXHMkildlfzyrdiwLCvr/MwZBKOayArpEqLo7FI71i7HYJxoJJRcveTqjFjURY7QhdNcVLO5AoSfBoUkbYPASLQF2HVTiCSS8Y5f0FKeFcZJPnFQQe92u2qCASIMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnWNgGpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9010DC433C7;
	Sun, 18 Feb 2024 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277265;
	bh=DFZXgu2m8CIKKnicq7E8EghgO4hQ/juT9RadYTksj5o=;
	h=From:To:Cc:Subject:Date:From;
	b=HnWNgGpUePufjd5OTstb3KZFlj416I9f9HxpKBpb+TwtHTpHyh3+0x2w3YMeDZx1K
	 lSUlY8WTwiAeV7k8jqbUVJ7gaC9Z0aWfKd4qHYCJXVg3DLdccGuBboS14L62BsFuDn
	 EjTUVk2JlohiVYN7l29LGTPDEZWrDWPjwyHOdHfFRUFwK3E+KVJ5LR7lXV8M215F+4
	 KYFZgRjUPG0AH+q/PHLL1GB2IxWxgYk3fCVcg1FlX3IjRCUDFjwAah7bx0alQAvbmt
	 MR4oiQmedx7a9ArEdf6HuGmhUb6nR6irBJl7+6sdVAmWPGZWd7a619teVjVeQ2HU8G
	 MOiWpIrdu4OUw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] IIO: Convert DT specific handling over to fwnode
Date: Sun, 18 Feb 2024 17:27:23 +0000
Message-ID: <20240218172731.1023367-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Andy pointed out that some of the drivers I was using as examples for
"[PATCH 0/8] of: automate of_node_put() - new approach to loops."
should be converted over to fwnode / property.h based handling anyway
at which point the device_for_each_child_node_scoped() handler could be
used instead. He correctly observed that it made more sense to make this
transition directly than to improve the device tree specific handling.

So this series does that and also some of the other drivers that were still
using device tree specific handling.  Note the rcar-adc remains DT
specific due to it directly handling maching against of_device_id tables.
It probably doesn't make sense to move that custom handling over to
fwnode.

I included one devm_ cleanup patch in here as I was touching the
driver anyway.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Depends on:
[PATCH v4 00/15] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/T/#t


Jonathan Cameron (8):
  iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode
    based.
  iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify
    probe
  iio: adc: ad7124: Switch from of specific to fwnode based property
    handling
  iio: adc: ad7292: Switch from of specific to fwnode property handling
  iio: adc: ad7192: Convert from of specific to fwnode property handling
  iio: accel: mma8452: Switch from of specific to fwnode property
    handling.
  iio: accel: fxls8962af: Switch from of specific to fwnode based
    properties.
  iio: adc: hx711: Switch from of specific to fwnode property handling.

 drivers/iio/accel/fxls8962af-core.c |  10 +-
 drivers/iio/accel/mma8452.c         |   6 +-
 drivers/iio/adc/ad7124.c            |  55 +++++------
 drivers/iio/adc/ad7192.c            |  38 ++++----
 drivers/iio/adc/ad7292.c            |  13 ++-
 drivers/iio/adc/fsl-imx25-gcq.c     | 140 +++++++++++-----------------
 drivers/iio/adc/hx711.c             |   5 +-
 7 files changed, 115 insertions(+), 152 deletions(-)

-- 
2.43.2


