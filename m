Return-Path: <linux-iio+bounces-27372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02187CDFF60
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8509F300BD9E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB673254A0;
	Sat, 27 Dec 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX4SjqWB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3B324B22;
	Sat, 27 Dec 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853747; cv=none; b=q8uT5njTP87fTTEj/DDBPijJcl37nP3qV7C5Zi9lfd+hRCKvWYrNBQ7CpMl+NaxP8jHihrFJ4++0dVCVe/TZzd0ZEVmE8W+kYn89cedkEpOP7Tbc6sV9SbS3vZlGRISs8BQJ35rU+w91GgelK/g2wr1bUJxKl66jhB5WAimCRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853747; c=relaxed/simple;
	bh=frKC2hjrSjQqL23j0BFVMIqv5PhzEQPP2TOi0JSQs7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdkbmICDplYmGug9Zm6ZBHLBpGiOYjtQFiEoGO+BRm93r5718l+SP8PKirD5prO8ICqCKbo2Q3jcnKhtAIhowZ40QbKi/843f7p8ZSGEGsor8ae/+dyDyVl7istf18MkNalomQyKeZX454nvbWXmp0D6c7XbO1Aa1J2knK4HqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX4SjqWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB58C4CEF1;
	Sat, 27 Dec 2025 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766853747;
	bh=frKC2hjrSjQqL23j0BFVMIqv5PhzEQPP2TOi0JSQs7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oX4SjqWBN3CiRjonsimNJ1IN7Q65Ak8zZLxho6BBDH1yoToiUHAZ9dWoX52186IR4
	 9zDSaTYMi0Ntf8TD1H3ViTc/AtW14MmttPzS4Ouzl51h/nyevwp/0cP4RRk4IllTze
	 G21BRaIo595x4r6aqW661XGnKWmgwD/gDb/tBgYvQUjRT+6lbkPMPSC2G4CfCZN+Hq
	 DAxTFTAIyqC5fcZPh0JDzQvrytOaZoN1hUWIh/08wjNW6xGKz7dSLaNjB6esr2BcSC
	 tKAA9kaN5HnRlV4i7RlKXVSzBn9MkGiJKilLgg/EFD2sLwtXddq4Xl2zucdLYJ6FYu
	 G2wRQySkbikmA==
Date: Sat, 27 Dec 2025 16:42:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Fiona Klute <fiona.klute@gmx.de>, Roan van Dijk <roan@protonic.nl>,
 linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd4x: fix reported channel endianness
Message-ID: <20251227164219.5ffa1b60@jic23-huawei>
In-Reply-To: <64181fc9-4795-4c5b-97de-a9482eea4bf4@baylibre.com>
References: <20251213163226.1678707-1-fiona.klute@gmx.de>
	<64181fc9-4795-4c5b-97de-a9482eea4bf4@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 10:41:04 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/13/25 10:32 AM, Fiona Klute wrote:
> > The driver converts values read from the sensor from BE to CPU
> > endianness in scd4x_read_meas(). The result is then pushed into the
> > buffer in scd4x_trigger_handler(), so on LE architectures parsing the
> > buffer using the reported BE type gave wrong results.
> > 
> > scd4x_read_raw() which provides sysfs *_raw values is not affected, it
> > used the values returned by scd4x_read_meas() without further
> > conversion.
> > 
> > Fixes: 49d22b695cbb6 ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
> > Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 

Oops. Seems I queued this up but never replied to say I had done so
(or updated patchwork). This is on the fixes-togreg branch of iio.git.

Thanks,

Jonathan

