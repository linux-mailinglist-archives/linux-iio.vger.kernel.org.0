Return-Path: <linux-iio+bounces-26967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD08CAFA61
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 11:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE08A3011A59
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E182D46D6;
	Tue,  9 Dec 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXJPCgqN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFD2D3A60
	for <linux-iio@vger.kernel.org>; Tue,  9 Dec 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765276417; cv=none; b=WC33z0yVxj5ZaJFow1fAASki22H4j4hJo+W8fp9/C+Nqyk8OFzD2u7YKXzh3vLy0wYWb7O8YvHHv3EMgqcsIHf1AlhHmzAMYyhX0QgUy1MUJphoDJ0PtIGs4wHgCX4vLMIINvbRaBYZ3ViFGkiuBknfLVkNM62TsThuZngX5N/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765276417; c=relaxed/simple;
	bh=6vUYZ7ZB1XA9z9XfSJy6LYoyZNPS3TghgWHThsU7xZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhIDsfP+HafWJ19NK1OOqkp9iDM3TGJfP4angjqe1ZK/9gxlTDeZufxDhyAGsNctaC9uy2MXldYY3/ynAWuf+oTwdy3xZrAL4pQZFebau9yBkN+z/XKOpiKZ7GZ5IfgNezeM+rz26ciLjKNEc4yvzi6d8HAXuz5FJ87h3jpDsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXJPCgqN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso27384465e9.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765276414; x=1765881214; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6vUYZ7ZB1XA9z9XfSJy6LYoyZNPS3TghgWHThsU7xZg=;
        b=FXJPCgqNR2x07Ds+wUdit0Ax7Vpt0t9xLQ4SQDrFB0MQHGF85CcLG+nVr3aG/rtxnQ
         oWMBO8EFFbOMyQRFhog5HAkr9EvbyQEQs64LLp3NSLBb3AWgxDJLUt0BWPy1wcJmioX/
         rZQemYn/vYPgZif62SJy9xc9BvTtVmnL9K3RbqcXg/O96n2NXJhIajxV6sPmPssoGzTX
         1dQX12tL9VvG8jaPfgSt+TUQIhZrYH1BVA8O+OxT8AVPSdh7+G0nv2FOAsG2kAUJUlfc
         k+rsrJ/vXFv/lC0ncJrz+lleg10QXGWnti8fqy1FSJ2x8UyYOSHJhdideHKrWXx/ejdx
         050Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765276414; x=1765881214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vUYZ7ZB1XA9z9XfSJy6LYoyZNPS3TghgWHThsU7xZg=;
        b=mcFQ9pfs00KHQlsO0WWuP+3g5iQvke4jKWiHHH+/0R7UQlCSLET3ABIiuIR4SAhPMr
         +3hpDqfwDlY3qhijEiXi1E86Pq4JMdnvCjU3V7HMiwgKpfXurfa9ftKk+of4FgFgqYRC
         raCXLWRl6mLwVIg/O3Pg53NPlrj9yTczIaLCuHo+nVsDtfi/Vj1y5DtljGlMClp3HlEI
         ahbxCvZEINKsDO1jXLwWhmdhrdFaj7lKo587dFkE3uzrMN/DzlY8xvtp0dVdW/V7ni/Z
         mMAZPNTaz3NCQQHqwIsYgjbJ8CoSEwz1xeWmy549RBWKksDacmQBXX58aaUpwsSdoKU9
         t9gg==
X-Forwarded-Encrypted: i=1; AJvYcCVLBVw6Yxvg++el/Nydk7lRf+QiCuIQvcKXNwa17Xe5IZMixXsWbYHhEKV5CVZo0cbY4u8I5tezgGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwveHkIpy1Cs5vb1V6nCneVip9/wqOJe5Iw+T4fm5gO+xbPS7gt
	fgHfnAbiy14RolamaplnIEsOZYj86x7OwZA73Wycx0S0Qn8eEErEsHAbIJwwF9HF
