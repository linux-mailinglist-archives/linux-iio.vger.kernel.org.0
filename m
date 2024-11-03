Return-Path: <linux-iio+bounces-11864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2869BA532
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 12:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736421C20FDC
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCAA15F40B;
	Sun,  3 Nov 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpMHCPS6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495161448E3;
	Sun,  3 Nov 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730631698; cv=none; b=XnBtsGWhLFnfY+zT5WGw5gblYsIktj9jv3It/sb4sVOA5g8C35j/XAI6E/EcBwlBC5EM6IhWrFtAhV+qu8Qat4CDAqciNlX1EWw9+bsmFwu+WWaiiF4DxNOBhJradr+RQfZ+P0tWs9g8o7bwsXt4+X1Daqe6AB7jikGjjvW0Xro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730631698; c=relaxed/simple;
	bh=idUqPVoqvdm7rDa6irSoJhgNHix23S5G3O04KTJUrdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAK6b1tofgeyzND1+Nox3S3yKQecH8zByIQ1LqwD6/8CcK4Z6sw2vIUZxzqwEoxHEMasWtADlk6rzmc5N4R5WIO5ztNFyCqv6MtFPWQM23XFj+jELlHzCRK9m9zv1l09dq09N6hhYVLJE6kU/sj599lKp1L/YWlCSxSYZlZ3E/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpMHCPS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040C8C4CECD;
	Sun,  3 Nov 2024 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730631697;
	bh=idUqPVoqvdm7rDa6irSoJhgNHix23S5G3O04KTJUrdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HpMHCPS6LVDxHLepJwDVb+1cb1E1Gu/6mz1uBY52XGhxcFSPnxBd3ripIsj7cUn7C
	 ZKFLi2nE48WG1dHFp+7ckeg7Bv4cQt4cMESbRJp65yBNMTzl8csLJEuAM6pufGR8m4
	 p5Kb9/MNFV2IOGwHlmXQrtkWtsO949jQ9E4eBb8ITnF3A1zZ8xnn8jtYJaWzMsULpk
	 gnVu5SMgIkCIIkcJthfEtfx9O56lw3dt4d+QOzJj3ACWbiyfspaHVHDR5x8lfXQJhV
	 6Okvxi5iBuVauDIWEZ1nROb+AGeFS8+Ql0um8G64rMf+9tFw5jR42gTJUDqOaaSodT
	 jwaCZ4Z2x9E5g==
Date: Sun, 3 Nov 2024 11:01:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <20241103110127.6453b537@jic23-huawei>
In-Reply-To: <20241102154509.4b2495fa@jic23-huawei>
References: <20241031065205.50154-1-victor.duicu@microchip.com>
	<20241102154509.4b2495fa@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Nov 2024 15:45:09 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 31 Oct 2024 08:52:05 +0200
> <victor.duicu@microchip.com> wrote:
> 
> > From: Victor Duicu <victor.duicu@microchip.com>
> > 
> > This patch implements ACPI support to Microchip pac1921.
> > The driver can read shunt resistor value and label from ACPI table.
> > 
> > Signed-off-by: Victor Duicu <victor.duicu@microchip.com>  
> Hi Victor.
> 
> I made a few minor tweaks whilst applying (see inline)
> 
> Applied to the togreg branch of iio.git and pushed out as testing for now
> so that the bots can take a look and see if we missed anything.
Backed out again so you can resolve Andy's comments.

Jonathan

> 
> Jonathan
> 
> > +/*
> > + * documentation related to the ACPI device definition
> > + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> > + */
> > +static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
> > +{
> > +	acpi_handle handle;
> > +	union acpi_object *rez;
> > +	guid_t guid;
> > +	char *label;
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +	struct device *dev = &priv->client->dev;
> > +
> > +	guid_parse(PAC1921_DSM_UUID, &guid);
> > +	handle = ACPI_HANDLE(dev);
> > +
> > +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
> > +	if (!rez)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Could not read shunt from ACPI table\n");
> > +
> > +	priv->rshunt_uohm = rez->package.elements[0].integer.value;
> > +	ACPI_FREE(rez);
> > +
> > +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
> > +	if (!rez)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Could not read label from ACPI table\n");
> > +
> > +	label = devm_kstrdup(dev, rez->package.elements->string.pointer, GFP_KERNEL);
> > +	if (!label)
> > +		return dev_err_probe(dev, -EINVAL, "Label is NULL\n");  
> ENOMEM appropriate I think. 
> 
> Also, a package is an array of elements, and this is the first one so
> maybe res->package.elements[0].string.pointer is more appropriate?
> (similar to above).
> 
> 
> > +
> > +	indio_dev->label = label;
> > +	ACPI_FREE(rez);
> > +
> > +	return 0;
> > +}  
> 
> 


