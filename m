Return-Path: <linux-iio+bounces-1933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA183EC1E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 09:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DF6285605
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D33A1DFEB;
	Sat, 27 Jan 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS46c8Bp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB81DFD6;
	Sat, 27 Jan 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706345029; cv=none; b=VZuABxysDuIJ9zDcrPbkEvDDEr6rdJW2yqWMSknsvld41kLuGG5sPlTiWSG8SqfK1tFoq1kyD7IbiVUfBovaJ2WxPOvOGZpHLISDpatEUVh+v+RkDs7dx3V8hBXrR/P1OXuY2X/hXD9nuim6O5OAhuCvubzh+Nkya5ieMkhfBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706345029; c=relaxed/simple;
	bh=TWoSTo3mx1ixEUyJHtazcJt9Z4Hfep7wfxqd+BfHWng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZyIpQ6H+++pBZlA/iVSYaHOlYyfzkAQmlThF1evyX0rEYjQaiCNOpr8qNVBqJIiwm1U1JGzOlIW2HhTNUXTPItO1BDHSxX12SqJf5yZqxUsuA5E+X92ynJ80sHxhHp1a7jH1czsIN3/sDgzLKH2NYZw87Er9KHn51W8sY/opYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS46c8Bp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a86795a3bso751046a12.1;
        Sat, 27 Jan 2024 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706345025; x=1706949825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWoSTo3mx1ixEUyJHtazcJt9Z4Hfep7wfxqd+BfHWng=;
        b=RS46c8BpVCGnLSJiPCfvmG6ULnbyN6F7Py1uvbVsDHQtiIkxGPvkjFypjldWOKN6dm
         /52M605pmY4LldrH4pJHz+8IW3x8yOAXz9uSeP9iBO0oZKpPv6dCRYonfk0OSHglPwlV
         gVR30kocjvMnIAUCN+uioJjlfPFlL0vRudqVRDKI9OZN8WpTOW6a3Fgb28h+a9MA8ph6
         czmM2v7W+xqwm0cEkgDTzJOHgzW6Ie2FZqOJtDgG1nI891CO54S9XDT3Cs8JrkovHqqA
         eWXKkONDEWDWHFduGCDCMIFZzqHkcK/DLm0kRQcxHfggF0PRMU1s8PWr5cr1XtNUL2Zh
         QD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706345025; x=1706949825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWoSTo3mx1ixEUyJHtazcJt9Z4Hfep7wfxqd+BfHWng=;
        b=a6NF48bYfpKZAxOY4qqcrYUWg1GxWRQEA3KBjK8i5DOhSTAxMm9KrXymLWO8qbV6lm
         3jWMY7THawTSSl2wL9Kbb+K3R7tOb3MN4nmpjCW89/mqolaqNC1LnlOq+TushJY7SjHP
         JH4Kjpau+TI2cosWrPyM+O7kkRSKMtHG4sxY0f5als9CbKOMIhxYdhIv/mm0Y1c1I8Pj
         DcwtSBYS/mNEepoE/Z4Npm0obu8wO1UM0e4GLgHHEgll94m5jPWXvjN4tojf1/qOhRGB
         VUnMs3celXDYXPazV7Gu/8REnFc7ccPDLrJBlJlsc4O7JQ/OlJpiEGpQ4Sufk92mn+h1
         DKSw==
X-Gm-Message-State: AOJu0YxIY4Y8RgTwGwvz8T2DLeq9oqwtBypkO3pRQiASB23Tjv3cjIBF
	Vrshuekcv+5/1h5rlS0vrCKCi6wfK/YdsHXoo+b2HkH+h9FPxhNZ
X-Google-Smtp-Source: AGHT+IERZzszDssSbs3OChLYMwKZ32r0+djR8psmVNKpEt+8RCtnDC05tq1S8mwqsmRaYsA7CoqV4A==
X-Received: by 2002:a05:6402:160d:b0:55e:abbe:32cc with SMTP id f13-20020a056402160d00b0055eabbe32ccmr506831edv.11.1706345024955;
        Sat, 27 Jan 2024 00:43:44 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7c9da000000b005581573e251sm1391317edt.2.2024.01.27.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 00:43:44 -0800 (PST)
Message-ID: <8894371fb9b625992b172928fe1bcff5fc201d85.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Sat, 27 Jan 2024 09:43:44 +0100
In-Reply-To: <CAGETcx_TXTddsExr+7hq9VWY518Qoai_YQ9u1Jb3WPihAK5fqg@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <CAGETcx_ScsW4gKpAK01dHYxB3XGs-pRjJQMygbZUNAdxV6BqtA@mail.gmail.com>
	 <865346908c9b76d72741e6f319a4535459de1ea6.camel@gmail.com>
	 <c459cc6766b741892cdf9de0b50832023eb4196d.camel@gmail.com>
	 <CAGETcx_TXTddsExr+7hq9VWY518Qoai_YQ9u1Jb3WPihAK5fqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 10:09 -0800, Saravana Kannan wrote:
