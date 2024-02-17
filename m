Return-Path: <linux-iio+bounces-2699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7888590F0
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643F11C20E6F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D981D53D;
	Sat, 17 Feb 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okQGxwkZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3E1E86C;
	Sat, 17 Feb 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187514; cv=none; b=o+BRRpe7lkt9LSyddZlJN3ykkJmwuKk1hPVcfBgTSAnG9OH5HLT5zTH91vVUHwCnxYZHgBeABPCHtcDP/3fXY8iDxdKWsrsp+yvyn9GuZtigSsItwJ77LMO/426EqtrhqeKvDLgY+ib4qwlcNnWuSLmRLY7SgngpIWEkWGBIQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187514; c=relaxed/simple;
	bh=4XRIxHr9mSDH0aNp7dMPc0Gan/B3/tdvebU5I4ixx20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+wm/JQpVN6B9tJVY1+yk0wgDgP/yDUWFoqOIWaMi4DNuwDjXSRTsBpHR5PAnNbPn+AvajBsdY8HvzovhJu0rm2obfEn6gRFiFkYAWzNZQmqjcVYWAmxVlAnEYp8nbGo0gUwv0ozhfD/qvrtP+VA38jqT8NpbAYj9ucMI/HCbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okQGxwkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB610C433F1;
	Sat, 17 Feb 2024 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187514;
	bh=4XRIxHr9mSDH0aNp7dMPc0Gan/B3/tdvebU5I4ixx20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=okQGxwkZkOJuRr/zCoiBaYI7lN3xUuvnXO2S/cPP2QabIo1Ai9Yt83xp8zMwwkwr2
	 0T5XvSuPgZCAh2BoCkK5zNX4qEer1qJhT6cLqv5+vqdBve/Th77ZNOWt6gRK+OInO0
	 9KIs+tpBmcejYzUXyYsW8SWQP1BawJMlZAF1t/UgRuysh09biA6OmK6An/ac1N1Osd
	 xwnDwCJuJMcyyQBolsmFMph0aNpaj10SahmRTDdt5uZAtWUe+e9tJ9aB1PZVZsNw87
	 WmWlNl6zYyqoDBIdrz0xMQYN7nCClB7vKQIo7Wf2qkbo3or+oNUzMzdo5uK0jq6anx
	 hYC2r0oCYDdfw==
Date: Sat, 17 Feb 2024 16:31:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 04/15] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <20240217163138.72e185de@jic23-huawei>
In-Reply-To: <Zc-jSerjhYjfndDg@smile.fi.intel.com>
References: <20240216175221.900565-1-jic23@kernel.org>
	<20240216175221.900565-5-jic23@kernel.org>
	<Zc-jSerjhYjfndDg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 20:02:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Feb 16, 2024 at 05:52:10PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Similar to recently propose for_each_child_of_node_scoped() this
> > new version of the loop macro instantiates a new local
> > struct fwnode_handle * that uses the __free(fwnode_handle) auto
> > cleanup handling so that if a reference to a node is held on early
> > exit from the loop the reference will be released. If the loop
> > runs to completion, the child pointer will be NULL and no action will
> > be taken.
> > 
> > The reason this is useful is that it removes the need for
> > fwnode_handle_put() on early loop exits.  If there is a need
> > to retain the reference, then return_ptr(child) or no_free_ptr(child)
> > may be used to safely disable the auto cleanup.  
> 
> ...
> 
> > +#define device_for_each_child_node_scoped(dev, child)\
> > +	for (struct fwnode_handle *child __free(fwnode_handle) = \
> > +	     device_get_next_child_node(dev, NULL); child; \
> > +	     child = device_get_next_child_node(dev, child))  
> 
> You haven't changed the indentation of backslashes...
> 

I've managed to send out a stale version as definitely did update
that.  Sorry for the noise!

Ah found it - I managed to commit it on patch 15 not this one.

Will move it and send a v4.

