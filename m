Return-Path: <linux-iio+bounces-23049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00AB2DD3F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD571C8165C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2830F53F;
	Wed, 20 Aug 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBCRXboM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800E42AA3;
	Wed, 20 Aug 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694935; cv=none; b=eScUhI0KUra3I+9X6vZoxhxfjGc3yIcL8Rmvo8GAlvuI2klNoByZc39VLBLFQ4KzOozCjzSzr8C5PAQ3vL/8N1zACqw0mrNE/U3Z6MO5p8n+Dhs1Z6fRKz/RPRqY2A2t+4RQI5Oxskg4FSoPnUjhd2Tm+u8DD3Xw+eKFHjQAsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694935; c=relaxed/simple;
	bh=hEN3aJohbGZNLa8VDJV2dbOoTdBqI5P9kVlUzDzaFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpW5mXFsloy8pKZw4+MRATIg9dXT16asDK0sAHq+ijWFJW8/9BXUmV53wxu1DDf4DC4AdEQP3vx7iRQoiP8FfV9+36a9Wv++nf8bpKwlWUu4wwYFqujo9zIljxRYp8H4BU3Tlf61GQkwCVShHcf+ZJ+I0f5FB2g0g0vS0qwtjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBCRXboM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755694934; x=1787230934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hEN3aJohbGZNLa8VDJV2dbOoTdBqI5P9kVlUzDzaFVM=;
  b=lBCRXboMSgqP/ZzTwLfgFxYqdcxJirdPwYBl/7VxBcjF18fqtCDY5C+M
   H/CdfASBgjealwgbRyEHnWXesthN4Q8irxM5VK4GGF3Nd4Aut93gdTzxa
   ARaPgXCv2PpTbI2499jVZmJlkeMWebGSNH5zAQoNqhyfcwMVEqzfiFEcE
   4Yjqh248bCtURxTlkXDdJG/7vR9c9Z9bHQvlr+UNVWLvAX+c/sBrUoMMT
   xSDBpP+wnhpFkEQhUpD+GDPPH3guGJ0g7WN7jlwaYu1AMoql7YM45h5kn
   pnaIcqPaUrtiLZyb+mv+JTu9Holg4Sc9oHMgqmu0hvwDSQ/YK6hAG62W5
   g==;
X-CSE-ConnectionGUID: vv5B9x77SqCp1eAPe7q4gw==
X-CSE-MsgGUID: eDiZta2ARoSYP8lz4rqqwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61773200"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61773200"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:02:13 -0700
X-CSE-ConnectionGUID: 5VUgcoWeRr+Mf7IaCM3Mvw==
X-CSE-MsgGUID: lxwRfl03R2WJwBynJJLGvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205280230"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:02:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uoiS6-00000006rI9-3YwG;
	Wed, 20 Aug 2025 16:02:06 +0300
Date: Wed, 20 Aug 2025 16:02:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ben Collins <bcollins@watter.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <aKXHTqlQmDFjx8Ra@smile.fi.intel.com>
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
 <20250819-upstream-changes-v7-4-88a33aa78f6a@watter.com>
 <CAHp75VfrRJmB-Q6TM+Tiy79_q63=cOvyrePMQwi6ZbvDNUPezQ@mail.gmail.com>
 <00D2ACBD-DE50-4132-8DF2-46DD97DBCE3B@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00D2ACBD-DE50-4132-8DF2-46DD97DBCE3B@watter.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 07:11:08AM -0400, Ben Collins wrote:
> > On Aug 20, 2025, at 6:07 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 20, 2025 at 2:45 AM Ben Collins <bcollins@watter.com> wrote:

...

> >> +struct mcp9600_data {
> >> +       struct i2c_client *client;
> >> +};
> >> +
> >> #define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, cj_ev_spec_off) \
> >>        {                                                                      \
> >>                {                                                              \
> >> @@ -123,10 +133,6 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
> >>        MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
> >> };
> >> 
> >> -struct mcp9600_data {
> >> -       struct i2c_client *client;
> >> -};
> >> -
> > 
> > It's not obvious why this piece of change is needed. AFAICS it's a stray change.
> 
> The explanation is in the changelog above. A follow up patch needs both struct
> declarations to be where I added one and moved mcp9600_data to. It’s just ordering
> so I don’t later have to forward declare new functions for filter_type, which make
> use of these structs, but need to be in the iio_chan_spec mcp9600_channels[]
> declaration.
> 
> I guess I could move mcp9600_data in that series, but I had this in here before
> I split that series out, and it seemed simple enough to leave in.

The usual thing is to avoid changes that are not used. In this series this move
is not used, put it to the patch which actually needs it.

-- 
With Best Regards,
Andy Shevchenko



