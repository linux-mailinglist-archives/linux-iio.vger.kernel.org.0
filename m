Return-Path: <linux-iio+bounces-20816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DCAE2A5A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B4F1645FA
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163A22129F;
	Sat, 21 Jun 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3qlGY/E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28019BBC;
	Sat, 21 Jun 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750523866; cv=none; b=loSPfYKZxjiJKmiIT9Mhxidq8NsQHo1UJ2UKQf1v27JZylxl7Y5Ds3pijF66DeJvtfBiizOMKf1UkdTCJcMFjp9ZGRy1h/VQIJZSZVggwhaWDPffmzpolGq+NPLBLilaC4pSC0HVTeyYGoY098jhLQ4H41yjNY2jORzc/LCbl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750523866; c=relaxed/simple;
	bh=XKLCY5N+Rj77xkasF6iejpj+DVUXT1IxdB49Ucua51A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hE1YZB1oQb9OJxPdnUkmP9/VQQqvh1SGTpODhij3/bDqQYlU3w/umIByKPRiZcdfyz7gHyQDrv76/dH0nMmYJGpDe9+1HUAGCdEkA4xsYDZQ8bb/l1fNNKyEuLF2Yq9ffwXH42V2Nzo0BTjV0idc/Kj8HGs8zgtXRJ38g7EV8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3qlGY/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971C1C4CEE7;
	Sat, 21 Jun 2025 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750523863;
	bh=XKLCY5N+Rj77xkasF6iejpj+DVUXT1IxdB49Ucua51A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3qlGY/Ek6l9P2Bt4Fd/r9izq4nJXnbD5f0GxGwvAJwyMi5n08yij/AyXuHQaFkZY
	 t9V1DL8yNpnyisXHm5PeW1LJmF7tOH20KNSkHrh28Fvq+EeTV7IRAREFvPcUwglvn4
	 IN8qZ2DOjk4kBCjEyNkYGw9RoZeOZz1EbJ0q8SvydYaE6E9oNIUATZSMSoEyaabXZo
	 T2ZAMcnCkoN9M2VUqOZ/Q6Nvan/5hv5nAhTuBN69TRWhk7Y7vIv59aztyktTiOewb+
	 TybBZJ2Wr92vZ5RPU2Gc/vH089UP+MMdsVV+ujIMpfb89GBaB9yVSItXGyrWrdlPxN
	 LXsKCHpVGlrTA==
Date: Sat, 21 Jun 2025 17:37:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250621173735.176184d0@jic23-huawei>
In-Reply-To: <20250616-neurology-explicit-ec2a829bd718@spud>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
	<4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
	<20250616-neurology-explicit-ec2a829bd718@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> Otherwise, what you have here looks sane enough to me - but I'd like to
> see some comments from Jonathan or David etc about your approach to the
> excitation properties.

They look sane to me.  The complexity of devices that handle weigh cells and
similar are always a pain.  In theory we could have a go at describing
the weigh-cell in DT and then try to derive the 'right' settings but that
seems like a very complex thing to do.  Long time since I did anything with
weigh cells, but I think you mostly read the settings to use of a datasheet rather
than deriving them from first principles. Thermocouples are similar (I'm not
that familiar with RTDs)

As to the handling of the different sensor types - that seems like a sensible
way to constrain the binding and end up with sane readable combinations rather
than a bunch of excitation settings with no info on what is connected.

Not sure this is the perfect solution, but to me it looks good enough and
flexible / general enough to cover a wide range of other devices.

Jonathan

> 
> Cheers,
> Conor.

