Return-Path: <linux-iio+bounces-16556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9AA57B0B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2673ABD8D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4B1DDC04;
	Sat,  8 Mar 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFbFVnCm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E91DD88E;
	Sat,  8 Mar 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444465; cv=none; b=ePZdd2H3NIIIQ+YkpGevZ7qA6kz6AlaRPPoMvSnSJW0Vn9noW/UDK2NECwe91WJ9Z0gsZ9KnSKAp3XAo5v+0ZJoXSycTnEvUWpiHUX/ZiDnGct+DGZ7S3CF9Ozf6G9VA8PMWtCED6S6zDe+MShEZ7sgB4VpcMDMOcafShBweYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444465; c=relaxed/simple;
	bh=JlXljSV3xOhanWQXOIoVuzLatbTFPo+EY2eimlZ420w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyHl8kPLB0y2KHaZyJCbitmwLdVQmHTk/09gRqmqNDGSHImt+oBaFCccjjXIPVbHwMFrUs8EAXKal8OQdOCBRFGIuQBWHdA5kojygpLcWHNAEZAkKGLompPXPF2UD8wrH1ByVTEJ7tBr/h+GVvlbxyJdpucg6v65SWPpUoWXTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFbFVnCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7164FC4CEE5;
	Sat,  8 Mar 2025 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741444464;
	bh=JlXljSV3xOhanWQXOIoVuzLatbTFPo+EY2eimlZ420w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFbFVnCmO5BlgeXfJEr4REucTDTJ2lEblx8g0f2SRGRIz2wAtzguDrmiwPxsdU/yT
	 iWS/FkccIuNe6qTmrHXuVZuabN6Ook7J/jCmeQ/XdB0XHHS4WZhKhO7pWTBtRErvCZ
	 cj5jcOCmglGxlm/cqbLhclar8zKxCDq6QNSYiZgY4vwr8VyZxkjQrdiLhJI8USHKEN
	 9H40eli3dk3DKX3DHb5BDmbQZKedyLgDjvjALSD026l8hFd8rACGHASz70O64JbHpu
	 V6NTgABrirM+BL9Pmjrb+gsdbYAGqyGPtYhMXr5wxC/h+T+FWRIdRsN/GdqHTwD1K6
	 5erVmP6//lWpw==
Date: Sat, 8 Mar 2025 14:34:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jun Yan <jerrysteve1101@gmail.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: gyro: bmg160_spi: add of_match_table
Message-ID: <20250308143417.0a8fd8e0@jic23-huawei>
In-Reply-To: <Z8psFU4mhW76jFqE@debian-BULLSEYE-live-builder-AMD64>
References: <20250306145740.32687-1-jerrysteve1101@gmail.com>
	<Z8psFU4mhW76jFqE@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 00:46:29 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/06, Jun Yan wrote:
> > Add the missing of_match_table to bmg160_spi
> > driver to enhance device tree compatibility.

Wrap commit messages to 75 chars.

> > 
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > 
> > ---  
> 
> LGTM
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied with commit message wrap tweaked.  Initially applied to the
testing branch of iio.git to give some exposure to the 0-day bot.

Thanks,

Jonathan

> 
> > 
> > Changes in v3
> > - Adjust the content of the commit message; there are no code changes.
> > - Link to v2: https://lore.kernel.org/linux-iio/20250220165001.273325-1-jerrysteve1101@gmail.com/
> > 
> > Changes in v2
> > - Fix a syntax error (a missing comma after the .of_match_table = bmg160_of_match).
> > - Fix the style issues found by checkpatch.pl.
> > - Link to v1: https://lore.kernel.org/linux-iio/20250219150254.24664-1-jerrysteve1101@gmail.com/
> > 
> > ---
> >  drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> > index fc2e453527b9..ac04b3b1b554 100644
> > --- a/drivers/iio/gyro/bmg160_spi.c
> > +++ b/drivers/iio/gyro/bmg160_spi.c
> > @@ -41,9 +41,19 @@ static const struct spi_device_id bmg160_spi_id[] = {
> >  
> >  MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
> >  
> > +static const struct of_device_id bmg160_of_match[] = {
> > +	{ .compatible = "bosch,bmg160" },
> > +	{ .compatible = "bosch,bmi055_gyro" },
> > +	{ .compatible = "bosch,bmi088_gyro" },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, bmg160_of_match);
> > +
> >  static struct spi_driver bmg160_spi_driver = {
> >  	.driver = {
> >  		.name	= "bmg160_spi",
> > +		.of_match_table = bmg160_of_match,
> >  		.pm	= &bmg160_pm_ops,
> >  	},
> >  	.probe		= bmg160_spi_probe,
> > -- 
> > 2.48.1
> > 
> >   


