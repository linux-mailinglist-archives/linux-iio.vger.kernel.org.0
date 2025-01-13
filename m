Return-Path: <linux-iio+bounces-14265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5874EA0B382
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF703ABCD3
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066922C32B;
	Mon, 13 Jan 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN56A3YJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8B22AE76;
	Mon, 13 Jan 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761002; cv=none; b=Rq5lTExhsE9q+ijW9gveIsewNyBuW3Sxsa6HE6z0girxyH5Af4tZDRBlF+nV3FPJjmkt9VSLxwGVq9bdEin3RpzG+qmdPU1+jButoKJ3yzV1SrVPkV0cjmxXO7INaYkuTlWbxxm6HmVffF3lgdctlh3QltdG4PUJlLy+d6VK74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761002; c=relaxed/simple;
	bh=CnSGARktw4IXiEEBL5guac/mAy2S/VeEr/vvlM4oBsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTVbQMS5z8Zp3fNBqOZzQJS/o9AWJnasoaEpSQIj/h5YSepNbFplKQ/jmInLy5mWRWFUnMIcucChVdh/e/UMZTVFglQIwX6huTP+k9n/34HpANumwBL/n8HN0Wnuq/AY3saHYrx8XcFe93pJyrCC3V/icUSwl8xywVB/NbFiY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN56A3YJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2114850f8f.3;
        Mon, 13 Jan 2025 01:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736760999; x=1737365799; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7nyUSHHP0yR3ZtnhpxdtDCyqMGbgmdlP3dka+ZfZ0PI=;
        b=RN56A3YJ6jJ9fVBaydvYqdI4fjOnhhIAeKz4rWms8cOcwKkCmZ8FSbM0FSPa0vUSIV
         Rc/sEXT4Fid1WJfLdAIoV0GDy1D8pTF42GdIhUnxEwZcajMHyT9PzVth+KVXf8gek3hk
         bBYywYes7exrSuR09QkFVBZ4nT21p3Q1sb21WFFANDDg5cAnH6AO/NmVgfQ9hHf7I/a4
         dfAYeRWp3j/8+j3F8rBVbovmeT5wbCwSJHTNLxrU6wnWLxnCGifqAyLKReU3bnbXJncU
         PDOuiSANTK3NXwtRHL0JwqM8gYs55Y9yH/tV0xxbh1Y7eA1skQcHXixRGDutJx80nty/
         83bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760999; x=1737365799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nyUSHHP0yR3ZtnhpxdtDCyqMGbgmdlP3dka+ZfZ0PI=;
        b=LcPVutEpoGqa91xvLsiPv9fqpaH7Kc0/Q6KZNJRsXyVWwJf7/nwA551akBnHk8u72f
         Oyn9tbI6gEnQ33h2hHzgJJpHAJ9z+Lxz0CpIocyug4M57zw6EOyjc5dRbauhX6mQFVjn
         0UeV4WRaB68dH53ebSH2SFjTfZL2sZYrz6/+EkFc8BaXgUfswFKn9JIwZJITwWUixqkf
         tgjrDCpdKEUUdSKgQIPm/9mMbXSDtL4OPrUk7G4fLKv2eeLFRVD0S0MnET8ebquvjdTf
         udaUkTyG2EMBRNsFHfm7QiYTBUVR4gwtHHM7D3zOKAck0VD7BO8GOkh4y2Bs3op0dkbp
         G+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUr1Q+0SGFz0f2wWUTb3RCBpwW77Jc0mbSN9oW73RYq6lBNviEfFWcabN/PEMs8pliCFUIAHqGD7LK@vger.kernel.org, AJvYcCXK0LVKO7YdbGK9RDXkiiTuGjbvlI6NvqDXzA2edACz4wDyM7ca8QFmt8AQEdd4t9sSgSgBQ49nuV8U@vger.kernel.org, AJvYcCXU2Pv4+8A/TQmzT4BX/62Nb0rH4hMYCJi0c9iXpHMg7EGPJATex0se8O+JDZyaq6M3NFWQ6dFozGHf@vger.kernel.org, AJvYcCXvB+tLYRVMWBKd/2rfwa5weZVvjnjqs+vFI5AuWCuSJsewkp02tb0GdJhq7gEGUIN4nG7EFj2ysIzvcy2g@vger.kernel.org
