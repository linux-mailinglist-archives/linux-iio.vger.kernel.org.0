Return-Path: <linux-iio+bounces-13790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6A9FC546
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 14:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9127018838A2
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14541B4F02;
	Wed, 25 Dec 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtVJ+MDe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B714E2E2;
	Wed, 25 Dec 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735131749; cv=none; b=b4D2XtHDHOWY3aZxfK3D+7MZaSdnQSDmqjjP+9SW7XCMLaHQf3oBm3DfAPAjsXRtj3tjoC39UMcXg72KRg6LPFCXrK5thekgAzj8IPlS2p9etOPSeMRkzPMtSFtRIlqSJ6kyI9AOHT4Pgnf22Mrtgy0f2YnI197yhLy+cqaJ83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735131749; c=relaxed/simple;
	bh=V72tC3QfUDNcNbLtR+4eFEIvd5zVqyKJaogtIFsFJJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7xScRFhn7zTS/GIOsS1CfSY8b6PZXztGLqAfg9/4wh92ne/udbqmb/mEB6NewfwATylHHxSiM1xiawPeDQH44nSyT7CsOz/f+vPEGsRMJyzkolKBFYTFi/zk4SQ7gJcTN4CMq1iFFchO9pyP+/BlhXAe6Lr2WnSKrXSQD13emc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtVJ+MDe; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3a0d9aab47so675278276.1;
        Wed, 25 Dec 2024 05:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735131747; x=1735736547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYUfV8rMWmfrT0n4/d7WJieHYcMXg3SqOTiyM/7U9Qs=;
        b=FtVJ+MDewsl4zwGrp3M7x2sOGp45UaNJYWp2xReK4OfJFQMCFu+UZuNvQqx7WNcHTO
         /rZjOMSa9Q4i4H9USOl0gH6GknyKdhp50yb4RTHiYNuRbPQ0tZgIKIZcflYO8i0L7U3p
         4u//QlKpNHk/HEEHGB7G1D0DqkzSQX89qI1vJB5vNXUGRTwlDlHPrYDzm3lYzYgSNLG7
         ZHiGnqr1AO7HrP/sPXfHq5AVg1iXKyG5sl24FPEDvjzmFLBVtbkoSOAYLbCpwBCcjn0k
         tOmOBCGBFCoH2/gxHnFOF2lObM3Luf899mf71RQMLSo4aMDkJRmLdJ3c+/SY49ubBf6l
         o5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735131747; x=1735736547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYUfV8rMWmfrT0n4/d7WJieHYcMXg3SqOTiyM/7U9Qs=;
        b=XHYLgveTQ+AuNtwI0I6TRB37UrlttIo3rptzjUsKUoM9+M1uIZV/xxAx52OK7wfIfq
         RZmVRip7Z0PE3HG/mM9yIb8+0KBfxZQH/TkyvMHIdmljJratt0ZHRQg3K1QYznuYrNvF
         FwfecyI8w5S2JqvgHILT7sPASKse34d6mQTfU9zurcbRRLvcKzufATCxAZW3Yib41L38
         w9E0Iwv0dfzA1lmumFcKYNfYh6o+S09rGvUXaNxZgNcD6zJHe2S/ttS0WSozFoZQIAIA
         +FmqQslzLWnqDat1Q7bKuyD+ZMeNEHsIfLn2+Jn34eaxUBtGQiAlRNz96bDTOO1bDCCL
         hkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ix3To1hQNyNYYcqTOCO7J6gCEbhvlegoz4M+MonwaXkQtEy89fSxUZLh6d2fbiaBBPkGHtpJeTNX@vger.kernel.org, AJvYcCWJyG0bEbHbMgGIY7a5UAKoGffsToSkx9InAKo+N2m8XmgeAtbIdU5tghGO93bs/TmMpX56t9E77Qzx540M@vger.kernel.org, AJvYcCWTbBVu/DchxIpRGfOy3WCTsl1d7h3QAaAi0UYMkCfPiU07TUFZ4wPb88Y1Cpq29kMAcZ2hirm0kDg2@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBdp0vFcFOGs29mmpFm6os66b/FhM3Y1sUGL/kVF6SLFzJXtd
	ugwX1DtcNVjSeEikm8Yj9CUUqLIzpH1GFRdU5lRLMp7ChZZR6vymhH/1y/cN+VTa0j+MqJeUEAe
	+9lZi2JNUgM8QmOf6T1NiFAtUr8I=
X-Gm-Gg: ASbGncvESZ+mdkFYuPTjNWCsHXLI6N9eKtnz4wd2WrPYigymvDoCeJ2MGhLLzo4n8ZE
	9D0f65SnHzzOWKBefiVvQ7l/SdvO93hQS2gHZYA==
