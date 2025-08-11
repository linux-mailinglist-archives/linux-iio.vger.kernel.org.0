Return-Path: <linux-iio+bounces-22591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D5B212B0
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515CF7AFBFA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF142C21D7;
	Mon, 11 Aug 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2oh2T1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398E2C21E0;
	Mon, 11 Aug 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931605; cv=none; b=HDo/9wTRPmzEZgjRl62BPkARTH19ViRZjr4CKPGDlrxiNZDL8N93pv7npf9+j3/uz+LSWiM6iUydjJKRua4XosYXZtV5s8ikr6gVFaRplm44JXklh/oMtAaNKhgcSSkF71Gf0HGbey/aqRjnj+FTtuMC7upOnk8mR6lbI95DcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931605; c=relaxed/simple;
	bh=FM4j/KLa0Su57Gvjd7AN5fN2uWKuVf7TUWmimPrZGA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tsk39KMQ1L/15/tHnMB4V6Tb+DToyR8TIZ2eASSLy44Le6dCG6gpzjQz/t8D2Vati9TghWHX5XvapUI1msRXbjubaKm2RTQg7WQKaD/pz/fWvBc2ACCWWdsW9qF1kRmy9du3U40rCUp8m/bRl/iZnr7FjoVwT1IULGysW3I6KvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2oh2T1Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24041a39005so29180575ad.2;
        Mon, 11 Aug 2025 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931603; x=1755536403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b70QEBMuVk1XRVGfOT/SmxeLFQr82ewV2GdsPecZp9k=;
        b=Z2oh2T1QAM7veNFtfNcQZFKnEqih73Io7mN2xq2tLMkg0LNi9Ujf62rw63+7uybgSs
         ibe479/f+YuOEVGPU4ipa5AnrbxS1w0MSdJ4/SSefs3XEc5TqBNllmzw45rfj+IaXNbf
         BgSVU4QRn6mTNTce8IXZtqa0rCUaI0tdIkvjuUuP9mYwjo4S2PLUozmjSgkSqV7QXJtc
         35v6Nh021w8oyguRQ6vjnhN74yXnreYZH9pFAGS8TBOnNUL2EesRaXJS3baRJRxXRrur
         tG6cxJgizIvEMSgQbdWDFQ7KnUFxmxTxU4995KK4f8UnF+3VN2662O/YBs7nD2rSGitU
         tgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931603; x=1755536403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b70QEBMuVk1XRVGfOT/SmxeLFQr82ewV2GdsPecZp9k=;
        b=XRIS2u5ZIp000hejz+NwC+e0x6bRwGLU68ouBcrvNoWt+j8xil5ul+hPo5+3USnsrR
         HjnToelpxpRGWzDgr2dmFq3yKTk2KxKfJaLedQbE14MWSkhUNkghl6rVLLwzCdRMg1uv
         8b5uiwVzQSproPeVV2r0ozFcsNkMfJ2J0NccxGYN4C36odnxOK7Znha8Ol3CVQMggTol
         5hNhXe08tNaPF4hpEa4D9T+61HfNZjTv7OjAdXayG/S8WXyna6kz5UvWyTtGKUJ1rmM4
         mSzB3xuKiB5qvbzTNkfWTcoXz8B19Fm7do2vK6ueTnny3jSBKVupH+qScKjfO48rfnsA
         RxtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQcZtQTKvJXax0zd+SjKM/5BJbfxa8nXsVPFmcBJj0MaS5MbsOR1CL30JDBGTHs5OpGVWnpENWtQ=@vger.kernel.org, AJvYcCVWmNCngEbAbFIdChwB9xRqHtO0LAd6N0/4n0nF1cpGTnjawz2HHl7ZN82PeNRMP7PLWHC4MTbu2D2O6YH+@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRuXBXShCAIrw182wSxVIjYA4qEuFpbhOLW3FsnuAWAQeUrQf
	SObY+rIS4mdXs3pFUMJSIouQlPBfaxhQ5TeFPbOQy+3OYi2W2bVvayJp
