Return-Path: <linux-iio+bounces-21318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D042AF7E47
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 18:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024EF483C4E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C866258CDC;
	Thu,  3 Jul 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrf8oxAz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA422CBD8;
	Thu,  3 Jul 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561902; cv=none; b=YzRo9B4z9oZcYTkIGveFAltxlie7Z+D1gJBYZkzFnwZFFBaysgofp8ynkFMrHFLT5jteUbmrs+nnsxOgSAv8pfjABItXBC8wMr9DEOsgEUGet9A8aRBkZpUFA5KwIzSMI/iiENXZ5OIPbDt1l7fQH259zrj1JfiJ8AWxKDRaa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561902; c=relaxed/simple;
	bh=gTADXefJfpRuQnZneIMTgmGJqA5Hp6PtGpOLvS7HbS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx5hdniXbIYvxEmMKVdNP6SSLOGbuz0kv37NTGjcM3rCyO4BaBa/pdf6axHS3WdH8c19zsm8xE6vBSf/aHuOoiwOUdcSYVTwT0DdkfRTlQ62jOPB+TGoecyFPl4kvjL+gSWoUtrsW8bBdxHYlVrqElg/VFcSck/xo/1mxF6PHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrf8oxAz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23508d30142so2320675ad.0;
        Thu, 03 Jul 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751561900; x=1752166700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfdd40hGPW9+mSHHbH6Co29MQZFw5Zd3l8gaeJvJ/Dk=;
        b=hrf8oxAz0nidYYki/3FPZzuhWEmNBIKEGmgnG8BI5LK2e/56CE7MeSVzQ5hm0F3G2a
         UCAnNbNn6gTnyaGQxvmtCBcQu2X9q2+A5moWeeDpbJrYxhKNE4cdxswKrpMXNfdrFMLB
         iPtFouGxYLZg6YctAuH8wpQoRfaArI7tLcMFdbZSPn8fj/K7nFq39xDvlX/yxPT+jgi9
         slYRCwmaWOa+kc/VP2i8i8NsmHsK15mM16pClBahXsqMZNfcTMjR679aEWyw2e88m+F9
         D8fkw+30TAD8mHiDcUoMBIz3U1OWV8WZA46XwNfqvvcIKS/aah5bNE87KIDwtHiwn0ld
         1baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561900; x=1752166700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nfdd40hGPW9+mSHHbH6Co29MQZFw5Zd3l8gaeJvJ/Dk=;
        b=NjO9HjJxDaoazaMpyA8FPPTTp7TDCNOyY16yX+/pQhQSlKMZ3KW9sqB/3gQl1HyDfX
         ALAZZe3fhhHrC6XcCiZigDL82YncBpQULeyN8aDQHt6Pb0XdpXr2dQxNjxoqhjsbtCO1
         4UpHEP6svKMM6NMPHXJ5kJ2gnpjtrP65/w2EGudzopSWWFRyPAsAiOGmB8kBBPIJ225V
         DP1luG3p7I4047tbsr3uh5+EKVsb6fu2Vy8l1gNGZyexjFD80w92Yrh0wQH4W3jJyRgt
         tZhCtb1WOzzdPXb+o1VSiAyHTgpMHlh0aoufCjuBBIFUwXWQ/HQrMw4MloGWLlpxVL7T
         mx5A==
X-Forwarded-Encrypted: i=1; AJvYcCUOw44aqGL3c54oE9g4aNHjsIGYBv3c3+UYlkrK7dy9iztVveGgLyt5KI7D9bZS7YNuiBVckLoFniUGTCW7@vger.kernel.org, AJvYcCXHPEj6fuxZ0+EbdC/cwH1kZB9aIMzFzF8LT28kEQzui+ufHse5pAPxMwY/p53tgmltHbWPDaomGBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTIzBzFiLQnXJni/oaTOvL8N83A45lcu18IleIoJr4iRsRw/L
	qxk361wgqKSpo4CT9/eQyx6jDZ2G/ylgYL3Md0tud7swtlXluD1QFkRWkkFg2A==