X-Google-Smtp-Source: AGHT+IHNTqSdSMcUPy7sJ0+07c0EPJDC/weW68OgvRL26rvIUQQGE2LuhgisVQK0D/PqdI1MnjtfOTZdk7ONqPDG0Sw=
X-Received: by 2002:a05:690c:6e82:b0:6e6:c8b:4ae3 with SMTP id
 00721157ae682-6f3f8291096mr69305427b3.10.1735131746717; Wed, 25 Dec 2024
 05:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213211909.40896-1-l.rubusch@gmail.com> <20241213211909.40896-4-l.rubusch@gmail.com>
 <20241214121057.5b12a236@jic23-huawei> <20241215-satisfied-expiring-9200ec935768@spud>
 <20241219175815.797b376a@jic23-huawei> <20241219-pregame-blot-e15ff0fbfe45@spud>
In-Reply-To: <20241219-pregame-blot-e15ff0fbfe45@spud>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 25 Dec 2024 14:01:50 +0100
Message-ID: <CAFXKEHaaLj7gePiDruMvwGGZKq5ctoq5z7_Qv_NC3bvBsL_BeA@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add interrupt-names
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 7:21=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Dec 19, 2024 at 05:58:15PM +0000, Jonathan Cameron wrote:
> > On Sun, 15 Dec 2024 14:56:58 +0000
> > Conor Dooley <conor@kernel.org> wrote:
> >
> > > On Sat, Dec 14, 2024 at 12:10:57PM +0000, Jonathan Cameron wrote:
> > > > On Fri, 13 Dec 2024 21:19:05 +0000
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > >
> > > > > Add interrupt-names INT1 and INT2 for the two interrupt lines of =
the
> > > > > sensor.
> > > > >
> > > > > When one of the two interrupt lines is connected, the interrupt a=
s its
> > > > > interrupt-name, need to be declared in the devicetree. The driver=
 then
> > > > > configures the sensor to indicate its events on either INT1 or IN=
T2.
> > > > >
> > > > > If no interrupt is configured, then no interrupt-name should be
> > > > > configured, and vice versa. In this case the sensor runs in FIFO =
BYPASS
> > > > > mode. This allows sensor measurements, but none of the sensor eve=
nts.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > >
> > > > Just to repeat what I sent in reply to v6 (well after you'd posted =
this).
> > > > Maybe we can maintain compatibility with the binding before this by=
 adding
> > > > a default of INT1.
> > >
> > > But can you make that assumption? If we did, and it's not universally
> > > true, we break systems that had INT2 connected that previously worked=
.
> >
> > I guess there is a possibility of a driver in some other OS assuming IN=
T2, but
> > seems an odd 'default' choice.
>
> Ye, I think that it is unlikely a driver author would think that way.
>
> > Also odd for a writer of DT for a platform
> > to assume it.
>
> I agree, I think it is unlikely that someone would assume it'd work like
> this. I think a lack of attention paid to the schematic of the board is
> a more likely culprit.
>
> > There is a thing that comes up in spec orgs when discussing whether to
> > rush out an errata.  "Is this bug something people would get wrong
> > thinking the answer was clear, or something where the would ask a quest=
ion?"
> > Anyone who thinks INT2 is the obvious choice for me falls into the woul=
d
> > ask category.
> >
> > However, in the linux driver we would would go from assuming no interru=
pts
> > to assuming the wrong one.  That's indeed bad.  So I guess this doesn't=
 work.
> > Oh well no default it is.
>
> I don't think you really lose anything from having no default. The
> driver works just fine without the interrupt, so the albeit small risk
> just doesn't seem worth it.

Agree. To be honest, I'm not sure if I catch the point here. IMHO,
falling back to FIFO bypass should match with backward compatibility.
Please let me know what I'm missing here.

I would prefer just to check for a specified INT name. Then configure
the specified interrupt line in the probe. In this sense, the
interrupt line is only useful also if the INT name is defined in the
DT. If no INT name is specified, the iio driver will setup FIFO_BYPASS
which is the legacy behavior (according to the datasheet: if none of
the FIFO mode bits are set, defaults to bypass mode). This is the new
behavior.

The old iio driver did not use interrupts at all. It stayed in
FIFO_BYPASS mode (or did not change it, after power on, it assumes
FIFO_BYPASS to my interpretation). Thus declaring the IRQ line yes or
no, with or without INT names - for the iio driver implementation
before this patch series, should not make any difference. It uses
FIFO_BYPASS in all cases.

The input driver (AFAIR we already agreed on ignoring this driver)
needed interrupts. Defining INT names here does not change anything,
either. The input driver configures by default INT1 and simply ignores
what was specified as INT names in the DT.

I cannot really think of any third case here. Please, let me know if
I'm wrong. If not I will keep the above explained behavior, since to
my understanding it should match the desired compatibility
requirements. Am I wrong here?

Sorry for the late answer. Best,
L

