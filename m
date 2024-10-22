Return-Path: <linux-iio+bounces-10917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC39A9C3C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2011C21F15
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723D1714BA;
	Tue, 22 Oct 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hccPh/h3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452E13BAC6;
	Tue, 22 Oct 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585219; cv=none; b=sCU17KIMF6+IVRj+m1Jk+h0ebjc0v4os6GWYtDhBu5OAZvDBNlqiMaKgnyTHKwq5WJRmwKnBcWC9l3eWIQMsKlWisVv/K1fd4yz9R1HFmQUl15Lx1YMSVQpymvDRWUk/Ns/KH8CoXLgMw8ro97bz0dwC6JSsQTotgRz4VlJ4UEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585219; c=relaxed/simple;
	bh=DtkD7/WOyzheoNuGOwX4n9uo4j8otWxfGYuvhmDO8yE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcEVCswn6/9avchnQSD+D3Gtkw+j8zPjicQ4aAyfzg85CRb7G2T7MQtvuC8ovPhvWoVHsBErX6kBrjhq0hY1NdxPKFr2IX4pkBYvygPrXHHlkBhFrpvwolpRsqxyc5R/shjLohGuYAICh8CLCSmj5PYZD/nNACbUjboImid+0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hccPh/h3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso45095125e9.1;
        Tue, 22 Oct 2024 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729585216; x=1730190016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DtkD7/WOyzheoNuGOwX4n9uo4j8otWxfGYuvhmDO8yE=;
        b=hccPh/h3YUGyawgTje+Y0WRCArGzk1NL4SmpDkxsXzW1ipYVn86t8YmhI43kq8FQQe
         lMILXofabHHU4BvNiW12aHlOuV156boSQgobY+XQxYfg3/s0HBOHfIpfzZCaiCqGkWdc
         vJ/EcZevFphxL4g+2uXGaYIwEYjbuMfRUkOIj4pncDEJ5+N9YMUr/wRf1poiP/Ilujn0
         aJrMLjRyeejsxQsRHnJ27mt3xRCJOpY9kddWSN6JwqdsyBxvzWTsZjpt+xTuhIn9hOal
         RF3GXLmviAd5keOslJ+UjqTY0/FzV2Yv/7FuJZTKRNF4rr7ElYOO8BQ2PilswcgHLA8Z
         ZU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585216; x=1730190016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtkD7/WOyzheoNuGOwX4n9uo4j8otWxfGYuvhmDO8yE=;
        b=TYMSZjRExCs7+ZAyBv3S97ixvoP3faBiPjrMFK3vFD6kb9JZviDdNh6U1xdgJ5QP9n
         Mv5gh3y1+/DayHdw8xbdnA0CRtRXifRjvmCps/bIlWRGtD9jTkxoetBqDcdh+GJU/Jxi
         YeOw12mh9ZiIQyxiDpMCbE/iDs9ma4nl24idmqiztr9BDGU4oSKrKnkMMPrGIphWTnUY
         LlQOtUrY7sW+nMQ4+m4b76DQkc07883STPmk0tBE04wMSRVFaj1lTC8gZMOMQmWLD3di
         gOC3+MgXLBi8gg6lh0rgwhL0IU6H1hE229AIl2uriUnYCexi7i8X1qw6Vi5/4JXtaGY2
         pCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGQBfi3SNvxrhu1QjzTxQYLvlAIKoUmVwqqfBwf8BzIvafUTm/IkxWVhLfKx2RzN872+U1fXk3S3pTD9yd@vger.kernel.org, AJvYcCWCKOQfY91ONcC/HiRmNw85hT1fDyX+PJE005nKUIkK94Crb9+SnV66QDQtY5fXhrtAwXf0HShCuyNU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/UaklzLFnu1xamkF3M4nKEGCV1ndcf+P5fyh6jwZHAun3CAE
	vRul3cjaTRhtzaK75icoObl48RO+rMnTD/MDq7k3GcKIoeLjkxYa
X-Google-Smtp-Source: AGHT+IF6e+OhDpwMYF0L2Cd0RKYv1mC/Z+QmSowZ9xsOSlUMsH/VtZdOszcs6pRLPJH3IWSPvcT2dQ==
X-Received: by 2002:adf:979a:0:b0:37d:5352:c83f with SMTP id ffacd0b85a97d-37eab6dab50mr9219218f8f.17.1729585215955;
        Tue, 22 Oct 2024 01:20:15 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9442bsm6040959f8f.78.2024.10.22.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:20:15 -0700 (PDT)
Message-ID: <41c6f424ed42655a62a7b66aa81604605676a551.camel@gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: ad7606: fix issue/quirk with
 find_closest() for oversampling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexandru Ardelean <aardelean@baylibre.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, 	lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com, brgl@bgdev.pl
Date: Tue, 22 Oct 2024 10:24:33 +0200
In-Reply-To: <CA+GgBR-8i-S2gnp39TnOxayfGqLpdhAceOjNDpE+Y7t_5Xeaig@mail.gmail.com>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
	 <20241021130221.1469099-3-aardelean@baylibre.com>
	 <2842cbb5-680e-483a-af62-4c08e7818a85@baylibre.com>
	 <1dbc8e19-d6fd-42dd-b116-f08c408b6a5c@baylibre.com>
	 <CA+GgBR-8i-S2gnp39TnOxayfGqLpdhAceOjNDpE+Y7t_5Xeaig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 09:31 +0300, Alexandru Ardelean wrote:
> On Mon, Oct 21, 2024 at 10:31=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >=20
> > On 10/21/24 2:03 PM, David Lechner wrote:
> > > On 10/21/24 8:02 AM, Alexandru Ardelean wrote:
> > > > There's a small issue with setting oversampling-ratio that seems to=
 have
> > > > been there since the driver was in staging.
> > > > Trying to set an oversampling value of '2' will set an oversampling
> > > > value
> > > > of '1'. This is because find_closest() does an average + rounding o=
f 1 +
> > > > 2,
> > > > and we get '1'.
> > > >=20
> > > > This is the only issue with find_closest(), at least in this setup.=
 The
> > > > other values (above 2) work reasonably well. Setting 3, rounds to 2=
, so
> > > > a
> > > > quick fix is to round 'val' to 3 (if userspace provides 2).
> > >=20
> > > This sounds like a bug in find_closest() instead of in this driver.
> > >=20
>=20
> Adding Bart (the original author of find_closest()).
>=20
> > > If there is an exact match in the list, it seems reasonable to expect
> > > that the exact match is returned by find_closest().
> > >=20
> >=20
> > Likely also affected by this bug since they have values 1, 2 in the lis=
t:
> >=20
> > * rtq6056_adc_set_average()
> > * si1133_scale_to_swgain()
>=20
> Yeah.
> I forgot to mention this sooner.
> But this patch is more of an RFC patch about how to handle this
> situation with find_closest().
>=20
> For monotonic values with an increment of 1, find_closest() is a bit bugg=
y.
> Will try to fix find_closest()
>=20
> >=20

FWIW, I'm not a fan of using find_closest() in this situation. We have an
available attr wich outputs the supported values. To me, -EINVAL is the way=
 to
go if some user writes an invalid value.

I feel the usage of find_closest() in these case is likely to make the code
easier. Maybe an helper analogous to match_string() would be seen with good=
 eyes
(like match_value()).

But yeah, I guess that changing the behavior now could break some userspace
users.

- Nuno S=C3=A1

