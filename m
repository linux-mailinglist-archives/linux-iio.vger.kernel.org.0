Return-Path: <linux-iio+bounces-22693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3733B255C5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99009B6007B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0842F39AC;
	Wed, 13 Aug 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akuzHPj/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712482F39A3;
	Wed, 13 Aug 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121390; cv=none; b=r4QUH3lJb9snOe8SeWCDOKookpdqzev3MRQK57vIHQBofey4MnqAkHsY5nGwdLFWHxrVEbC6NXQzC116++Htjq8aFPLx+izlxDM1S6WvAAxKnd+aJsQEHG1cfxPZj3ZbGYxWdu6hsH5VHhmTc8DTqy146MaqU/gQA+umeBVFKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121390; c=relaxed/simple;
	bh=vNOMFop6b7QXAPlMFznjXkcqq5QtdQnZgK1D0mDl5RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTfZQc8cT4GLZ9PcBnrxVJ+XmjARFtjxSgzT9qMXhzlGWx6OCfEYDzsAgDHW8lK9L+UW0Eovw2zwMJzt2Nbr/PydSs0pk2ld5ChaXgu+1nSwyWXq1f6HlkpFhFEptenbLtp4DJ7igSlz8dQRviWfwxTXy8KUt14H4UJETyV+YmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akuzHPj/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755121389; x=1786657389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vNOMFop6b7QXAPlMFznjXkcqq5QtdQnZgK1D0mDl5RU=;
  b=akuzHPj/o4XK8m7Qfjut+30sYi+HtWFTa151d9ehSuiMWbe90hljepLJ
   hAGFliTbbOSt849WWCPMdotOgWOXY5cNKkAkOFvc7Tr9jfvBx6KMvwmOq
   Hxzi4guUGLbLqz9q0ytoLWjcTPAkeaJRi513W1zY3C3TjxpwVT1xAaBdg
   Q1gmxe7vkoXk2JPmuJs06xYrX6cQJT5K3UjEat7GWM2GGjLtFgvPaq0Ap
   GOJYffQV+X3XYznB8dEDQcsmtF3bhAXPcvZzC9o3hHXIdzX4w1n4fGw8K
   +cQZRuEYAZq8PtE3neWGd3kdeuiZvZiqR1iXsnijnHLNxWiZXvdHQirP3
   Q==;
X-CSE-ConnectionGUID: gB0SwNnbROmI5WankK+oFg==
X-CSE-MsgGUID: HPGjAER1Qd2uGcvUG7B1Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="60055959"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="60055959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:43:09 -0700
X-CSE-ConnectionGUID: juI7VGPnSCS6aKyE27r4uA==
X-CSE-MsgGUID: POxqJ+nsQ/W/QY41ngLZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="190293389"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:43:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umJFQ-00000005W8R-0lt8;
	Thu, 14 Aug 2025 00:43:04 +0300
Date: Thu, 14 Aug 2025 00:43:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Add device powerdown
 functionality via devm api
Message-ID: <aJ0G542k3K4jGrrw@smile.fi.intel.com>
References: <20250813133017.72476-1-akshayaj.lkd@gmail.com>
 <aJyYJLMUYAm_uqUx@smile.fi.intel.com>
 <CAE3SzaSNV4DMUQB5rQQSV+QsCS6Z2BjFkFD3eaXO9J=TjUbNYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE3SzaSNV4DMUQB5rQQSV+QsCS6Z2BjFkFD3eaXO9J=TjUbNYw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 07:27:09PM +0530, Akshay Jindal wrote:
> On Wed, Aug 13, 2025 at 7:20 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Aug 13, 2025 at 07:00:14PM +0530, Akshay Jindal wrote:


...

> > > Set client data with i2c_set_clientdata().
> >
> > This is not used anymore, correct?

...

> > > -     data = iio_priv(indio_dev);
> > > +     i2c_set_clientdata(client, indio_dev);
> > >
> > > +     data = iio_priv(indio_dev);
> > >       data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
> > >       if (IS_ERR(data->regmap))
> > >               return dev_err_probe(dev, PTR_ERR(data->regmap),
> >
> > So this hunk needs to be removed from the patch.
> I thought so, but removing i2c_set_clientdata would mean that
> dev->driver_data will NOT contain a pointer to indio_dev.
> Irrespective of usage, ideally dev->driver_data should contain legit value.

NULL is legit value for driver_data. The rule of thumb is that we don't assign
something that we know will never be used. Also think about debugging issues,
with the "legit" value in some pointer it may lead to not noticing a real
problem or to a problem that never exists if driver_data left untouched.

> Hence I kept it.
> If you feel otherwise, I can remove it, but I feel this should be kept.

I feel definitely otherwise.

-- 
With Best Regards,
Andy Shevchenko



