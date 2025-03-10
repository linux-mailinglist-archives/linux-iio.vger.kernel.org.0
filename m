Return-Path: <linux-iio+bounces-16695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59432A5A450
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E1F1893673
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94151D88D7;
	Mon, 10 Mar 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb/dLF2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63A1CAA8A
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636911; cv=none; b=jAWBtwAMhMhn3L0Xh3QugCpscldjp421abwWd5LxEKirR+yqbPOPYsPDwQ/ow5T5kVcN5WPnegWVzHz85VWNDhzpzIacX4YWiaPvO/T+hiuT/wCAEyflh90y66CtEOmD6Ros9v+sYpnqbJdYHLP2qKxgdy5bl7ert0D0N/ag9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636911; c=relaxed/simple;
	bh=C5fjZk5SaVLvFBGs5YS3Gc6lBiiUI+LEF6zN1olQhbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7Spf/Lsm2zeAieS2fgyCfKZ8bCF5BbdnOkinUInCJlV6PyWps/Gb1UKPBrnf0UZes5Ox/6oVH5xkLZmoPvCPtU4xzIxMPbbvvVP13PIn3Vi+tYRzgjIr5gf9tRMjiXfiXOK3Aqo+/hsqJrV781HGtCwolgoykSjr65HiF8H6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb/dLF2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D48EC4CEE5;
	Mon, 10 Mar 2025 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636910;
	bh=C5fjZk5SaVLvFBGs5YS3Gc6lBiiUI+LEF6zN1olQhbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sb/dLF2/Q/jdQ7LtsW1eK3NRRXnBfarXJuuJ7Iz76RGDhXkuNgjsyAtBnNLQaAmge
	 KzxA5FIqgmsVxYot5gNMJtaVhK+0rJlgtwzj4FOJ+qiHUAMFaTU+yUIKTWhfZu5QUi
	 DSWrIFSiZzLcPDOYORi5bEgfa+S/dLlEGa7EM/oAVphvVzisXPP1bE/L8kyDyRDiOW
	 JYHA1F3gAVy77w6LpyHxVyvIJ6kkzNic288u+l+sq/q5jmvRRjphASWrC/Mk3XuOsM
	 XNZ3Vp6GrW/D4IAFeuI24WbvBsezEAfpdZpzvrGKAXSRP9CUFA4iu/KCV/b6650q8M
	 6tkZsOpsAx0FA==
Date: Mon, 10 Mar 2025 20:01:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Astrid Rost <astrid.rost@axis.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/18] iio: light: apds9306: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <20250310200142.1a91a6bc@jic23-huawei>
In-Reply-To: <5ecd4fc5-a35f-4a2a-87c9-4d0fcb14771e@tweaklogic.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
	<20250309170633.1347476-2-jic23@kernel.org>
	<5ecd4fc5-a35f-4a2a-87c9-4d0fcb14771e@tweaklogic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 17:05:50 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 10/3/25 03:36, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > These new functions allow sparse to find failures to release
> > direct mode reducing chances of bugs over the claim_direct_mode()
> > functions that are deprecated.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> > ---
> >   drivers/iio/light/apds9306.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> > index 69a0d609cffc..fca7e73a905c 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -831,11 +831,10 @@ static int apds9306_read_raw(struct iio_dev *indio_dev,
> >   		 * Changing device parameters during adc operation, resets
> >   		 * the ADC which has to avoided.
> >   		 */
> > -		ret = iio_device_claim_direct_mode(indio_dev);
> > -		if (ret)
> > -			return ret;
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
> >   		ret = apds9306_read_data(data, val, reg);
> > -		iio_device_release_direct_mode(indio_dev);
> > +		iio_device_release_direct(indio_dev);
> >   		if (ret)
> >   			return ret;
> >     
> Thank you Jonathan.
Maybe a tag if it looks fine to you?  Reviewed-by or Acked-by

Thanks,

Jonathan



