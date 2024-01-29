Return-Path: <linux-iio+bounces-2038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4178B8415A7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22A7B2397A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84250A6B;
	Mon, 29 Jan 2024 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpDdf5gh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09624F1F8
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567527; cv=none; b=NjRoAGf/m2Mz88qjHJgDwuhaPNjdZ0nQoCVLNrXdyBk+y1uwXL6UBtuhDelIvz/tWrSuNw1byT3inFcnHrGefciEBHiH0z4pZXIMan2QGYA8yDJpdXFuzaDIbhFbaUS6Fx0DjtiGcsZRCAnK3vQZr0SNW6OVI7O4wHOiiw9Byn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567527; c=relaxed/simple;
	bh=F8DglcXYBwsrEN3IcXaHlZ/7nENevKG6ZImG/ubdKK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOBA9f252ivEB9MMyrIajpBpHDKYlR3oAmjQNmA3KPE/qFLWzqoCdhf5Sn0sah4raGtpLtaYXyfXl9RDVLwH8tlb82oViR3QuRz/mBQtCwmNnhurfU2HHuKAhhZnPYh6Y71Q6zxM1ZxVqFo9VkM0RsbevUcr3d9i4+hujd1wnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpDdf5gh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-428405a0205so39841cf.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 14:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706567524; x=1707172324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8DglcXYBwsrEN3IcXaHlZ/7nENevKG6ZImG/ubdKK0=;
        b=CpDdf5ghxG0TakQE2sXS/sWUXuvMgKZSKtLQcUklzMslC3lvZP3WN9Wf3U8NO0ECcB
         3cXIwityY7QxJOKnFmhE/eLhf2Sc9pDR4NxtG70N68ALZN6keFx1HuV2RtUt5AXTh1rw
         OPDT/gu240bewxgM/1SZaKCU9/tdlq0qgr75oLPPQ2uZIiE17TmexjHp4ai9/pCWz2o+
         iGuThAC6GT8SUYtNc0qssjqlB8au/49cz9W6sXKmPtBzzU1iLYb8zezlkowZD7LS10lz
         eihiC5uLUDXhXbsvJnKU760Xm9t7oCywzJyv//hasixnlxUEQBLjMlrPvKTMx2eZBv7n
         qEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567524; x=1707172324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8DglcXYBwsrEN3IcXaHlZ/7nENevKG6ZImG/ubdKK0=;
        b=PUkgoRjyHvCnY896Z4SSZfVFDecQPLc27v6UFMz0olqg1pDkRysMV7AQnuK7MOMpZg
         ydp/kqP4PK8fVpes5q1qI9oFXS8//5XaNS809FKYJ7rSwKSWaaFWAaWeITnjpmtdOI0u
         5r1RyU29gT20tUWxquZcN0VT/+YiHbtHPk2/aKt8LKSPHpDEvZXnHxjSCWDizmKa6O5n
         ShSCFEauxDv7zGfBCHNYZIEyqsnPwebKvcw6TailBX3DjnkMO/qrU9seL1kIT9kkWDXt
         BRBMKrmZVOVoxnETixTLaY2wnyQH4XEcaY0MCvTc2ZKUkY+AjGADcJTo4p+5Fujq5XiL
         p8lA==
X-Gm-Message-State: AOJu0Yz4rdGDnQlJyb7WENLhvdbLeS9pXvbaAS6qSKNKexu+A7h9SKqm
	6yohMOk1f/XsCxwf8eCLXWoU9Tr/cdbHxH0S7wdpA1Oci1QLiqfJVsV9BNX5ttJe9lDVM0FLl0n
	wnDwwlOvNIR8fNFQLgyViYky0dgFxSU8RqMEh
