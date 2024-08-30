Return-Path: <linux-iio+bounces-8893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E0965A6A
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BEBB21C5F
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CC16D31B;
	Fri, 30 Aug 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw6s1CII"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985816EB42;
	Fri, 30 Aug 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006874; cv=none; b=o0pqJqPYqONtTWGbQX1Uh6VNIC9HLTgwRj6nK107fiIROBoQdZOqsRsvwCRWkx1wPvn9sLu/oqdzF8zkGYE7vqgYur5HxMVQlZozi2dunM1K5MSXx/+794QKAisGuRqJx2FR0xcnra/ic8BK2vZcmt28n2QgYlZrkWV81+3F8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006874; c=relaxed/simple;
	bh=U9qy+SkXALOXvlSMMq6arVH245/dtt7i7Ysg6+KWb7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suk4bbcx0mWFoNXnas9zLRMKz3zVYHj/WyjEfzEpPvcF5c4RPp0sN6eCTRj5ESZCTq1xwu3/BFwG/bPyvz6GInt0Pt5kZJYXRswq00h10JX/hc8QOcH0GqCW8VUd/8YptwL5Lrdrhg+PTw476NloMbOMTTgSsE4U6tFSJamwXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw6s1CII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352B8C4CEC2;
	Fri, 30 Aug 2024 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725006874;
	bh=U9qy+SkXALOXvlSMMq6arVH245/dtt7i7Ysg6+KWb7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pw6s1CIIZ7F2jb5LjcXbQKQ8uJ/uYDx6FcLM4Bp6MLnTTCYeKrYWpcfsL/bishn6o
	 ox89cSr2bjyyMwcYC6bJEaUGpr96+RqsPg0OcnjpcWb2zP1pfjUu4Jgs3L1sdYzNi4
	 MO7fjhjQzPHmBfC65nsm0mShvkcTKdSBMFE6m1mkLNyuaArpyRLHmHxdnMFJscNpIT
	 VnEEO4EkdU/K7F0Yk7Vs+W4NTa93F1eOmdz/5DIDiPbvjdhK4EU5FR2nGb8vj5NDHV
	 mNPuVSkphDEIGEQfXnzTPzL+vDfPDdAZPSGuuPwcv/FiS5ROZzqdFy2fLk8+KN4A82
	 1OWVlQJqCVJsQ==
Date: Fri, 30 Aug 2024 09:34:27 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
	mripard@kernel.org, tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de,
	samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org,
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de, jic23@kernel.org,
	jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [GIT PULL] Immutable branch between MFD, IIO and Power due for the
 v6.12 merge window
Message-ID: <20240830083427.GT6858@google.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>

Enjoy!

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-for-iio-power-v6.12

for you to fetch changes up to 2e1a57d5b0adbb5bd1d85245ec29b6d3cc7edc69:

  mfd: axp20x: Add ADC, BAT, and USB cells for AXP717 (2024-08-29 13:16:24 +0100)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Power due for the v6.12 merge window

----------------------------------------------------------------
Chris Morgan (1):
      mfd: axp20x: Add ADC, BAT, and USB cells for AXP717

 drivers/mfd/axp20x.c       | 25 ++++++++++++++++++++++++-
 include/linux/mfd/axp20x.h | 26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]

