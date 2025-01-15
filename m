Return-Path: <linux-iio+bounces-14381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF5FA12BAC
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 20:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B994A3A4E71
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E331D79A5;
	Wed, 15 Jan 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us/qWUST"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD21D7994
	for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968815; cv=none; b=ZIN0PF8B27xpXJ/ZRGTddOKOBNtwWdAwmlTvePmsVJ+kad47joLRNpAhzYEGgknj1m4FmYQpv6C+vdIoPmeaZn+VevgrRfDPzq/CNrH13pffch5Hfrdl4SY6/vpPMxecqVTClOXyBxHw/g1+9WrUqjpyMJzPNujYiEr1dUz6KVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968815; c=relaxed/simple;
	bh=CCxHSNGu6q07K/t4aqA68JYg4a4aZ11viQA0tRI3MIk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=EtgY+rOZMfqRaZV1W8WmsGYdKrk9QuWqEOt0otJi12AtGeTp4/xKyMHSEzB8TkW0bNcS5E7OJ/6RO2UOEPKQu0P6Xh7YBW8kfUPHtlvtL5Q/xvivJ3z2AQSMih1ZapVk6VME4StRjLtJKaqSCbcARGnWwKUplSf3mMY/Tl8CXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us/qWUST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB3AC4CEE1;
	Wed, 15 Jan 2025 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736968814;
	bh=CCxHSNGu6q07K/t4aqA68JYg4a4aZ11viQA0tRI3MIk=;
	h=Date:From:To:Subject:From;
	b=Us/qWUSTV8gUAuxLYJWpbfIKxIbwnxiBCNpNyaBCVzyE4mBBu6X/VSF6Hflyb6kJk
	 m62xiopRUyu2Uv+IaedviZNRQFpfK8iruChxVnIyUB7EfTikzUivd5Zy2as2NT0iYq
	 ZxJf+LqRnUW7FjaEbCKBxrttmXIErhL1ZF0TwefkkDKOyoZ9utSz+JA5CfA77ZNxgi
	 D162gW2d4XEoHRNCx3WIvzguWsIrd54NqpXbF9+Wq9RfM0LAm2xZ3HQWv2ZFZ+/Bu/
	 1qdqlHSuRmQIbu2PRmlhgPTgmWVgPd2muWk2yqNFy8SWmNu7vzrMjMpEWGE0fhYvK3
	 xDXox1DRSskXQ==
Date: Wed, 15 Jan 2025 19:20:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of fixes for 6.13 (or 6.14)
Message-ID: <20250115192007.7e022805@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit e16ebd9d839d1252ff15c29d37b0cf303ddd2662:

  Merge tag 'mhi-fixes-for-v6.13' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-linus (2024-12-16 16:30:58 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.13b

for you to fetch changes up to 012b8276f08a67b9f2e2fd0f35363ae4a75e5267:

  iio: dac: ad3552r-hs: clear reset status flag (2025-01-12 13:36:01 +0000)

----------------------------------------------------------------
IIO: 2nd set of fixes for the 6.13 cycle.

Given timing so late in cycle and that they are all confined to
specific drivers, it is fine for these to go upstream early in the
6.14 cycle.

hid-sensors
- Handle processed attention channel rather than just returning
  an error.
adi,ad3552r
- Fix output ranges for ad3541r and ad3542r.
- Clear the reset status flag so that we can pick up any resets
  during operation.
adi,ad5791
- Fix a misleading dt binding example where the sense of the
  interrupt was reversed.
adi,ad7606
- Fix some hard coded offsets that should be taking the number of
  channels on a particular part into account. These were missed
  due to some racing changes.
ams,as73211
- Fix an off by one in optimized path for just reading the colour
  channels.
bosch,bme680
- Fix type of variable passed as pointer, ensuring it works on
  big endian systems and doesn't expose uninitialized data.

----------------------------------------------------------------
Angelo Dureghello (2):
      iio: dac: ad3552r-common: fix ad3541/2r ranges
      iio: dac: ad3552r-hs: clear reset status flag

Axel Haslam (1):
      dt-bindings: iio: dac: ad5791: ldac gpio is active low

Dan Carpenter (1):
      iio: chemical: bme680: Fix uninitialized variable in __bme680_read_raw()

Guillaume Stols (1):
      iio: adc: ad7606: Fix hardcoded offset in the ADC channels

Javier Carrasco (1):
      iio: light: as73211: fix channel handling in only-color triggered buffer

Ricardo Ribalda (1):
      iio: hid-sensor-prox: Fix invalid read_raw for attention

 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |  2 +-
 drivers/iio/adc/ad7606.c                           | 48 +++++++++++++---------
 drivers/iio/adc/ad7606.h                           |  2 +-
 drivers/iio/chemical/bme680_core.c                 |  4 +-
 drivers/iio/dac/ad3552r-common.c                   |  5 +--
 drivers/iio/dac/ad3552r-hs.c                       |  6 +++
 drivers/iio/dac/ad3552r.h                          |  8 ++--
 drivers/iio/light/as73211.c                        | 24 +++++++++--
 drivers/iio/light/hid-sensor-prox.c                |  1 +
 9 files changed, 64 insertions(+), 36 deletions(-)

