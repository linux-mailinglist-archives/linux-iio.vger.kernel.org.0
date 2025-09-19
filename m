Return-Path: <linux-iio+bounces-24298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389A1B8A8A2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E801A5A7773
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C02C2AA2;
	Fri, 19 Sep 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EZqkadce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5F3191AE
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298700; cv=none; b=P2vQbi82tRuk7QnHnyFjfCZ1cW5WVJseCsFxlQBU+/EpithdAjFv+vExKdhjXNa41cwGC6nHUTrguBTvenB1nzntP70ZdIqSSDE/hFsb62F1I6FKOnIMrb6CbOcrd+vPWN2aw/0Oi4AjIUBMjD4hLvK80MLzpXsDSIxy0cais5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298700; c=relaxed/simple;
	bh=WxQ0B4IlsgTIq4DWFmrJtf+73r29i4Kp+qGE9Unb6OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukfpF6iKpjV1KJRuJz9DRgMxmoPqj96KmAw48mDGRVvrWScEHyeD/N9Unw4VA8VSHptRsIGCgRa1K/RGgeOcn63OXD7/cFSIjXsOJiM1kkvdG9BdVx9g5GJhOoPooMhpO3OABN/IdlLskiD0hAFji7fDDy4+GeZMJ+iLiIbILs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EZqkadce; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ef166e625aso783511f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758298696; x=1758903496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCMQiFsm4hsxlP+tNTYkhaVGT0aEA2D4RKsC3Gwmrs0=;
        b=EZqkadceqFxerreYBdqwFV5YJ44n7V/slvuzf41+//RfCO4ImSUEhNlXJra+tXl6Kv
         3ZN6bEPT8bu5KeHN8FwZ9yHVJIMQMvyxZCW1zW+UqiF7G0GETN6NH7/bM31wgBdmiJSq
         Dxn1+G8bZHXZFqs16sfPc8MOCpsmR3QPWLpMzqL+fj8EJWNMjk4D6RFld3jOGbQnEiUs
         l7b0e2KV0GAxRsmS/c6mzfpf2c11Ld81JnhWP4wv9N6lzoiy92ARa97lWCyH0kT/+io5
         vhCiL/BYEFebmwFUrrO6PwRQ8p/qtZVXgKPhjgTS2jDQCZPqHKmszTi2BGTDOrU/swpi
         ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298696; x=1758903496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCMQiFsm4hsxlP+tNTYkhaVGT0aEA2D4RKsC3Gwmrs0=;
        b=f69tPm30DeWw4ZU7vDCdvA9pZsu06zMRUmZ9LGUH2NX68nA81zPd0jBABqrI6SgR/p
         LN4UnK/WEtnJDQVhDvgOPrMnqEy7PpGYWkf1/jvoI5DhOSJ/Rp68SsiQJNkQ7CQiqHJ6
         eFF97TaSDePBHSP+aFZtQyxPgAhS+1f16bE6+0GsfzQprQm9xlikJcM9NEkddVFoVnoX
         Y3ipOk80KwQg3YXzGJIkV6CBXCy07k9eZFvvvI85nkn/LSfhQMFHWsa6cu7fymaCtZ7d
         4OZGWrQFtEXfJ8Y4zRDKJ7rS7KrUs/QKcDxwhuUbfbXVegkTuixGlKRg1W7051z7UBHG
         sLCw==
X-Forwarded-Encrypted: i=1; AJvYcCWF/6pPFqx6deon8SyklbTViBK16UqmZsbpQvBBsOSvXR5HSYSw1nFm5J7gYnW0T3mZhiT0TCi0flc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sF0kga6JDqe+wjOeD+sON+Z2RNuNQZLnPu9Tj/rEtjU7+A8j
	X9gzjl9Q9OfOysqQSEsFJq9fN0ZwJK/KtvvRavg94PoPX4KeyZbi57MqbTOtdm+iyq8=
X-Gm-Gg: ASbGncuXv4amm3qqlEaWSvaEM4+BYu35Abvu2UQXlZ5SeAkj7HdH9+PUZYljkDPOdc6
	RqYXyDJ6ktk67e5MEYijNhmc3TNT4OyT9eDU1SJTeeFWD0M4ddfOsAlPCrXKcjutpIZWSRT8kwr
	r3RyccOKvS4xeSSJLXNNqbdBbzknOtIqmdvgCou6qqqAaZkowQaQocDaRm4BK2yN3TmU2BWhniC
	9ZFc6mZz+WHelsVw4Lv/GfpXJcKwJpAcIn5WpLtEs7SuKkdrv98VqwYRwcNKbWJ1PcWlV+emEFi
	9SyR0uQ7p4KMaockvQqZNKd/CIaI1JcrGMbdivH0hq/DrXrAtjZF3fS/hoXx48IvwFIqsvFcUPk
	IKnpVHEjl9qtIr2v1ZvNS5IetelNSTJoKjC/7pvYjJwK49ejwU1vC/5F+7HguLqIZ
X-Google-Smtp-Source: AGHT+IHeDyqCwZEwmBRMLgDcVcjTaBDuQhje8qnjQHoNKHQszsQBAbYzFqO5E0qmktZp1YKSObnQbQ==
X-Received: by 2002:a05:6000:248a:b0:3ec:b384:322b with SMTP id ffacd0b85a97d-3ee8585f513mr3310968f8f.46.1758298696034;
        Fri, 19 Sep 2025 09:18:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee07412111sm8325227f8f.28.2025.09.19.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:18:15 -0700 (PDT)
