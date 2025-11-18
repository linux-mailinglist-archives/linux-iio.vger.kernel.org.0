Return-Path: <linux-iio+bounces-26276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E74AAC68245
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 09:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 278A534DAE4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A23081D4;
	Tue, 18 Nov 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvPTBHfy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA13002B7
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453266; cv=none; b=LPx0oLAwEOKjKUAVfmtAENvFR/zWFaXiATX324dbJU/pgZhrLYCYMA+5dZ8pF/tz3/M8T7RHGuqF0mVusKNAAFJMFg1O/LSgerKFT0UFf75/LfFSDbiPSCy0MUQpttPuCg5FANXRHN6SG41A9OPcMlSDNHdAbk+3zKAXyIpKuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453266; c=relaxed/simple;
	bh=pPUUDsnON1f/C/Xt/Dp4J8y7/kKmxia2J0vzj31aggc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzbzHzk4sRjbsP7eFfkM4m7tNfpN9i/oh1dHCjQ80bmeEOXRoWiRCYW4vB4YGPuerJHoYHONpX8Q55dttZrwvqiGp1k7L+djA6AAP0eidxyH19ddfJLd4RZIvHpkt8T/Js/ytUGNZlAqZAZSaN797ko8j1ns8m4gJFdr9gxAaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvPTBHfy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso16903515e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 00:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763453262; x=1764058062; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SOKyqW+rWF326wuYtSwfKzyTd2rHymbXP5+Sszs5WVA=;
        b=LvPTBHfyBMrlhMUxom7VFzy6cBZCClpsJnWuz73c9jjGKwkh9Kt5oKfu447Cosatt0
         KOibY0GwcTILBKIuo5TVl74HnWKOWnoE7F4KGuGl47wZeX+Zjk0154YM+MiwaV4rhAPZ
         9vP+xIUvsMR26bLDlk2qw+nttWOLhwzGbBZ3V3CSEmecKm1JQVWNcRBcCxBmRs1pBSjx
         00nkj6+6TG/HVVVPu+lC1qmmB1PyrMnfrjE6ShzBDE7Ir1QUluCXQqhACKQz2ebMb3AH
         FrnM6QHW6XPk1lOgqzxx0ZIouYykLByG20mTu+V3aQjga3Yed1FZU3aHQIWyelp2nuf4
         EZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763453262; x=1764058062;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOKyqW+rWF326wuYtSwfKzyTd2rHymbXP5+Sszs5WVA=;
        b=AEKxNjAjsFfm/t14SjXyZxjTNn/1kQhCIcOpP8tN6pcyI4nIgKchLd/G0vCpf0pH/1
         XSeUbRlsmUS2h13cxfkc6sDcAYzsweP6ttdwcbV25g65zVyxSgAom8O2BHHdxRxsvjcF
         oQK3qA9xPFQhLwYT6oPzjD4qJrTOQT1XrgbVNS+cnKBl/pMmIAaUMn6Q5q00a8izl7Vc
         fpr+y5RIm0giFLeLEA2xxFtFTaBGkwXXvr1hUhcPlIbOhfVD+YYApCf5nzMq1SbHEBfP
         tNeealSS6cj0JH7q0XcuDqVfASh+OV19Ovb8l0JwooNx8eYWwZGORo6DySmo6SGX+MyT
         Wgvg==
X-Forwarded-Encrypted: i=1; AJvYcCUCdL6J3GsED1BUulUsJyDS8eCaymnYYAgiWoiQHWq4GdREPfLQTVDJQqZaq0Mo2gfMgp604Vzdfcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2NIxjOw+XrgImjX5b32DqaqcGTOIy1TRnHE+TV3HWapSK1gY
	sIKbcJ5rhCElObLaz1EXDolWzclanVEcY7a9Znu3aTXm3ZpP9y90cTz/
X-Gm-Gg: ASbGncvbCYRqVgAabDZk3IWll1nZ27r2D1KUFfDXuFvHYlvkQCoXBHwDAmz7pMeWYOT
	TzudlyegCCWCtC+jg32XM1ganmUQJrwAfBT9fkMbsmNZ2QRJQ3AaWzntsh4IkpiYVKj1/8YQRzX
	5z2YCZX9a8VDUHUm+k7tI8fYrYRSNNtF0GQ+Rnkqd59nDnLjSY0+Qo3igM1wg7IPHCwbU+sxXeu
	6D0LCFsjn/GTslz3o3gSn7fCsZeEeGhee0ZB91Ozr+NVYeUCinkduz7YYhXkU4fvw4lpvrIS+bz
	g/m7avhJDtsN7K7uhoE/7znSrVsBD9mnKqUbDzwjeNAtRVovPdFRimUIip59LmAiWbRwSKCFUDa
	XaoOHqgjKPiRvjNJ6kGKsx8WLEPhPeHJfLcI12PYwVdxXV1qrCPQyFSJibqZncRSvRTMyuL1LXW
	3WzFinFemgTMnDVTB8i3UKNAiBy2rKQjWajxdx4rvGn238P+k9
X-Google-Smtp-Source: AGHT+IE2twSPK/uc1hNp2awrrqEaL9qbm7pw2MaLUZezT/jfn8ugeWsBEA486+i2PPciEUsgTJjarg==
X-Received: by 2002:a05:600c:3550:b0:477:7d94:9d05 with SMTP id 5b1f17b1804b1-4778feb0f3emr142789245e9.35.1763453262096;
        Tue, 18 Nov 2025 00:07:42 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b5ce849ddsm24157607f8f.14.2025.11.18.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:07:41 -0800 (PST)
