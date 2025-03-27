Return-Path: <linux-iio+bounces-17285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA82A735D0
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6931B3BEE8B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C7197A8E;
	Thu, 27 Mar 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEmpVFmt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03912C7FD;
	Thu, 27 Mar 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089938; cv=none; b=K/PYrzNc3A3/J4HmVSTTmXGUzTmuADF0C6F/2lpMkuRfABHblKb7Rb00I6Fm6g4ZD5TO1VFNB8tttCjSctgzl5zvelvYq6ttwsvmSaex+auazQmuDJHNkNkzr5bMjqqB+97Icoo34+RRh3B3BMqzTMeDUleQgf9YHX4Q7Ue4GCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089938; c=relaxed/simple;
	bh=78MgLGQzI79frvLlETDu2bytHR2IyVuj9YMUHUwubLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLF/w7dgNuUklQ1tg5EQbcenjw3g2ghL3sgQKqTNawn9G/cAI46YHISgx0c+rKRvgufQIAkc3M31Q6kNBL+/18Fx6HYUVXCo0VZ5QutstZP3Uvm3/rFH5PNxWjJP9F9h6d+uaWHBixfggASCNkpjR7FG0CYW6EcifT3QcFetp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEmpVFmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE134C4CEDD;
	Thu, 27 Mar 2025 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743089937;
	bh=78MgLGQzI79frvLlETDu2bytHR2IyVuj9YMUHUwubLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MEmpVFmtUb8ETCIa9TetR75heX10WNFmM5xRkncSUt5eEjOl2N857Y5nYJzKRS65g
	 oI9Mk+AF+SsHZ3uQoHRaYUTBBYIPziQeUQVmUYuMn9J2WGBi0rUjO/kMB264amQNSh
	 5s0baN2U9QMEIVqlQWeOtQ2QVmG1Bn0PbT1YdOTAiabHwqijjvuchdsos08tnN4Uw4
	 6Olw9xM2wgdtakf+lHZdyPhbaDXFRdJfn2vhljgrcuoeBJ2gUZ4KsQaoy3ADmEvqr6
	 a4RMxldUFVfIQ0xXVbJsp4MqeL9yiEZPbTJENqUxozEoxZHi6r4SYy372uoteFPDHo
	 e4WvDuU/w1iWQ==
Date: Thu, 27 Mar 2025 15:38:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Message-ID: <20250327153845.6ab73574@jic23-huawei>
In-Reply-To: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 14:26:25 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds some cleanups for the RZ/G2L ADC driver after the support
> for the RZ/G3S SoC.

This doesn't address Dmitry's comment or highlight the outstanding
question he had to Greg KH on v3.  
I appreciate you want to get this fixed but I'd rather we got
it 'right' first time!

Also, please make sure to +CC anyone who engaged with an earlier version.

For reference of Greg if he sees this, Dmitry was expressing view that
the fix belongs in the bus layer not the individual drivers.
FWIW that feels like the right layer to me as well.

https://lore.kernel.org/all/Z8k8lDxA53gUJa0n@google.com/#t

Jonathan



> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v4:
> - open the devres group in its own function and rename the
>   rzg2l_adc_probe() to rzg2l_adc_probe_helper() to have simpler code
> - collected tags
> 
> Changes in v3:
> - in patch 2/2 use a devres group for all the devm resources
>   acquired in the driver's probe
> 
> Changes in v2:
> - updated cover letter
> - collected tags
> - updated patch 1/2 to drop devres APIs from the point the
>   runtime PM is enabled
> 
> Claudiu Beznea (2):
>   iio: adc: rzg2l_adc: Open a devres group
>   iio: adc: rzg2l: Cleanup suspend/resume path
> 
>  drivers/iio/adc/rzg2l_adc.c | 67 +++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 


