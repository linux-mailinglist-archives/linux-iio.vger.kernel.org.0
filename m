Return-Path: <linux-iio+bounces-23098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA0B2F646
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3975AC41B5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2EA30C352;
	Thu, 21 Aug 2025 11:14:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70430BF7F
	for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774871; cv=none; b=Eoxkq0pjupcAg1t05VXBY8BdvvkRYarsSjVNdSHpNc8eylpZIYywdwbumYN02DBIRkz9fndIAfD8h9B3DaTRczLtinOIOJIubvRZF2Q2ib8jO57ERz232PWcQQaQ9ealnF7OhJbtBXcvBYiS6efAPLtOEuJDcfShR0akLgvcbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774871; c=relaxed/simple;
	bh=KzKRZYg6UYoEJ54lFuvpm/UX/8DOsiCsq0ftZ887CSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLPP7xD25r8iC/7P4lCY0lUsVn+w3r9d3gjX7x42l1odGSAsPfVDuFHmrzX+brCAocq4MX2o+0vSAFM8tboErt7R+5hynQsWGD7dbd3v50i1nrAaSW5o/Cm79c1ITmulBaxEBFBIjIxOSvZ9nW+JCtUncxfpUfAqVBgOmtU08a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 07:14:21 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <2025082107-spiritual-centipede-ae66d0@boujee-and-buff>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250818035053.32626-1-bcollins@watter.com>
 <20250818035053.32626-4-bcollins@watter.com>
 <aKbn39Ek1pOVO7rb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKbn39Ek1pOVO7rb@smile.fi.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 12:33:19PM -0500, Andy Shevchenko wrote:
> On Sun, Aug 17, 2025 at 11:50:51PM -0400, Ben Collins wrote:
> > The current driver works with mcp9601, but emits a warning because it
> > does not recognize the chip id.
> > 
> > MCP9601 is a superset of MCP9600. The drivers works without changes
> > on this chipset.
> > 
> > However, the 9601 chip supports open/closed-circuit detection if wired
> > properly, so we'll need to be able to differentiate between them.
> 
> ...
> 
> >  static int mcp9600_probe(struct i2c_client *client)
> >  {
> > +	const struct mcp_chip_info *chip_info = i2c_get_match_data(client);
> 
> I believe I have commented on this already, please, split assignment...
> 
> >  	struct iio_dev *indio_dev;
> >  	struct mcp9600_data *data;
> > -	int ret, ch_sel;
> > +	int ch_sel, dev_id, ret;
> 
> ...and put it here.
> 
> > +	if (chip_info == NULL)
> > +		return dev_err_probe(&client->dev, -EINVAL,
> > +                                     "No chip-info found for device\n");
> 
> Wrong indentation.
> 
> Besides that I have commented as well on
> 
> 	struct device *dev = &client->dev;
> 
> at the top that helps to make the code neater.
> 
> ...
> 
> Since it seems the comments were ignored, I stopped here. Please, find previous
> emails, take your time and fine grain the result for the next version.

You're looking at v4. The latest is v7.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