X-Google-Smtp-Source: AGHT+IGiZNNE6BaVG8vbktDdhW44MXb1wj33xVcd47qI2ESuKPKBzdZhfCCrc0k5xPyqFw/B45BkDfJyI6Kn6IjkdoQ=
X-Received: by 2002:a05:622a:470e:b0:42a:a1bf:d780 with SMTP id
 dn14-20020a05622a470e00b0042aa1bfd780mr84205qtb.10.1706567524303; Mon, 29 Jan
 2024 14:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-4-1bff236b8693@analog.com> <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
 <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
 <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
 <ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
 <f6cfd587242001326ea6fdb9678359c1289202e5.camel@gmail.com>
 <20240127151511.4763cd61@jic23-huawei> <b119a1fbc5f50b77d135e8995be95e0b5bf05613.camel@gmail.com>
In-Reply-To: <b119a1fbc5f50b77d135e8995be95e0b5bf05613.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 29 Jan 2024 14:31:25 -0800
Message-ID: <CAGETcx-ngqdWQbRa15Xdig4TKi=eHMun3G25X2ymGhNsdfUufA@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:26=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> On Sat, 2024-01-27 at 15:15 +0000, Jonathan Cameron wrote:
> > On Fri, 26 Jan 2024 15:26:08 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >
> > > On Fri, 2024-01-26 at 09:04 +0100, Nuno S=C3=A1 wrote:
> > > > On Thu, 2024-01-25 at 17:57 +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nuno=
@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
> > > > > > >
> > > > > > > Hi Saravana,
> > > > > > >
> > > > > > > Thanks for your feedback,
> > > > > > >
> > > > > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Rela=
y
> > > > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > >
> > > > > > > > > If a device_link is previously created (eg: via
> > > > > > > > > fw_devlink_create_devlink()) before the supplier + consum=
er are
> > > > > > > > > both
> > > > > > > > > present and bound to their respective drivers, there's no=
 way to
> > > > > > > > > set
> > > > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still s=
et
> > > > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags chec=
ks to
> > > > > > > > > allow
> > > > > > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > > > > > > >
> > > > > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER=
?
> > > > > > > > Especially if fw_devlink already created the link? You are
> > > > > > > > effectively
> > > > > > > > trying to delete the link fw_devlink created if any of your
> > > > > > > > devices
> > > > > > > > unbind.
> > > > > > > >
> > > > > > >
> > > > > > > Well, this is still useful in the modules case as the link wi=
ll be
> > > > > > > relaxed
> > > > > > > after
> > > > > > > all devices are initialized and that will already clear
> > > > > > > AUTOPROBE_CONSUMER
> > > > > > > AFAIU. But, more importantly, if I'm not missing anything, in=
 [1],
> > > > > > > fw_devlinks
> > > > > > > will be dropped after the consumer + supplier are bound which=
 means
> > > > > > > I
> > > > > > > definitely
> > > > > > > want to create a link between my consumer and supplier.
> > > > > > >
> > > > > >
> > > > > > Ok, so to add a bit more on this, there are two cases:
> > > > > >
> > > > > > 1) Both sup and con are modules and after boot up, the link is =
relaxed
> > > > > > and
> > > > > > thus
> > > > > > turned into a sync_state_only link. That means the link will be
> > > > > > deleted
> > > > > > anyways
> > > > > > and AUTOPROBE_CONSUMER is already cleared by the time we try to=
 change
> > > > > > the
> > > > > > link.
> > > > > >
> > > > > > 2) The built-in case where the link is kept as created by fw_de=
vlink
> > > > > > and
> > > > > > this
> > > > > > patch effectively clears AUTOPROBE_CONSUMER.
> > > > > >
> > > > > > Given the above, not sure what's the best option. I can think o=
f 4:
> > > > > >
> > > > > > 1) Drop this patch and leave things as they are.
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > > is
> > > > > > pretty much ignored in my call but it will turn the link in a M=
ANAGED
> > > > > > one
> > > > > > and
> > > > > > clear SYNC_STATE_ONLY. I could very well just pass 0 in the fla=
gs as
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> > > > > >
> > > > > > 2) Rework this patch so we can still change an existing link to=
 accept
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
> > > > > >
> > > > > > However, instead of clearing AUTOPROBE_CONSUMER, I would add so=
me
> > > > > > checks
> > > > > > so
> > > > > > if
> > > > > > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > > and
> > > > > > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, rig=
ht now,
> > > > > > I
> > > > > > think
> > > > > > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends=
 ups