X-Gm-Message-State: AOJu0YyeE4P9Q0ZAxfEifGI0kcmfYMYaxf/FAGPvsopIWRB7U55NvFNo
	h5cgUF5IBNIcyoVr2MqgfRl+g2ODplXJ39req9u+33bsSchkqumr
X-Gm-Gg: ASbGncuACnq2de47WrvIjcW2UfPjlAMeO63N/ZLnzbdH/mcOClDl7y2p6iIs6aR7R8O
	Juqu5pCXlEOeA+4Z1F8+qtKDNUGvjkV/kOPCGGSI1KHEbnSaP4kKVo382KxFD2FbUMqjs5jqipW
	rUhYx4bFd9afZYnmiJ9srpJsLEoV9Gz9ayE31psIYuL3aqBGGspU1DkUbp27wMZLNvRVJASBQYg
	p2WL81l+Kn3jDUY5cdgvUBuxb/yC7f/aiUW155bFh46Oiw03TBmY9F/41Z5r3HH53EUHe8t/8nA
	oPsfSkOnSFPHOi/eU4ctg5YPLkxu
X-Google-Smtp-Source: AGHT+IESwRCXbGth1qot4cl0kyw6thE3Qlkh6tb8Sk5ZxVbqvaA8AEXyrAMpEIhD/zBSCKA7evuCVg==
X-Received: by 2002:a05:6000:1acc:b0:385:db39:2cf with SMTP id ffacd0b85a97d-38a872c943fmr16012470f8f.12.1736760999113;
        Mon, 13 Jan 2025 01:36:39 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b80d4sm11395176f8f.85.2025.01.13.01.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:36:38 -0800 (PST)
Message-ID: <c5bbfd1555a8a141caca944f2bb1b6eccb88fd67.camel@gmail.com>
Subject: Re: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Robert Budai
 <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano	
 <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Mon, 13 Jan 2025 09:36:38 +0000
In-Reply-To: <20250112161141.563064c2@jic23-huawei>
References: <20250110074254.38966-1-robert.budai@analog.com>
		<20250110074254.38966-6-robert.budai@analog.com>
	 <20250112161141.563064c2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-01-12 at 16:11 +0000, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 09:42:53 +0200
> Robert Budai <robert.budai@analog.com> wrote:
>=20
> > The ADIS16550 is a complete inertial system that includes a triaxis
> > gyroscope and a triaxis accelerometer. Each inertial sensor in
> > the ADIS16550 combines industry leading MEMS only technology
> > with signal conditioning that optimizes dynamic performance. The
> > factory calibration characterizes each sensor for sensitivity, bias,
> > and alignment. As a result, each sensor has its own dynamic com-
> > pensation formulas that provide accurate sensor measurements
> >=20
> > Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > ---
> >=20
> > 4:
> > - reorganized channels to match the order in the datasheet
> > - removed extra checks and goto statements
> > - for buffer memory allocation used only kfree, since adis library alre=
ady
> > takes care of freeing the buffer
>=20
> That last bit makes for a mess wrt to who owns the buffer and lifetime
> management. Suggestions inline.
>=20
>=20

...

> > +
> > +	/*
> > +	 * Allocate the xfer and buffer for the burst read operation. The
> > buffer
> > +	 * is used to store the burst data and the xfer is used to send the
> > burst
> > +	 * command and receive the data. On device remove the adis libraary
> > is going
>=20
> library.
>=20
> > +	 * to free the xfer and buffer.
>=20
> That is a horrible lifetime control.=C2=A0 They should either be allocate=
d in the
> library
> and freed in the library or allocated and freed in the driver.=C2=A0 Mixi=
ng that
> doesn't
> make sense.

Agreed. TBH, I did not remembered at all to suggest ignoring the library an=
d let
it call kfree() on NULL. I also don't like that much of how things are done=
 in
the lib but I don't think it would be that straight to change things for th=
e non
'burst mode' cases. For the devices implementing 'burst mode' doing the fre=
e +
allocation on every update_scan_modes seems unnecessary. Anyways, maybe
something worth looking at in the future.

- Nuno S=C3=A1


