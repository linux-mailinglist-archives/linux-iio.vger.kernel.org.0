Return-Path: <linux-iio+bounces-2006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81973840005
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 09:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D59283928
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3C537F1;
	Mon, 29 Jan 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Dn+Ypc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B554679;
	Mon, 29 Jan 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516770; cv=none; b=XL0bYORIFHcaTGqtYUYxiwmIhzMD/Jkd9Ur4ISJldJmGAkxNlRhQ3BfTVNYz89gy5bB2QPEX0fOWskTnslzUtHKMtRcI+Au1Jj9nZhU7pP0IdLNvak60asMPv5xnhE7W/kSqlvPxoR4o1Bztr6FmOAAjNxCr98OseQ3V/vLh9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516770; c=relaxed/simple;
	bh=+VJrF1WdLLxvDRKuF93xTUcEPpjeJ+F1jPbs0GIt0Dc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3apUsG8s3IkDXQu7Y270cDpjUZDRXVPi2FimctyXBs9oV5+k3svSmTQvk5HBfYZWCuMEjMtkwYBCe7LFLXFsPvHAwgZ21qDqPLz4JVF8QpIyNY2SoqcWpeMYIeRUm4pTHYPwjBTIrSecWv/kj63QGpujO6V9XjJtvg0F9uXg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Dn+Ypc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a354408e6bfso241639166b.1;
        Mon, 29 Jan 2024 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706516767; x=1707121567; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+VJrF1WdLLxvDRKuF93xTUcEPpjeJ+F1jPbs0GIt0Dc=;
        b=l5Dn+YpcA23PPJInAF78qN/zyf/P4DhkVJaScZkoJg+EqK7lwHJ+CrdAPtjCdAlWhx
         v2tisCPdGdctV+62QNpb2dm1d7ubzpfPOz39OIj3vojrD43BGoYtXLDGmRGyU/gcX784
         RN22+7kiTYQhY2UQ8vk6xoZKq9c9O5Gv8ix5BajzfYybV1hsAL07au5qP5V0DE4pbnp9
         FZTFQ6/mHOioc7FGUN8y99Rsq5XMGEItcxM0ShTs8jlLNVBDj+L/rpm1she4G1alymKV
         9PbAwxgWKM+4zldP6X8Xpa/ZEusGkItZAYtp9H8bJgEOZSJVeCXk2inj9erMP0+OSrlu
         U2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516767; x=1707121567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VJrF1WdLLxvDRKuF93xTUcEPpjeJ+F1jPbs0GIt0Dc=;
        b=EPbKLIHbNR3BcvVZSEEOgAj8mzSeOGvez0PWdd1kdN0Ex2twS6JM/m8T6auFP5ei9f
         T+FcjFG7dd/YfdEQXwdrQrR6FNiFuKCESPcVE6i9YCdQ1KWFmAHHqvR21vfqh+Xpv//u
         Dkq4IOxVEzwNSXBK4LNJS6zn+ezulLvx5mzUPmyPYy8K5KsxvxzxfPS0HxsSmQ1HXeSb
         XJsLdbxQZd3ZAPDADQJIB7fW2r4BKa2DMfthC+EyzKr+O8InPrz+CNlrUKsltMlQc9CG
         ohAIEY+DdykAUcqqtXewjWcxOx2zAY71An2F3BBDntQJ3sK5IEz+iVW6ErGgoiF+oMf2
         gEGw==
X-Gm-Message-State: AOJu0YxM5UApuPwTDblHihpH79Ap8Y6YCmDtTFfwDlUt2b7UMtZrx4zf
	fDnVv9i4i+V3oZ8Tt/09St+b0drefypZLLu11oEun23HgXrAuOuJ
X-Google-Smtp-Source: AGHT+IHwm6NBwZc535gjo1NkSmAh0QPivN7JK4ksolBBiRjkiwCokdZNVM1xbtLPF+pwuXXzzfO0FQ==
X-Received: by 2002:a17:906:468e:b0:a35:d634:ed70 with SMTP id a14-20020a170906468e00b00a35d634ed70mr833775ejr.31.1706516766720;
        Mon, 29 Jan 2024 00:26:06 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id pv13-20020a170907208d00b00a35b708185esm840011ejb.71.2024.01.29.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:26:06 -0800 (PST)
Message-ID: <b119a1fbc5f50b77d135e8995be95e0b5bf05613.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan
 <saravanak@google.com>, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 29 Jan 2024 09:29:23 +0100
In-Reply-To: <20240127151511.4763cd61@jic23-huawei>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
	 <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
	 <ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
	 <f6cfd587242001326ea6fdb9678359c1289202e5.camel@gmail.com>
	 <20240127151511.4763cd61@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-27 at 15:15 +0000, Jonathan Cameron wrote:
> On Fri, 26 Jan 2024 15:26:08 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Fri, 2024-01-26 at 09:04 +0100, Nuno S=C3=A1 wrote:
> > > On Thu, 2024-01-25 at 17:57 +0100, Rafael J. Wysocki wrote:=C2=A0=20
> > > > On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:=C2=A0=20
> > > > >=20
> > > > > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > >=20
> > > > > > Hi Saravana,
> > > > > >=20
> > > > > > Thanks for your feedback,
> > > > > >=20
> > > > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:=C2=A0=
=20
> > > > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:=C2=A0=20
> > > > > > > >=20
> > > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > > >=20
> > > > > > > > If a device_link is previously created (eg: via
> > > > > > > > fw_devlink_create_devlink()) before the supplier + consumer=
 are
> > > > > > > > both
> > > > > > > > present and bound to their respective drivers, there's no w=
ay to
> > > > > > > > set
> > > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks=
 to
