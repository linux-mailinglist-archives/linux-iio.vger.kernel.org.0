Return-Path: <linux-iio+bounces-25836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED3C2B1BB
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E479188E150
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C02FF166;
	Mon,  3 Nov 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjYNBIFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E82FD1DD
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166388; cv=none; b=l1UWnCZ2uJ4e0jkC+iT6usoCePXwAUAgbu4sdyGKcEXTKFSINIiQJS+eBWTzFECIGxFiSZINsgGJcxMyuz59G9n6PyAcKVbluMovU2u/Nkrpd84yExh6hJ04XoesPzMAKgtQ08shTH7zUJE6KgPtGAA1zKbXMm3cqpP8Qj9y9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166388; c=relaxed/simple;
	bh=1ck15MgFUj+5JLGXiVIAfEIKjbi6T/LZ+JxMjRMaiIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvca4aHw6hgWNNqK+7zWmPgWM7p5wGYISKn3psIYrAlTRhot30nFlamjxmm/56b+5MspjvkGLhJBDKFSqqEFQdIhe+WP1gdluchB0MVNviGe2qoIDhnj0zn45T2cxbOBzkUuaRkbI31DNBaL5azpJJWxfzE2jaYnKojDQqhjCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjYNBIFv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so37836985e9.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166385; x=1762771185; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fovaz9WflgzlwTaD2yY13mBWQjUWu8aPyZOWrcI5YCo=;
        b=WjYNBIFvLy2icTHx3qhLigtT/exupmTTwJp4SK3dNhTYw/uyfiqE88wnbR+aNkfRrx
         kXABO5VPfnLbk8zT6NWEj1FPVcxfr3I/r/f1riXn0Ndxy0bPK0UlmnrzY/FU+XSrOofG
         N54kfqR7TBt4vISQZrDoHBHzXL49NDw9bMPLqQhasZD6hea1AoreeVeI1t/KA51sIi+p
         c7yjrZlH+xVnP9OZz6pUc0s7L8lNUno40zzJ7DcNaJ3gzmD6JsxVR0RGP8oIcNNy37Qa
         MJfJGmOFsq56Nc6QfI8FCH/kHqPlRYCogUfdvZSm7W8d7fNw07s/qmuOGm6H8Wg2IAtb
         MqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166385; x=1762771185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fovaz9WflgzlwTaD2yY13mBWQjUWu8aPyZOWrcI5YCo=;
        b=PyNZyumgyBPUDaiFd7r9D8iJKnXTg3ROYjhPjpiPq/euFDdxKvy1/p20qtu8ambgNU
         /hDrEW1xgIAIIyCeNUSd5oA+7OqMdzVRwcthb1UYWh9dIzmimnjjuD3uYrqkcM55757A
         wMebXOZag+B/ljqVzHnaLL3JRHnwp5X8w2I1hZ05YIXaGtDW3nDI3uzm/ff6fpjJmZdr
         Gt5KPvJ0FsCb6w5kXWDUNkM7eVustBm1X0QOTnjqzL0/H3D0ADcqYtwU2/qVR+7TZ2zv
         fIaAJbEbqUn7lrlG5ojxSFwMs6YgYVExWTFiEj473RJU9x2ONRD3TdNtx4ZLtm93OHgc
         Ve4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+3PobkHg2Ab6Wrp1eryInWYcbUC6JAjs2dEQyjfGRIR3FnKYu+ziZPjtnxhGoiRX5wK7+AKne1IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlL3KdmtE2tvgTza2gZeDv7Mm9Qr4cEaZovRtfjSDGldkD/3D
	Jq7kXUnjhx9Va2NF+s9adHbpXkbb21cYnzPbgyxU9oyOIKsq4PkfaVzyjsgpjg==
X-Gm-Gg: ASbGncumvL9aQs6IboI3w+dqPEt4mKArMC7LpIC7MydUwzi5eBHUK4Qg4Xdui+QkN5M
	daoqlLn4qhYMoz2pxqgDHUGsR1MO/T1y5K7Gra9MOmN0JmRMy11PKZPm8An21ENLmfaPpvEGSon
	xIizvtocnEkzX2apDX0exIbFNbhjiPwKhQ4DOoYJ3sGfZ/n858wuZOcJuAQ3RjsCor08i/TW2G9
	WS7Z1VFOSGDW/6ZuQDIGIpJygsbsJRfq245sAq2J3JfOFyhGFEEwIfr/2jH7abzkw97ExFGWmtS
	NFoH9xM/gEPVZfvn2QyG5a5Ee9l/QTccv68f7HW0h8md7A1wXgDPnY3f3d35hl87PINqMV+j7IH
	i+KPU8vE2hA0uH/VZzLZl7P6J8HAYsmZtQI/OUeEC8yq10+TZaqglpN6UiY9KaNvyDX0yr9klRZ
	dYF7ECS7o4QrkG0QU1tek=
X-Google-Smtp-Source: AGHT+IHuZdNrU54P2NkcGLLJ35h4VOE8yUhWVx1HKCFre8hlEfwp8TJYBTIblWmOohNBSx4Ud4vPoA==
X-Received: by 2002:a05:600c:8b66:b0:475:ddf7:995e with SMTP id 5b1f17b1804b1-477307b865amr112547125e9.12.1762166384749;
        Mon, 03 Nov 2025 02:39:44 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429cdd11467sm9439174f8f.26.2025.11.03.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:39:44 -0800 (PST)
Message-ID: <3c82c959e714ec8507d2c28494bb24d9146cfee3.camel@gmail.com>
Subject: Re: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= via B4 Relay	
 <devnull+nuno.sa.analog.com@kernel.org>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>
Date: Mon, 03 Nov 2025 10:40:20 +0000
In-Reply-To: <aQhcFl4fE5Akn397@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	 <20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
	 <20251101164612.449606c2@jic23-huawei>
	 <aQhcFl4fE5Akn397@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 09:39 +0200, Andy Shevchenko wrote:
> On Sat, Nov 01, 2025 at 04:46:12PM +0000, Jonathan Cameron wrote:
> > On Fri, 31 Oct 2025 12:31:27 +0000
> > Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote=
:
> >=20
> > Looks good to me.=C2=A0 A few minor things inline.
> > In particular a question of which include is missing for the byteorder =
stuff.
> > Maybe Andy can help with a suggestion on that?
>=20
> asm/byteorder.h
>=20
> ...
>=20
> > > +	st->d16 =3D cpu_to_be16(val);
> >=20
> > Should have an include for this.=C2=A0 Probably
> >=20
> > linux/byteorder/generic.h
> > though the kernel (and iio) has a random mix of that and
> > asm/byteorder.h
>=20

Yeah, I did tried linux/byteorder/generic.h but it fails to compile if it's=
 the first=20
thing we include so I did not wanted to go that way :)
> Can somebody go and fix all of them to be asm/byteorder.h? Yeah, it might=
 need
> some thinking as in some _rare_ cases the author might imply the explicit
> choice of the algo in use. But then it might be problematic on some archi=
tectures
> as well...
>=20
> > Hmm. linux/unaligned.h is using asm/byteorder.h so maybe that's the bet=
ter choice
>=20
> Yes.

Hmm, so linux/unaligned.h or asm/byteorder.h? For the spi version I do have
linux/unaligned.h beacuse we use some APIs but for i2c there's no use on un=
aligned so
it feels a bit odd to include it?

- Nuno S=C3=A1


