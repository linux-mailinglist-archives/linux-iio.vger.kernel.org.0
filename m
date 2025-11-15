Return-Path: <linux-iio+bounces-26243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA88C609DB
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C24C74E3B53
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EAC3064BD;
	Sat, 15 Nov 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD6IeNS1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21A18EAB;
	Sat, 15 Nov 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763230378; cv=none; b=DZsN1hWiPD/Qw41O8AWycVya0lppmBdRtb4vEpnhWuLm6uIuuhejvoZ8pwLB7xhi9Vs8tPXBBGAf7nO6cGtJVKU5ykSQvQrvbKUUjS5Mz8NwN6zsPHURR/lP9hgi+70U8YPIsCTtUjiDoNp7QCTtgAhsQROuCKChdjrY6tzi2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763230378; c=relaxed/simple;
	bh=3NdBHchOwzDWWETfpr+5Htap0dMMcBzCZHuWBP/Crk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5zoagxHLm6Vm0ADlg5pmFYwDlYNLQ4/OvXf8bp2TjRFFz3EvtyfZIE4Wdcn9hcPOU2/lCxUCEN09uKNJqjTpSo+ALbWgpytpRplorStuBH04rD3oWVZNtRKDvjNYaAWK34EWVCEYya5NKIPYxCS1NCliLaeO/dY4xAVMHHGZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD6IeNS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D302C4CEF8;
	Sat, 15 Nov 2025 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763230378;
	bh=3NdBHchOwzDWWETfpr+5Htap0dMMcBzCZHuWBP/Crk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WD6IeNS1dWrho8dFbjJHU3AAZ5F9Som0clzVpdwbwYEKz0aR6VNPppeHFhn+5+Otd
	 eO4lgtc2EjneUKa4plPJFaoXSj2ifIxHg1R3thoeDvZ+y6F43wvnTsM9TpQWyMTLPm
	 rIiQoXZRL9WPSALiPsVHvsqXSg12jqIJlEIQa/UNGOP585E/s6PzAPtBXi/4OVAQqu
	 uPj5L1EbrCEUgLTao91S1anJck0sU6uVnbVCYif1SD6H3z5igf1vac/eguDE+U0oIn
	 fMkMvt9q6gX/2y5XBrjY+QAJ8pZMUUzCHKdhBnADCa9+++bJVB0nVR/3RqSxS7H0Pj
	 L2EiNF8x2ZLww==
Date: Sat, 15 Nov 2025 18:12:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: amplifiers: adl8113: add driver support
Message-ID: <20251115181254.32b00b34@jic23-huawei>
In-Reply-To: <CY4PR03MB33991FC450F33126532B80C19BCFA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
	<20251108174357.3748-3-antoniu.miclaus@analog.com>
	<20251109172213.69d35297@jic23-huawei>
	<CY4PR03MB33991FC450F33126532B80C19BCFA@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +
> > > +static int adl8113_read_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *chan,
> > > +			    int *val, int *val2, long mask)
> > > +{
> > > +	struct adl8113_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +		switch (st->current_mode) {
> > > +		case ADL8113_INTERNAL_AMPLIFIER:
> > > +			*val = 14;
> > > +			*val2 = 0;
> > > +			ret = IIO_VAL_INT_PLUS_MICRO_DB;  
> > return ...
> >   
> > > +			break;
> > > +		case ADL8113_INTERNAL_BYPASS:
> > > +			*val = 0;
> > > +			*val2 = 0;  
> > gain of bypass = 1.0 rather than 0.0 which is open circuit gain.  
> Isn't this supposed to be a dB value since I am returning IIO_VAL_INT_PLUS_MICRO_DB? Linear gain of 1 = 0dB.

Good point. I missed the DB type.


Thanks,

J