X-Gm-Gg: ASbGncszp1iY35dvlce8htggvMy7j8dsgLxFhcVxg9ce+kgPUiSieqkwkT7deQUctiP
	SWEtIWcTKIn8jHfoI4XfsM7wbS8Ydv/pJhFCE3wXvr3r4qIUHiOV9sWxG7wDzagNA6sPpuVrw9e
	XDnj5awEVnnrbJ1Nee8MACJm9mpCooH8M3ZWPs98YrAm2v/0ZrgStJMUIibo+VJElW2BB+QPApQ
	5Mu3DRFTeLOc3uvoWFxhLE7/rZ0g7cYFsy/fuoP+qy8cDy0PcjWit6k55imujPHqOJqxSSdCzmI
	A23hdKHHeDr7Dh60mkKAG0m02UdrO9cJs0WykjDLqauSeTeDngXP/33fCF5Z
X-Google-Smtp-Source: AGHT+IH8FObvGV7iLQxpoXaMWI/xlTrZYbrAR5aXp8VpSULc6F5ZzAmEgd7yWsFD0hTIxulY4uJk9A==
X-Received: by 2002:a17:902:f745:b0:235:799:eca5 with SMTP id d9443c01a7336-23c797ab3d4mr64095645ad.44.1751561899962;
        Thu, 03 Jul 2025 09:58:19 -0700 (PDT)
Received: from mbox.localnet ([36.50.162.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm292935ad.149.2025.07.03.09.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:58:19 -0700 (PDT)
From: akshay bansod <akbansd@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Thu, 03 Jul 2025 22:28:13 +0530
Message-ID: <2413481.ElGaqSPkdT@mbox>
In-Reply-To: <aGaIMjkYBmfMmCBn@smile.fi.intel.com>
References:
 <20250703053900.36530-1-akbansd@gmail.com>
 <aGaIMjkYBmfMmCBn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 3 July 2025 10:12=E2=80=AFpm +0530 Andy Shevchenko wrote:
> On Thu, Jul 03, 2025 at 11:08:59AM +0530, Akshay Bansod wrote:
> > Update the sysfs interface for sampling frequency and scale attributes.
> > Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> > and recommended for use in sysfs.
>=20
> 'must' is stronger than 'recommendation'.
> Of has the documentation been changed lately?
>=20
> ...
>=20
> > st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
>=20
> >  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> >  	for (i =3D 0; i < odr_table->odr_len; i++)
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> > -				 odr_table->odr_avl[i].milli_hz / 1000,
> > -				 odr_table->odr_avl[i].milli_hz % 1000);
> > +		len +=3D sysfs_emit_at(buf, len, "%d.%03d ",
> > +				     odr_table->odr_avl[i].milli_hz / 1000,
> > +				     odr_table->odr_avl[i].milli_hz % 1000);
> >  	buf[len - 1] =3D '\n';
>=20
> My gosh, this is error prone. I'm wondering when some CIs will start to
> complain on this line. But this was already before your change...
>=20
I'm planning to drop It entirely or should I replace it with another `sysfs=
_emit_at()` ?
I've seen other device driver returning space terminated buffers. Maybe I'm=
 overlooking
something.

> >  	return len;
>=20
> ...
>=20
> >  	fs_table =3D &hw->settings->fs_table[sensor->id];
> >  	for (i =3D 0; i < fs_table->fs_len; i++)
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > -				 fs_table->fs_avl[i].gain);
> > +		len +=3D sysfs_emit_at(buf, len, "0.%09u ",
> > +				     fs_table->fs_avl[i].gain);
> >  	buf[len - 1] =3D '\n';
>=20
> Ditto.
>=20
>=20

regards,
Akshay Bansod




