Return-Path: <linux-iio+bounces-1930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143283E10F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB7D1F261D7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7A208B4;
	Fri, 26 Jan 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJqWUt1I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB520DE1
	for <linux-iio@vger.kernel.org>; Fri, 26 Jan 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292596; cv=none; b=kX3zn24ICwROPlkiHVwuvLpfyntoiiOhzKh8mHJFV8wyVYvV8F57btQL7rh/zOwEoq5uTy+7ysDd3tIC/RI6m7Qb7niietjF8qapjgVhYdp76vfg+NQ3JWrMyuBRC7IUqG8iKanbYtPcA0heYuVM8cxrqTj/n1Hr7PUDPyyY9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292596; c=relaxed/simple;
	bh=IApN5jeDzJFeUDMG9m9MSuW8aJpOPCcJcvFopWbIyTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3WSo2Dd5FOqoLDTwW/4XgCXn3UbJ7Ocvjsm3AjzKW+MbROCEbFxwL2JD9xBe3I1KqL8vBf2hR/4o0WNy+1QO9vD0E0ImYMO9oKTn43JfI0tLD9VSrvBNo8Yq9Ies0nHZUSv7fm03/iCdG3qylgzceoW2Mwl1sbSPx32VKXZgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJqWUt1I; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so5241cf.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jan 2024 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706292593; x=1706897393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IApN5jeDzJFeUDMG9m9MSuW8aJpOPCcJcvFopWbIyTc=;
        b=NJqWUt1IAoy/KdHO4BcDS2OiX1HSYSBjZ54O18jURVEBz8fKru/2FKjeMzga82Ok9J
         XQXhDFuLQf4w7zZMKBocl7ZkJZez7RoxVQjLC2EV98dK9n0abCgAuTeiF9zpR1yvpUAZ
         BRr4WPt58SuHldnNiY0XAYgd/pPibMG/961izp1xl+3w98bQd92p3b1s411YD9cCrE0y
         upTeC7NW91oWl8sVh009yCXvaDOpwuvAjCknnTtPHaXw2MZPOsoxggQTXzG9wBlfsueZ
         FICAsHx5XaOWTnL3O/VEHeARYegh0e3p5Gqc0Imss0mR12aI6pf27D8lKYKuwQ63tq9E
         i/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292593; x=1706897393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IApN5jeDzJFeUDMG9m9MSuW8aJpOPCcJcvFopWbIyTc=;
        b=Gt7i+rjETAzxidlyHNEs0LAlTmrrpuEU+NzCo5yqWsYin+5gE0ojT4dCOuYkTHHvvN
         tbniFQ3it15QBthz/t2b9jqVKXdRaR8IgQICso0ae4MXsyfI6lVOJdpYuY9DnTGgC/uG
         YLQkIiOKCchk3o+teUcfy8YU/SAfWOQK59IYdT75ji8oniEYoMkJuf/Dnt4NvXVtA6Nu
         N2itc4XEQjjtyrgf6Sd68E1BshhQav4we9UZAZ6jRH1OegmUDfOzbY/YksTZfF3/NfnL
         9CfUrNb4QE3da2Y+f8lpV83owIfW9qmUT/IxBqqL5HIvzBMMrCUqYW49Zjhmt5m0xub0
         kBIQ==
X-Gm-Message-State: AOJu0YwwIMfBS2edLSX5EGK9TM2/ouojhdYnfJRbZlWiSeDr1hBu8rPE
	FPyBZrWLMnEwZO+VoNQRuFnEpnv5KvHSIdweNEIYWayvUcR74nxkWnjcS9URfD2FH2DMpOl/aop
	WORrrv1xCgZMjK683Kcv2YKWy/IvBcRP5cR8/
