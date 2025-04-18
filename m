Return-Path: <linux-iio+bounces-18236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D80A93591
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C42446D9B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02A211A0E;
	Fri, 18 Apr 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxeB7XFi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D5204F6F;
	Fri, 18 Apr 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969880; cv=none; b=COi0jqJw5jP7/kx9DxjgDPgdK4aFrXLn/plfGMSmXLqvKOI0eMJWoAOsyDNlSRZsEEBhBupMGYO7q0PWrah9CDjdMCglxeRAIiJMfBl/AJiXxEKpFq6Cn17k/y+yCiNmYKkrHKpCzs2aN+/baRGheRhEhnpoAe/ruve3VeBD3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969880; c=relaxed/simple;
	bh=Ezx/sOto0Rena9uEb8fLM6zOGB1zJXCrOxowi4762QA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UI5sAdReshhhL2C7vIbX0/NAa556gjeBiAl6NuXwiBGJ4KLJQiOKRLgdzHCpBwFSMTd+nbgFJRUCzMBgDQFizPJ2HS3RdsInRxJptXOnTnxbKWbT2y0vcLtqIc91FtCAszVDjwa5+2G7ablOWgVkwtXdFikKZSLMdGkgCHqxs7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxeB7XFi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso8002575e9.3;
        Fri, 18 Apr 2025 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744969877; x=1745574677; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CSvWnI3C5tegcykknlWng3qsayJZpjRB+0TI5j6d/zU=;
        b=VxeB7XFihhn/uOkDqbBO+SW7fDeRRE0JUxokj+oKNwNUYRmvJlVGn4C2GxeAOKXhAK
         2T3vHauNdXS+Vr0XTXjiSYS05i0eaEB9NdSnu6bIDSSjpX+PLYrlcXtkokwBmqwjx+cY
         nttvZw/7EEZnRXszgDdGCMp3w9x6tWb5HJEKM3j7deOUXFxoyHG+wWjbO9WvBRXEjLt/
         m9gg53hPeW/A2sDzHMPVu2siDX/LVVPk5ppbJe48+jBxAkB2K+iYxXtFj+H3Rk06MtIM
         i2vtxjMceAObCAZYyX2fYMuiDjkfEGtICoaXveQYovkxAxYmzGFn6DHO241sM3d33DcG
         Y1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744969877; x=1745574677;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSvWnI3C5tegcykknlWng3qsayJZpjRB+0TI5j6d/zU=;
        b=YqFfeNinpV0nucMca5PAz/RN87rhnRcfx0n1a8fK2JS3uPphA7FjHKEbImQXtfVIgX
         x/LMIqto9X07EBNbO3jHZ6bHix0kng6oMrYvMFS9af+8JPfrVEoYDNst4NFZXxLXaZbu
         xyVN9c3sz9A1r5884OWGcxFv8ZvfnW0xssuk7DzAPAnHKjdRU4FOEVEGwJ3t9BKyQmOV
         X4atNfOGtdNjav6wnOQXQ66hmBvuvv20vP6DycL8B52KaT0KlmVVMfaRoMY5RgujtUk5
         BVopPNcB08SDdjyWwP7DSeqlZqCHUzhTPyx5jGvPHU9jC0FAE+tibAe9WWmjQAUU7a7X
         sqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUWLkshW3DmsYaMGTuD3ZvOoyEPlUs41HHdyzHM3oTV/LBtGU1EXoup3lGWxGUtTjcT68OFBiqNsPLkE0sG@vger.kernel.org, AJvYcCXXDouGFUdK2Mc8Fmu1Xqib9mj7bm+7VWeH8ZjWzrTFEyGJabeAhkTR8U2pUr+gmyCmt3Ouw0X4I/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2pgFYLJrpJqWDGfKRBvnleXSeJQwRJS+wslv1dt9hXJqZkA9
	9Oi3d0lqsOVjizhQDHMXB/h0ngRadWbia3+OQH3a6LYUfCl0oAor
X-Gm-Gg: ASbGncvU8yKTN8yw/DWdC966xHr3vzdtLkVbxiwHdflW1EE6Al9JN9tLQ6sSwT/GrEX
	NhNG6JQqqUc+P8DId8bStZww+Hft5hveHLFAo9hd3LVlIapJw506POlecKwDeoYikTrFlB33sNN
	LWQikq923eE2PsUTK0CDVHtIBszaN/f+7z1A/OnzXMmUvYNDA1KKr73ZRRMpuz7bW93Jf39oRMO
	OJVz3yAYAfVANCvLmpw1lYzjNgiLGrcOSW14xdxH/DDOIf/cgKy3cv6CyDjfE8yShhB075bZXIy
	Ku6OJEMCH2Lv0PqMWumN9tPSe1VWlrZ0bnQIRAtHNSELu0wvtvN83WGgdFY0pwQiCW+tAhkZbwd
	vWU+pp80jN8O0mzoxC3PdTWGCsg==
X-Google-Smtp-Source: AGHT+IHiAyPXvivjkrlHTACUGM/NMgQ1u+r/3U7mrpl/ZgbCVhByQU9psxpkQOHV5GsJ9WwVMnk2vw==
X-Received: by 2002:a5d:648c:0:b0:39c:30c9:822 with SMTP id ffacd0b85a97d-39efba6ae03mr1476935f8f.30.1744969876650;
        Fri, 18 Apr 2025 02:51:16 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5aa100sm16015785e9.7.2025.04.18.02.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:51:16 -0700 (PDT)
Message-ID: <2ac349c8dd9b7fcc86e2caae1f74943c23289921.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: chemical: pms7003: use aligned_s64 for
 timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger <ak@it-klinger.de>,
 Petre Rodan <petre.rodan@subdimension.ro>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 09:51:37 +0100
In-Reply-To: <20250417183535.00004d87@huawei.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
	 <20250417183535.00004d87@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 18:35 +0100, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 11:52:36 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > Follow the pattern of other drivers and use aligned_s64 for the
> > timestamp. This will ensure that the timestamp is correctly aligned on
> > all architectures.
> >=20
> > Also move the unaligned.h header while touching this since it was the
> > only one not in alphabetical order.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > =C2=A0drivers/iio/chemical/pms7003.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7=
003.c
> > index
> > d0bd94912e0a3492641acd955adbc2184f4a11b3..e05ce1f12065c65d14b66ab86e291=
fab47805de
> > c 100644
> > --- a/drivers/iio/chemical/pms7003.c
> > +++ b/drivers/iio/chemical/pms7003.c
> > @@ -5,7 +5,6 @@
> > =C2=A0 * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > =C2=A0 */
> > =C2=A0
> > -#include <linux/unaligned.h>
> > =C2=A0#include <linux/completion.h>
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/errno.h>
> > @@ -19,6 +18,8 @@
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/mutex.h>
> > =C2=A0#include <linux/serdev.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > =C2=A0
> > =C2=A0#define PMS7003_DRIVER_NAME "pms7003"
> > =C2=A0
> > @@ -76,7 +77,7 @@ struct pms7003_state {
> > =C2=A0	/* Used to construct scan to push to the IIO buffer */
> > =C2=A0	struct {
> > =C2=A0		u16 data[3]; /* PM1, PM2P5, PM10 */
> > -		s64 ts;
> > +		aligned_s64 ts;
>=20
> Bug I think..=C2=A0 So another one that really needs a fixes tag.
> For all these we might be lucky with padding on the allocations
> but we shouldn't really rely on that.

Agreed... We're likely not that lucky for x86-32

- Nuno S=C3=A1
>=20
> > =C2=A0	} scan;
> > =C2=A0};
> > =C2=A0
> >=20
>=20


