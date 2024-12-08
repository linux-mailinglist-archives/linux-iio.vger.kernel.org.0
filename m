Return-Path: <linux-iio+bounces-13249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF249E8747
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8A18855EA
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB75189B84;
	Sun,  8 Dec 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxtE1kKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4B1EA65;
	Sun,  8 Dec 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682361; cv=none; b=YS9TY4cHl+uJLc0rjGtPCUj+cXe2V5tsfpjJF0gjm1OHsxqP0VTaGZbqmQg7uvscDnGc7uPOo5Hk1N30zUJUGqwmOvV9z50w/nYGT7aqN9F/8bikPVBrzuQqB3+zntJ4qjaiSjM/cJPKXUA/013mbmq4gmvt7jgQMtUOBqKpZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682361; c=relaxed/simple;
	bh=ZlAEwvanh8CCMftkCtbAApvzcPFguurRr96kF4Mfg1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXP/jxJlFQhd+7fXGQ2Q2kJRsF+szXm0vliFpRLGEUcdSr2DV0O7Ak1BrwzoUkUydqCp6gCHJgHKbdVLdxTNY+FaIoXIBI21ybieB/aoOyCM7hpRX4RASZz1tcuZZ5o4MsqkoqtDabZc6VKElk0+4cfjmnh9mTkaXAolV80LVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxtE1kKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D54C4CED2;
	Sun,  8 Dec 2024 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733682360;
	bh=ZlAEwvanh8CCMftkCtbAApvzcPFguurRr96kF4Mfg1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxtE1kKanDbA20NOpzVCGlbICIPWYm2KU7ZdXMJ6acqnHGhZEXFJUqUIGYVZqKrBy
	 HVPG7HlDWV0vxxK47KwkCT49GcR3pP20arlnv34quAbH3DEnxokAUm0J5zY8u4Pw0h
	 c4IwqELxcMN0P0lCN5/NHnDxNhEO8ptsu2XDFLE9oL3OW/aDyN3KCreWyMQO+vQSbj
	 OlsFuPmrFMsem6t4s7Y7iMuYPsfd0s7IpQUL8oowDJK9KpfbU1cPZU9xrPqCHQ6Ymk
	 bSJtUQfXu0McCbYAg2qsSBczheFR701yu2XaBkhvyZYTv6LhoxRmrgmZrRarref7C2
	 eMBiLTt1LGM/A==
Date: Sun, 8 Dec 2024 18:25:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: kx022a: document new chip_info structure
 members
Message-ID: <20241208182553.42f13c05@jic23-huawei>
In-Reply-To: <xfjchvcsoeuqz4j2rnqait2jqok7p3jzrs57n4hgzykkqhqkoj@so7z326jfrzv>
References: <Z1LDUj-naUdGSM6n@mva-rohm>
	<20241207180201.51deb7ce@jic23-huawei>
	<xfjchvcsoeuqz4j2rnqait2jqok7p3jzrs57n4hgzykkqhqkoj@so7z326jfrzv>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Dec 2024 18:42:56 +0100
Mehdi Djait <mehdi.djait@linux.intel.com> wrote:

> Hi Jonathan,
> 
> On Sat, Dec 07, 2024 at 06:02:01PM +0000, Jonathan Cameron wrote:
> > On Fri, 6 Dec 2024 11:26:42 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> > > The kx022a driver supports a few different HW variants. A chip-info
> > > structure is used to describe sensor specific details. Support for
> > > sensors with different measurement g-ranges was added recently,
> > > introducing sensor specific scale arrays.
> > > 
> > > The members of the chip-info structure have been documented using
> > > kerneldoc. The newly added members omitted the documentation. It is nice
> > > to have all the entries documented for the sake of the consistency.
> > > Furthermore, the scale table format may not be self explatonary, nor how
> > > the amount of scales is informed.
> > > 
> > > Add documentation to scale table entries to maintain consistency and to
> > > make it more obvious how the scales should be represented.
> > > 
> > > Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > Applied to the togreg branch of iio.git. Initially pushed out as testing.
> > 
> > Mehdi, if you want to give a tag (or more feedback) I am happy to rebase
> > for a few days.
> > 
> > Jonathan
> >   
> > > ---
> > > Revision history:
> > > v1 => v2:
> > > - Improved wording based on discussion with Mehdi.
> > > 
> > >  drivers/iio/accel/kionix-kx022a.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> > > index 142652ff4b22..d18d56cef098 100644
> > > --- a/drivers/iio/accel/kionix-kx022a.h
> > > +++ b/drivers/iio/accel/kionix-kx022a.h
> > > @@ -137,6 +137,14 @@ struct kx022a_data;
> > >   *
> > >   * @name:			name of the device
> > >   * @regmap_config:		pointer to register map configuration
> > > + * scale_table:			An array of tables of scaling factors for
> > > + *				a supported acceleration measurement range.
> > > + *				Each table containing a single scaling
> > > + *				factor consisting of two integers. The first
> > > + *				value in a table is the integer part, and
> > > + *				the second value is the	fractional part as
> > > + *				parts per billion.
> > > + * scale_table_size:		Amount of values in tables.  
> 
> I just noticed that the '@' preceding the added members scale_table and
> scale_table_size are missing, but I guess you can add those when
> rebasing ?
Good spot ;(  I'll fix.
> 
> --
> Kind Regards
> Mehdi Djait


