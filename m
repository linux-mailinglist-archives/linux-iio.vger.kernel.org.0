Return-Path: <linux-iio+bounces-827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4880D38A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BB21C2141C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616BB4D58D;
	Mon, 11 Dec 2023 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PP2VlYOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECEC4
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 09:19:16 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d05ff42db0so45370227b3.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702315155; x=1702919955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJOibuG6vu5h39vC6LrzSpC8cKv0ovNojHLf3UcUYOs=;
        b=PP2VlYOpY4zu95UBeyOyWADoTCcy0+hpqqdAjOq4QrR8SPevBm8QEMjUqLpPTEAV4C
         Jqa3T3IvFrcmJjgb6LoP+yTD/A3uAjIRIQEcQyN97pDG+3xvGezxZbxS+w74IRsCCynB
         aLbfE239Twi9uLADkycEu0XmG+T4UF1EQ837dCknAdh25aXeGm/TjphE7gE4KPzB5V4t
         5IYeSL8vzIlnmXOgDD0w6Mr08KwAmKdQMJ8Swfklsczdd5pKE68gegIevHSBBzNAYvyO
         doy1EbofNXHx2dvvLNpqKAOSNDWSYzk8Nkhr093L+f2xKjWd9A0DVT6UavhX2Fdk6mID
         pVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315155; x=1702919955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJOibuG6vu5h39vC6LrzSpC8cKv0ovNojHLf3UcUYOs=;
        b=USr94lMFu4E3LnWUmNoeTkQRx0+bcbJLyK/S/POzPo+2cmvus9H3OF2yVcd6ZrStu3
         FgJsOxQpslzwgzR7Z36FH0Mb0V+h4vgEGAKdof+DnZveXD5FxuPfYV/1ijFm06Yrv9DI
         nBqF09ghS9KcPv5kLLqBufVggTpDgSRu+AkFUqQWuv5Kmpol31Gf+/26rlaCbDuKCXWe
         3mArcKEU3VLSSEu1hhpkK6dYoRcjY6ptv9kW7z+7JlLqXCMfxOtEtMbXVVncpzcBnw6f
         bAA/JMBmEQZFketJexrM4J1ebyMBTf/CsbPKHzWvFv8efyqyqVQu0ooIawiPO1Vyhaqd
         IN3w==
X-Gm-Message-State: AOJu0Yw3HAS0JToQp/roc7SQbX8rJq0QeNjzFxiRWG18vrImQlC1hu8q
	AfEaMMthT6bGHCp61y7O/lVt8wGhZz8erJeOgS4=
X-Google-Smtp-Source: AGHT+IEN+r/n8bFmT9gt2y1wkBpK7QWHUW6PhQg7FVQRhsKR/QNz5faUQmkXhyYOv6/U5cLojeBmqg==
X-Received: by 2002:a0d:f846:0:b0:5d7:1941:2c1b with SMTP id i67-20020a0df846000000b005d719412c1bmr3832075ywf.72.1702315155100;
        Mon, 11 Dec 2023 09:19:15 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id gi3-20020a05690c424300b005df4992992esm2225483ywb.24.2023.12.11.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:19:14 -0800 (PST)
Date: Mon, 11 Dec 2023 17:19:12 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MAINTAINERS: add myself as counter watch events
 tool maintainer
Message-ID: <ZXdEkO5u/IDKEgaV@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-3-fabrice.gasnier@foss.st.com>
 <ZXcx+94QW2pWDBxM@ubuntu-server-vm-macos>
 <81bbf2f7-6db2-47de-9761-0b196b5348d2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DqZxG5w8JvyzHbBp"
Content-Disposition: inline
In-Reply-To: <81bbf2f7-6db2-47de-9761-0b196b5348d2@foss.st.com>


--DqZxG5w8JvyzHbBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 06:09:44PM +0100, Fabrice Gasnier wrote:
> On 12/11/23 16:59, William Breathitt Gray wrote:
> > On Wed, Dec 06, 2023 at 05:47:26PM +0100, Fabrice Gasnier wrote:
> >> Add MAINTAINERS entry for the counter watch events tool. William has
> >> been asking to add at least me as the point of contact for this utilit=
y.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >> ---
> >> Changes in v3: Add MAINTAINERS entry. This is a split of another patch
> >> series[1].
> >> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasn=
ier@foss.st.com/
> >> ---
> >>  MAINTAINERS | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index dd5de540ec0b..b8541ab7866a 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -5322,6 +5322,11 @@ F:	include/linux/counter.h
> >>  F:	include/uapi/linux/counter.h
> >>  F:	tools/counter/
> >> =20
> >> +COUNTER WATCH EVENTS TOOL
> >> +M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >> +S:	Maintained
> >> +F:	tools/counter/counter_watch_events.c
> >=20
> > Add an L line as well for the linux-iio@vger.kernel.org address so
> > discussions get sent to our public mailing list.
>=20
> Hi William,
>=20
> I can add it, yes. But just to be sure, with current patch,
> get_maintainer.pl gives me:
>=20
> ./scripts/get_maintainer.pl tools/counter/counter_watch_events.c
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> (maintainer:COUNTER WATCH
> EVENTS TOOL)
> William Breathitt Gray <william.gray@linaro.org> (maintainer:COUNTER
> SUBSYSTEM)
> linux-iio@vger.kernel.org (open list:COUNTER SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
>=20
> So is it really needed to add an L line ?
>=20
> Best Regards,
> Fabrice

I think the get_maintainer.pl script tries its best to find a list when
one isn't specified, so when it doesn't find a list under the COUNTER
WATCH EVENTS TOOL entry, it finds the "tools/counter" directory
specified under the COUNTER SUBSYSTEM entry and pulls in that list.

Although we end up with the same list, that level of indirection makes
it somewhat ambiguous to a user whether that's the correct list to mail.
So just to be proper and clear, we should provide an explicit L line so
there is no confusion.

William Breathitt Gray

--DqZxG5w8JvyzHbBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZXdEkAAKCRC1SFbKvhIj
K7IpAQCwOWCY90BHIn4sKetysj1BC1aPzwZTDdzLCYI+4tKFbAEArcPeysYkeWXY
eqnjLqD+msPvPKVxDRMOLJZBn70lcQs=
=GTfg
-----END PGP SIGNATURE-----

--DqZxG5w8JvyzHbBp--

