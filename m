Return-Path: <linux-iio+bounces-4590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED58B4CA2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD041C208D2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CF200D3;
	Sun, 28 Apr 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdv7s3vf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7536F072
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321057; cv=none; b=q7cCbAEgtkJ14zECvWWySX5xdZ55aO08fM/mc1n3GdSjm4weaI/kUO+y8rT2h+RmAx8V162hNXEk1uuF0N+QWD7yK1APJ4BoDY87DFZNc/2G7ecOwX81hWMD10ZZM9UeU4oqP2YBz4XtaBXygjBTuyIRINxBELfBsYtBYrcOqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321057; c=relaxed/simple;
	bh=dCst2lh3Upy9h3lr1UdDABMmBZPhzgO0avyj+iEVV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQAYYE+kX1TspwAiUZvkZGY85iQ16bDr8Bp3+uK+kUgVOuWAvBYtt+uT+6P/meN7zC8PigAyAskT6IqPU8FrW7qDdROlBV8aKSe6njdhKm68EXbGNBiKTVlyJkhHsRyVqx4V+MdxySQVwtoIyejCG9IU7RguBpMK1/SvW6RX6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdv7s3vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D4FC113CC;
	Sun, 28 Apr 2024 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714321057;
	bh=dCst2lh3Upy9h3lr1UdDABMmBZPhzgO0avyj+iEVV0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdv7s3vf8q5LAvda7mliRJsVrvJpXZcszqrFhPe2bckBkh8cTpq9OD6Z60/fVct1I
	 cIFLD5tD8XXMxllx/zz0ywJPR9W6LY8fuXjkrEQ4hweMryY/OdkAYE6anq+z7igOqo
	 501Qt/W/SENiv7Z7HKqY+Pl+aV0yuhyPlFxjrs4iPYuhePbUzEJYWcYznCsFG5ABrp
	 aREF2/Su7zpBdTrbFKgYvWcTcxM9N6VL+mIcqjfTPMCDgjEZHQE8vK+DWm+qFfMtgA
	 Y0mG1+gLNVdi4ex7nU8PvabPXCkNYwu8mtqNgDXsj07rzkOhA8bwiZwd8AJuDKSIB+
	 IIqvWjHbbPqEQ==
Date: Sun, 28 Apr 2024 17:17:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Pedro Mariano <pedro.mariano@usp.br>, anand.ashok.dumbre@xilinx.com,
 michal.simek@amd.com, Roberto Bolgheroni <robertobolgheroni@usp.br>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: Use
 device_for_each_child_node_scoped()
Message-ID: <20240428171725.5c24b858@jic23-huawei>
In-Reply-To: <ZizBndYiU5GVUtmQ@debian-BULLSEYE-live-builder-AMD64>
References: <20240424225302.47004-1-pedro.mariano@usp.br>
	<ZizBndYiU5GVUtmQ@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 06:13:01 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Pedro, Roberto,
> 
> Patch looks overall good except for the _scoped() function name and arguments,
> must have been miss-typed or miss-copied somehow.
> Comment inline.
> 
> Regards,
> Marcelo
> 
> On 04/24, Pedro Mariano wrote:
> > Using device_for_each_child_node_scoped instead of
> > device_for_each_child_node automatically releases the handle on early exit
> > which reduces the chance of bugs that cause resource leaks.
> > 
> > Co-developed-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
> > Signed-off-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
> > Signed-off-by: Pedro Mariano <pedro.mariano@usp.br>
> > ---
> >  drivers/iio/adc/xilinx-ams.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > index f0b71a122..7f5571d9d 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -1261,7 +1261,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
> >  	struct ams *ams = iio_priv(indio_dev);
> >  	struct iio_chan_spec *ams_channels, *dev_channels;
> >  	struct device *dev = indio_dev->dev.parent;
> > -	struct fwnode_handle *child = NULL;
> >  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> >  	size_t ams_size;
> >  	int ret, ch_cnt = 0, i, rising_off, falling_off;
> > @@ -1283,13 +1282,11 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
> >  		num_channels += ret;
> >  	}
> >  
> > -	fwnode_for_each_child_node(fwnode, child) {
> > +	fwnode_for_each_child_node_scoped(fwnode, child) {  
> should be
> 	device_for_each_child_node_scoped(dev, child) {

Yes, we didn't bother with a fwnode specific version of this macro because they
aren't nearly as common.  I'm not sure why this driver didn't always use the
device form or why it needs the fwnode_device_is_available()
I suspect this dates back to some confusion on why there were _available variants.

Chances are this driver only cares about DT and in that case the callback used is

static struct fwnode_handle *
of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
			      struct fwnode_handle *child)
{
	return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
							    to_of_node(child)));
}

So the fwnode_for_each_child_node() + fwnode_device_is_available() end up doing the
same as device_for_each_child_node().

So I think there are more opportunities to tidy up in here than simply this scoped
change and I'd be keen to see them all done together.

Jonathan

> 
> >  		if (fwnode_device_is_available(child)) {
> >  			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> > -			if (ret < 0) {
> > -				fwnode_handle_put(child);
> > +			if (ret < 0)
> >  				return ret;
> > -			}
> >  
> >  			num_channels += ret;
> >  		}
> > -- 
> > 2.44.0
> > 
> >   


