Return-Path: <linux-iio+bounces-824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CB80D05F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148791F21971
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A664C3AD;
	Mon, 11 Dec 2023 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6ANyIU/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAE726BD
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 07:59:59 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d719a2004fso33574957b3.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702310398; x=1702915198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmodIMBO1Qk0Y+vje8OUGjZ5BvXR/87b/qmy8RMt3ic=;
        b=N6ANyIU/Iqty41xTVjLfK56B/eG/p+DgA4Fejlp4xJ3B9XMIlpMjFcXaS1bJ885eJJ
         eNmXAx1VMv5fmsQdpUSOzTZpggUpzFVxfbRnVM6EttZVQY7Ccl+JWmh/i68cwRpbWfEK
         VTln0just8rOyquVPzNZv3FlU4KNSaL8uP7q4aEmJXf/U0weYeH+bPtuyeeRk2IEm5dh
         IWh8sbYzBSU0RKPVvZAo6yvn3LrC4oX9JNcr8XRWEwrD8FLwazL3TdKzsUFjzvheYFPv
         xeimrXxXgtfTfxYnjO1GZCjiMjcxkyToqevAAZPPWkVrXOrs3TzokhkDUZOQe/TpWdvU
         B73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310398; x=1702915198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmodIMBO1Qk0Y+vje8OUGjZ5BvXR/87b/qmy8RMt3ic=;
        b=NuDGM9AoBbsbwutwjP/EM6LURxRh7ZmheaKw8EHGIfo0QbiY/p1P3leAYx3bEe1w4k
         jK3iH3kkoQh+Chx2bkxKZQwxXh/Uj+wECMdtrTm43Gv7JlOcIYxtaE9ZIh9J27gOma2Q
         5WF6QVN+bBmkg7upL9qHVmKmeljaw5UtDM0mL3vlNxldbGGo9/P1cSHqykGBO7394n4l
         czmajE+9ojYsxHofzVAxMsaS1zIbaa4/L+roBScq5cu5At82xriwMJRZ+p+Lba2nS2ct
         ViZC/7Sq8ALmdFjEGMRT//5kpg9iGceyETJKVZprnuol/RIjmYHHAkkPlamcox5FNmwA
         UuqQ==
X-Gm-Message-State: AOJu0YzKTHoE/taXr28XUcP42OXBz/ybShKUTcEoQ79Gdr5Rk4Do0qdM
	c5KNZj9XiBTAzeLu3iPMHkt7Cg==
X-Google-Smtp-Source: AGHT+IFJDzAr52fuc8/1ih2Utb+8daDqbEMt410Vgn3UCnD00YsjCaesHmI6CL7seE5geyt+WYpNkQ==
X-Received: by 2002:a81:7b42:0:b0:5d7:1940:8dd4 with SMTP id w63-20020a817b42000000b005d719408dd4mr1675599ywc.59.1702310397969;
        Mon, 11 Dec 2023 07:59:57 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id s129-20020a0dd087000000b005d361dd6454sm3061847ywd.87.2023.12.11.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:59:57 -0800 (PST)
Date: Mon, 11 Dec 2023 15:59:55 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MAINTAINERS: add myself as counter watch events
 tool maintainer
Message-ID: <ZXcx+94QW2pWDBxM@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-3-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PZCr3blPdUWJymRC"
Content-Disposition: inline
In-Reply-To: <20231206164726.418990-3-fabrice.gasnier@foss.st.com>


--PZCr3blPdUWJymRC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 05:47:26PM +0100, Fabrice Gasnier wrote:
> Add MAINTAINERS entry for the counter watch events tool. William has
> been asking to add at least me as the point of contact for this utility.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3: Add MAINTAINERS entry. This is a split of another patch
> series[1].
> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier=
@foss.st.com/
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..b8541ab7866a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5322,6 +5322,11 @@ F:	include/linux/counter.h
>  F:	include/uapi/linux/counter.h
>  F:	tools/counter/
> =20
> +COUNTER WATCH EVENTS TOOL
> +M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> +S:	Maintained
> +F:	tools/counter/counter_watch_events.c

Add an L line as well for the linux-iio@vger.kernel.org address so
discussions get sent to our public mailing list.

Thanks,

William Breathitt Gray

--PZCr3blPdUWJymRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZXcx+wAKCRC1SFbKvhIj
K3moAQClczPRsK4fQOXT/SzSTFuFwbEXiJr0jHN4XFmq+4XImAEAqAkugSYm34wr
oGcCtS70zcIffl2iy1cXE4etZ+etxQ8=
=QVg4
-----END PGP SIGNATURE-----

--PZCr3blPdUWJymRC--

