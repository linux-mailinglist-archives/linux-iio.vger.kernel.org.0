Return-Path: <linux-iio+bounces-4048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ADB8983B5
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32881C22FF1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75D71B44;
	Thu,  4 Apr 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoaAIbTc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC771B5F
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221563; cv=none; b=DvDiPnxgRB8H5qQ2k/jUCQhLbyt9fHANpuvKCiwBWOjahIJ8EGE+uqXAOgvRoSBIz0QuKpTr18vulsd8/6nqTkbZeTtiUE3zz1sNtlGDfKkykK72JVs76lebb3gexxU9QmspIozsnXXXn/am2xjOPLB1Vs9uOLYtVAZcoXpIBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221563; c=relaxed/simple;
	bh=DXthwQz+d4By1ND7tf0c7jZZFgcAxgbal4kAigJ9j2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGczCVMDQStHPuq0Cgk7Y73XdXbWrvrz3+IBscDSnGYIuxoa6+mr7euRbKWirdRiB7XFADmf5VWXFSL+CKYmhYi4Jg0LAxKoNV88MtGPRaXr8wA/2tHNKKZmbkHEF9UwXBE3u1eUFWRmC7Z7plxC7CjbJQ1BfJBfuqxe37CB3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoaAIbTc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so97309266b.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221560; x=1712826360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXthwQz+d4By1ND7tf0c7jZZFgcAxgbal4kAigJ9j2M=;
        b=PoaAIbTcEWsXaeOscDAt1fuWqBtnTXAFGSJsB7H3BpzsA7IDgwMs8cAwO3ryh/5pA0
         cM38y1a+9mmYEmw0ofe6o7yRc+vhPH7i3uztxVB2sCqjAmtkr3w7cn/CK4r6Kz88rsqp
         ZrwVcSxIk3b+0d+S2r8li5R4ZL2P0LJDF3LDdU424C5NWAtOizHXqpXqH4rriOVteNtE
         KvZpwaJdLpHNbaldaI19Cj/nJxLQe0pDZVwmxq/1V4mEFlJpeNNaMY2vtop7V2qRdJD7
         gOElSugzNcQfPp1hNd1KoEk6O2GmM39YIFS2r/R4TnNSYsHXwmNlgJ2LYgDDjczFrP4/
         KvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221560; x=1712826360;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXthwQz+d4By1ND7tf0c7jZZFgcAxgbal4kAigJ9j2M=;
        b=k3jQuN3q8PgGFSCtjcV3JaSaCn35DyDyaGTFXmJR6Y+LLow2t3Za7usUl89Kmo7NUC
         kabHONQDD8SdyE+TukUVytTSrXK5vcA578sVY7QMjDi1FfaneJ3uoNysWCzqyV3bdQTU
         rmfY+/neEAVG074BacS8N2S6FUepAOuB2OZnIyFCAUQaets05CPDYvWaD5J+ia4V/qrz
         p3azQZYN4yiUI3H1SuXLnqVQKdjYD614Gf2avozzv8oPtKt6EJNLOEvmfX5nyBA+8xJB
         fB+PWNf9jMooN3lJ67R1aj3tJu8Hq/sVLhkhRj0z0Tm00/uaIYLchdoslUeq03T1cf+2
         Tw3g==
X-Forwarded-Encrypted: i=1; AJvYcCUNJUGQLbobScEO173qsyCMFgKEse31utu9D5fyawi1yHKJGLWdU3gAj/PMNk3Spq1/bPWoxbcu/7BxnwoPhe2AO1tlWff/C8mq
X-Gm-Message-State: AOJu0Yzxw/aFqLQ6qdPkWTDby20jAVPnSNuPMselzPs42EosQ/n+dvN4
	dpcZR8mJZRXP5s9QeOm/KBTqGe05ef2a065y4sdGNmsN+sKb7vBh
X-Google-Smtp-Source: AGHT+IErpc2AIVdZ5Q0Ai9VwRjSc/S6KQc8LmHxXmykGFAguqTXMlkbdM2DwCIyj7dFeSXGEHP2L2A==
X-Received: by 2002:a17:906:4913:b0:a50:f172:699e with SMTP id b19-20020a170906491300b00a50f172699emr1234446ejq.33.1712221559280;
        Thu, 04 Apr 2024 02:05:59 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709060f4900b00a472c4b9486sm8762811ejj.84.2024.04.04.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:05:59 -0700 (PDT)
Message-ID: <4f29b9e1d713b1db94c86a829438f83bba686984.camel@gmail.com>
Subject: Re: [PATCH 0/8] IIO: More use of
 device_for_each_child_node_scoped() and __free()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
  Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, Linus Walleij <linus.walleij@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 04 Apr 2024 11:09:31 +0200
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-30 at 19:08 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Mixture of new code that entered in parallel with the original conversion
> set to use this new scoped cleanup and cases I missed.=C2=A0 Note the
> relevant code didn't make the 6.9 merge window but is queued up for
> 6.10 in the togreg branch of iio.git and linux-next.
>=20
> Includes allowing easier building of the ab8500-gpadc driver to enable
> testing the changes. Seems a sensible change to make in general.
>=20
> This series is making us of the automated cleanup introduced in
> linux/cleanup.h and new device_for_each_child_node_scoped() to avoid
> the need to remember to call fwnode_handle_put() in early exits from
> loops over the child nodes. This can also be used for simple scope
> based cleanup as seen in the ad3552 patch. In general this makes it
> easier to avoid a common class of bug.
>=20
> Jonathan Cameron (8):
> =C2=A0 iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
> =C2=A0 iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
> =C2=A0 iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped() to
> =C2=A0=C2=A0=C2=A0 simplify erorr paths.
> =C2=A0 iio: adc: ad4130: Use device_for_each_child_node_scoped() to simpl=
ify
> =C2=A0=C2=A0=C2=A0 error paths.
> =C2=A0 iio: adc: ad7173: Use device_for_each_child_node_scoped() to simpl=
ify
> =C2=A0=C2=A0=C2=A0 error paths.
> =C2=A0 iio: frequency: admfm2000: Use device_for_each_child_node_scoped()=
 to
> =C2=A0=C2=A0=C2=A0 simplify error paths.
> =C2=A0 iio: dac: ad3552: Use __free(fwnode_handle) to simplify error
> =C2=A0=C2=A0=C2=A0 handling.
> =C2=A0 iio: adc: pac1934: Use device_for_each_available_child_node_scoped=
()
> =C2=A0=C2=A0=C2=A0 to simplify error handling.
>=20
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/iio/adc/ab8500-gpadc.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++--
> =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 7 +--
> =C2=A0drivers/iio/adc/ad7173.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 24 +++-------
> =C2=A0drivers/iio/adc/pac1934.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 77 +++++++++++++------------------
> =C2=A0drivers/iio/dac/ad3552r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 59 +++++++++--------------
> =C2=A0drivers/iio/frequency/admfm2000.c | 24 +++-------
> =C2=A07 files changed, 73 insertions(+), 128 deletions(-)
>=20

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


