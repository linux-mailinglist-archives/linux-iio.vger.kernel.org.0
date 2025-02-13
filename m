Return-Path: <linux-iio+bounces-15488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E64A341C7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5A11893DA8
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E4281375;
	Thu, 13 Feb 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6U6mrhb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1228136D
	for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456050; cv=none; b=GeIuWfivXWBwF1q9tJwRwap0tXBYBSbqmLXUFOHb56m+lPeX2OI3qrcqmSO+HSWF45QC8XCcNivdc4Y/6twF+omqZOjpOHhGXXoyg8Y99QJKEl6ldpD2Nbm36JwR3zV0QtHxpHcpmmyJE0O2tLT1+OXUm9qZX+aqWEQqBcqBkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456050; c=relaxed/simple;
	bh=P1NEfa4zEQeoqaPcq7Tsvkd/tfn+NPzmhbOvCzm8xEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QM+qUoBtrW8GoX91vtZxMUa8EUfpye3mg+xz157eX9bKmkiCdkDA7b531nIHf1DMXzyEeeC8XwnAe/ZcSXKmcVQwdwv9pTYXE6hHEi5iLw9PIQCoB/jMGr9L3PVhflOIVySs72tWMF1QABaNYjydBl/RT5dw8duhkm11r/F1A+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6U6mrhb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7f838b92eso164060866b.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739456047; x=1740060847; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DD5ELLs6xTamjszH7VguUfoAP87xnzg7zG0dgvCBOvo=;
        b=h6U6mrhbEfgsIbzIfeASGHMV4zx55kz/tmD3Ponictfau1iE0M8iplKOWlrZR59JPo
         Jymx+SiPF/2EWeFgAZnHw18yJCDx1hKqUcVqZtbfc25R7wS4xmG0+wAa4nC2CFu+CisB
         PIzPofjHq0xsVR2t/OSnQiIlqVB68Q4qQdv61bLqbIrx5I24x94XbT6MDSv13kHxi8jX
         gZ29bP4f2JrKJe0WJ0PCjlv1oF7ofvE1aRaYmENhcuh4BSSNEnsa4gllwb+K0JSHUEQP
         j+LUQNXoM18ciy6zjHHSvXvB2wifrgtEUUasE8cmobj+V0am1lI6Bw9GUNOevVheoZ/G
         dVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456047; x=1740060847;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD5ELLs6xTamjszH7VguUfoAP87xnzg7zG0dgvCBOvo=;
        b=LjHsMZvVBX5sbAj6lS7Kb3FxH90iW8vf1dESZJw0tu0TiSJqqLPHLqUNod0JvTNB/B
         bExU7pmdE5jxILJTiZcfQYMk/BMOlMr644EqVyMzT+0EwUbJm2uvRcVBG18tAmXLnpYC
         entjKgwWBR0MLcR8ph0revZy+paB41o51rvlspSUhFmxN+IVMeF+EiG72OB3JqsoJ+Ln
         8HCARK1CKdEClI1zUnCiBXW4tctXzcVlvKiy+eBlZ8cR2AwuW314YdapbKhaqXGJUmlQ
         ljChYRUUtBToa6nrTa9YgDSnjTAMXOZ//OTpdWs8nUkfe5CbvoGuRmweqNdh09XjGb4O
         qQsw==
X-Forwarded-Encrypted: i=1; AJvYcCVH+Yss4G4DWUXb6GMSMZOrBd8+jfE+JEii7jZ6YwxmpuMOsmr2OPXWRfVv0fmNRyEFLRRDa9jeqWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+sZXgBMZH1VdSdiXTKKa16ZP4FWf7vYhU3cxrax8u/0a65BI
	5BSBqoJysYEAl9//v0tsRT1veGO9yUY0799LicJp2YORVss98QakhY8coQUc7Pg=
X-Gm-Gg: ASbGnctU3n5OX5On+AZaRb3pg0jZZ8yX8lZb67OCrenKv+n9FGetMsh+5+Lrrrf0Avw
	ygL6KxHemLZr72TypAnUvTjf+LQsJgW2CnPqq0Uu3udKLw6BSJoTHJOuI+d7bcidxVtjliykelg
	WNisQFyS0wzlWpeXHJ7makrk6qwEQC0VXduYklk3Wel/493sbADLv42u4kw9UwvLjyUFL8mtM1J
	HFdMDNBq5QElZwPudq9QMhnBAxn5eVOoB2R0LzOTc27FGaqF05Wdo4MJhh7gtZQPpVi6R4xEkEB
	tyBML4BWG5iCBPsKsd8F1UxJrnKztcMlSNt+HvpYlJaELGeFN67mV99CyAJbabw=
X-Google-Smtp-Source: AGHT+IFtOEhc3iTHs1v6dYZvCdScv11ccOn2tv5d2w91TZ3dYES8cZ5bDM2YTx0ZO1C4Da8TqMRotA==
X-Received: by 2002:a17:907:6d24:b0:ab7:be81:8940 with SMTP id a640c23a62f3a-aba4eb9b519mr355063766b.10.1739456046858;
        Thu, 13 Feb 2025 06:14:06 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm138572866b.131.2025.02.13.06.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:14:06 -0800 (PST)
Message-ID: <a6737423fea51af836f28dcb67d4bf3a1892f38e.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad4130: Fix comparison of channel setups
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Andy Shevchenko
	 <andy@kernel.org>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, Michael Walle <michael@walle.cc>,
 Nuno Sa <nuno.sa@analog.com>,  Dumitru Ceclan <mitrutzceclan@gmail.com>,
 linux-iio@vger.kernel.org
Date: Thu, 13 Feb 2025 14:14:08 +0000
In-Reply-To: <ewed75ppixxpbo4tgifnaqcbfp4gkqht6p42hx3usizs7zg5cl@mln2ul5fxrgk>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
	 <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
	 <Z5vBj62990oPT0QK@smile.fi.intel.com>
	 <ewed75ppixxpbo4tgifnaqcbfp4gkqht6p42hx3usizs7zg5cl@mln2ul5fxrgk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 10:01 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jan 30, 2025 at 08:14:39PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 30, 2025 at 06:45:01PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> >=20
> > ...
> >=20
> > > +	BUILD_BUG_ON(sizeof(*a) !=3D
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct {
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int iout0_val;
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int iout1_val;
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int burnout;
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int pga;
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int fs;
> > > +				=C2=A0=C2=A0=C2=A0 u32 ref_sel;
> > > +				=C2=A0=C2=A0=C2=A0 enum ad4130_filter_mode filter_mode;
> > > +				=C2=A0=C2=A0=C2=A0 bool ref_bufp;
> > > +				=C2=A0=C2=A0=C2=A0 bool ref_bufm;
> > > +			=C2=A0=C2=A0=C2=A0 }));
> >=20
> > Is I shuffle the fields (for whatever reason) this may give false posit=
ive
> > warnings.
>=20
> That's fine in by book. Whenever the struct is changed it's a good
> opportunity to check if the cmp function needs adaption, too.
>=20

In practise I think shuffling the fields is unlikely...

> > I think this BUILD_BUG_ON() is unreliable and ugly looking
> > (static_assert() won't help much here either), so on the second though =
I
> > think
> > it's better to simply add a comments in both places (here and near to t=
he
> > structure definition) to explain that these needs to be in sync.
>=20
> The nice thing about BUILD_BUG_ON (or static assert) is that the
> compiler quite reliably enforces the two being in sync. A comment
> doesn't.
>=20

Agreed... I guess we could also add a comment on top of the affected struct=
 so
that if someone messes with it, is also aware of this comparison.

- Nuno S=C3=A1=20


