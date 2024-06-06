Return-Path: <linux-iio+bounces-5936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5668FF559
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835DD1F25B9B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93061FC5;
	Thu,  6 Jun 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF8bfCpQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8013F9C5;
	Thu,  6 Jun 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702717; cv=none; b=FYrEQaq/bTr2wibkwFZpVhAi9Mi3H5k2/Lxo0uD93N12kn07ODWwp11iHmM31u8v/wRgJbDtK8iVycokGe/DNBQS1APhP2B5unffn1kRZRn6ejN1EqAkK3IoavAZ2+li1grdSqYNXN6Dn6tDAPQyXsU7Jz6pp1UE+qAKyOVblMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702717; c=relaxed/simple;
	bh=KniDFAo2wUWRRcajeNk4mxB1BC6ddnLIEbaLXKzbKqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMHb5u5dU//QFISkSgbngtP+fOruWoved1QSXYulED8yYyltFLyVJ0mDPiFkkkinkVR+EpjlnxU1AKY1FQ4xCncH4rRxw6uuDHPnzJQp79ptRFpD+/gCb3YnYFYw7FwEsibMvKQ2zsercXfhbR5QNvb5aIfJmtzSphMp3whsckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF8bfCpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5F7C2BD10;
	Thu,  6 Jun 2024 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717702717;
	bh=KniDFAo2wUWRRcajeNk4mxB1BC6ddnLIEbaLXKzbKqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fF8bfCpQ9m6jlbr7dyIaCY2Qe7JBR+5xUPCfAA39vryfLwAVVvddrzdcnKCBazyMe
	 wFKLnkhqargTgiuPXyat1P96w0VZZAwz8bt1DI8XCmaLiDSyJi71FvQm0S+KbXYqHh
	 Or5dYBOEX2EDy6lAa5iUccQQoGRUYWUm1m6hBAS2nH8SuPt8FmaYhvsjOre0DOLJQP
	 WRjhrcmp8ZbAOasJC9HMU10qcvcxDXoQxgB/9I/v56exrHCGOqDRdLPSSZtX8KpwXb
	 dD5LhY4g1d+p5NIC7LAOTK+zZy0Swcb+Fux+2dXcmgWsYfLKtDN4NdOO2JtO9+Uy+I
	 oEJa7B5IYaYXQ==
Date: Thu, 6 Jun 2024 20:38:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: apokusinski@o2.pl, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: si7020: add heater support
Message-ID: <20240606203831.20ee99c2@jic23-huawei>
In-Reply-To: <20240603230323.135181-1-apokusinski@o2.pl>
References: <20240601132507.316f9b50@jic23-huawei>
	<20240603230323.135181-1-apokusinski@o2.pl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 01:03:23 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Hello, thanks for the review. I have a one question though:
> 
> >> @@ -134,6 +259,10 @@ static int si7020_probe(struct i2c_client *client)
> >>  	indio_dev->channels = si7020_channels;
> >>  	indio_dev->num_channels = ARRAY_SIZE(si7020_channels);
> >>  
> >> +	/* Default register values */
> >> +	data->user_reg = 0x3A;  
> 
> >Can you build that up from fields with names?
> >I don't like a magic value where I have no idea what some of the bits are.  
> 
> In the datasheet it's said that all the bits that are set by default in
> the `user_reg` are "reserved" and have no meaning for now. So perhaps
> mentioning this in a simple comment would be sufficient here?

Yes and grr at the datasheet author / hardware designer.

Would be unusual to have reserved and set bits but I guess
maybe...  More likely chicken bits for features that don't work ;)

Jonathan

