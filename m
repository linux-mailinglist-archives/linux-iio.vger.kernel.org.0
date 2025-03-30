Return-Path: <linux-iio+bounces-17356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69EA75AFA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977743A856B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AED1D8A14;
	Sun, 30 Mar 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSlP+kHK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E8175D50;
	Sun, 30 Mar 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352783; cv=none; b=UFHE6rC1To+nGxga1nZa4SDrKax3nYAg+M1BpGsTLk2DEm7bNVMD0hnADZg0QAn8a1UWelLgrKXphbNfi5zeJbIvddD9GJdybn4tOFAqkorJ02HFvmKuvrfUjgedAJkEOWjNBqsD7L3iHamF20ubxQiQf+L410BK7zSgejZxWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352783; c=relaxed/simple;
	bh=V5j1W1nJpZdHJRcysq7Oe534M79h+6sw32lCrhO5bko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H687h5A76VYm0nK4WxqPE3+Ia7tJ0LNC+447PFAg6Zgc5G4zpYhbSGRejr/HYNRxv8o/eCoSzbLS0rr4KbkQ+wBg67PHmZ/z1OQSa2fud0lJ5wcXDoJ4Y7Gb97QfGBt2GGdkzmaZ2InDujMGBV3I7KDU8djRa859FUGQlDWbZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSlP+kHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07588C4CEDD;
	Sun, 30 Mar 2025 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743352783;
	bh=V5j1W1nJpZdHJRcysq7Oe534M79h+6sw32lCrhO5bko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DSlP+kHKxiKQhEBGuOxQvTYGW2bothqLP6dIcRecKrLJBpk2FAQQ1Sd6hhBeuzeRq
	 uzc+n5Lat8DYzJqEunPmSYRE3SWpFes1lhxdokXGw03tLAp23GJKKluvvimOCXPXzr
	 9UmTF60kHO92zccmwnCHVjfMlIklx5i4nr51Nr805xZSQQTjGsz6cSApKud+Fzabh+
	 eHNWEZR4K7lM2YOA8ejB3M+0umjyLGGLRxj71D4WjHFXKgtGlKse1d6MhXjelM7wwm
	 Rjrd49yz8AqS0I3NW6FBkjhGZOMp4ePleRmbdgPmKCS5dcaBzjQB7IfZSR5Jn1sy6G
	 sB4EyXezgVr5Q==
Date: Sun, 30 Mar 2025 17:39:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v10 2/8] property: Add functions to iterate named child
Message-ID: <20250330173929.155477d1@jic23-huawei>
In-Reply-To: <2767173b7b18e974c0bac244688214bd3863ff06.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
	<2767173b7b18e974c0bac244688214bd3863ff06.1742560649.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 09:12:50 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

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
Whilst I've queued up the series, I'll be rebasing on rc1 anyway
so if Sakari or anyone else still wants to comment on this patch
or offer tags, go ahead!

Jonathan
> ---
> Revision history:
> v9 =>
>  - No changes
> v8 => v9:
>  - Drop the fwnode_for_each_available_named_child_node() as suggested
>    by Sakari during v8 review:
>    https://lore.kernel.org/all/Z9mQPJwnKAkPHriT@kekkonen.localdomain/
> v7 => v8:
>  - Fix the example in fwnode_get_named_child_node_count() documentation
>    to use the fwnode_get_named_child_node_count() and not the
>    device_get_named_child_node_count()
>  - Fix the rest of the new macro's indentiations
> v6 => v7:
>  - Improve kerneldoc
>  - Inline device_get_named_child_node_count() and change it to call
>    fwnode_get_named_child_node_count() inside
>  - Fix indentiation of the new macros
> v5 => v6:
>  - Add helpers to also iterate through the nodes.
> v4 => v5:
>  - Use given name instead of string 'channel' when counting the nodes
>  - Add also fwnode_get_child_node_count_named() as suggested by Rob.
> v3 => v4:
>  - New patch as suggested by Jonathan, see discussion in:
> https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
> ---
>  drivers/base/property.c  | 27 +++++++++++++++++++++++++++
>  include/linux/property.h | 20 ++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c1392743df9c..f42f32ff45fc 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -945,6 +945,33 @@ unsigned int device_get_child_node_count(const struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_get_child_node_count);
>  
> +/**
> + * fwnode_get_named_child_node_count - number of child nodes with given name
> + * @fwnode: Node which child nodes are counted.
> + * @name: String to match child node name against.
> + *
> + * Scan child nodes and count all the nodes with a specific name. Potential
> + * 'number' -ending after the 'at sign' for scanned names is ignored.
> + * E.g.::
> + *   fwnode_get_named_child_node_count(fwnode, "channel");
> + * would match all the nodes::
> + *   channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * Return: the number of child nodes with a matching name for a given device.
> + */
> +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
> +					       const char *name)
> +{
> +	struct fwnode_handle *child;
> +	unsigned int count = 0;
> +
> +	fwnode_for_each_named_child_node(fwnode, child, name)
> +		count++;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_named_child_node_count);
> +
>  bool device_dma_supported(const struct device *dev)
>  {
>  	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e214ecd241eb..3e83babac0b0 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -167,6 +167,10 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
>  	     child = fwnode_get_next_child_node(fwnode, child))
>  
> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
> +	fwnode_for_each_child_node(fwnode, child)			\
> +		if (!fwnode_name_eq(child, name)) { } else
> +
>  #define fwnode_for_each_available_child_node(fwnode, child)		       \
>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>  	     child = fwnode_get_next_available_child_node(fwnode, child))
> @@ -178,11 +182,19 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  	for (child = device_get_next_child_node(dev, NULL); child;	\
>  	     child = device_get_next_child_node(dev, child))
>  
> +#define device_for_each_named_child_node(dev, child, name)		\
> +	device_for_each_child_node(dev, child)				\
> +		if (!fwnode_name_eq(child, name)) { } else
> +
>  #define device_for_each_child_node_scoped(dev, child)			\
>  	for (struct fwnode_handle *child __free(fwnode_handle) =	\
>  		device_get_next_child_node(dev, NULL);			\
>  	     child; child = device_get_next_child_node(dev, child))
>  
> +#define device_for_each_named_child_node_scoped(dev, child, name)	\
> +	device_for_each_child_node_scoped(dev, child)			\
> +		if (!fwnode_name_eq(child, name)) { } else
> +
>  struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  						  const char *childname);
>  struct fwnode_handle *device_get_named_child_node(const struct device *dev,
> @@ -210,6 +222,14 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
>  
>  unsigned int device_get_child_node_count(const struct device *dev);
>  
> +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
> +					       const char *name);
> +static inline unsigned int device_get_named_child_node_count(const struct device *dev,
> +							     const char *name)
> +{
> +	return fwnode_get_named_child_node_count(dev_fwnode(dev), name);
> +}
> +
>  static inline int device_property_read_u8(const struct device *dev,
>  					  const char *propname, u8 *val)
>  {


