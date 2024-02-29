Return-Path: <linux-iio+bounces-3249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1986D420
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 21:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163ACB243B2
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21D13F43E;
	Thu, 29 Feb 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3N//8Ji"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED4142916
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238194; cv=none; b=FQjyX0IJtyGOvDkieK2eu6xst9oUyxZZdd6vaBflZys3+g5ZbqsgnqwZ+4I6n+qdcrhSiYwdGCEAJzgdcoKWpsyuU6nkAidNo1egcveF/6dQvCtZE2/X8DHcVM1vlXsZMjVPlboZncLS5YlnXBryMGv/XDa52z5nK0pJyk2frSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238194; c=relaxed/simple;
	bh=YKgDQiq062VPgmvvzsmoZJ7ZxP7qRZjy6kVx2BPuMno=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jyygCiz2BccyJWovPhIHR8L5x5x/FQtxvk6UxZ4npC9ve9L+rau0aUtSxcvLK1fQTvMzsbdLuAIs0bLh+7K2FQgj2FXZ6LwIOd/MxsnIBejWqT8HmchIyBSIqC01UteTIGGXBC+4vDSLi2yHKi9Tt7Ugbsz0wopbMQyXAv4ohdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3N//8Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74F2C43399;
	Thu, 29 Feb 2024 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238193;
	bh=YKgDQiq062VPgmvvzsmoZJ7ZxP7qRZjy6kVx2BPuMno=;
	h=Date:From:To:Subject:From;
	b=V3N//8JiRAgPXot1XWu1yWtSSPTZbGRz1b6WihiC3h8Q620ByJaFv98CVbXI24Cmm
	 jRzu4U5r1Z4O0KTloIo1e6CNPvZRWhCVGZ8DMcdpDvR4Va4Ptefi55T439WyzGhON6
	 nsmdeEZULjg2sbDpnoSCYPpLrmpgPbJqYjM32hTGgYGQyqEYrYChV0Lx0KV/hQhdB8
	 LKHvede0RmThTx2XSgg4yn7d58MkEYk1VYQow8H/KRTp0lhVIHibqvu8emH5HASTxm
	 VUmM6uKURQnxvjCwQY7AAi8GvvbNjttBOWHvpEhvWnHivEzTofLS1gwTNjGAkaZgRk
	 lOXeC6GMramDg==
Date: Thu, 29 Feb 2024 20:23:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 3rd set for 6.9 - cleanup.h handling of
 fwnode_handle_put() related (not ordered wrt to PULL 2)
Message-ID: <20240229202300.3321cc11@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit d4551c189d6e6a3fcf7f625bd4b273e770fad35a:

  Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-02-25 14:11:41 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.9c

for you to fetch changes up to 64e19caa5564ecc43edaa7fb818d53de650d9b34:

  iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped() (2024-02-28 19:15:43 +0000)

----------------------------------------------------------------
IIO: 3rd set for 6.9 - cleanup.h related.

I have separated this set out from the more normal patches as they can
go separately and that may simplify the merge window.  Greg, up to you
how you wish to handle this in the char-misc tree.

Introduces __free() based handling for fwnode_handle_put() to
allow scope based release of these handles on early exit from functions.

Also introduced device_for_each_child_node_scoped() to provide a
a convenient way to process child nodes without the need to explicitly
handle the fwnode_handle_put() needed on early exits from the loop.
Typically these early exits are a result of error handling or completion
of a search and have proven very prone to being missed.

One instance of such a leaked resource was found during these conversions
though review of that patch was too late for this pull request.

A number of drivers are also converted over to generic fwnode handling from
the device tree specific version.

----------------------------------------------------------------
Jonathan Cameron (16):
      device property: Move fwnode_handle_put() into property.h
      device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
      device property: Introduce device_for_each_child_node_scoped()
      iio: adc: max11410: Use device_for_each_child_node_scoped()
      iio: addac: ad74413r: Use device_for_each_child_node_scoped()
      iio: dac: ltc2688: Use device_for_each_child_node_scoped()
      iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
      iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
      iio: adc: ad7124: Switch from of specific to fwnode based property handling
      iio: adc: ad7292: Switch from of specific to fwnode property handling
      iio: adc: ad7192: Convert from of specific to fwnode property handling
      iio: accel: mma8452: Switch from of specific to fwnode property handling.
      iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
      iio: adc: hx711: Switch from of specific to fwnode property handling.
      iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
      iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()

 drivers/base/property.c             |  14 ----
 drivers/iio/accel/fxls8962af-core.c |  10 +--
 drivers/iio/accel/mma8452.c         |   6 +-
 drivers/iio/adc/ad7124.c            |  55 ++++++--------
 drivers/iio/adc/ad7192.c            |  38 +++++-----
 drivers/iio/adc/ad7292.c            |  13 ++--
 drivers/iio/adc/fsl-imx25-gcq.c     | 140 +++++++++++++++---------------------
 drivers/iio/adc/hx711.c             |   5 +-
 drivers/iio/adc/max11410.c          |  27 ++-----
 drivers/iio/adc/rzg2l_adc.c         |  11 +--
 drivers/iio/addac/ad74413r.c        |  10 +--
 drivers/iio/dac/ltc2688.c           |  28 +++-----
 drivers/iio/temperature/ltc2983.c   | 137 +++++++++++++----------------------
 include/linux/property.h            |  22 +++++-
 14 files changed, 206 insertions(+), 310 deletions(-)

