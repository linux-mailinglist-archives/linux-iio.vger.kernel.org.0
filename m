Return-Path: <linux-iio+bounces-7641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61942932EDF
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 19:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9218C1C2215C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B519F48C;
	Tue, 16 Jul 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktdtx1l9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80619E809;
	Tue, 16 Jul 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149740; cv=none; b=raR8qXK7cF/wdP8tMDfIpPBdqp9UrBT4gZPVJDpkyXRSOYXsJYiZ0DpvdmF5WcbXkqtWNjP/k//ovV7YLTfHwnqVV5XOM3LZUfQlLHlkyl3MMKBIHOvdgN52aOkBj690+sdpLRgj7ItzIHzviJQYwXkQPf4Lh/8zW0jXTQ3lpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149740; c=relaxed/simple;
	bh=HdP4DmiZbGFy/iNyjViBsnCN4s5UN330LrizbZ9eO+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3lKXiPMgtY+aQB1j1IFNacAGaxNAk2MPWPwXGrAx9px2+8V5di2D5Ub/QZqTuBWks/LKkrwnj32rScxZzCXPDVyjyrZM+krQ29q0XY1T/wM0Ec+qgPVB6M5vbhiM/ZWol50J8AvqF0TpRDsf2AYE3F5CySpbd5aQWd+m7+UZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktdtx1l9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D0BC116B1;
	Tue, 16 Jul 2024 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721149739;
	bh=HdP4DmiZbGFy/iNyjViBsnCN4s5UN330LrizbZ9eO+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ktdtx1l9qV0UJxtGhey6tCY6gM5HS8tPZyjdV6fseTR6e316UpVs2vCuYgQ6zNk1o
	 kWtT7wXCX6RK6anPFTl7Yg6tIn4yVdRcNZXTrXFfAmvYvr4WP7c3Mm7eQQl26UL1z+
	 LEa6RbmHwiBD4Lsu86LMDrMc5KUHTazk2ee7SurDUWlULpjBNIM+0KcfwG6otpaAnI
	 lGJS3iRyLgTGv5u3csoy765aeC1YKLolicSIFFBFLYl1pTaa3q6ioJoxg7APdvqYHG
	 2/Xvy107PEiM3NW9pnA3HHZ9Y1iDYsUYq4rCEHiOWPWwtwKcMmEEY98M5mOuv0j9mO
	 HmmG1ncjEqn4w==
Date: Tue, 16 Jul 2024 18:08:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adam Rizkalla <ajarizzo@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 petre.rodan@subdimension.ro, mazziesaccount@gmail.com, ak@it-klinger.de,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org, tgamblin@baylibre.com,
 phil@raspberrypi.com, 579lpy@gmail.com, andriy.shevchenko@linux.intel.com,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240716180850.7c6089f2@jic23-huawei>
In-Reply-To: <ZpROUow6p78VJsrO-ajarizzo@gmail.com>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
	<20240628171726.124852-2-vassilisamir@gmail.com>
	<ZpROUow6p78VJsrO-ajarizzo@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >  
> >  static const int bmp580_odr_table[][2] = {
> > @@ -1830,6 +1848,9 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  
> >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > +/* Instead of { 1000, 16 } we do this, to avoid overflow issues */
> > +static const int bmp580_temp_coeffs[] = { 125, 13 };  
> 
> I'm not really sure what we gain here from using 125/13 instead of
> 250/14...but I don't think it hurts either.
> 
> I don't have a way to test this with the latest kernel release
> currently, but lgtm.
> 
> Acked-by: Adam Rizkalla <ajarizzo@gmail.com>
Series applied.  Thanks

Jonathan

