Return-Path: <linux-iio+bounces-19718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EBABCAE4
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 00:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF2A17B53C
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 22:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50601FAC42;
	Mon, 19 May 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im6H618V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0F524F;
	Mon, 19 May 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693899; cv=none; b=V+1SFJRUx8mQqmhvsXnK4nsL/c40qPfXz4d/QhUI16xBikwZFmvs73WZHeJF6WtdZsRLY8uDoq1N+BQTbP3eV2cw7ORFYSLO0qv52aMBu3F7lEWPCdifP3PT8cnPa50bTyUcpOzDgp7ru9KL3q2BxgCQqlJFbFhpcx+r083vUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693899; c=relaxed/simple;
	bh=twd94YFShG5PaKr1yOCPEGR19p35/1Yadc8USsIYst0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFdaQOea+vQWwHKi355SroatxNwXufijWngtx6E9zQx3hQRm+rz3jvHBwip3GRQvs7GrsLRaUJHkj/oCTtdUhF971auXNNcFSeSsH1Ic/PTtpt8H5g10mwI3kMxsVLj8gfYoe9NCEyBmkpyipHJUpKRGfjd6SGOGBszX0fgcg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im6H618V; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5f619cc01so73194085a.3;
        Mon, 19 May 2025 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747693897; x=1748298697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNRhady4NedJvDV1wRtYfXkN0eIeHdeRYwkGiPr6wzc=;
        b=Im6H618VdaAdx/F1R8I+0fc7Lv7RENbWhYn15EiGBM2MidjfMFUGsu/gHTwvmZAN+y
         Wpl8707oLRuA88w7P0hzu9MlAG8b7+2AfgxVZ85SKk/MBuSyxeiMrWO+T28eGxGxtZfG
         25o3oUz9kMRGaEc4QQu+1ncbVk3yroM8nWdRQ2CgCaZPCagv1syF3OIQnYKFzFFWkHix
         pLheUWuyxqenkZJvFs4p0qMcTVMc8gnzxcELJiB9Vnyt3pfPRfqg48LYJ/eMKx6WE9LQ
         PXelrq9DVqK4wiUPiPN/TEELw7DYCe1f0ZUAlluBlDDG28k0kqgKoSemNR1f/nLrjsYn
         INyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747693897; x=1748298697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNRhady4NedJvDV1wRtYfXkN0eIeHdeRYwkGiPr6wzc=;
        b=HAMA6b97SXhv8KJrzz98H1CkCabUzHizwQV7NeHN4Df1hDLD9GwWDJAWabmWmpZUSB
         CK9izalv2B9E785DRIzRw2mL1GcQm0EnQrvjENKob02F4Aa9RozPpWqb/8xN02ji4ERf
         KG7txev48+iAiQhSU01/iFrPtykcM7MI6XU2kdQNvHjuH886COLOeasH5gYD16H50uaa
         gGmr8xR012FCTm5ymTWg0JfE1zP0AJu3ClY2nB9vKROLgk6UVvwh7ngJJYoC+9MngHLj
         uNAbt3krmcYzLewNkUZhvZGJPgfCvNxv87p5xX9o/8wMYGqHgnjtF6Bwm9Ix4ZqB70PM
         DtaA==
X-Forwarded-Encrypted: i=1; AJvYcCUCpZSXpdC0WsqXOgL7nuG//3MXTFBiDAK8Bwtb5DGgDnFOH7KeQIgZhYtkftW2q5YngWW1TrmXFfADHzMs@vger.kernel.org, AJvYcCWLfc3UNBIMjjI1Snm6hAp1vStKQ3punzrQeSS1GvGxBPrpBzOH3P7LkICIY7nifCKbhUDfByIgjtReGg==@vger.kernel.org, AJvYcCWrmx2E7YN1o2QXYDoazJLVgDB7ZCMGvUi2Z3w6+t9YbcJZB8624wBU1r0Qb+9gNIKwr5ekePJHk0xp@vger.kernel.org, AJvYcCXegAP0MbbXWO5BZNIouy+lIf/gLMNdMx44MHHjUi8ad/UeJxCM7Qe89N32yaJfdmNbNb3xsEa90HDp@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/HVXZnzWLb87DL0FumWLebuUQnDXdzXfXwkiypaZ38h+uhDZ
	bmDY3lljr/9LLn3/OMWoCRhYRFtQGhwasTSJJZ2l2QQWRcTGrtH5AcYO