> > > > > > > > allow
> > > > > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.=C2=A0=20
> > > > > > >=20
> > > > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > > > > Especially if fw_devlink already created the link? You are
> > > > > > > effectively
> > > > > > > trying to delete the link fw_devlink created if any of your
> > > > > > > devices
> > > > > > > unbind.
> > > > > > > =C2=A0=20
> > > > > >=20
> > > > > > Well, this is still useful in the modules case as the link will=
 be
> > > > > > relaxed
> > > > > > after
> > > > > > all devices are initialized and that will already clear
> > > > > > AUTOPROBE_CONSUMER
> > > > > > AFAIU. But, more importantly, if I'm not missing anything, in [=
1],
> > > > > > fw_devlinks
> > > > > > will be dropped after the consumer + supplier are bound which m=
eans
> > > > > > I
> > > > > > definitely
> > > > > > want to create a link between my consumer and supplier.
> > > > > > =C2=A0=20
> > > > >=20
> > > > > Ok, so to add a bit more on this, there are two cases:
> > > > >=20
> > > > > 1) Both sup and con are modules and after boot up, the link is re=
laxed
> > > > > and
> > > > > thus
> > > > > turned into a sync_state_only link. That means the link will be
> > > > > deleted
> > > > > anyways
> > > > > and AUTOPROBE_CONSUMER is already cleared by the time we try to c=
hange
> > > > > the
> > > > > link.
> > > > >=20
> > > > > 2) The built-in case where the link is kept as created by fw_devl=
ink
> > > > > and
> > > > > this
> > > > > patch effectively clears AUTOPROBE_CONSUMER.
> > > > >=20
> > > > > Given the above, not sure what's the best option. I can think of =
4:
> > > > >=20
> > > > > 1) Drop this patch and leave things as they are.
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > is
> > > > > pretty much ignored in my call but it will turn the link in a MAN=
AGED
> > > > > one
> > > > > and
> > > > > clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags=
 as
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> > > > >=20
> > > > > 2) Rework this patch so we can still change an existing link to a=
ccept
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
> > > > >=20
> > > > > However, instead of clearing AUTOPROBE_CONSUMER, I would add some
> > > > > checks
> > > > > so
> > > > > if
> > > > > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > and
> > > > > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right=
 now,
> > > > > I
> > > > > think
> > > > > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends u=
ps
> > > > > with
> > > > > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not
> > > > > allowed...=C2=A0=20
> > > >=20
> > > > No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the link
> > > > flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there and th=
e
> > > > former replaces the latter.
> > > > =C2=A0=20
> > >=20
> > > Oh yes, I missed that extra if() against the DL_FLAG_AUTOREMOVE_CONSU=
MER
> > > flag...
> > > =C2=A0=20
> > > > Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flags if
> > > > AUTOPROBE_CONSUMER is set in there.
> > > > =C2=A0=20
> > > > > 3) Keep it as-is... This one is likely a NACK as I'm getting the
> > > > > feeling
> > > > > that
> > > > > clearing stuff that might have been created by fw_devlinks is pro=
bably
> > > > > a
> > > > > no-
> > > > > go.
> > > > >=20
> > > > > Let me know your thoughts...=C2=A0=20
> > > >=20
> > > > If the original creator of the link didn't indicate either
> > > > DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, they a=
re
> > > > expected to need the link to stay around until it is explicitly
> > > > deleted.
> > > >=20
> > > > Therefore adding any of these flags for an existing link where they
> > > > both are unset would be a mistake, because it would effectively cau=
se
> > > > the link to live shorter than expected by the original creator and
> > > > that might lead to correctness issues.
> > > >=20
> > > > Thanks!=C2=A0=20
> > >=20
> > > Thanks Rafael, your last two paragraphs make it really clear what's t=
he
> > > reasoning and why this patch is wrong.
> > >=20
> > > Jonathan, if nothing else comes that I need a re-spin, can you drop t=
his
> > > patch
> > > when applying?
> > >=20
> > > I think we can keep the DL_FLAG_AUTOREMOVE_CONSUMER in the
> > > device_link_add()
> > > call as it will be ignored if fw_devlinks already created the link bu=
t
> > > might
> > > be
> > > important if the kernel command line fw_devlink is set to 'off'.
> > >=20
> > > Or maybe, as Saravan mentioned in his reply we can just pass
> > > DL_FLAG_MANAGED
> > > as=C2=A0=20
> >=20
> > Forget about this as I just realized DL_FLAG_MANAGED is not a proper fl=
ag we
> > can
> > pass...
> >=20
> > - Nuno S=C3=A1
> >=20
>=20
> Discussion has gotten too complex - so even if no changes, send a v8 drop=
ping
> the patch (assuming that's the end conclusion!)
>=20

Dropping the patch is pretty much decided is the right thing to do. The onl=
y
thing I'm still thinking is that if I should use AUTOPROBE_CONSUMER (as
fw_devlinks) instead when creating the link. With that flag, any IIO consum=
er of
the IIO backend will be automatically probed as soon as the backend is prob=
ed.
It also has the advantage of keeping the link around (vs AUREMOVE_CONSUMER =
which
deletes the link when the IIO consumer is gone) so in the re-bind case we c=
an
avoid useless EPROBE_DEFERs.=C2=A0

It's a nitpicky thing in the end and not really that important. Moreover be=
cause
I expect that in 99% of the usecases, fw_devlinks will already create our l=
ink
so the flags we pass in our call don't really matter. Note that our explici=
t
call is still important (as I explained to Saravan in another email) as we =
based
the design with the assumption that the consumer can never be around withou=
t the
backend. And in the case we have modules, we can have the links created by
fw_devlinks removed unless we explicitly call device_link_add() (and that w=
ould
mean our previous assumptions are no longer valid).


- Nuno S=C3=A1


