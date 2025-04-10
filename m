Return-Path: <linux-iio+bounces-17921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F4A8493A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506403A9797
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9541EB5FD;
	Thu, 10 Apr 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMPR7vgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E49189F5C;
	Thu, 10 Apr 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301244; cv=none; b=rTsfQ1OTP+AxGIkXGcLtIr3rFMwkEnbYorAVYJMlvYUlXg9kpuTsMePtoNzAl86YdtuufSq/+QB7P2rx3vWh5Yg3c9Uvhsuummvo5LEooAX8YJnqoQ28nhg8U0HIrMwd/4Ib7CriEPe4i4F48bcjQBzU7b0eZG31zdCtCl3CxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301244; c=relaxed/simple;
	bh=vKTeQFFCmt46JdP7DyCiIVywztk+IaK0aYIzzD8T+Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDJkt3IKZxi5IvjrUHe2M+2YSLJWQS6H8/vuswbVkUbi1/IIIMLqbdlaGS56yIUV9hHR3cwm/Vm0wC7k4YlPN6GAvbLsR3K+yGHaDdQz2oxiS/QljdgIfmROF5mP1H3zFFKF5JEU7MrcfYPTx30essFAn4sZekS74fbyh32eEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMPR7vgG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744301243; x=1775837243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vKTeQFFCmt46JdP7DyCiIVywztk+IaK0aYIzzD8T+Jo=;
  b=iMPR7vgGHmnvT/E+2eypgXdahpO/smz7LhCF6ghXnxbQyEO4WFRU7u4d
   9vNCxetzNYi7IMQN1HYttYyw1fuIIe8UR1xSOYZ0bOOjYf19T4VM17IZi
   BlBMkUhqG9t8AI3utO4NuCQloK2+Ei/VVohzq7bUM00YL9RnqjfY/2n10
   SAy/Wg2nAaoQ7/PWrIhWsrjeOzfFsJVZpPDBMPrl4Xu5cmjovlg1PQG7/
   s0bEkN8pDwxMhD9fm3d0SN20glZuvYWB4bH1epju2Lmpzj3yKHdXBdaP/
   lTBXHpfdux+OEfjoE31ynxQ08MYs7Q/e4uEClyU+BZ4u6XQOmgYgs8rIA
   g==;
X-CSE-ConnectionGUID: 9tqa/V1TQ9imIIMe7DvoYA==
X-CSE-MsgGUID: GvQq0lM0Rgye050lXhAHBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="68321257"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="68321257"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:07:22 -0700
X-CSE-ConnectionGUID: G2NMB3yxTr6Jlw4dDbGdvQ==
X-CSE-MsgGUID: hjUqUviBT8C0/8Ovewh4ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129286470"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:07:15 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 349EB11F74E;
	Thu, 10 Apr 2025 19:07:12 +0300 (EEST)
Date: Thu, 10 Apr 2025 16:07:12 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v10 2/8] property: Add functions to iterate named child
Message-ID: <Z_fssEg3QZXyaTzx@kekkonen.localdomain>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
 <2767173b7b18e974c0bac244688214bd3863ff06.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2767173b7b18e974c0bac244688214bd3863ff06.1742560649.git.mazziesaccount@gmail.com>

On Mon, Mar 24, 2025 at 09:12:50AM +0200, Matti Vaittinen wrote:
> There are a few use-cases where child nodes with a specific name need to
> be parsed. Code like:
> 
> fwnode_for_each_child_node()
> 	if (fwnode_name_eq())
> 		...
> 
> can be found from a various drivers/subsystems. Adding a macro for this
> can simplify things a bit.
> 
> In a few cases the data from the found nodes is later added to an array,
> which is allocated based on the number of found nodes. One example of
> such use is the IIO subsystem's ADC channel nodes, where the relevant
> nodes are named as channel[@N].
> 
> Add helpers for iterating and counting device's sub-nodes with certain
> name instead of open-coding this in every user.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Kiitos!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