> On Fri, Jan 26, 2024 at 6:24=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Fri, 2024-01-26 at 09:13 +0100, Nuno S=C3=A1 wrote:
> > > On Thu, 2024-01-25 at 16:50 -0800, Saravana Kannan wrote:
> > > > On Thu, Jan 25, 2024 at 12:11=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@=
gmail.com> wrote:
> > > > >=20
> > > > >=20
> > > > > Hi Saravana,
> > > > >=20
> > > > > Thanks for your feedback,
> > > > >=20
> > > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > > > >=20
> > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > >=20
> > > > > > > If a device_link is previously created (eg: via
> > > > > > > fw_devlink_create_devlink()) before the supplier + consumer a=
re both
> > > > > > > present and bound to their respective drivers, there's no way=
 to set
> > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks t=
o allow
> > > > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > > > > >=20
> > > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > > > Especially if fw_devlink already created the link? You are effe=
ctively
> > > > > > trying to delete the link fw_devlink created if any of your dev=
ices
> > > > > > unbind.
> > > > > >=20
> > > > >=20
> > > > > Well, this is still useful in the modules case as the link will b=
e relaxed
> > > > > after
> > > > > all devices are initialized and that will already clear AUTOPROBE=
_CONSUMER
> > > > > AFAIU. But, more importantly, if I'm not missing anything, in [1]=
,
> > > > > fw_devlinks
> > > > > will be dropped after the consumer + supplier are bound which mea=
ns I
> > > > > definitely
> > > > > want to create a link between my consumer and supplier.
> > > > >=20
> > > > > FWIW, I was misunderstanding things since I thought
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > was needed to make sure the consumer is unbound before the suppli=
er. But
> > > > > for
> > > > > that I think I can even pass 0 in the flags as I only need the li=
nk to be
> > > > > MANAGED. Still, I think having DL_FLAG_AUTOREMOVE_CONSUMER makes =
sense.
> > > >=20
> > > > As you noticed, your understanding of DL_FLAG_AUTOREMOVE_CONSUMER i=
s
> > > > not correct. There's almost never a good reason to drop a device li=
nk.
> > > > Even when a device/driver are unbound, we still want future probe
> > > > attempts to make use of the dependency info and block a device from
> > > > probing if the supplier hasn't probed.
> > > >=20
> > >=20
> > > Yeah that makes sense and is making me thinking that I should change =
my call
> > > (in
> > > patch 7 to use the MANAGED flag instead of AUTOREMOVE_CONSUMER). Sure=
,
> > > AUTOREMOVE_CONSUMER won't matter most cases but if someone disables
> > > fw_devlinks
> > > then it matters.
>=20
> I don't fully understand the patch series, but what exactly are you
> gaining by adding device links explicitly. I'd rather that every
> driver didn't explicitly create a device link. That's just a lot of
> useless code in most cases and we shouldn't have useless code lying
> around. If someone does fw_devlink=3Doff and you don't create a device
> link explicitly, what's the worst that's going to happen? Useless
> deferred probes? fw_devlink is really only there as a debug tool at
> this point -- I don't think you need to worry about people setting it
> to off/permissive.
>=20

There's (at least) a reasoning behind the explicit use of the links. We wan=
t to
ensure the creation of a MANAGED link so that we can be assured (i think) t=
hat the
consumer device will never be around if the supplier unbinds causing those =
typical
issues of a supplier going away and consumers trying to access it's code. N=
ow, in the
HW arrangement we're trying to support there's no such thing as optional su=
ppliers.
If the IIO backend is going away, there's no good reason for an IIO fronten=
d to stay
around. And using the guarantee provided by the links made the code way sim=
pler.

Note that in the first versions of the series I was also adding code (toget=
her with
dev_links) to make sure we would return error in case the consumer tried to=
 access a
supplier callback and the supplier is no longer around. That meant a mutex =
for
syncing callbacks plus checking a pointer and having a kref for the backend=
 object.

Jonathan (rightfully) complained that I was adding two ways of guaranteeing=
 the same
thing. Thus, as we don't really have optional suppliers, we went with the e=
xplicit
links creation as it makes the code much simpler. If you have any interest,=
 look at
[1] (and let me know if there's any wrong assumption).=20

> > >=20
> >=20
> > Yeah, just realized MANAGED is not a valid flag one can pass to
> > device_link_add() :)
>=20
> If you don't pass the STATELESS flag, a link is assumed to be MANAGED.
> So, you can still create managed device links.
>=20

Yes, I realized that... Maybe even passing no flag would do the trick.

[1]: https://lore.kernel.org/linux-iio/8085910199d4b653edb61c51fc80a503ee50=
131d.camel@gmail.com/

- Nuno S=C3=A1

