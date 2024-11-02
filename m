Return-Path: <linux-iio+bounces-11851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787039BA14A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE06A1C20DCF
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CB19E975;
	Sat,  2 Nov 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+sAMh9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387CF5A4D5;
	Sat,  2 Nov 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730562316; cv=none; b=ebedktdN3GB+4awus4kSKj9V1HQImjzlnQ3dzTCKYSp1Cy/ekZq13oAobdlvZmK+ECJlnQq9VEBEwAEfaoqYUfkA+yL8HdsA5wM/z7Y+5CRMdFXlbwRSbZjnYme7mHYwQGG2F/TixYsnu/DVaJENK4HXix4N88kevJjCkDDSqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730562316; c=relaxed/simple;
	bh=8DsoVdW5mlk2YCLJUT4atpMPQdRVvCf3/gfbYRNyfT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qc0tqYAwN/DDSIU5gUhbzISYPVz1Flyx+BZDq2KsZ7Crmw9LgKtk4o4Dbha+EyjMCA0H+WwGTg2cLIMty0LOomD1pRubq7cLHD+s/iCXrjgdOO13gtDoR+Esn4hNAZXCtt+7OY6ca8WXRxiaM3bUGxYZFpEwz9g0C2r5beUGH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+sAMh9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89855C4CEC3;
	Sat,  2 Nov 2024 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730562315;
	bh=8DsoVdW5mlk2YCLJUT4atpMPQdRVvCf3/gfbYRNyfT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+sAMh9mFN7LWVhHpe4U3l57yqSH9z4svGRysiHvCJerWIWfnWuQ9ou+HD3taAJDD
	 sjcRSpk/1rIC7+94sbW+VjUao6S6p/6dPbYCN1E9PW1Mf+mR44P/BZzmau1ZHb9TTn
	 t+FFvom9nPP6/Yw8heMY5BQr2ewX8E1CPeoKstN9KBpuMCyVcnq8vmmA3ItryeuOXs
	 f1HnOxKCYJHQ/nUn07hTmZe/f/wOCfPUwK+bTz/43t4/aYFGzG+IxJmhQznx9dUVUK
	 Y+z35Q6CRVDHOgbA38exsGRk1WrKh3/ZhYsSudEzWOIbm72npk9ZVtjEtvDp1BrEgg
	 dUEWo6tcPiM0w==
Date: Sat, 2 Nov 2024 15:45:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <20241102154509.4b2495fa@jic23-huawei>
In-Reply-To: <20241031065205.50154-1-victor.duicu@microchip.com>
References: <20241031065205.50154-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 08:52:05 +0200
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Hi Victor.

I made a few minor tweaks whilst applying (see inline)

Applied to the togreg branch of iio.git and pushed out as testing for now
so that the bots can take a look and see if we missed anything.

Jonathan

> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
> +{
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	guid_t guid;
> +	char *label;
> +	struct pac1921_priv *priv = iio_priv(indio_dev);
> +	struct device *dev = &priv->client->dev;
> +
> +	guid_parse(PAC1921_DSM_UUID, &guid);
> +	handle = ACPI_HANDLE(dev);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");
> +
> +	priv->rshunt_uohm = rez->package.elements[0].integer.value;
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
> +	if (!rez)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read label from ACPI table\n");
> +
> +	label = devm_kstrdup(dev, rez->package.elements->string.pointer, GFP_KERNEL);
> +	if (!label)
> +		return dev_err_probe(dev, -EINVAL, "Label is NULL\n");
ENOMEM appropriate I think. 

Also, a package is an array of elements, and this is the first one so
maybe res->package.elements[0].string.pointer is more appropriate?
(similar to above).


> +
> +	indio_dev->label = label;
> +	ACPI_FREE(rez);
> +
> +	return 0;
> +}


