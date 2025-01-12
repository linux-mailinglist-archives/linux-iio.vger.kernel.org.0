Return-Path: <linux-iio+bounces-14233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F2A0AABF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4413A8D64
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352981BD00C;
	Sun, 12 Jan 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnNzKI55"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D71BBBF4;
	Sun, 12 Jan 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698067; cv=none; b=Tqx+cMf2wZc4TaMIyHhtteEgw0AAJhrVzqkcaCq1eKRoybq+hPfnFrvzGDwvPQifh0jYI6hZ5ZYMlDbMRxFC1q0OoeDH9jla5gOfsYtLTtijiPj+Q2XQ6PlJm2g8teejhVOEe6lPuAnBKKPiJj129nvj47ZhRlCVDtCXt7MEt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698067; c=relaxed/simple;
	bh=ws6d0Tir81zfEMIo3Iv9pyj2/RpUpAccKseGIzt6EiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GgpUlSWeVsJebatILUVvlsf7yYkqS3nJw4C8zeYc05Pw4g39SDnT0UQOf6NkexmLpQ4me1ftXxc8IElhFTNi3kaoihSsD+MxW/sV3gtoNJ7luXI9bYqh3veNyS0EHhLM58dcarJ/gzBneQzBTR8k90UTKgOF8Lkq8817fW74MNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnNzKI55; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a88ba968aso2978001f8f.3;
        Sun, 12 Jan 2025 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736698064; x=1737302864; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfhk7dxskIWup4BxhAT2ThjYcUUpbv+WhEtZQMeo3V8=;
        b=TnNzKI55NeeNlijVWm2ezt3pMEBS5Pu8EioTJ9YFiLpiLpkLX10QkM/sX1wK8RA8iO
         I5cp5BI6qEG6D8VSdpxYCeAihBdzBOfreW8aKCbJ4Oi0q7Vq7ZyrwsC+pn7anXfUF/IR
         RL+R0xHLVzWu/p9F83ZwcMnrDwepZTXUWSGqX9u3M8o1nZmuoLJOCVxV4Yae0DvQno47
         FPP1HdLdySq2R9YAZthW61qcQX/6qNTqFipNzuqhWlDC9s+/1LTWs5QZfxpV8ajnDnk9
         SR4r+t7T9S1Yvkk/fR/crNEE7dy4viAmZUtsQJUto0qAzxHeZBEoplZ2yrZKxPVVhRdQ
         htXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736698064; x=1737302864;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfhk7dxskIWup4BxhAT2ThjYcUUpbv+WhEtZQMeo3V8=;
        b=FEIXW+NmOK5hg5PjrDF6SUdRN578T7Yy742c80J+pflohIVHxzK29YyDKC0HNgiggg
         Z1JWDvYpMbn94DMAMqZnWvnPuf8wCE2jaAMgiN6hgB9GzaM2/BXz0KCGxv9lttsYKfSg
         0z9YwznI8bfxc4qhJ68DUuLHsjw1v0EnHXIZ8k43zCMD4mhHSOAasOaEkswHdVvwy7wM
         YopxBoHnCgCVj7TgSPrVoyFiJid3J7dR+VU3JNKownp4IXFKE7ULGNVVxSOArEKP0IDZ
         Sl8tj2TCVQ4o+ovg94JDMr+v10FRGTamKD8BAve9sUKMINS4dvC7Glnj/BRcVQ6m43up
         BIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDFpRTnja5nM0QqpVHv0wcB2VHYiwQIc7lOBgygW8RRlfJ7zRqg4JiKmL/oadMyH3ZspUQPig957o=@vger.kernel.org, AJvYcCW1Z1NeHyry8NjbsTEpUeG5QBJrM86rMY1JwivyAAOgF+ng8D7ph83raa1FVacFBcvidoGKb2ih7zvZxw5o@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzWYIbrhPqCIOy5pZFRCOocr5xOo8/+xLdQMoHSh1a5tAyiEd
	YbdwtvQJxJ3BIAUch0ous1PcRUfhGuHenzb7sw6B1URSbb2DF/t/Bx4FzA==
X-Gm-Gg: ASbGnculJtZweK5zq8PsTVJB0jqii6hjwXPXbI5hDo20yLXuQt1NZMebu8uA+8RlKbe
	hjyeFhIbUDCh/5I1UEL474owPthnJJqLol07c6tDe9zFzgk2306H43fmg1wBionDTh3RZH7YAxn
	0pYMrf3eoQoLfCzeGOP49JtALHxmdf7zrQgLxgEq1BgIpJsnP4IItlxca8E2ENKIg0WLHhVws2M
	nufrUzqJmDxlJtPG13Inm2eWj9GHkQAD2VnjCSMqCyLfO4Ziy6zXvEd/R7WENDHYKnluiE9VBw3
	HGTy4H7eyxbym+bXMlMusqZo/mxd+snw3tHmbttUj9fTWHqp+jsNAWARJ5Cg1gF2wzvwLNdK4zT
	B
X-Google-Smtp-Source: AGHT+IHFMk86PVZ9PUQ5EVTLuo2RL1ACBbF3rC56IuKyxKoPS8kJr1flynrjAfHtOfw2WrcBCub2EQ==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id ffacd0b85a97d-38a8730d55cmr17582090f8f.25.1736698063543;
        Sun, 12 Jan 2025 08:07:43 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-b3ae-4f78-5cdc-b04a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3ae:4f78:5cdc:b04a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383654sm10119572f8f.30.2025.01.12.08.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 08:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jan 2025 17:07:41 +0100
Message-Id: <D7082ZE34NTT.DHC0Y5220527@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
 <Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>
In-Reply-To: <Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>

On Sun Jan 12, 2025 at 4:18 PM CET, Andy Shevchenko wrote:
> Tue, Dec 24, 2024 at 11:59:02AM +0100, Javier Carrasco kirjoitti:
> > The configuration and ID registers are not volatile and are not affecte=
d
> > by read operations (i.e. not precious), making them suitable to be
> > cached in order to reduce the number of accesses to the device.
>
> ...
>
> >  static const struct regmap_config veml3235_regmap_config =3D {
> >  	.name =3D "veml3235_regmap",
> >  	.reg_bits =3D 8,
> >  	.val_bits =3D 16,
> >  	.max_register =3D VEML3235_REG_ID,
> >  	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> > +	.rd_table =3D &veml3235_readable_table,
> > +	.wr_table =3D &veml3235_writable_table,
> > +	.volatile_table =3D &veml3235_volatile_table,
> > +	.cache_type =3D REGCACHE_RBTREE,
>
> Any specific reason why this is NOT a maple tree?
>

Hello Andy,

I followed the most common approach in IIO (52 RBTREE vs 2 MAPLE),
assuming that the "low-end systems" comment for the different REGCACHE_*
applies well to the typical systems that will make use of this driver,
and many others under IIO. I considered that *possible* performance
advantage for low-end systems above other considerations, like the
general rule about using maple tree.

Thanks and best regards,
Javier Carrasco

