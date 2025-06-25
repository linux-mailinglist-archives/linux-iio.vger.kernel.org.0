Return-Path: <linux-iio+bounces-20959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B1AE8679
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145777BA1C7
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E73264A7C;
	Wed, 25 Jun 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU+nKfkS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF120C00B;
	Wed, 25 Jun 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861646; cv=none; b=KnAHctbdQfbhhpcFXVLcVEkO8dE83wAkLBiO/pRH3TUox8ynXsJSiHuUaeoDRhJOheAVgL+nh9SFqN7Kk+GzPTZqlRsYsAo6qEs7oSApjcapIGhbRECTZhTMJqqC8tSt1dIshCX4HUUKrivwXlF6XfuakZg0K/oEHxwI3+qX/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861646; c=relaxed/simple;
	bh=aiCBfShnv6jIIgQ4bpuIfMp5r40wbfensHpHCEm3pBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH+XbgzH4Xd4WC8txwHpcxlRtJ6iRfhXEwKRdEAdiORO7jebIr4ddHigFYA3Ei2fN+iv0MC/mVCJedk3awUdzKrF2VQrtqmhfHHx78e2vCYHoATTC1RVXY31kpbKaJfcB0l83/wD8N+8UjQFYAL74hZ1yxYXxmuCXR7/JUaIu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU+nKfkS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750861646; x=1782397646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiCBfShnv6jIIgQ4bpuIfMp5r40wbfensHpHCEm3pBM=;
  b=mU+nKfkS2z3z9O0xwUk5kQ0cuEPjqmKzxvvq/Z6FYVrq5C0CRu0lhWOO
   cCK6bv2XpjmAqbQNMzHYaVwZdSBZvv+zLtbAInNunTJubqF/ggWsjhap6
   fLM6KbYWKdVlq7NWUEy/1wUCigXjUpaZKk8Hc40U46XCAKaivobECZK0j
   ZGo/oyMsoLasZt4fv+Xoi728oJcA01PN2b6hJlKCwy+2JI3WzHKzfrQmM
   zhfTQf0+pnFQCgdYMxcCKTk53Df/IMWMDtV8MjTFsd1ShedmPA6ko3cdF
   uo3T97eUKQnoXdbJ+4+6KAPKE0IwQKscvTu8zqIvJWBVq68F1Ze9URKaS
   A==;
X-CSE-ConnectionGUID: dkxlRjhbQqC2rBspwRddlA==
X-CSE-MsgGUID: XVwLUXiITWqaTCLDJbXwwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="56920079"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="56920079"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 07:27:25 -0700
X-CSE-ConnectionGUID: NYVNjaqgRd2C28PhusN2oA==
X-CSE-MsgGUID: Vm3m4nwNToS9MwdDCSPhkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="175877583"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 07:27:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uUR5q-00000009nnt-1JQk;
	Wed, 25 Jun 2025 17:27:18 +0300
Date: Wed, 25 Jun 2025 17:27:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 4/5] iio: adc: mt6359: Add support for MediaTek MT6363
 PMIC AUXADC
Message-ID: <aFwHRigf95hPKTE7@smile.fi.intel.com>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
 <20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
 <aFlk-l5LhgO8dnXK@smile.fi.intel.com>
 <1b173e16-f681-4256-8dd2-92db2e90ca73@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b173e16-f681-4256-8dd2-92db2e90ca73@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 03:29:47PM +0200, AngeloGioacchino Del Regno wrote:
> Il 23/06/25 16:30, Andy Shevchenko ha scritto:
> > On Mon, Jun 23, 2025 at 02:00:27PM +0200, AngeloGioacchino Del Regno wrote:

...

> > > +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {
> > > +		/* If the previous read succeeded, this can't fail */
> > > +		regmap_read(regmap, reg - 1, &lval);
> > 
> > No error check? lval may contain garbage here, right?
> 
> No, because if the previous read succeeded, this can't fail, and also cannot ever
> possibly contain garbage (and if it does, - but again, that can't happen - there is
> no way to validate that because valid values are [0x00..0xff] anyway).

Never say never. Any regmap_*() call that performs I/O might fail. You can't
predict with 100% guarantee the HW behaviour in all possible scenarios.

> > > +		val = (val << 8) | lval;
> > 
> > Is it guaranteed that lval is always less than 256 (if unsigned)?
> 
> Yes, with SPMI that is guaranteed.
> 
> > > +	}

...

> > > +		regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
> > > +				   MT6363_EXT_PURES_MASK, ext_sel);
> > 
> > No  error check?
> 
> No, because if the previous reads and/or writes succeeded, it is impossible for
> this to fail :-)

Ditto.

I.o.w. the failed regmap_*() call can be a signal that something on the
communication channel with the HW went wrong, Depending on the severity of this
call the device driver may decide what to do next.

-- 
With Best Regards,
Andy Shevchenko



