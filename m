Return-Path: <linux-iio+bounces-27899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498BD38F43
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 16:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8119301FF87
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABCB217704;
	Sat, 17 Jan 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9pETcyi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06BCA4E;
	Sat, 17 Jan 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768662756; cv=none; b=q8mN/UpQ6mpnx5c9mzKmCfc6P2LNY6TYs/klMlhY0o+X9FQEQkLG0/+gVPQ86yC2bP9t/FUrSldtOla4IvqbWuSMPzFdHt8GeC7OkjUvWHtAMHBz/9K+Rstz3kgZD1auwL5eFh/oO5F2EwFeC8fWFq8IcvoXMpkwZF7s+eLqhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768662756; c=relaxed/simple;
	bh=umIiPY5ervCOX2MPCXih/Zj/EiCfh2mMYmVVMRypvY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GibP+ecWMH01ec3PbxiqDAKAcCmBJgMV91seyDoGo7dGhriLaCEhj1jQcs4x/MXIBgWQouNgAFIc+Vg35DNaQa4y4ueILZ9rtj406Lr+pNZ6D2ymwSikhn4MaHcqUZvlIKZhngltbscZPzNcekvBbU2/V/anHxiy2EnjNKCrTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9pETcyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2AEC4CEF7;
	Sat, 17 Jan 2026 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768662755;
	bh=umIiPY5ervCOX2MPCXih/Zj/EiCfh2mMYmVVMRypvY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9pETcyiyQsiMAnJzstlgs/Q5OG6MggZtOPQ80c3p7AWioldKTZ0Jp5S9QmvXPkiz
	 TwLfKxfpSt3WGiekjNhlPmaUCeWb7P5u5ekfxManjP1UlvER3IxIClcaHWbJhn5KYx
	 T9NdbVtceRXEazbiFoOViEdeRtHtL4txzguR9/bLKN+dzgUynkRsoGVC86Eju8X7AL
	 DCYKEiwB8jhVxoYsHgfa60qaL6h2Tyk9s9T3IJmil0TfmwqaOsM1ALsqe4KC40u7ym
	 YJaSrtUlsQJld1+K9vFrYUKuHdYoRtmmvAE6ZbqeMWS4KYVvsQBGphRKbx3GThhIoC
	 lrFmD/hmIDh7w==
From: Sasha Levin <sashal@kernel.org>
To: jic23@kernel.org
Cc: Michael.Hennerich@analog.com,
	andy@kernel.org,
	brgl@bgdev.pl,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jorge.marques@analog.com,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linus.walleij@linaro.org,
	linusw@kernel.org,
	linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org
Subject: Re: [PATCH v4 0/9] Add support for AD4062 device family
Date: Sat, 17 Jan 2026 10:12:32 -0500
Message-ID: <20260117151232.215213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251227163506.2fb90815@jic23-huawei>
References: <20251227163506.2fb90815@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan, Jorge,

Heads up: the AD4062 driver uses the deprecated I3C API which was
removed in commit 9904232ae30bc ("i3c: drop i3c_priv_xfer and
i3c_device_do_priv_xfers()"). This causes build failures when
merged with trees containing that commit:

  drivers/iio/adc/ad4062.c:471:24: error: variable 'xfer_trigger' has initializer but incomplete type
    471 |                 struct i3c_priv_xfer xfer_trigger = {
        |                        ^~~~~~~~~~~~~
  drivers/iio/adc/ad4062.c:472:26: error: 'struct i3c_priv_xfer' has no member named 'data'
  ...

The fix is straightforward - migrate to the new API:

  - struct i3c_priv_xfer -> struct i3c_xfer
  - i3c_device_do_priv_xfers(dev, xfers, n) -> i3c_device_do_xfers(dev, xfers, n, I3C_SDR)

The struct fields are identical (i3c_priv_xfer was just a #define
alias), and I3C_SDR is what the old wrapper used internally.

-- 
Thanks,
Sasha

