Return-Path: <linux-iio+bounces-6323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D3909C9B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8CA1F21693
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957A60B96;
	Sun, 16 Jun 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3zNC5Wf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B543169;
	Sun, 16 Jun 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526984; cv=none; b=ojYkEg4ASNjGmkt+1SX0AjqlmlDnmMqJb9X1E9WEeZzROLFmm6cbMdirQpxDo5I8PlLKk9gdSDENl1eai9tnZa3MnRcwU6FVDj5LWORWRmk9NKYK4Wv4rKjebZeJ0N/zc4f9apiafKQxBwfJlgeTqMSVIIOuUvYX/c9yZRc+iH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526984; c=relaxed/simple;
	bh=Hqj3a5a9i+YbUSirp7SLHfyN0FVYo+jl8r4IKf+Ssrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt/SvaVg1BPXDVj++rWYy5uEyc0kamSVNpqhAyfraZILB12aTxwn6uR8ScJaqpiQFcocxD/Zx4OU8gvTIxkihCRgruLs+yQw3SudLTJMPBvuCbTqn9mTaAJP+IiQdwo8Qphm33D9mVIsS1DXkUztlUU1VdfeXb5DdlEFC5S3olU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3zNC5Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6420EC2BBFC;
	Sun, 16 Jun 2024 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526983;
	bh=Hqj3a5a9i+YbUSirp7SLHfyN0FVYo+jl8r4IKf+Ssrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3zNC5WfiEX5XlH+fGuNW4AGW0yTboVqQFLMHpLfeMhO5xGJ3ItIrVMFYWlMYEWkv
	 5Kj7pz/OyPObgARx7TaDo2NleOWutQXhAwvOHiPYozne/kbZTsDuPm8xh8ZbI7YQal
	 pmt71W3lizabqA6Qt6uI1iv0wac/5I5rz430bYDWmtdnbgPGmexqjPoiela09h4sGG
	 KLf2zxlbeUUHHEyERm7QX1dfNFl8xy62uHSd0nPKYzoE8DiW9tGSHbTO+BV9MEaCh4
	 MSzOSBhetJpbNHW2li9cZyIw9MCRCR2Af+7BEjvo8F0ZYBQuuSasUUcyL0qFdp2Mph
	 QxirzOpvgio6Q==
From: William Breathitt Gray <wbg@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] counter: ti-eqep: small cleanups
Date: Sun, 16 Jun 2024 17:36:15 +0900
Message-ID: <171852695355.2480388.6972474400297991607.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
References: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=475; i=wbg@kernel.org; h=from:subject:message-id; bh=8Chq+fZNMQ6oGLxSjvj5BDcjd3eGdRR2PY8CTl6darU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDGl5i7+tsjg/e7LJvYdVX8rLEmYHiSzjM/jz3PWwVTJTu A/XLmnnjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAit1IY/vCLtl85INA8p7Ok /cB/bQdlh+s//fVlzDceOlGawxEgw8jwP6t/xqNb5Vn2VRrshzM3CH37XnH5qFLSmZjtMw1OqU9 VZwIA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sun, 09 Jun 2024 15:06:14 -0500, David Lechner wrote:
> Judith got me looking at this driver again, so I noticed a few small
> things that could be cleaned up.
> 

Applied, thanks!

[1/2] counter: ti-eqep: remove unused struct member
      commit: 42c1debf9b68d5f7c6deacda5fa1a8b83722c052
[2/2] counter: ti-eqep: remove counter_priv() wrapper
      commit: f045f1e1cc530f34688f9e71b1aeef6fece0f514

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

