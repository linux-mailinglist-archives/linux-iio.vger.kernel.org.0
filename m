Return-Path: <linux-iio+bounces-5672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547188D7FE7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 12:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E518E289FDF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953B682496;
	Mon,  3 Jun 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFvGCRP9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B567D3E8;
	Mon,  3 Jun 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410360; cv=none; b=YFKCvph50PuEikglAqHOf2vj0yxX2XLCFKsot6d6ivqn6x9d25epO3cD975L5N1SE3SRWSfz9WOrVAa4xxiSWJ074zX94WUipbnzFwhD4fP759k+dszqoakBzBnS2nLpkGwFTSIjRv7HiFcgUnCzetqWJ032lrh8nWUWKNRx5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410360; c=relaxed/simple;
	bh=YPDnODl9PcFzR13QsOhcvaSdZfLpPP4ia6ug9ukKWwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agOLkn88qJrbiqnHqwyqVnXT7DHS8bqiqre91hANfimOmfAxEA8btu0QetQwNXj0gcVCPIehIiV8IJWHg7TMlUBYMEPPimBvBdyvjarQ1aEmLUb94btpCQywGdBZeGBIQ0ovZrpi4PWD/spoeyAjXWOHAlYhGGftfOr+5YifxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFvGCRP9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e73441edf7so46022301fa.1;
        Mon, 03 Jun 2024 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717410357; x=1718015157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YPDnODl9PcFzR13QsOhcvaSdZfLpPP4ia6ug9ukKWwk=;
        b=LFvGCRP9GgS0LPDu9rUohYwS3fiGv5Zz2y8ESaCExPzYQw1iNzRMMwp94/xqr6QwaN
         6RTwG7kqIa0wlbFQ7QApaaG7QIlb+Aw0zS1xipm+dV4O3izalrecN4meV3jHYhxCC8U3
         ghKLs2L4lPA+Su4o9zyL1vjgcJlyisPnMfdkGlkontVPtiXnbIGReFV/WTuVlXF3NQaF
         a0nJaMEHpdCCxAvY/I/cNxFM6AooroqSFu9aZxoxMi58sHcWfajR8pXPTvB2G3GUuNlC
         /eBOsVMmdd2bfOwzr9Y3btmj2BPIT3rO5xuNUIUuN0PyXIjqaOYu10pNEGUa7r4dC7Un
         mS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717410357; x=1718015157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPDnODl9PcFzR13QsOhcvaSdZfLpPP4ia6ug9ukKWwk=;
        b=sq7s0RWutIprCiwB2hoXq4P+MSSbo1sBoAcCYRGTgOKFKfY0Wk6M/Qz9yIgXpTTdSt
         kcdrosoCDpHas9EyJ71vIDNPlBHbHZyKL6SDvJannc84QlickDC/lF9yzDmyKNUdDYMh
         CjKgzl7/YDKWQmikxTAwSQorkXem1ZGMQ0U7xHBJYfF9L/FHa4Opvhqq0s5Uea2lF85R
         OEtujpLC7R9qro7UfzMC3V88ykb3hCS//Sio0lstPfwrimMjoYa+xQ7eT/g/Iq89Oj6y
         jMx2+yejieqhMmpo18is7U3JmqX0NcQfqACFNydrZJw5o38apSae5MEwPB9bbY4jwAcX
         BlSw==
X-Forwarded-Encrypted: i=1; AJvYcCWMDFNb909KDKgnX5PrJIVst2o4+RINIjWDmGQW6FFy8iZNOWResn2XQFQHRqvQ5b24Q4MrLSwtuFxa+takrn0g/3xW9Ydp6n8f8g30Rix8GJL+i/pADumN+r5nWI2QsSs7irXnDRm5
X-Gm-Message-State: AOJu0Yw+jKm2NvCZoEspG+dJlf9sijiYt3dB/r+7krK7OTITDiisPQKW
	j00zUJy/1e6PaEiSW5MTAKYY9YoNCG569LA5cx3guOtX81RLNejZ
X-Google-Smtp-Source: AGHT+IFoYCPQcW7U08SKO8zdKSSmkBYwIdHuHbk1AW5ruboNFfp/attGeJ9EPFVoBvokLFFq6UlC1Q==
X-Received: by 2002:a2e:b8c8:0:b0:2e9:5011:f6b1 with SMTP id 38308e7fff4ca-2ea951a9d69mr71259451fa.42.1717410356686;
        Mon, 03 Jun 2024 03:25:56 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421292205ccsm134767175e9.4.2024.06.03.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 03:25:56 -0700 (PDT)
Message-ID: <11841924e4e1db49001a2fe52f5985f3c044c184.camel@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: add support for multiple scan types
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Julien Stephan
 <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 03 Jun 2024 12:25:55 +0200
In-Reply-To: <20240602102517.438b51b8@jic23-huawei>
References: 
	<20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
	 <20240602102517.438b51b8@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-06-02 at 10:25 +0100, Jonathan Cameron wrote:
> On Thu, 30 May 2024 10:14:07 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > Up to now, the IIO subsystem has only supported a single scan type per
> > channel. This scan type determines the binary format of the data in the
> > buffer when doing buffered reads.
> >=20
> > For simple devices, there is only one scan type and all is well. But
> > for more complex devices, there may be multiple scan types. For example=
,
> > ADCs with a resolution boost feature that adds more bits to the raw
> > sample data. Traditionally, for slow devices, we've just always used th=
e
> > highest resolution mode, but for high performance ADCs, this may not be
> > always practical. Manipulating data after every read can hurt performan=
ce
> > and in the case of hardware buffers, it may not be possible to change t=
he
> > format of the data in the buffer at all. There are also ADCs where
> > enabling the higher resolution can only be done if oversampling is also
> > enabled which may not be desireable.
> >=20
> > To allow for more flexibility, we would like to add support for multipl=
e
> > scan types per channel.
> >=20
> > To avoid having to touch every driver, we implemented this in a way tha=
t
> > preserves the existing scan_type field. See the "iio: add support for
> > multiple scan types per channel" the details. The first couple of patch=
es
> > are just preparation for this.
> >=20
> > [1]:
> > https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_d=
dH-Dw3s6-sQ9sg@mail.gmail.com/
>=20
> Nice series. Applied to the togreg branch of iio.git and pushed out as
> testing for 0-day to poke at it.
>=20
> Obviously this v3 hasn't been on list that long, but there is still time
> as I doubt I'll push out a non rebasing tree for a week or so.
> This week is looking too busy!

If there's still time, feel free to add my tag:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