X-Gm-Gg: ASbGncuEAH1t9OpqaOlHyZNcusjfRSm+7LCNFpyPEukFQiyzzeQ7RaSp1Fol/ssakaO
	vA62CafcClUZJl3cDCZhM0nyLDN7x2B4oXqX3cQOVShEiToZhmiIjxWwN9fhwEL4TyXQuPrzHDS
	KxRrMjzyrzKblFfOBPgg6AUewJof9d8Zmn4hKa/2htvRI8+lJIzGV80NSJYrb7hTIUmqhFXD4ne
	CBn5RJcri6mdlCkjKLsYnF9wbIrQ1x//m7JOxfqlXdZKn0XzHUg0y9seRY5MhgIo5Bh4hgD9rTb
	6aGNTfNPPhq64YJrLzB+IZ2ktafvP5wevol5vBqQ//u5Ur514dIq1+lySyUcOzESn1P3Al/M
X-Google-Smtp-Source: AGHT+IGh3p0p6XHD6kUXTDkG5ZGADgJ0hhzJakFzthoIXrWXnT4v5hCkzwTklcCcCCf5dr6edgdKFA==
X-Received: by 2002:a05:620a:6506:b0:7c3:c9d4:95e3 with SMTP id af79cd13be357-7cd46779c90mr967974885a.10.1747693896617;
        Mon, 19 May 2025 15:31:36 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467ee1fcsm637581485a.52.2025.05.19.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 15:31:35 -0700 (PDT)
Date: Mon, 19 May 2025 19:31:30 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: 1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v8 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aCuxQgCPgeFAqwWh@JSANTO12-L01.ad.analog.com>
Reply-To: 4843ec52-57e2-418a-b640-8e05ba60959e@baylibre.com
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
 <aCtmt+ozqSRDGQxi@JSANTO12-L01.ad.analog.com>
 <4843ec52-57e2-418a-b640-8e05ba60959e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4843ec52-57e2-418a-b640-8e05ba60959e@baylibre.com>

On 05/19, David Lechner wrote:
> On 5/19/25 12:13 PM, Jonathan Santos wrote:
> > On 05/15, Jonathan Santos wrote:
> 
> ...
> >> +
> >> +/* Decimation Rate range for each filter type */
> >> +static const int ad7768_dec_rate_range[][3] = {
> >> +	[AD7768_FILTER_SINC5] = { 8, 8, 1024 },
> >> +	[AD7768_FILTER_SINC3] = { 32, 32, 163840 },
> >> +	[AD7768_FILTER_WIDEBAND] = { 32, 32, 1024 },
> >> +	[AD7768_FILTER_SINC3_REJ60] = { 32, 32, 163840 },
> >> +};
> >> +
> > 
> > Since we're still discussing some points — is the `step` in 
> > `[min step max]` for the IIO range additive or multiplicative? It is not 
> > clear on documentation, maybe on purpose or I have missed something.
> > 
> > Here, decimation/OSR doubles from 8 or 32 for SINC5/WIDEBAND, and is a 
> > multiple of 32 for SINC3. So I'm still unsure how to represent this to be
> > clear to the user.
> 
> Sounds to me like sinc5/wideband should be lists instead of ranges.
> It is only 6 values.

So can we mix lists and ranges for the same attribute? I see that this
is not usual.

> 
> 

