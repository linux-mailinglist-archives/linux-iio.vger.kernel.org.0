Return-Path: <linux-iio+bounces-21074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4625AEC961
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE1C16F510
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4021E0B7;
	Sat, 28 Jun 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYL+WD7w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6D22B594;
	Sat, 28 Jun 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131806; cv=none; b=YzLixBTfaZuGhwA3JZ4vBG/lfG1l0aoLEIJuWfUjB2eLVmJDP5Z63lThZak6WHFviGQL/C3gHFI0K79JyRsDxEt5u8iMNR0+OO4FPKm89DytNn/PfviDedm2345EjUtQrVpABIAMD8Nls7sGhz1cXXSkss0VuqELqNbTbA4DGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131806; c=relaxed/simple;
	bh=lJSsq3cKeP0H9TEkQ5kU1v6+iu6VQAqH/CtrVASdrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9JSyzoZ1+G0buNdpj1o8c3hAdiLKPoDFpcf8bOFS5di4MmiT5x11OBPcTVg8LvgXERDObbK810vX0VjKYbar7Q0PGgcaONIozUPu/uZS5dnqdBCV8G0uoWFHiGM/8BEh40794YMWgIqSEDNG6v9IQjlDkJqalJjWIBuK1o8qbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYL+WD7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46868C4CEEA;
	Sat, 28 Jun 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131805;
	bh=lJSsq3cKeP0H9TEkQ5kU1v6+iu6VQAqH/CtrVASdrM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYL+WD7w3GZy4QK6crHNAwtMKMJ+yWs/QmpzlcyGq3bSvr89/v41UIDYXpYJzcpmT
	 7rnxwe64SHFztw8y/i9JnMewRNO0UjUjBPDOqahef1VzhZmzPHDRo0OoKCIRzpRjjx
	 RDMhWFMkNcSPcNXOevemIJ/rJrDRUm4bV+8UPv6b85LI7x7dGIAY4LED4dm14uWL4J
	 yHI8lngTFCDVF2q5m1JqUMRC2wSeYYGevVBwW0bhU7eGM0vWaY+Dewy/fWF7x3wAC/
	 BW94CFtQ6iKiWUDaY/Jl/TkLCO/uPm7XoJdn+vHBUk+QeYzjgow7s2gEGw9i4rPtX4
	 mdbbsS9WH3gNg==
Date: Sat, 28 Jun 2025 18:29:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <20250628182958.6a813bc8@jic23-huawei>
In-Reply-To: <20250622153423.0d8ddcdb@jic23-huawei>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
	<20250622153423.0d8ddcdb@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 15:34:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 22 Jun 2025 12:29:29 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
> 
> > The patch set covers the following topics:
> > - add debug register and regmap cache
> > - prepare iio channel scan_type and scan_index
> > - prepare interrupt handling
> > - implement fifo with watermark
> > - add activity/inactivity together with auto-sleep with link bit
> > - add ac coupled activity/inactivity, integrate with auto-sleep and link bit
> > - documentation
> > 
> > Sorry for the fuzz: when I was about to rebase for submitting I
> > noticed Jonathan actually already applied parts of this. I'd recommend
> > to consider v6 rather over v5.
> > 
> > Since activity and inactivity here are implemented covering all axis, I
> > assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
> > channel for activity/inactiviy. AC-coupling is similar to other Analog Device
> > accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
> > documented and functionality tested and verified working.
> >   
> Given reply to wrong email thread probably meant first few patches of v5 that
> I picked up, I've dropped them for now.
> 
The series looks mostly good to me, just those couple of function naming things
need tidying up + I guess there might be something else from the adxl345 series
review that applies here that I've not noticed. So maybe have a last read through
with those changes in mind.

Thanks,

Jonathan