Date: Fri, 19 Sep 2025 18:18:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, arnd@arndb.de, srini@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	wenst@chromium.org, casey.connolly@linaro.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <lq4rgzue6uah67nc7lob7eexsquk7qhr22wr4xwymzrvvopgc4@mkzyvadgd3qs>
References: <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
 <2025091925-thirsting-underuse-14ab@gregkh>
 <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>
 <2025091918-glancing-uptown-7d63@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enuyknrtw4cq5eeq"
Content-Disposition: inline
In-Reply-To: <2025091918-glancing-uptown-7d63@gregkh>


--enuyknrtw4cq5eeq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

Hello Greg,

On Fri, Sep 19, 2025 at 05:13:35PM +0200, Greg KH wrote:
> On Fri, Sep 19, 2025 at 10:05:28AM -0500, David Lechner wrote:
> > On 9/19/25 8:59 AM, Greg KH wrote:
> > > On Thu, Sep 18, 2025 at 10:00:29PM +0300, Andy Shevchenko wrote:
> > >> I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the=
 header
> > >> file.
> > >=20
> > > Yes, please never do that, it defeats the purpose of module namespaces
> > > completly.  If you don't want to have module namespaces, don't use th=
em
> > > for your subsytem.  Don't use them and then make them moot by putting
> > > MODULE_IMPORT_NS() in the .h file for the symbols as that's pointless.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> >=20
> > Could someone suggest some additional explanation to add to
> > Documentation/core-api/symbol-namespaces.rst to explain the
> > reasoning behind this?
> >=20
> > Right now, the only part of that document that say _why_ we have
> > module namespces says:
> >=20
> > 	That is useful for documentation purposes (think of the
> > 	SUBSYSTEM_DEBUG namespace) as well as for limiting the
> > 	availability of a set of symbols for use in other parts
> > 	of the kernel.
> >=20
> > So I don't see the connection between this explanation and and:
> >=20
> > 	[Putting MODULE_IMPORT_NS() into the header] defeats
> > 	the purpose of module namespaces completely.
> >=20
> > I am guilty of putting it in a header, so if I need to fix that
> > I would like to actually understand why first. Andy has mentioned
> > something about potential abuses, but without any example, I haven't
> > been able to understand what this would actually actually look like.
> > Or maybe there is some other reason that Greg is thinking of that
> > hasn't been mentioned yet?
>=20
> Let me turn it around, _why_ would you want your exports in a namespace
> at all if you just are putting a MODULE_IMPORT_NS() in the .h file at
> the same time?  What is this giving you at all compared to just a normal
> MODULE_EXPORT() marking for your exports?
>=20
> I know what it gives me when I don't put it in a .h file, but I think
> that might be different from what you are thinking here :)

For me (who still today thinks it's elegant to put the MODULE_IMPORT_NS
in a header next to the declarations of the symbols in that namespace)
it's the documentation thing quoted above (e.g. modinfo lists the used
namespaces) and to unclutter the global namespace.

The latter was essentially the motivation to introduce symbol
namespaces, see the cover letter from back then[1].

Personally I don't see the relevance of making it harder for abusers.

A non-GPL module should be stopped by the symbol being exported using
EXPORT_SYMBOL_GPL() with or without namespaces. And for a binary
distribution of a module the need to add the MODULE_IMPORT_NS statement
in the source code is a quite low barrier for the evil binary module
distributor that IMHO doesn't justify to burden all regular users of a
namespace to have to do two things (#include + MODULE_IMPORT_NS) instead
of only one (include which implies the MODULE_IMPORT_NS) to make use of
said namespace.

And for GPL code: Who is actually an abuser of say devm_pwm_get()?
In my eyes any module should be free to use that function. And if it's
not sensible to do so, I would expect this to be discovered even without
the needed MODULE_IMPORT_NS("PWM") in the code. And if it's not
discovered that's fine for me, too. For me that's the spirit of Open
Source: If someone finds devm_pwm_get() useful, let them use it. Please
even tell me if you use it in a way I didn't expect, I'm glad to hear
about it.

I'm probably missing something.

Best regards
Uwe

--enuyknrtw4cq5eeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjNgkMACgkQj4D7WH0S
/k50wggAm2DTHJtv28WePL2zBaXONs/0AtzDza8lXQgPQoUVHUJXsRVsYbdK+5Te
R8MYd6+n8hqXv/pnvnZRwd81Wv0yFwJOJtUzAlqiXYr2tfvSfe785liM73qS3JNs
MI5i+z0WoWyRTqGTmPxJjJ1r/SgcvGFl+CHm9j1vDehiPVRnPalOS+y1JzYBezf3
CTfbDpMOfi4y6a9u/6GX+UrUMxe7arfGlBB7Sy3dOoxlXSWqoQ1hzjlTo4YrsYwU
ulHe6jKB+OI6xyUPqM0xXCphVFUZFacH+RitcWEFsTWH6Dt2vv8muCeB8jzPFkYc
QRkS8BwIA/n7bOdJgYaEtTcUyCIa4g==
=568Y
-----END PGP SIGNATURE-----

--enuyknrtw4cq5eeq--

