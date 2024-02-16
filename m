Return-Path: <linux-iio+bounces-2656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47689858445
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59B6B23BB1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4855132460;
	Fri, 16 Feb 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayplJ0JV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20B130AD9;
	Fri, 16 Feb 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105103; cv=none; b=abIMJteF0x06VOTBap27PLzB/Fun+M0+HvDoztnZh1zTZlQtb9JJ1Xj9mcPsPuLNuuxV5egQ+W2ow2Z6tNDRDep4QgKXk2Ih+thw99Tj140s5nTrzQQznMXqbon64GE2UIRXWmtxpBXGe99nmGfJ6zT+wJ3d/SwvTNAW+sGBfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105103; c=relaxed/simple;
	bh=9c71sdMeQbqB30OeR0l0j4kKQHd9fhotPKXLMWNpiFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOwsL+QpeJNquzKKgxPkqXYxa+Xi/1o9etzvtZF+fP4k5NSgvgsHsxnrNpcwsiBvlXsY+0zu2v3NKE2ER8k/ibRmkzcatlSKSIgBa+29+tsT0G5uccdz6WmdeoNcg/oQ+dMhM7DjFlz3UaWaZN5QtG1c/QzBp5lFhfsRb9oidm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayplJ0JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E60C433C7;
	Fri, 16 Feb 2024 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105102;
	bh=9c71sdMeQbqB30OeR0l0j4kKQHd9fhotPKXLMWNpiFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayplJ0JV4aU1XHwfiH/iQa9TncrzCrU4ECdQGY5/tHVPYzMFRXn8ZEM/VazAm6eaX
	 3+vJdIVvD9MC+qHw2WSGEDnLqGWy5+X52rTyEyRZtLasAI11oJyV+A6VO4bautCyx5
	 kmTR+dS3pdxtCVDD+m9dyFaTgAJvukOIcNb+FKFflVLDN2v/u45YkZotjNbFF7XuJk
	 Jtw/ZqOd2Ww5vxe8BrEfnnNWtTHUXoZxSvvUqjW8lkCoI2QNK4aMd+9IuaJxmRJyJc
	 7qZwQjwr8WCqmKWarQ6bT+tlo3hrTcd/5uziZ+Bdwe2GIBRIybEsP4rt2l3IH3sDyA
	 CUTSPZmPkvb8w==
Date: Fri, 16 Feb 2024 17:38:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Len
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
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 03/14] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <20240216173806.3749c818@jic23-huawei>
In-Reply-To: <ZcujDu0uQJqndFEs@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
	<20240211192540.340682-4-jic23@kernel.org>
	<ZcoK0Q8NgxolNeD8@smile.fi.intel.com>
	<20240213102529.00003bf2@Huawei.com>
	<ZcujDu0uQJqndFEs@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 19:12:46 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Feb 13, 2024 at 10:25:29AM +0000, Jonathan Cameron wrote:
> > On Mon, 12 Feb 2024 14:10:57 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Sun, Feb 11, 2024 at 07:25:29PM +0000, Jonathan Cameron wrote:  
> 
> ...
> 
> > > > +	for (struct fwnode_handle *child __free(fwnode_handle) = \
> > > > +	     device_get_next_child_node(dev, NULL); child; \    
> 
> > > Please, move child to a separate line, so we will easily see the all three
> > > parameters of the for-loop.  
> 
> Oh, I should withdraw above, we have other for_each macros there with
> a child being combined with previous line.

I ended up moving it down to the next line (so it shares with the update
term).

That seemed better than having it on the end of the line that is still finishing
the initialization term and felt similar enough to local style.


> 
> > > That said, indent the assignment to the right as
> > > well.  
> 
> > Indent makes sense - but (to save another respin) how far?
> > Next tab stop will be a bit random looking but I guess nothing else
> > makes more sense.  
> 
> Just make whatever TAB stop that doesn't require adding any spaces.
> 