Message-ID: <62109f602caefd06a23bbd96e05c327647d054e9.camel@gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation: ABI: adl8113: add documentation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Date: Tue, 18 Nov 2025 08:08:44 +0000
In-Reply-To: <aa2808d2-58fd-41a9-a533-86896352a485@baylibre.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
	 <20251114115725.5660-4-antoniu.miclaus@analog.com>
	 <20251116155013.2b55af25@jic23-huawei>
	 <aa2808d2-58fd-41a9-a533-86896352a485@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 17:59 -0600, David Lechner wrote:
> On 11/16/25 9:50 AM, Jonathan Cameron wrote:
> > On Fri, 14 Nov 2025 11:57:25 +0000
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >=20
> > > Add ABI documentation for the ADL8113 Low Noise Amplifier,
> > > covering the 4 pin-selectable operating modes.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +CC all the IIO subsystem reviewers as I'm not sure how to handle
> > what this device does, and would like some more opinions.
> >=20
> > Anyone who has expertise or design experience with this sort
> > of amplifier with external bypass path: how are these actually used?
> >=20
> > The development board seems to just be suited to measurement of
> > device characteristics, not representative of a design using it.
> >=20
> > > ---
> > >=20
> > > Changes in v3:
> > > - Replace "mode" attribute documentation with "signal_path" attribute
> > > - Update descriptions to reflect separation of gain control (hardware=
gain) and
> > > path control (signal_path)
> > > - Add explanation of automatic bypass mode switching when selecting e=
xternal
> > > paths
> > > - Update attribute names from mode/mode_available to
> > > signal_path/signal_path_available
> > > - Clarify that external paths enable connection of external component=
s for
> > > filtering or amplification
> > > ---
> > > =C2=A0.../testing/sysfs-bus-iio-amplifiers-adl8113=C2=A0 | 30 +++++++=
++++++++++++
> > > =C2=A01 file changed, 30 insertions(+)
> > > =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ampl=
ifiers-adl8113
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl81=
13
> > > b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> > > new file mode 100644
> > > index 000000000000..31fb1e6e80fc
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> > > @@ -0,0 +1,30 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/signal_path
> > > +Date:		January 2025
> > > +KernelVersion:	6.14
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		This attribute controls the signal routing path for the
> > > ADL8113
> > > +		Low Noise Amplifier. The supported signal paths are:
> > > +
> > > +		* internal - Signal passes through internal path. Can be used
> > > with
> > > +		=C2=A0 either amplifier mode (14dB gain) or bypass mode (0dB gain)=
.
> > > +
> > > +		* external_a - Signal routes from RFIN to OUT_A and from IN_A
> > > to RFOUT
> > > +		=C2=A0 (VA=3D0, VB=3D1). External components can be connected for
> > > filtering or
> > > +		=C2=A0 additional amplification. Automatically switches to bypass
> > > mode (0dB).
> > > +
> > > +		* external_b - Signal routes from RFIN to OUT_B and from IN_B
> > > to RFOUT
> > > +		=C2=A0 (VA=3D1, VB=3D0). External components can be connected for
> > > filtering or
> > > +		=C2=A0 additional amplification. Automatically switches to bypass
> > > mode (0dB).
> >=20
> > I'm still not sure how to handle these external paths.=C2=A0 The one th=
ing they won't
> > be
> > is truly zero gain (because that would be pointless given the internal =
bypass
> > path does that).
> >=20
> > So how are these used in practice?
>=20
> Afraid I don't have any experience with this. But I would assume that the=
 two
> external
> bypasses each have another amplifier (or attenuator) connected to them.
>=20

Unfortunately me neither. Antoniu, it would make sense to figure out who th=
e APPs
engineer for this part is. He is the one who can answer how the bypass feat=
ure is
supposed to be used in practise.

> >=20
> > Do we need to figure out how to describe the real characteristics of th=
ose paths?
>=20
> It sounds like this is just a multiplexer. So a few ideas:
>=20
> 1. We could handle this like iio-mux.c and have 4 channels and just restr=
ict use
> =C2=A0=C2=A0 to one channel at a time. Not exactly sure how we would do t=
hat. Perhaps an
> =C2=A0=C2=A0 enable attribute that is interlocked so that it will fail to=
 enable if another
> =C2=A0=C2=A0 channel is already enabled? In this case, the devicetree wou=
ld need to have an
> =C2=A0=C2=A0 io-channels property to get the two bypass amplifier channel=
s and basically pass
> =C2=A0=C2=A0 them through.
>=20
> 2. Have the devicetree specify the gain of the two external bypass amplif=
iers
> =C2=A0=C2=A0 so that we can use the hardwaregain attribute to select betw=
een the 4 mux
> =C2=A0=C2=A0 positions without needing a custom attribute. This works as =
long as none
> =C2=A0=C2=A0 of the amplifiers have the same gain.
>=20
> I'm envisioning this would be e.g. part of a range selection on some sort=
 of
> test equipment. In that case, option 2 seems the right way to go about it=
.

This makes sense but I would still try to have some confirmation about this=
.

- Nuno S=C3=A1
>=20

