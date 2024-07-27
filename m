Return-Path: <linux-iio+bounces-7963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3D93DF48
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CC22835FA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D578C70;
	Sat, 27 Jul 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZhyBL+U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF48F6D;
	Sat, 27 Jul 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083316; cv=none; b=LlwtwvrXHC8M7PXHKrNuQS5MYzSA7t9SvVCyfRcmZ/U+K3lh4EEBbX5eOqkRTARlw6A/ruVJ8n0w5BSxskVZVeYJ2eMHVPvbyHt6JBkwqAyVpE6Rxjxpu1eSfepo2vHmuLG3BsD6PPREy2AUaNUbAviFhqUDZIXZDgV8xuC0TOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083316; c=relaxed/simple;
	bh=gaWflVk0sdpSfl5Qb8wW22ZLQgPm5FtRJR6Hgel64p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZpkXdRDvEXHTxH8a5hRO0Nun1rs7JwfU5PAz2Rie6w+qBxJhmGA3ODfH7RdYZqwm3c9sCHbXliWNL1QHAPs7NQpkBS/Ihy+dG5W1yFKd3YulvdJvgteylmrDRwm1CIP4x0mM2FAZgrz5psIQYD5yvkDZS5dK75PJfAic8lAbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZhyBL+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1B4C32781;
	Sat, 27 Jul 2024 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722083315;
	bh=gaWflVk0sdpSfl5Qb8wW22ZLQgPm5FtRJR6Hgel64p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZhyBL+UGj8eyHg+7qNqpfVI8MeXZqqiI6MA0xIHq11fgvyeklrcZrpu9i9yI4f9E
	 HHQwU27AQa/74SNjr74FvVG4S4cjXzT7rwK7qMm4TfTP7GIWZ9BD+ki2aFXDJmgt63
	 LTAABgbpSUxaPJffUtFhOWJCdm8cg/y3gimy2xe3ZHbwUJ00rq2UJXf4Ik217Hr50I
	 AEslzMGDJGdRYk9aDH8YxYEns3gr51GikqeyGZFw8j2QrQfYW8MDCI41fXus3oZ52A
	 d+zXbofQxxG8RdVLAVr7GwQ5b+HfvjmiyZkdB818fypynfRaNpZmJBZ2jYf4LcmAWD
	 2lre8HhiKAJ8A==
Date: Sat, 27 Jul 2024 13:28:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: ABI: generalize shunt_resistor attribute
Message-ID: <20240727132826.64c5f2be@jic23-huawei>
In-Reply-To: <669f733746811_7023703c@njaxe.notmuch>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
	<20240722-iio-pac1921-v3-2-05dc9916cb33@gmail.com>
	<20240722210716.09ca4223@jic23-huawei>
	<669f733746811_7023703c@njaxe.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jul 2024 11:09:11 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 22 Jul 2024 12:03:19 +0200
> > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> >   
> > > Move ABI documentation for custom shunt resistor attributes into the
> > > generic iio documentation file. Exception for pac1934: leave it
> > > untouched since it does not comply with common iio ABI generalization.
> > > 
> > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>  
> > This stands on it's own even if the driver needs a minor tweak or two yet.
> > Hence in the interests of not having to remember I've read it before,
> > I've queued this patch up;
> > 
> > 
> > Applied to the testing branch of iio.git. That will be rebased on rc1 once
> > available and pushed out as togreg for linux-next to pick it up.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> Thanks Jonathan, should I remove this commit from next version of this patch
> series or should I keep posting it?

Please drop it from future versions.

> 
> Best regards,
> Matteo


