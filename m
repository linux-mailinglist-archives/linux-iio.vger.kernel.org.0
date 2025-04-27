Return-Path: <linux-iio+bounces-18733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB4A9E32E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 15:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0607ABD23
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C1114D428;
	Sun, 27 Apr 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akDSrTv3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAF84A35;
	Sun, 27 Apr 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758889; cv=none; b=q/uFkbe0G0ESOhqAPbY5l4x594kXMFurexH0pY1/LgqBClEKRyN8q7SRYu54RLhW4C/Y/jWsoh7CO1W8sddsCdsxynjpPLShXlSVjUIHhtgTQ/rWWmSFyU8jUE+Ye/Qgswlz1j5i4yWiE1hnHs90lZFPi9jToD+HPt1f748xpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758889; c=relaxed/simple;
	bh=jKAZnhfe4uFzdmI24dv10h3B5f4znfkAVF0qA0bSa+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU5MfZ6ZQ47KO8NQTTxqModuZQpxgYByhkhaEc5ckUIFuJxbIKGD8gij1kQHrW/3oBjG2bGP8/p+vmwELgXkXKIVtvGttMXJP6a0lRmfgxd5/iAn77IByBOsd8VyAo82IACM9kv/irwksbC80ZBGWWcGL1LFyjj1yWSqXEye0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akDSrTv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3124DC4CEE3;
	Sun, 27 Apr 2025 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745758888;
	bh=jKAZnhfe4uFzdmI24dv10h3B5f4znfkAVF0qA0bSa+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akDSrTv3jrbCQr2euOA4/lYIIJElm/nwRLSJjnLZzePG+4YtAsYx7yEEKJR2DASdp
	 graLqHaJlXu0aFdltKxIHjXNTIr+0dNqsjY131rlqt7IohXNQY406zyfkNaXN6vozt
	 gmt1+xz2klO8D4uQE9Xb8O0A4uZaIQJ5iw08vzCXT6xd+9eh9juiVxAqRa+9gyG0OH
	 5aw/plAFYrqdJWxqR8K1HmFSlsOZgxYN92rOF0mikWcaw7jlz8BFThg5Lx5P1q/GNk
	 Lqt1gG4oO5RIhXezqOTWr5F+hib+z1B8N+IlbzH+6Fpy9R1T81913UBXV5NvFpdei5
	 sXNoZjJxC4o5g==
Date: Sun, 27 Apr 2025 14:01:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 00/11] iio: accel: adxl345: add interrupt based
 sensor events
Message-ID: <20250427140121.2aaafee7@jic23-huawei>
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:30 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add several interrupt based sensor detection events:
> - single tap
> - double tap
> - free fall
> - activity
> - inactivity
> - sample frequency
> - full frequency g range approach
> - documentation
> 
> All the needed parameters for each and methods of adjusting them, and
> forward a resulting IIO event for each to the IIO channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Hi.
As you'll see if you follow replies through. I tweaked and queued much of this
but then noticed some issues in patch 9.  Hence I've bounced it back to you and
backed out the patches from my tree for now.

Please either incorporate the changes I mentioned (or point out why they are wrong!)

Also rebase the whole thing iio.git/togreg so that you don't have the patches
that are already applied in v8.

Thanks,

Jonathan

