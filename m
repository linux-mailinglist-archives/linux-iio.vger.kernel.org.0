Return-Path: <linux-iio+bounces-2335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94E84F1DB
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6226E1C22184
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B55664B1;
	Fri,  9 Feb 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6f5n1re"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B51103
	for <linux-iio@vger.kernel.org>; Fri,  9 Feb 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469443; cv=none; b=kraL/XzMLTGCelnZlWFdQNUMBXUEpUFjTpy9IfQ+5e8IQEZ3vmygPcHHMfbf9krLXCulTTC1NxjYYreWYyuirioqbnct7zRBJUrnM/bUmY+tm29PJMdHuAkHgm0eVCNg8dRcXlKRwOW01h32VSH2RPCPKc6jJ/XY6V20b7nRua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469443; c=relaxed/simple;
	bh=X9xFYGfHcyrNjSL4foi4phkkFDnZwoW579Hu5ZCehIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRcNz/hiPyeNL+yoRv5dkbr7QEQjxFjp0F1EyVzT/V+fXJFfaB7YjzfauehH7abR3KQj0WuVy974wSMiN1Dlwt/Ydmx+8WjTDa5/3zqObj8rZF+xZyaWxCicWjwT1HGhGH/KuNqK4jbcqkoPdeh/lt1BKQaHuYACxNIjcXFUMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6f5n1re; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5614e93e700so12821a12.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Feb 2024 01:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707469440; x=1708074240; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZrpi9M8s3Z2SLRnr1dc9p15beZD0oaCHKH2lMU5zLQ=;
        b=J6f5n1reh5ype/6jSE72ON3tq1pqBTX8LdDWERp2LRsR3N+45rILA+jgJ2zXeGSVoJ
         4aU2O7QVMU5mPhHcdYGc/gRzsj/4FyW2nKEkEqLiC4ffKu0YVWi7hfirM5SIsYzLHQi0
         acnhOm03FD66zK8JBeH5/ymhlO5kO5JIGDe42nvzPa619ov/nLkDn9geDrJCv66DExZ+
         /LmAJYzmdJbcToC30eHwoez7q+e0XGYzaSgyAZoLTpw/h5PG42ofVLKcyGu1yrEXN5t9
         3o/baor7y8ijqS/W7Gtm5HpwRs6MROZbZ9fCe9sm4jPCPxjSH3mGPQTOHvIBHZv6uCee
         7oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707469440; x=1708074240;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZrpi9M8s3Z2SLRnr1dc9p15beZD0oaCHKH2lMU5zLQ=;
        b=MA3Ip7UGEU4gatemthqdkzgKwbEo7H6riTvmvsxcRrH2dhTlU2Z6KgpHVx6DxWxL3B
         DukZ9Rkfv56icM7+gMgvhsE4L7sIjsSsClroM/sGMedAA+9od10ihi8VZqc93Qw4Khz/
         LfNe9Ko7UFDeKYTi8beW7CraKNUYgBmjizBv26TiR3JBEi2DPtOhsIRweLTyz3PVqSUv
         QnA65CZ+7iwvBiYj9orSFY5Gs1YPlG8fNAgdMUJneVhrkwSdn6dBf9M2vlUE/TOZn2nK
         EVZbAP+BVQ7F8fSCivj2OWH6mxqznQsKcME00JFBnrOFqq7RM3W2Y7HR1bWdwQeaoIGv
         B0DQ==
X-Gm-Message-State: AOJu0YyUmroVs1zibv1/lJhDayBu3rU/AoOhqjamIJyHMkdqFvXBX3Kd
	BsiEpebMwxXeku+IOq+AlX0gtMkzL2iw4OxxqLR/6dPwIkbKAC6w
X-Google-Smtp-Source: AGHT+IFoxTRdpn71UVl0jQtDkIBp+L7WgOB2yGKM+Mi9Ly5dAl3rc/NL08bjXzSYVOdIKKsJYg111Q==
X-Received: by 2002:aa7:c6c4:0:b0:55f:fd36:6b3b with SMTP id b4-20020aa7c6c4000000b0055ffd366b3bmr745367eds.12.1707469439992;
        Fri, 09 Feb 2024 01:03:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrJ7lcdiI+FN6nzdslb0Dc8h5MtgYgrwtxTHW6j+/mRgidPEe6+N0LzAjwz1eJRGrmwp/phT5DV0tHRoPU4M/QCwcooH+rGXyXrsmIzpvGqlAMMTKKPzIHRcrQDLOP0JCkIlYMF3OXyFY2gTMkDuAQRpsZEzp7A8og0YtMmUHT+18gTSEMqwTY/C36UdHZRfLWBpSDRR4=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id fj25-20020a0564022b9900b0055fe5a611f2sm578948edb.20.2024.02.09.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:03:59 -0800 (PST)
Message-ID: <9abe545667599a085b346bd280fe96201d66f59a.camel@gmail.com>
Subject: Re: [PATCH] counter: fix privdata alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: William Breathitt Gray <william.gray@linaro.org>, nuno.sa@analog.com, 
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Fri, 09 Feb 2024 10:07:19 +0100
In-Reply-To: <wkabgwmjkuc7rdtnyko6j5tbhbbrtjeudalhqj5rsut6s2tefa@xry7vuvztlty>
References: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>
	 <ZcUeyN8OF49CGqij@ishi>
	 <2ada0bacadf63dc4216a9a7f4d9d5d47041a8c8b.camel@gmail.com>
	 <wkabgwmjkuc7rdtnyko6j5tbhbbrtjeudalhqj5rsut6s2tefa@xry7vuvztlty>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 09:30 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hi Nuno,
>=20
> On Fri, Feb 09, 2024 at 08:42:02AM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-02-08 at 13:34 -0500, William Breathitt Gray wrote:
> > > On Mon, Feb 05, 2024 at 04:58:14PM +0100, Nuno Sa via B4 Relay wrote:
> > > > diff --git a/drivers/counter/counter-core.c b/drivers/counter/count=
er-
> > > > core.c
> > > > index 09c77afb33ca..073bf6b67a57 100644
> > > > --- a/drivers/counter/counter-core.c
> > > > +++ b/drivers/counter/counter-core.c
> > > > @@ -34,7 +34,7 @@ struct counter_device_allochelper {
> > > > =C2=A0	 * This is cache line aligned to ensure private data behaves
> > > > like if it
> > > > =C2=A0	 * were kmalloced separately.
> > > > =C2=A0	 */
> > > > -	unsigned long privdata[] ____cacheline_aligned;
> > > > +	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static void counter_device_release(struct device *dev)
> > > >=20
> > >=20
> > > This change sounds reasonable, but should the comment block above
> > > privdata be updated to reflect the change?
> >=20
> > Yeah, maybe. I can spin a new version with that... To be sure, you mean=
 (in
> > the
> > comment) private -> privdata, right?
>=20
> I guess he means: "This is cache line aligned to ensure private data
> behaves like if it were kmalloced separately." After your change it's
> not cache line aligned any more. IMHO keeping "private" is fine.
>=20
>=20

Oh yeah...

Yeah, it will depend on the platform. In some, it will still be cache align=
ed
but in others (as x86 which is DMA coeherent I think), it won't be and we c=
an
actually safe some memory.

- Nuno S=C3=A1


