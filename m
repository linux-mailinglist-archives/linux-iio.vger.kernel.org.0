Return-Path: <linux-iio+bounces-28009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC0D3B9BF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 441333045FFB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A02FFDEA;
	Mon, 19 Jan 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFvA+6E0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043232AABD
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857685; cv=none; b=eu+vVgkL9lK2IdSHpcCE7rX46MCLA4RuciHaHas5OTP5gfdvUSBH60vtWUy7WCnSF5syDCftVTX68H7yZ3tb4zz7hJlsIIaVmYIDU2MEn6eCNChVWS6SgsZu0R9E2VJ5EzbLWlfGe/8b7ZYhxsZ2DPF50ORALRR9O69zgeVO9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857685; c=relaxed/simple;
	bh=g1OtilV9v8HHqx3zWzeUeu2I8rCDBf8zN7geWZjIM70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIv5ooE+4Wsw15Hv0k9aGhBKT3cfHaG2dDpQNXPrAXwi27PkxjaNOInouGH3FX6C3EcHBr0e3WMqPfTdXDwnJYx4wnWU1GqiAO1Ygl5qN/aa0g5lel8PWQ7xS8jOtQC/zsM0GRgkj/dqxekImjJi6RcS2UnQ7MxT4YAl6fXQygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFvA+6E0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61CC19422;
	Mon, 19 Jan 2026 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857685;
	bh=g1OtilV9v8HHqx3zWzeUeu2I8rCDBf8zN7geWZjIM70=;
	h=From:To:Cc:Subject:Date:From;
	b=ZFvA+6E0W5BNNyw8If5uTbiZ1F4+a6MTkrXQpJQfOBp2MzvYJGnt+0CW45YHc0G8v
	 FFGRpHHB6YXWnXnd3OAF4n5Y2MxiWKoxsAsjxIlvUbbu+NqKtBICSNmplHw17NubIF
	 A6i7KIP+KvkC9oUrPh1VxYIkNSz7gyVuoZyeGkcejJlfOCf63OAuvI6uWSzpEdmQ4Q
	 MMGYhwaXKoKiHV4DRoCLidTLCF3aZgXSPk9LIn6Bg24PFwj3Ic2GYubkezQ8ap/y2S
	 ov7f7UIchJeAjcHWw0Mk7HahpZsneQsx3gVRdfMnaJ4Qadv5ttAn0ZJ7WWKKPSMjll
	 KfmCz6FkjH73A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/11] iio: adc: Improve include relevance for some ADCs.
Date: Mon, 19 Jan 2026 21:20:59 +0000
Message-ID: <20260119212110.726941-1-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

So this is a continuation of experimenting with IWYU to ensure that we
follow what I consider best practice in driver by including all
headers that are used (subject to some slightly fuzzy rules for some
of them standard kernel headers).

I was focusing on cases where kernel.h was included and moving from that
to the more specific headers. That partly explains why there were so
many headers to add. However, it is also clear that many standard
headers (mutex.h for example) were missing from these drivers.

There are a few notes and questions in the individual patch descriptions,
typically where I have either decided to ignore a recommendation or
conversely have broken things down more finely than IWYU was doing with
my config files.

All comments welcome.  Whilst I don't consider this particular high
priority (much of it was done in a train where I couldn't access my
email)m I would like to provide more examples in tree of what I consider
to the right way to do things!

Thanks,

Jonathan

Jonathan Cameron (11):
  iio: adc: ltc2471: Improve include relevance
  iio: adc: ltc2309: Improve include relevance
  iio: adc: max1027: Reorder headers into alphabetical order
  iio: adc: max1027: Improve include relevance
  iio: adc: max11100: Improve include relevance
  iio: adc: max11410: Improve relevance of includes
  iio: adc: ad4130: Improve include relevance
  iio: adc: ad7124: Improve include relevance
  iio: adc: ad7124: Replace device.h with more specific includes
  iio: adc: ad7192: Put headers in alphabetical order
  iio: adc: ad7192: Improve include relevance

 drivers/iio/adc/ad4130.c   | 22 ++++++++++++++++++----
 drivers/iio/adc/ad7124.c   | 17 +++++++++++++----
 drivers/iio/adc/ad7192.c   | 32 +++++++++++++++++++-------------
 drivers/iio/adc/ltc2309.c  |  9 ++++++++-
 drivers/iio/adc/ltc2471.c  |  8 ++++++--
 drivers/iio/adc/max1027.c  | 18 ++++++++++++++++--
 drivers/iio/adc/max11100.c | 11 ++++++++---
 drivers/iio/adc/max11410.c | 22 ++++++++++++++++++++--
 8 files changed, 108 insertions(+), 31 deletions(-)

-- 
2.52.0


