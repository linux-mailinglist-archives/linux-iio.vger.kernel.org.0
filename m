Return-Path: <linux-iio+bounces-20937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2AAE5DCD
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06151BC050A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27AC25229C;
	Tue, 24 Jun 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZljYiKK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A5BA49;
	Tue, 24 Jun 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750396; cv=none; b=OtpkIJ05bXIK74YmZP7xLp0LkE31tRsUlftGFiP4BL1SJAdfzxOBcNzsRd5ixj/8E4CDwCdHqsRnbt75bTciAS3MSPQevJAzyHhCch7jtEfIzEDhBsh8DGrVyIcSzcJ3toAgYq4OIV3/I2+WnefgEdMqCr/AnArcoayJkp81Ync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750396; c=relaxed/simple;
	bh=x0tGnbgqwLjk77W9xb8ogsnnZO9WRIj3MP86BXNQhUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEDgPsr1Xiur+oq9R/LiXCh0P/yarnXwMBO2VkZvXrBPdZlnj6kVm7NTFTU5QAcwx4xnqcGqwgqRr8BzpQTVVX4vmLWIrlxRK3JXAyL6n6wcBQ2ORnW60rN+qBihAbPFRlrQcpnrhrNzEkKXAjWX7mWQfA6EI+XRxssBQg57Nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZljYiKK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750750396; x=1782286396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x0tGnbgqwLjk77W9xb8ogsnnZO9WRIj3MP86BXNQhUo=;
  b=QZljYiKKT9LrDKxN+u5cHr5G0ueaHjZej8HWXAL9r3tJPmcBduvp+Guu
   UPRBd4HansUVKUFx7f8TNXT9qSlFjbzHwwmdYHPKjOTIogCka2zi61fB4
   CUoGsjohOrjz7NEoGtUdrLk+y/K/dknPI8D7IPVojVgDwYlZv8zYnkn83
   QVMrCPzpnXHAt2HNFaIVFadrDMMScPvxeRIXOHNOHJKb3U/mM5gFP13iA
   ZlQm9IiqydhIhkKp+ESjvgKAE1u0yHzOB82fJn/9QmemQSvmVOeoyaOAo
   HSNowjyQjPRz4yK0XLactft2VqB0qujboeIbGIWvIKLN7tJ5oNOSeVrrb
   Q==;
X-CSE-ConnectionGUID: VQeSogX0Qf+FbDKEkpyvVQ==
X-CSE-MsgGUID: qLS8Fh7ZSDGDsYILY+EIVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64038275"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64038275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:33:15 -0700
X-CSE-ConnectionGUID: BZOgtye7QOuK2mwuUCZeqQ==
X-CSE-MsgGUID: IoL2Bha0Si6j4SRmvQiPVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="189035968"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:33:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTy9S-00000009PEv-3F8X;
	Tue, 24 Jun 2025 10:33:06 +0300
Date: Tue, 24 Jun 2025 10:33:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
Message-ID: <aFpUsv5fWYJk4vxW@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-5-l.rubusch@gmail.com>
 <aFkh-E1dG__p_G4m@smile.fi.intel.com>
 <CAFXKEHan_7+BVshb12JZLH8CJtSPuwv=H_vC2kUWkS411wsqaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHan_7+BVshb12JZLH8CJtSPuwv=H_vC2kUWkS411wsqaA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 23, 2025 at 11:06:44PM +0200, Lothar Rubusch wrote:
> On Mon, Jun 23, 2025 at 11:44 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> > > +     case ADXL345_INACTIVITY:
> > > +             en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
> > > +                     FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
> > > +                     FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
> >
> > As I pointed out earlier. the indentation is supposed to be on the same colomn
> > for 'F' letters.
> >
> 
> Let me allow a stupid question, when you mean on the same column, the
> above is wrong? Can you give me an example here how to fix it?

Your mail client mangles the original text (TABs) and it's most likely
impossible to see on your side what I meant (I already answered once with
the example).

Here is the example, use https://lore.kernel.org/linux-iio to see it via Web

		en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
		     FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
		     FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);

All 'F' letters occupy the same (by number) column in the sequential lines.

P.S.
Also you seems ignored my ask to remove the context you are not replying to.

-- 
With Best Regards,
Andy Shevchenko