X-Google-Smtp-Source: AGHT+IHZyNsxPB0vf1l+a3JL0IxifsSg1TT1JukI6eVph+diAKXGvURUDfqHRQHz8xvr+w06DI7qli1x9UYLzckitd0=
X-Received: by 2002:a05:622a:4c0f:b0:42a:2976:8a7a with SMTP id
 ey15-20020a05622a4c0f00b0042a29768a7amr325741qtb.10.1706292593090; Fri, 26
 Jan 2024 10:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-4-1bff236b8693@analog.com> <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
 <CAGETcx_ScsW4gKpAK01dHYxB3XGs-pRjJQMygbZUNAdxV6BqtA@mail.gmail.com>
 <865346908c9b76d72741e6f319a4535459de1ea6.camel@gmail.com> <c459cc6766b741892cdf9de0b50832023eb4196d.camel@gmail.com>
In-Reply-To: <c459cc6766b741892cdf9de0b50832023eb4196d.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 26 Jan 2024 10:09:13 -0800
Message-ID: <CAGETcx_TXTddsExr+7hq9VWY518Qoai_YQ9u1Jb3WPihAK5fqg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:24=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Fri, 2024-01-26 at 09:13 +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-01-25 at 16:50 -0800, Saravana Kannan wrote:
> > > On Thu, Jan 25, 2024 at 12:11=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gm=
ail.com> wrote:
> > > >
> > > >
> > > > Hi Saravana,
> > > >
> > > > Thanks for your feedback,
> > > >
> > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > > >
> > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > >
> > > > > > If a device_link is previously created (eg: via
> > > > > > fw_devlink_create_devlink()) before the supplier + consumer are=
 both
> > > > > > present and bound to their respective drivers, there's no way t=
o set
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to =
allow
> > > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > > > >
> > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > > Especially if fw_devlink already created the link? You are effect=
ively
> > > > > trying to delete the link fw_devlink created if any of your devic=
es
> > > > > unbind.
> > > > >
> > > >
> > > > Well, this is still useful in the modules case as the link will be =
relaxed
> > > > after
> > > > all devices are initialized and that will already clear AUTOPROBE_C=
ONSUMER
> > > > AFAIU. But, more importantly, if I'm not missing anything, in [1],
> > > > fw_devlinks
> > > > will be dropped after the consumer + supplier are bound which means=
 I
> > > > definitely
> > > > want to create a link between my consumer and supplier.
> > > >
> > > > FWIW, I was misunderstanding things since I thought
> > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > was needed to make sure the consumer is unbound before the supplier=
. But
> > > > for
> > > > that I think I can even pass 0 in the flags as I only need the link=
 to be
> > > > MANAGED. Still, I think having DL_FLAG_AUTOREMOVE_CONSUMER makes se=
nse.
> > >
> > > As you noticed, your understanding of DL_FLAG_AUTOREMOVE_CONSUMER is
> > > not correct. There's almost never a good reason to drop a device link=
.
> > > Even when a device/driver are unbound, we still want future probe
> > > attempts to make use of the dependency info and block a device from
> > > probing if the supplier hasn't probed.
> > >
> >
> > Yeah that makes sense and is making me thinking that I should change my=
 call
> > (in
> > patch 7 to use the MANAGED flag instead of AUTOREMOVE_CONSUMER). Sure,
> > AUTOREMOVE_CONSUMER won't matter most cases but if someone disables
> > fw_devlinks
> > then it matters.

I don't fully understand the patch series, but what exactly are you
gaining by adding device links explicitly. I'd rather that every
driver didn't explicitly create a device link. That's just a lot of
useless code in most cases and we shouldn't have useless code lying
around. If someone does fw_devlink=3Doff and you don't create a device
link explicitly, what's the worst that's going to happen? Useless
deferred probes? fw_devlink is really only there as a debug tool at
this point -- I don't think you need to worry about people setting it
to off/permissive.

> >
>
> Yeah, just realized MANAGED is not a valid flag one can pass to
> device_link_add() :)

If you don't pass the STATELESS flag, a link is assumed to be MANAGED.
So, you can still create managed device links.

-Saravana

