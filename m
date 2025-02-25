Return-Path: <linux-iio+bounces-16044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF5A439F5
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B408A172C33
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FD261590;
	Tue, 25 Feb 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kmcl2aJp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054B13A88A;
	Tue, 25 Feb 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476430; cv=none; b=F1FOaOfxZlrKrfkVp5NJa3lkLK1p0IV52aU2UwdMCDsuLSOswM8qjq/kdHE/KFwIZRWMCxpe6k+E9eagApGhIgV/VkEvuL4VbC9WxVjagHywb48d3los+OBlwhENhpa5WElWWzTBSop9in1uwhUscwuValQ4YALVdz7mzv2D5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476430; c=relaxed/simple;
	bh=9MeSK15KTX1GpVUkanLg3jxBL8S+QzQcHgh3wTNK8Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiJ2RSz8lImVDxsEvPgyEAes+P69mvTL0GZjBa54YPbHfp9vVRsgXW7eGm1oLfrct+DC9C4vaQpROjdnBhHzzrO3SMirV1XSeQbqcCHCO/RKppsZqKKleC2/mJYKjR/gGCIwJzAi43j6nLDsYruuCfq09R5gx51adgxy37j4jBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kmcl2aJp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740476428; x=1772012428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MeSK15KTX1GpVUkanLg3jxBL8S+QzQcHgh3wTNK8Oc=;
  b=Kmcl2aJpA8oTw4fmvSTARNwxKw4RfMtg8KiIzu5L8TjtN3NHhaVvOAeW
   1aiWkdHYvukahe/cJQu59P6YYyE93Y4EjXZ95CQ2VPMaH1uIocrksq35T
   yzlKkFg4aluazGEyai0pQ3miAtYH2gixnT6RiT2GryCaYYopBhQSWYiLV
   uKGZECihTCtVbQwsj5VpNSFJO4M/yEfxh4f0GKDPpCMAAtK08kom+k6iE
   HXNbN5RZoKfxumaif+gTSlrcHAHD0EL2ph1fxCb1/RQzpewlgvI3l9cuN
   5c9bNQ06bRaXLIm6HJ/F2JIkq5wHtORhdODrh9QolAi0xWNfj044YghFB
   A==;
X-CSE-ConnectionGUID: foDcJOSLQem7Gatk7z0YIw==
X-CSE-MsgGUID: 1Zeabzl8Qr++C9VHi4GlYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40510239"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40510239"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:40:27 -0800
X-CSE-ConnectionGUID: wuPiuA/zQd22MTq7/2Oa3Q==
X-CSE-MsgGUID: 1/aed8HrRI+DCsOedLJWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117267075"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 25 Feb 2025 01:40:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Feb 2025 11:40:16 +0200
Date: Tue, 25 Feb 2025 11:40:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
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
Message-ID: <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>

Hi,

> +/**
> + * device_get_child_node_count_named - number of child nodes with given name
> + *
> + * Scan device's child nodes and find all the nodes with a specific name and
> + * return the number of found nodes. Potential '@number' -ending for scanned
> + * names is ignored. Eg,
> + * device_get_child_node_count(dev, "channel");
> + * would match all the nodes:
> + * channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * @dev: Device to count the child nodes for
> + *
> + * Return: the number of child nodes with a matching name for a given device.
> + */
> +unsigned int device_get_child_node_count_named(const struct device *dev,
> +					       const char *name)
> +{
> +	struct fwnode_handle *child;
> +	unsigned int count = 0;
> +
> +	device_for_each_child_node(dev, child)
> +		if (fwnode_name_eq(child, "channel"))

s/"channel"/name/ ?

> +			count++;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);

I did not check how many users are you proposing for this, but if
there's only one, then IMO this should not be a global function yet.
It just feels to special case to me. But let's see what the others
think.

thanks,

-- 
heikki

