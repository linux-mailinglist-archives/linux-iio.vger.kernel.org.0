Return-Path: <linux-iio+bounces-16204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A3A4A235
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D181783AC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 18:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83B1EF39D;
	Fri, 28 Feb 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVRfau7c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE5277010;
	Fri, 28 Feb 2025 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768700; cv=none; b=BiT+jY6iqleS9SklVtZRZ0aMCxuN3axJ/mj0eExwXPbY9HE8c83IHKWMxP5QPoAHGyXZCACxSVdYZ99FWPRj5YorsOAYTWGmgNjEs53nxX+18nTOsKQ8isFwToGZj3ljr/gcuSXLUYxB4eIl/7rY6j9paqLWb+QvD91eeRYECOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768700; c=relaxed/simple;
	bh=pkwgeMwCKf80SIaXk8KhThxONMPc4p/Xo+BvX6bjIBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feISJWPoyCbBIPUhU8D6NaD6Xfr7OE4veQQBljvmyrx/3j0KrUi/J+glwQF4EIuAgZ7JUzIDGtPPAToTnTNhA3GhxLQ5RR6SsmlUIO+Z1M63+FAlzxC2TYN0gZeQnA5AZN6zt0NyEq8XFHr2YenyVRayNdvrjEoDq45sPxlwFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVRfau7c; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768699; x=1772304699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pkwgeMwCKf80SIaXk8KhThxONMPc4p/Xo+BvX6bjIBg=;
  b=MVRfau7coZVJR5o8DyvDzVGPHXN/N+xfDl3t2BBaV8KzOF9F9yjqMffB
   JYfFasHXdS3W6ttYubPug5S/RJ+DcvoMwUtI4BuK8j/nXmTMgFUa9HwLr
   5RrZnGacsZhsuyxb6+ajbehED78dxEQ3eEFLzQcYhfVXezN4KKjvWcuge
   ctnTbjBcsaiJt8qWxqIUwP6FL905GsmvrgGK4RqoEEgyqJ0cuiRzJXnue
   YaYDvK/o/jqTlAslV+wI3pH1qnyITskGnuSl2dV0rs8gEfKWBEi9ioABn
   89i0phpgMQt8hP6iu4KOKtnoXywCjP149W6hjKH9dcgCqCQY28G5eIBid
   w==;
X-CSE-ConnectionGUID: UuNc/GEjQyWLkGsdDTt+hA==
X-CSE-MsgGUID: 0/Koq0/CRuiTaLlquxFtkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67083622"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="67083622"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:51:38 -0800
X-CSE-ConnectionGUID: aSyNmCmeRwqkQi0uhisfRA==
X-CSE-MsgGUID: IBifUjH4SWmgzTlo7TfT5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117206022"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:51:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to5SJ-0000000G3mv-0yeh;
	Fri, 28 Feb 2025 20:51:27 +0200
Date: Fri, 28 Feb 2025 20:51:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
Message-ID: <Z8IFr6LxK8m0kaDF@smile.fi.intel.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <CAL_Jsq+av-fptMQqBeVieKwA9c7+uUCaqZMLGu-RVJzWZ_7+Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+av-fptMQqBeVieKwA9c7+uUCaqZMLGu-RVJzWZ_7+Vg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 11:07:24AM -0600, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 12:33 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:

...

> > +unsigned int device_get_child_node_count_named(const struct device *dev,
> > +                                              const char *name)
> 
> I think this should be implemented as
> fwnode_get_child_node_count_named() with the device variant being just
> a wrapper.

Good catch! That's also added to our misunderstanding with Matti who didn't get
the role of dev_of_node() vs. dev_fwnode() in the first place.

-- 
With Best Regards,
Andy Shevchenko