X-Gm-Gg: ASbGnctx6Jsqvi4oz4JxcZvvFMyjakvY67UmgsgCChLX1W1AdWmRU25Tkd/viBm27Mn
	oo5kRTP1Ku4DquO1XW5iIlpG/5x3Od6gHxfaEGaAZ7JQ/0O5+xZTdy8jjH/JGTzSidedMW4jhWC
	XKCe3VPQigOJyCKnHKD2xVvoEnafE1WZQCuNUijCQSPtU1vBgkTeOBHX6AbAV/QsKxaclcjmyTX
	mQx6YbQWPQi6xF2isyddH9fqm/mBpVb75D1f4wFnstOOQkzBiCcL7ug++IOty1ls0mMa7qqMTB1
	C9tOesuLt/ZQua6XEdgwikhRqWOSxss73S29QIqISAjsXc1IxnxJm3VNsDel3MPpavqFVLejJZz
	5QFjV9sHrxees0+f2lTZtFkbLll21EuEqmRLgdcu7pH/VBuxdVemUdX6428os53pIcEDyrNAgUL
	4FqiBufprmFPc4jtoYaWA=
X-Google-Smtp-Source: AGHT+IGZQrJg+7CP7PO6TcoDaHyiNMGgsBliDZ1Lgu0m6bB12DU/JkBOondvRTh7wk+YcAEp6Q+UiQ==
X-Received: by 2002:a05:600c:a43:b0:47a:75b6:32c with SMTP id 5b1f17b1804b1-47a7b17cfdfmr29371385e9.2.1765276413463;
        Tue, 09 Dec 2025 02:33:33 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d3749bbsm15685995e9.3.2025.12.09.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:33:33 -0800 (PST)
Message-ID: <54483083c42cf7500239ebb7c0d32d25f11bb02f.camel@gmail.com>
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung
 <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou	 <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>,  Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck	
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Date: Tue, 09 Dec 2025 10:34:13 +0000
In-Reply-To: <20251206184645.51099254@jic23-huawei>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
		<77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
		<CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
	 <20251206184645.51099254@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-06 at 18:46 +0000, Jonathan Cameron wrote:
> On Thu, 4 Dec 2025 17:07:28 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Thu, Dec 4, 2025 at 4:35=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> > > On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:=C2=A0=20
> > > >=20
> > > > In a recent driver review discussion [1], Andy Shevchenko suggested=
 we
> > > > add cleanup.h support for the lock API:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_claim_{direct,buffer_mode=
}().=C2=A0=20
> > >=20
> > > We already went this patch and then reverted it. I guess before we di=
d not had
> > > ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much bette=
r. Looking at the
> > > last two patches on how we are handling the buffer mode stuff, I'm re=
ally not convinced...
> > >=20
> > > Also, I have doubts sparse can keep up with the __cleanup stuff so I'=
m not sure the
> > > annotations much make sense if we go down this path. Unless we want t=
o use both
> > > approaches which is also questionable.=C2=A0=20
> >=20
> > This, indeed, needs a (broader) discussion and I appreciate that Kurt
> > sent this RFC. Jonathan, what's your thoughts?
>=20
> I was pretty heavily involved in discussions around ACQUIRE() and it's us=
e
> in CXL and runtime PM (though that's still evolving with Rafael trying
> to improve the syntax a little).=C2=A0 As you might guess I did have this=
 use
> in mind during those discussions.
>=20
> As far as I know by avoiding the for loop complexity of the previous
> try we made and looking (under the hood) like guard() it should be much
> easier and safer to use.=C2=A0 Looking at this was on my list, so I'm ver=
y happy
> to see this series from Kurt exploring how it would be done.
>=20
> Sparse wise there is no support for now for any of the cleanup.h magic
> other than ignoring it.=C2=A0 That doesn't bother me that much though as =
these
> macros create more or less hidden local variables that are hard to mess
> with in incorrect ways.
>=20
> So in general I'm very much in favour of this for same reasons I jumped
> in last time (which turned out to be premature!)
>=20
> This will be particularly useful in avoiding the need for helper function=
s
> in otherwise simple code flows.
>=20

Ok, it seems we are going down the path to introduce this again. I do agree=
 the new ACQUIRE()
macros make things better (btw, I would be in favor of something similar to=
 pm runtime). Though
I'm still a bit worried about the device lock helper (the iio_device_claim =
one). We went through
some significant work in order to make mlock private (given historical abus=
e of it) and this
is basically making it public again. So I would like to either think a bit =
harder to see if we
can avoid it or just keep the code in patches 5 and 6 as is (even though th=
e dance in there is
really not pretty).

At the very least I would like to see a big, fat comment stating that lock =
is not to be randomly
used by drivers to protect their own internal data structures and state.

- Nuno S=C3=A1

