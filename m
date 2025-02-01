Return-Path: <linux-iio+bounces-14836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF175A24A74
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEED188791B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2531C5D66;
	Sat,  1 Feb 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVTvgpKM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561261C5D44;
	Sat,  1 Feb 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427765; cv=none; b=H7dHuroD/21tmkDW/9mIaFhtfo5pMPku3NRwHr+50WvA2cFxJu1GovjsaRPcgpqt1o7gzJ2eEB4CgYNqPZgXp2uStjll8S2Viv8YxvaNIMgYSjrgg77IQfZ3arp19W0i7i1NMqwDj4vlwOO1IKm6gz0KUF7v53atVs9V8Uw2hwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427765; c=relaxed/simple;
	bh=Uhi24aMEpwda+AdjN/x5FNlxQ/hnSzoD359XkzL6OjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn+51AdVhrY8w767V/AX3nR03D+lCgjKjrzt5c5m/yTqmogKy+Jv9UlOVz++Gz9VdkHhHUOD45FyE38gKX5IXgZlGpZutBY3ZrvXIhZZItNcxUzh8XZE25b8Uw1pXT6VxNEPhGXHx88ZvoZAD4bJGnGUyKIewlGvseHhNkHEiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVTvgpKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433CFC4CED3;
	Sat,  1 Feb 2025 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738427764;
	bh=Uhi24aMEpwda+AdjN/x5FNlxQ/hnSzoD359XkzL6OjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVTvgpKM591zc2GSxiwgKuTVWKxm65kMGFmMBqVujvgZM78FSmDHuwCCGniF9B9I3
	 Z3pbPBsk3IAvIWRlV3wtHsjrNsUJO/llC8wnUPHuUNKOpTgCZoWZdugnhdiAEbSs4X
	 RGEJLRTWS9T7urBYWBbyheLbeGTeSder30Ky9gdwAHb/GzF8/04ahF2BUhlWjSu93G
	 rdZulBJ9xQzxGk6eFQzXBJbVEmmIVPvPqzXk8hP0QLFzXklveC8hPupDu5f7dCCMSz
	 m9jSBgjnh9wnWwA1XQYAsih2fTyS9DozeJyyJYxqd9VQPl4bhwtEo1x+ZkdFTBicMV
	 LXhU25F++BxMA==
Date: Sat, 1 Feb 2025 16:35:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 01/12] iio: accel: adxl345: migrate constants to core
Message-ID: <20250201163559.015b343d@jic23-huawei>
In-Reply-To: <20250128120100.205523-2-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:49 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The set of constants does not need to be exposed. Move constants to core
> to reduce namespace polution.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,


> -#define ADXL345_REG_INT_MAP		0x2F
> -#define ADXL345_REG_INT_SOURCE		0x30
> -#define ADXL345_REG_INT_SOURCE_MSK	0xFF
>  #define ADXL345_REG_DATA_FORMAT		0x31

Normally I'd be entirely in favour of this, but...
I'm not sure we want to leave one random register here
and move the rest.

Se can move the stuff that isn't register related, but
for the registers I'd prefer to keep them in one place
and I can't see a clean way to move them all to the core.c
file. Even separating reg address and fields within it
makes for a harder check against a datasheet etc.

So I think all we can move is the fifo size :(


> -#define ADXL345_REG_XYZ_BASE		0x32
> -#define ADXL345_REG_DATA_AXIS(index)				\
> -	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))


