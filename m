Return-Path: <linux-iio+bounces-24133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CBB58FF2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D0216B245
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F41285406;
	Tue, 16 Sep 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5FY4Rwm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90804283CA7
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009859; cv=none; b=j5syMGolvJtmoKn95RN755lyi4uJ5YJsyH0DvVloEH63rxPBQuAeYPnFc5RoeXTlVDWQZ74H1mmA7YqX54n2z5RSbM7qfxhGF/Uczsi0d8BCc7ByQE8gWeuexCbJEujXXEJyF1sLiWNx1DzJ3bK2YuuzjoQgoywssgcWgPHSnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009859; c=relaxed/simple;
	bh=X8SgeEytaWETb7nh/wwlat3cVzjHv71duxrA2yPy2f8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=f9XYjT5f4bR6AXom1aB53WSEPqQyaHxjFmIpMApno2HC7eHKZj1EMJlQsUV6appDFFszTljULRrB572awyK2Rm6kthcXXWLteKXGIB8adLgkrsHKn9kGmcWYw8AQZYt3txuJaCX5DB72Bfjsp+QHOsRrAJNH+UE9C7wg8lWDzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5FY4Rwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF5C4CEEB;
	Tue, 16 Sep 2025 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758009859;
	bh=X8SgeEytaWETb7nh/wwlat3cVzjHv71duxrA2yPy2f8=;
	h=Date:From:To:Subject:From;
	b=p5FY4RwmegWCXFhagFyK6VpGBcp2CRyBsU54Tggkmz83FVKs8CzO4T+GdjU/n7pl3
	 wF2mnxcLYq9kCraYY3ygtKBYVIBIPgeQshTFk7hztJhdylCgf/8l6LiTvT+YC93A60
	 Z2X+8YixM9VR7EtezgLqBdpLWtKy+KOPE3sigQ9npzhELNJ7OGR3H1ySqAfz8SGHhz
	 4oZnTTXzHlZcB67NQLX96waevLyTWMaMg4ExvQBotmMUE+F9RuqrJIvC/355fxBFMr
	 mQOEi+0wpkp8pSi+AlcHu/Zw5vF7v4WMlOSR31h4rFth0OGR9lePbAS0/HYs4BrQA5
	 Gl1jUtPSj9c1w==
Date: Tue, 16 Sep 2025 09:04:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of fixes for 6.17 (or 6.18 merge window given
 timing)
Message-ID: <20250916090413.48a78014@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.17b

for you to fetch changes up to 3379c900320954d768ed9903691fb2520926bbe3:

  iio: dac: ad5421: use int type to store negative error codes (2025-09-01 20:43:43 +0100)

----------------------------------------------------------------
IIO: 2nd set of fixes for the 6.17 cycle (or 6.18 merge window)

adi,ad5360
- Use a signed int type to be able to hold a potential error return.
adi,ad5421
- Use a signed int type to be able to hold a potential error return.
adi,adf4350
- Ensure rules on VCO frequency and prescaler values are met.
- Fix a wrong offset for the clock divisor control field.
xilinx,ams
- Unmask alarms correctly if an event is disabled and re-enabled.
- Fix a wrong register field mask.

----------------------------------------------------------------
Aleksandar Gerasimovski (1):
      iio/adc/pac1934: fix channel disable configuration

Michael Hennerich (2):
      iio: frequency: adf4350: Fix prescaler usage.
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE

Qianfeng Rong (2):
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Sean Anderson (2):
      iio: xilinx-ams: Unmask interrupts after updating alarms
      iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK

 drivers/iio/adc/pac1934.c             | 20 +++++++++++++--
 drivers/iio/adc/xilinx-ams.c          | 47 +++++++++++++++++++----------------
 drivers/iio/dac/ad5360.c              |  2 +-
 drivers/iio/dac/ad5421.c              |  2 +-
 drivers/iio/frequency/adf4350.c       | 20 +++++++++------
 include/linux/iio/frequency/adf4350.h |  2 +-
 6 files changed, 60 insertions(+), 33 deletions(-)

