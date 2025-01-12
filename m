Return-Path: <linux-iio+bounces-14199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A1A0A954
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E62188303C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B11B3948;
	Sun, 12 Jan 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNKK3MRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA273C1F;
	Sun, 12 Jan 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685962; cv=none; b=my6ux+tjBQsuZoGJ83BuvSsgW48DabhPrDUrKDaDPJbLsRPK1XWPNimDVZqGk41EJNreRQuaf/crlHYOtlacvGUT7AyazhyNLGAs7PXFh5vEtOf480QCwo60voHDZk9khLCuQJq0bw4mRMGgJifOX9tfGgF1nEsEkzIEbPG9vPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685962; c=relaxed/simple;
	bh=g2U8Et++mQt6bgW4PRVrXtesqICjkneXCD5BgoH9BNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/m7RhJZKX+hkjK6tu6uivKJdI1YsjMN97D60rLTRBFtLHOUQXwE/XtPIBBrF2Fo3L73LHxuh3WAkl1j6ZL3pUhmnHxqG24Z7AIeUoju1Ra72RKKzufXiXy8Kzt0M905Z+46goROR+3es8C+EU9RA7MfOcMCtOrOpeMCKRSlzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNKK3MRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA71AC4CEDF;
	Sun, 12 Jan 2025 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736685962;
	bh=g2U8Et++mQt6bgW4PRVrXtesqICjkneXCD5BgoH9BNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNKK3MRIG0mO3v4AVhSMC1uc/zvF6tgI4xicLGpT7qZ53Chbd9tKNZr2wI6G2n4D4
	 X/hFl2SiMQSf01qRT2l0l584G/vI1nde20+RgvpIx5prVIkxFsRpK9D5FqLH7ukzuB
	 dhMdVEo/sAUboXo5SggwYBfqAMhygK7xd3VHxkPIpxz2Yu5/Fpqx91LzQa5GJLqS2P
	 yhHLqkJ0okCMRHz3gLc4ouP3/KCKrm6U0weFDYGyplEmQ5y4ttNcQt+P/ihoYW4Dko
	 PSxyEpDh+GSE0BHGFzFWhiWVsJJiynNcuyP7+8cJtoYX2AlOFF+aETDTpquU+Hh9X2
	 3QU5whhB2wciA==
Date: Sun, 12 Jan 2025 12:45:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 61060bc2-6450-4309-8e57-3d1bb32d3ab6@baylibre.com, David Lechner
 <dlechner@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 10/15] iio: adc: ad7768-1: Add support for variable
 VCM
Message-ID: <20250112124552.4eec878f@jic23-huawei>
In-Reply-To: <Z4Mq6RBLWFZuf2Be@JSANTO12-L01.ad.analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<a6999fc24a4c61498e55f23861997382df2ab4f4.1736201898.git.Jonathan.Santos@analog.com>
	<61060bc2-6450-4309-8e57-3d1bb32d3ab6@baylibre.com>
	<Z4Mq6RBLWFZuf2Be@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 23:37:29 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 01/07, David Lechner wrote:
> > On 1/7/25 9:26 AM, Jonathan Santos wrote:  
> > > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > > 
> > > The VCM output voltage can be used as a common-mode voltage within the
> > > amplifier preconditioning circuits external to the AD7768-1.
> > > 
> > > This change exports the VCM as an iio attribute and makes it available
> > > for configuration.  
> > 
> > We model common mode voltage inputs as a regulator consumer (e.g. vcm-supply in
> > DT), so should we make this a regulator provider instead?
> > 
> > It could be used with "regulator-output" to be able to control it from sysfs
> > or if the amplifier ends up in the devicetree for other reasons, the amplifier
> > driver could control the regulator instead of requiring it to by done in sysfs.
> >  
> 
> Ok, that is an interesting approach, I will try this. It makes sense to
> have it in the devicetree. 

I'd be a bit surprised if this ended up being varied in real systems.
So maybe start with a solution that has DT provide a value suitable to the
amplifier (ideally because the amplifier requests it) and we can figure
more dynamic stuff out later if needed.

Jonathan

