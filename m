Return-Path: <linux-iio+bounces-6755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9E913B94
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A92EB20FC3
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6211802CA;
	Sun, 23 Jun 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djl/S6yB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497706CDB3;
	Sun, 23 Jun 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719151168; cv=none; b=Uw5ztvV9GmCKlJtgYD3Ne1ZOe/fsjE8M2ijgPTKJCHY/PceRmwRUhXYfjYPc+DZU+eweYpZrLdmpo3RqBQprSq4bPvhrg4TMgYX29UdYdQtPgz3DXymVZ9m0fNXGQjp2Y6q7pPZuCpO2uKxNLe9b1u5u6gqVvVFDc0BHrLL0u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719151168; c=relaxed/simple;
	bh=vUpCuCkap/QgHYa36NWnzkaJ6PgbtigkSzQJmzKQhGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHEDINt8ZGItocFMVms26kuYH7AmPbx5wQumG/nUE95H1Zvln66lRswLLhE/boEpUwKTNVe0GWSNH/vyOQ2MaHWdlAKAqWVvvtx7Erl87iU/HN1n8wz+CtEETAI20C3iCoSf0rIImSRAhWDLOpzs+oaH4C+68waUnZaEbAXtwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djl/S6yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70742C2BD10;
	Sun, 23 Jun 2024 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719151167;
	bh=vUpCuCkap/QgHYa36NWnzkaJ6PgbtigkSzQJmzKQhGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djl/S6yBMcY2Jdsh0JIsfmt1Q919YffZVdv3TdLn7QX/EiAgEynwtmpFnbvi16EOM
	 gvEftvQwGcoYzwTDsIq1YCEo+8qFc9mggc7mNtdEtppMZ+RmckdWAUqtUH2h4IvQYX
	 oZIQq3TRMQPWDJLFIKCIv7+6PYiGEnzn4nXywNa9qTyn6JZ3lppiNMPZG45WKNjTSH
	 jTYecrTuHASC5BNBLrSUZRNbDj0dLrBVpf44boldHy4a3jgbDMS7fqLQW7AVJz+Vnh
	 iS3xbhbBXoeCq4lgRzmF1D1+ZjSItWlbg2fKHfBO3bARYicRzFGRqxL3boETbvGsb/
	 7IDmm/bYrB3ZQ==
Date: Sun, 23 Jun 2024 14:59:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] iio: add child nodes support in iio backend
 framework
Message-ID: <20240623145920.462d2fdb@jic23-huawei>
In-Reply-To: <20240618160836.945242-4-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-4-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:08:29 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add an API to support IIO generic channels binding:
> http://devicetree.org/schemas/iio/adc/adc.yaml#
> This new API is needed, as generic channel DT node
> isn't populated as a device.
> Add devm_iio_backend_subnode_get() to allow an IIO device
> backend consumer to configure backend phandles in its
> child nodes.

Really trivial stuff:

Don't wrap so far below 75 chars that is typical limit
for commit messages.

> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

> +
> +/**
> + * devm_iio_backend_get - Device managed backend device get
> + * @dev: Consumer device for the backend
> + * @name: Backend name
> + *
> + * Get's the backend associated with @dev.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
> +{
> +	return __devm_iio_backend_node_get(dev, name, dev_fwnode(dev));
> +}
>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
>  
> +/**
> + * devm_iio_backend_subnode_get - Device managed backend device get

Same short description as the one above.  Fairly sure this wants to be different!

> + * @dev: Consumer device for the backend
> + * @name: Backend name
> + * @node: Firmware node of the backend consumer
> + *
> + * Get's the backend associated with @dev.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_subnode_get(struct device *dev, const char *name,
> +						 struct fwnode_handle *node)
> +{
> +	return __devm_iio_backend_node_get(dev, name, node);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_subnode_get, IIO_BACKEND);