> > > > > > with
> > > > > > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not
> > > > > > allowed...
> > > > >
> > > > > No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the link
> > > > > flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there and =
the
> > > > > former replaces the latter.
> > > > >
> > > >
> > > > Oh yes, I missed that extra if() against the DL_FLAG_AUTOREMOVE_CON=
SUMER
> > > > flag...
> > > >
> > > > > Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flags =
if
> > > > > AUTOPROBE_CONSUMER is set in there.
> > > > >
> > > > > > 3) Keep it as-is... This one is likely a NACK as I'm getting th=
e
> > > > > > feeling
> > > > > > that
> > > > > > clearing stuff that might have been created by fw_devlinks is p=
robably
> > > > > > a
> > > > > > no-
> > > > > > go.
> > > > > >
> > > > > > Let me know your thoughts...
> > > > >
> > > > > If the original creator of the link didn't indicate either
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, they=
 are
> > > > > expected to need the link to stay around until it is explicitly
> > > > > deleted.
> > > > >
> > > > > Therefore adding any of these flags for an existing link where th=
ey
> > > > > both are unset would be a mistake, because it would effectively c=
ause
> > > > > the link to live shorter than expected by the original creator an=
d
> > > > > that might lead to correctness issues.
> > > > >
> > > > > Thanks!
> > > >
> > > > Thanks Rafael, your last two paragraphs make it really clear what's=
 the
> > > > reasoning and why this patch is wrong.
> > > >
> > > > Jonathan, if nothing else comes that I need a re-spin, can you drop=
 this
> > > > patch
> > > > when applying?
> > > >
> > > > I think we can keep the DL_FLAG_AUTOREMOVE_CONSUMER in the
> > > > device_link_add()
> > > > call as it will be ignored if fw_devlinks already created the link =
but
> > > > might
> > > > be
> > > > important if the kernel command line fw_devlink is set to 'off'.
> > > >
> > > > Or maybe, as Saravan mentioned in his reply we can just pass
> > > > DL_FLAG_MANAGED
> > > > as
> > >
> > > Forget about this as I just realized DL_FLAG_MANAGED is not a proper =
flag we
> > > can
> > > pass...
> > >
> > > - Nuno S=C3=A1
> > >
> >
> > Discussion has gotten too complex - so even if no changes, send a v8 dr=
opping
> > the patch (assuming that's the end conclusion!)
> >
>
> Dropping the patch is pretty much decided is the right thing to do. The o=
nly
> thing I'm still thinking is that if I should use AUTOPROBE_CONSUMER (as
> fw_devlinks) instead when creating the link. With that flag, any IIO cons=
umer of
> the IIO backend will be automatically probed as soon as the backend is pr=
obed.
> It also has the advantage of keeping the link around (vs AUREMOVE_CONSUME=
R which
> deletes the link when the IIO consumer is gone) so in the re-bind case we=
 can
> avoid useless EPROBE_DEFERs.
>
> It's a nitpicky thing in the end and not really that important. Moreover =
because
> I expect that in 99% of the usecases, fw_devlinks will already create our=
 link
> so the flags we pass in our call don't really matter. Note that our expli=
cit
> call is still important (as I explained to Saravan in another email) as w=
e based
> the design with the assumption that the consumer can never be around with=
out the
> backend. And in the case we have modules, we can have the links created b=
y
> fw_devlinks removed unless we explicitly call device_link_add() (and that=
 would
> mean our previous assumptions are no longer valid).

I saw your reasoning, but technically there are still gaps in the
forced unbinding of consumers. If the consumer doesn't have a bus or
doesn't have an explicit driver, it won't be force unbound. But this
is all generic issues that need to be resolved at a driver core level.
I'd really prefer drivers/frameworks not duplicating it all over.

How about just checking for fw_devlink=3Don or better and not probe your
supplier if it's not set? Or not allow unbinding your supplier if
fw_devlink=3Don or better isn't there?

-Saravana

