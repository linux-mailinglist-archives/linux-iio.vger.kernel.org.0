Return-Path: <linux-iio+bounces-24973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BDCBD063B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73774F028C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B82ECE8A;
	Sun, 12 Oct 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guMPckn2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D32EBBB8
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282822; cv=none; b=ltigidvr7bij5fUG49VtN1yXr8UdCktoc0djjFbS7VoWKTonxaaPQJato9OrXbuEPe7URsAjceu0ebHF1HBR6uqoNx5267v1aZhL7T917ocX5yRLDT6PMkMELcfJoSaeSnGXthw+H9IG6hPz8deGl2DiQIoK8wgBf2A+qRoyy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282822; c=relaxed/simple;
	bh=LG3JPApVnDYHNEdBFWOxO8l3zO7UTgrJUeTi9USqmWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufnEFM7ucDGxIoHOHNYzVxpahZ4fShEO3UMu+pc5I0oKyip+HiNkBv0DFynDUlYW20g9AhPlqnb8z3esdApp1c3h90RUPxou7LHQ/Rod4v2hYwxDPk2Bb03wfc0vQcz1dFQAnH1v8faNv3mEjX/OsXTYHCky9QsqT6x4KPrfqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guMPckn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E5C4CEE7;
	Sun, 12 Oct 2025 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282819;
	bh=LG3JPApVnDYHNEdBFWOxO8l3zO7UTgrJUeTi9USqmWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=guMPckn2p/iU4QosYtSC0qrVhMEW80t3TlJXMUJhEB4m1KWDb8ZQY9NX83VEVj8xi
	 Ht67Us2UxYIf/hUdVxta3aUUUApPnTgZKXChe9R8ieEikLrXlJRZkK9VfaY5zMW3W8
	 AB6LYZqKh0RnZM4/BIbgrEKE48wCSrTS7pCIJzdMn4TV4e+yYdSruF6BfYiA45hd6C
	 +IQx+rtEWamH4d8Bdc4zkookXUb1vX2SdSY8x+yNsQYMFnMbBjbgVxo98rrNGcRyV/
	 Ep5ks0Cbhxab1KBx0m03sqwBnnKZ9JQxejG/zeHOOzzx/GCa5ZuthTjRygDjEccvhG
	 eJRfstv5itdhw==
Date: Sun, 12 Oct 2025 16:26:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>, Kessler Markus
 <markus.kessler@hilti.com>
Subject: Re: [PATCH v4] iio: accel: fix ADXL355 startup race condition
Message-ID: <20251012162652.65619962@jic23-huawei>
In-Reply-To: <20251006095812.102230-1-andrej.v@skyrain.eu>
References: <20251006095812.102230-1-andrej.v@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Oct 2025 11:58:12 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> From: Valek Andrej <andrej.v@skyrain.eu>
> 
> There is an race-condition where device is not full working after SW reset.
> Therefore it's necessary to wait some time after reset and verify shadow
> registers values by reading and comparing the values before/after reset.
> This mechanism is described in datasheet at least from revision D.
> 
> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
See submitting-patches.rst in documentation for how to format it, but as
requested on previous version please reply to this thread with
fixes tag.  No need to send a new version.


> ---
Change log missing

Otherwise looks good to me.

Jonathan


