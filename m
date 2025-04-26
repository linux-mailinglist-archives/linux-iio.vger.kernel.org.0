Return-Path: <linux-iio+bounces-18693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B31A9DB6D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FF792651C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924222172E;
	Sat, 26 Apr 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwPtB/qk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B93A926;
	Sat, 26 Apr 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677073; cv=none; b=u8I2HBjg63jwb8C2xpt4Uxu7xeKgn9wWznG22Fx27mgjPJb2jqH3sCCfhF44QSHh7hEWl6i91ZA3ThMLeh86E/VjsMPPlvGcLq+G5MZ3wszqWskPwrWxov9/0nNCNoLogNF6MUTkDr2Xn56YLaJ/rvgiNffMr+ROG5p4+kn1Rls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677073; c=relaxed/simple;
	bh=cuEInkRwNerk6OIj59R3c5CceD+2y0SbZ4SaWSSSy+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw3NM+J86tkJYd3fL3SvaRR06YDkGkq9IAxaD9djq1J1uRW9cb4sK5WbWG5F1Lfza5CeJ863GDlXjIn7w7vdm+znvYvYEsvOoW1IzVpK8n4N4Zs3z/iAChyKndMFB0xI+zKUBq5Y2lZiScmpZ/NJKLjPDczJU+MKHBNTAHZCVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwPtB/qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16886C4CEE2;
	Sat, 26 Apr 2025 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677072;
	bh=cuEInkRwNerk6OIj59R3c5CceD+2y0SbZ4SaWSSSy+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RwPtB/qkxig3paTp7m1RpRlCAA5RCyqTq6FFtfQ1baIQuvGHBKJrFlIPHYIxg8aKn
	 L7lPlhIMYWXER4bVjYgpPY0u+6LCAxfBAKEL/MamSkR27UwtjR3JUb6GxbNv4RO2/Y
	 OEiKkWoqH5T/nhzmTPuFaog/hYM6LAF6rP7I9/vXfs71+3uVg9nygNYl1B3gYn5vaX
	 2NiqWpm9w0qUA1vq06NiZZfOlS6XMSoFKScTiGBncYTpCgvL6ytnk9xTDO1mg3uIWW
	 t58zlr1EC06lR9l5SapjKiz/Bn1PthT2rdzcGwqfppxkxKFT3+15QJx2oKNDJjwkR1
	 eV+a2Ksxujw6A==
Date: Sat, 26 Apr 2025 15:17:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Eason Yang <j2anfernee@gmail.com>, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
 olivier.moysan@foss.st.com, alisadariana@gmail.com, tgamblin@baylibre.com,
 antoniu.miclaus@analog.com, eblanc@baylibre.com,
 joao.goncalves@toradex.com, ramona.gradinariu@analog.com,
 marcelo.schmitt@analog.com, matteomartelli3@gmail.com,
 chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <20250426151738.43f0d25a@jic23-huawei>
In-Reply-To: <aAoU6iWGPkqjon7Z@smile.fi.intel.com>
References: <20250424083000.908113-1-j2anfernee@gmail.com>
	<20250424083000.908113-3-j2anfernee@gmail.com>
	<aAoU6iWGPkqjon7Z@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +	/* Enable Channel */
> > +	if (chip->num_vin_channels <= 8) {
> > +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> > +				   GENMASK(chip->num_vin_channels - 1, 0));  
> 
> > +		if (err)
> > +			return dev_err_probe(dev, err, "Failed to enable channel\n");  
> 
> This...
> 
> > +	} else {
> > +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> > +					&data, sizeof(data));  
> 
> > +		if (err)
> > +			return dev_err_probe(dev2, err, "Failed to enable channel\n");  
> 
> ...and this are identical, deduplicate by moving outside of if-else.
> 
Not worth the dev vs dev2 distinction.  They are ultimately the same device so
just use dev for both.

> > +	}  
> 
> 


