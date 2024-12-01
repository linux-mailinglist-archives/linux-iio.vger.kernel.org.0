Return-Path: <linux-iio+bounces-12917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774239DF5A7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 14:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8D0162BA4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCD1C830D;
	Sun,  1 Dec 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqLpTHPm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A628687;
	Sun,  1 Dec 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058134; cv=none; b=i1Owc4j//iGCiTPb+GO4+V881idqXSB1ruoli4CCNi08BMKOm1h7iZe8FGft8kHwxSE85hmDPdH8TOS7Q//QDVK0kYglVTp9koK+kFFXeaiF/wgLdKfMwU982rdrShEYTg6Of9RAX/mV+T0mjYw6AJHlF2VImoLI5HdAFixSoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058134; c=relaxed/simple;
	bh=0Ma+nkdDmYaAt8VTjIxe5NKx3mhEpEl4RlavIfegqv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTIqYpwjQFCU0gRxuUvpAqBv3NsbnjnW15dxoEgqLnGcaIR4iDY1MRgDJCSIZK8c1OgGwyWKVRi4jxDNNJ7qzIeeNAcL5fJTph8WLo2aqLfI8H/fn5U/ZwOyDvDYosrb1dEw5cXbH+VMXZBejuWf9xbeQbEA9c7s/Vay44mFzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqLpTHPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48D0C4CECF;
	Sun,  1 Dec 2024 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058134;
	bh=0Ma+nkdDmYaAt8VTjIxe5NKx3mhEpEl4RlavIfegqv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqLpTHPme8emU7BAhbjJ3E/kQi+TWtix2OVYE4K5s6lO5uQ8z/7zMtcGBycTF84HW
	 cIR6NTm9yZiYKH9ioDte7m7Ax7CeyvVlmM5RbN7v5x0asBF6mga6jCkq4vRON4I5Sr
	 ee/oouDZnLdOwmpmBy0BGZzzKe7ckLJHln8UgwPmmghcqwWlYyfS8WjCkJupdQM/30
	 8xjsPED8KfEToHCUOSdWvGDpIw9XyMjnt7PQOmn2qBWb8zKQkziTqTrSNZF5RxPJvD
	 q9guxIS/qskjZz/uKGs5dM0ee9cxLb5T+XMEfEaYISNwcvi6kUgEUp7GFZ7rhU+yoC
	 mOW/JEGLRX+7Q==
Date: Sun, 1 Dec 2024 13:02:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: veml6030: add support for triggered
 buffer
Message-ID: <20241201130207.57a30306@jic23-huawei>
In-Reply-To: <20241124-veml6030_triggered_buffer-v3-1-565bb6b4b5c8@gmail.com>
References: <20241124-veml6030_triggered_buffer-v3-1-565bb6b4b5c8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 19:59:06 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> All devices supported by this driver (currently veml6030, veml6035
> and veml7700) have two 16-bit channels, and can profit for the same
> configuration to support data access via triggered buffers.
> 
> The measurements are stored in two 16-bit consecutive registers
> (addresses 0x04 and 0x05) as little endian, unsigned data.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.

Thanks for this and for fixing up the other cases where holes weren't
initialized right!


Jonathan

