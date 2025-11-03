Return-Path: <linux-iio+bounces-25827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AED3C2A98F
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E79024EA50E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F8E2E0B42;
	Mon,  3 Nov 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iWIQ6qIs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A92E03EF
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159265; cv=none; b=OwfyNIrgt79wIKrYNd7Psk5u8fcNhV4g0IYkGir9xNTZrd2Vcf2GX9nWy7wPssbObxXmAjVTjhccCG9hf2bbPe1YgvlOCcrDT0WZpZznD0h/XQbLayTHA3mIXJ6eQvU8DczBT7NV3/FjU5bTH7LnwRaOSKyc/nWvtfjM3wEvLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159265; c=relaxed/simple;
	bh=v+GhSFMVaW/Lfg8/fIiRNwYwGsUSOMGi1AXYxUkQrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gfwqpo2DVlJpa7g2HsvCypuViUi1XJLls7OdP5Fc+8CJfeIfv0e6WJbDI18MEwcuiHkQtWTWGyP4GQELBAtrexlIkm4jjx4M5Q3M5hmIwUkdfXngh2EADTuOyqIErFQWqcwrFOSKASyF83fWL2h2vsvPqNXOklwCY5VJeucNeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWIQ6qIs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 136841A1831;
	Mon,  3 Nov 2025 08:40:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7E4F60628;
	Mon,  3 Nov 2025 08:40:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23F7A11818002;
	Mon,  3 Nov 2025 09:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762159252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OdBSKKFuFhKbNuvtZatqu6kaGrQLICACn7lyjwcUeMg=;
	b=iWIQ6qIsThvjONMtKyRFIt3RRi6l8dYaN4kZtEpF0WxdZTR7zGXHa3A3SoAxpgiYwhng1C
	zo2hxlhOeOIb85bpal78IjolPGrbtnhMf2GTaOtON4SFmj2JNEwTdhhikSLHT8y9Vdw5pv
	PGiWyZayoE1KrFgQsZhXz5nqIV76pBGQ8b8xJ76M3McS23COAjPQu2EtNEeGG/Y9zwpRNq
	g9l+LJDWDxoiA7qLF+F93yPnQWhTEwvv/B1gMSc6SWwqI7FSB0SrI3CR5JZdfOpIGSeo7I
	GXAnVbrl6Vm6a//OWA6mPtDG2QKiil4G6Ce/v9nokrQP0Y5ZxZU1SzYSk1dnMA==
Date: Mon, 3 Nov 2025 09:40:45 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal Eberhard
 <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251103094045.73a061ea@bootlin.com>
In-Reply-To: <aQMpHDwCqcrNrnT9@smile.fi.intel.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
	<20251029144644.667561-3-herve.codina@bootlin.com>
	<aQMpHDwCqcrNrnT9@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andy,

On Thu, 30 Oct 2025 11:00:12 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...
> 
> > +	ret = devm_regulator_get_enable_optional(dev, avdd_name);
> > +	if (ret < 0) {
> > +		if (ret != -ENODEV)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to get '%s' regulator\n",
> > +					     avdd_name);
> > +		return 0;
> > +	}  
> 
> 	if (ret == -ENODEV)
> 		return dev_err_probe(); // takes less LoCs
> 	if (ret < 0) // do we need ' < 0' part?
> 		return 0;
> 

Well, I need to abort on error returned by devm_regulator_get_enable_optional()
but I need also to filter out the ENODEV error.

ENODEV, returned by devm_regulator_get_enable_optional(), means that the
regulator is not present. This should not be seen as an error by the caller.
Indeed, the regulator is not present and so, the related ADC core will not
be used. This is not an error from the caller perspective.

The code you proposed is not correct regarding this point.

Instead of my original code, I can propose the following:
	if (ret < 0) {
		if (ret == -ENODEV)
			return 0;

		return dev_err_probe(dev, ret,
				     "Failed to get '%s' regulator\n",
				     avdd_name);
	}

What do you think about it?

For other comments you have sent, I agree with them and I will take them into
account in the next iteration.

Best regards,
Hervé