X-Gm-Gg: ASbGncvC5Y4uTsfNKqVDayy4byJx/FavZ+Cv5978tZDy1nkAr3rv4k1dljuI2EqoIl9
	96N1uKpyomAO9c3J2wjCcJ/7IkGw+RmDj2oUBMPCwMrEL1tbs1Fku81DkY4hJknxKA0eIHngPDd
	hxAJAjqG2jzcMNdQ8zoVZrbJKh/I6g30N6Lm0WnRp0BaiSirh7DwLbrziw3QgeQ02H6Qh3CE54z
	VwqiRt+M7qAooR2zIQBqNJb0BTl3JpMU6ncpvsLl4o15A89PlMINZUd7sVdU1zDDEkNupeKeJag
	Yg1f4vv6P7jcLG8VJiGGdzu3Aqjkqx7/nnqXZb+PkNxxn5C/7kjvXLbIaYHcr/0Pp5Gt4BMfMtl
	E23tSQ+0CWyrJLhb4YOHMYg8O
X-Google-Smtp-Source: AGHT+IH0zWSFZlX6bq67OkLzvNoVEetQmj5bpELLZPknl/+OFNeXJ8jejEywySmXdVtYBA0wrWlIEg==
X-Received: by 2002:a17:902:e54f:b0:23f:d861:bd4a with SMTP id d9443c01a7336-242c21dd44cmr188020895ad.27.1754931602588;
        Mon, 11 Aug 2025 10:00:02 -0700 (PDT)
Received: from mbox.localnet ([2401:4900:1f3a:31cb:81d4:471d:6f8e:380b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976c40sm280902885ad.84.2025.08.11.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:00:02 -0700 (PDT)
From: akshay bansod <akbansd@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Mon, 11 Aug 2025 22:29:21 +0530
Message-ID: <13797318.O9o76ZdvQC@mbox>
In-Reply-To: <20250802125038.7a02cbce@jic23-huawei>
References:
 <20250723141359.11723-1-akbansd@gmail.com>
 <aIIdU7mJi_cEdRuI@smile.fi.intel.com> <20250802125038.7a02cbce@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 2 August 2025 10:26=E2=80=AFpm +0530 Jonathan Cameron wrote:
> On Thu, 24 Jul 2025 14:47:31 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Wed, Jul 23, 2025 at 04:41:00PM +0100, Jonathan Cameron wrote:
> > > On Wed, 23 Jul 2025 17:42:28 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > > On Wed, Jul 23, 2025 at 07:43:59PM +0530, Akshay Bansod wrote: =20
> >=20
> > ...
> >=20
> > > > >  	fs_table =3D &hw->settings->fs_table[sensor->id];
> > > > >  	for (i =3D 0; i < fs_table->fs_len; i++)
> > > > > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > > > > -				 fs_table->fs_avl[i].gain);
> > > > > -	buf[len - 1] =3D '\n';
> > > > > +		len +=3D sysfs_emit_at(buf, len, "0.%09u ",
> > > > > +				     fs_table->fs_avl[i].gain);
> > > > > +
> > > > > +	sysfs_emit_at(buf, len - 1, "\n");   =20
> > > >=20
> > > > Still looks a bit weird (while working).
> > > >  =20
> > > > >  	return len;   =20
> > > >=20
> > > > I deally we should have a helper doing all this under the hood for =
plenty of
> > > > the (existing) users in the kernel. =20
> > >=20
> > > hmm I'm not sure generic is terribly easy =20
> >=20
> > I agree, I have some plans for %p specifier extension, but I was stuck =
with it
> > and it in half-basked state in some of my local Git branches.
> >=20
> > > and I'd prefer this using the
> > > read_avail callbacks that require the data in an array where ever pos=
sible.
> > > Mind you that does the same print at len - 1 as this.  Let's play.=20
> > > Completely untested.
> > >=20
> > > 	for (i =3D 0; i < fs_table->fs_len; i++)
> > > 		len +=3D sysfs_emit_at(buf, len, "0x%09u%c",
> > > 				     fs_table->fs_avl[i].gain,
> > > 				     ((i =3D=3D fs_table->fs_len - 1) ? '\n', ' '));
> > >=20
> > > better? =20
> >=20
> > Without extra parentheses this makes the job.
> >=20
> Akshay, can you spin a new version along those lines?

Apologies for the delay. Here's the revision
https://lore.kernel.org/linux-iio/20250811165641.1214347-1-akbansd@gmail.co=
m/


> >=20
> > > It's definitely not more readable than the above, but it does avoid t=
he write
> > > to len - 1.
> > >  =20
> > > > In any case, I leave this change to others to comment, I don't obje=
ct pushing
> > > > it in this form, either way len - 1 is simply weird. =20
> >=20
>=20
>=20





