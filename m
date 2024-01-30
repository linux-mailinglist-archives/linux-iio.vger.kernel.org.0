Return-Path: <linux-iio+bounces-2043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3918421F5
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517FE1C2452D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30965BD4;
	Tue, 30 Jan 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaabyXQV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223665BCD;
	Tue, 30 Jan 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611856; cv=none; b=en4FKND1bsyhdHQX+3DUHXRxaFpT831GxS7LonKrt/CsiJA5wQKr744jt+gqb/dG7fjlNY13cxK28TIzXVhlCJ6IA6OFurB2R/1rU7ks5Imrc6v2dLqTBQlpa8D022TAyrt3WxwRIIZ5sE2It64LsDVpkAqpYbh+FgLX16Cm6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611856; c=relaxed/simple;
	bh=V80v9Bd8VBakkpI7HAnNjr5CMMDFR7WUDlFAQRDUO88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QoqrJ8xmP99SKzPj+aKaqnxK8HRrCerBpaUMWGxu3V/67qU5pFaYdlxxC0BggIVazI5jFAgyu2nfKUG/lOiQmq2szxLqfWR6fadu/LBycrnF7K5w7YagCoDqsqBnkN0qV98oS5ZyVYJIus7V0C0CCJvb4CuGLJXojv5PqccPfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaabyXQV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b12dd21so2760487f8f.0;
        Tue, 30 Jan 2024 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706611852; x=1707216652; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V80v9Bd8VBakkpI7HAnNjr5CMMDFR7WUDlFAQRDUO88=;
        b=FaabyXQVjHpPqFv30DzU88skOKFC3naoS6H7LDpaGb/9hXzMJoYAs3RfwZYYm5fC7c
         N07TS2ahAWDjjdSOtayzr2U5B1lw+2sz+Wcjmrd9IYVXdJxyh+FgXIrLc4D3UElusO9X
         yGC9gqwlwaaRlrQ+vl+C6Ia5i50asr/YDRCpnLYaJGuV5xUFAUoaHLaOznXL/4HDXrrz
         8z1TMhsxNpI7yvK22WmPUIFCApQVm+Kg/EbDIhAMUcnuQN1xw2AECLRDENLeOsrP2whf
         IjaYzkM9Xv0YXTCmaTsEwNqX5syKpjN5vhNLhcuSQZpTUcedav7/+dEntlSIMFdhegME
         kGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611852; x=1707216652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V80v9Bd8VBakkpI7HAnNjr5CMMDFR7WUDlFAQRDUO88=;
        b=LwGPTgPwelFJMI5qskGRUqZHn0WIiSEoZbRByxR6d8y4UM0WE8kx5+RL8OYsyXF1rs
         uXt6IxKwSwiUdMNDfHJhlTpdDHsMLYt6c0VTtDrfx74vg2DJS7nuNHIJRmrqL4OzlHBj
         S6Le4x6oxZ1/Mowu9EBdKdHPnicPbK7JTyAeNGvHjq7AtP72FxCupCQASmlSTOGjDprJ
         S6xvgp9cIkOPVaId4lRBFkUJnXYLwgOXltJmWV5VQNFQX+pQORGJjq6KbmRbBZswvVnw
         ANHpVF8nI6iHzhwHvPy8my3kGezwhQJ2YmuHelMy6lbQ3IE8+z7N+qg6aWVoamJ9D6oV
         iNUg==
X-Gm-Message-State: AOJu0Yww50GI1hejU1u/azGcEWJQnNITUUeq4EsDCjyLqMgX4zd+fuWl
	l0I0a996v69NGbqJCkebl5Rr4O2/Ao2YTeRJgCc3qGBq7yKTH70q
X-Google-Smtp-Source: AGHT+IGLOB5zrg5rhfE1hEywKUyuhSeqjnVc77DsPJvXTn9NChyN7KGhlPZ7fMqcF0vXS1WCGGxoTg==
X-Received: by 2002:a5d:5222:0:b0:33a:d70a:1b83 with SMTP id i2-20020a5d5222000000b0033ad70a1b83mr6216639wra.70.1706611851997;
        Tue, 30 Jan 2024 02:50:51 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id fa8-20020a056000258800b0033afb7c68a7sm1337301wrb.55.2024.01.30.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:50:51 -0800 (PST)
Message-ID: <d9fe7b666da504746b2e0da8ca828bbcf1d4ecfe.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 30 Jan 2024 11:54:08 +0100
In-Reply-To: <CAGETcx-ngqdWQbRa15Xdig4TKi=eHMun3G25X2ymGhNsdfUufA@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
	 <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
	 <ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
	 <f6cfd587242001326ea6fdb9678359c1289202e5.camel@gmail.com>
	 <20240127151511.4763cd61@jic23-huawei>
	 <b119a1fbc5f50b77d135e8995be95e0b5bf05613.camel@gmail.com>
	 <CAGETcx-ngqdWQbRa15Xdig4TKi=eHMun3G25X2ymGhNsdfUufA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 14:31 -0800, Saravana Kannan wrote:
> On Mon, Jan 29, 2024 at 12:26=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> > On Sat, 2024-01-27 at 15:15 +0000, Jonathan Cameron wrote:
> > > On Fri, 26 Jan 2024 15:26:08 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >=20
> > > > On Fri, 2024-01-26 at 09:04 +0100, Nuno S=C3=A1 wrote:
> > > > > On Thu, 2024-01-25 at 17:57 +0100, Rafael J. Wysocki wrote:
> > > > > > On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nu=
no@gmail.com>
> > > > > > wrote:
> > > > > > >=20
> > > > > > > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
> > > > > > > >=20
> > > > > > > > Hi Saravana,
> > > > > > > >=20
> > > > > > > > Thanks for your feedback,
> > > > > > > >=20
> > > > > > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > > > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Re=
lay
> > > > > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > > > > > > >=20
> > > > > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > > >=20
> > > > > > > > > > If a device_link is previously created (eg: via
> > > > > > > > > > fw_devlink_create_devlink()) before the supplier + cons=
umer
> > > > > > > > > > are
> > > > > > > > > > both
> > > > > > > > > > present and bound to their respective drivers, there's =
no
> > > > > > > > > > way to
> > > > > > > > > > set
> > > > > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still=
 set
> > > > > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags ch=
ecks
> > > > > > > > > > to
> > > > > > > > > > allow
> > > > > > > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > > > > > > > >=20
> > > > > > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUM=
ER?
> > > > > > > > > Especially if fw_devlink already created the link? You ar=
e
> > > > > > > > > effectively
> > > > > > > > > trying to delete the link fw_devlink created if any of yo=
ur
> > > > > > > > > devices
> > > > > > > > > unbind.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Well, this is still useful in the modules case as the link =
will
> > > > > > > > be
> > > > > > > > relaxed
> > > > > > > > after
> > > > > > > > all devices are initialized and that will already clear
> > > > > > > > AUTOPROBE_CONSUMER
> > > > > > > > AFAIU. But, more importantly, if I'm not missing anything, =
in
> > > > > > > > [1],
> > > > > > > > fw_devlinks
> > > > > > > > will be dropped after the consumer + supplier are bound whi=
ch
> > > > > > > > means
> > > > > > > > I
> > > > > > > > definitely
> > > > > > > > want to create a link between my consumer and supplier.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Ok, so to add a bit more on this, there are two cases:
> > > > > > >=20
> > > > > > > 1) Both sup and con are modules and after boot up, the link i=
s
> > > > > > > relaxed
> > > > > > > and
> > > > > > > thus
> > > > > > > turned into a sync_state_only link. That means the link will =
be
> > > > > > > deleted
> > > > > > > anyways
> > > > > > > and AUTOPROBE_CONSUMER is already cleared by the time we try =
to
> > > > > > > change
> > > > > > > the
> > > > > > > link.
> > > > > > >=20
> > > > > > > 2) The built-in case where the link is kept as created by
> > > > > > > fw_devlink
> > > > > > > and
> > > > > > > this
> > > > > > > patch effectively clears AUTOPROBE_CONSUMER.
> > > > > > >=20
> > > > > > > Given the above, not sure what's the best option. I can think=
 of
> > > > > > > 4:
> > > > > > >=20
> > > > > > > 1) Drop this patch and leave things as they are.
> > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > > > is
> > > > > > > pretty much ignored in my call but it will turn the link in a
> > > > > > > MANAGED
> > > > > > > one
> > > > > > > and
> > > > > > > clear SYNC_STATE_ONLY. I could very well just pass 0 in the f=
lags
> > > > > > > as
> > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> > > > > > >=20
> > > > > > > 2) Rework this patch so we can still change an existing link =
to
> > > > > > > accept
> > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example)=
.
> > > > > > >=20
> > > > > > > However, instead of clearing AUTOPROBE_CONSUMER, I would add =
some
> > > > > > > checks
> > > > > > > so
> > > > > > > if
> > > > > > > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or
> > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > > > and
> > > > > > > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, r=
ight
> > > > > > > now,
> > > > > > > I
> > > > > > > think
> > > > > > > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags en=
ds
> > > > > > > ups
> > > > > > > with
> > > > > > > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is n=
ot
> > > > > > > allowed...
> > > > > >=20
> > > > > > No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the li=
nk
> > > > > > flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there an=
d the
> > > > > > former replaces the latter.
> > > > > >=20
> > > > >=20
> > > > > Oh yes, I missed that extra if() against the
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > > flag...
> > > > >=20
> > > > > > Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flag=
s if
> > > > > > AUTOPROBE_CONSUMER is set in there.
> > > > > >=20
> > > > > > > 3) Keep it as-is... This one is likely a NACK as I'm getting =
the
> > > > > > > feeling
> > > > > > > that
> > > > > > > clearing stuff that might have been created by fw_devlinks is
> > > > > > > probably
> > > > > > > a
> > > > > > > no-
> > > > > > > go.
> > > > > > >=20
> > > > > > > Let me know your thoughts...
> > > > > >=20
> > > > > > If the original creator of the link didn't indicate either
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, th=
ey
> > > > > > are
> > > > > > expected to need the link to stay around until it is explicitly
> > > > > > deleted.
> > > > > >=20
> > > > > > Therefore adding any of these flags for an existing link where =
they
> > > > > > both are unset would be a mistake, because it would effectively
> > > > > > cause
> > > > > > the link to live shorter than expected by the original creator =
and
> > > > > > that might lead to correctness issues.
> > > > > >=20
> > > > > > Thanks!
> > > > >=20
> > > > > Thanks Rafael, your last two paragraphs make it really clear what=
's
> > > > > the
> > > > > reasoning and why this patch is wrong.
> > > > >=20
> > > > > Jonathan, if nothing else comes that I need a re-spin, can you dr=
op
> > > > > this
> > > > > patch
> > > > > when applying?
> > > > >=20
> > > > > I think we can keep the DL_FLAG_AUTOREMOVE_CONSUMER in the
> > > > > device_link_add()
> > > > > call as it will be ignored if fw_devlinks already created the lin=
k but
> > > > > might
> > > > > be
> > > > > important if the kernel command line fw_devlink is set to 'off'.
> > > > >=20
> > > > > Or maybe, as Saravan mentioned in his reply we can just pass
> > > > > DL_FLAG_MANAGED
> > > > > as
> > > >=20
> > > > Forget about this as I just realized DL_FLAG_MANAGED is not a prope=
r
> > > > flag we
> > > > can
> > > > pass...
> > > >=20
> > > > - Nuno S=C3=A1
> > > >=20
> > >=20
> > > Discussion has gotten too complex - so even if no changes, send a v8
> > > dropping
> > > the patch (assuming that's the end conclusion!)
> > >=20
> >=20
> > Dropping the patch is pretty much decided is the right thing to do. The=
 only
> > thing I'm still thinking is that if I should use AUTOPROBE_CONSUMER (as
> > fw_devlinks) instead when creating the link. With that flag, any IIO
> > consumer of
> > the IIO backend will be automatically probed as soon as the backend is
> > probed.
> > It also has the advantage of keeping the link around (vs AUREMOVE_CONSU=
MER
> > which
> > deletes the link when the IIO consumer is gone) so in the re-bind case =
we
> > can
> > avoid useless EPROBE_DEFERs.
> >=20
> > It's a nitpicky thing in the end and not really that important. Moreove=
r
> > because
> > I expect that in 99% of the usecases, fw_devlinks will already create o=
ur
> > link
> > so the flags we pass in our call don't really matter. Note that our exp=
licit
> > call is still important (as I explained to Saravan in another email) as=
 we
> > based
> > the design with the assumption that the consumer can never be around wi=
thout
> > the
> > backend. And in the case we have modules, we can have the links created=
 by
> > fw_devlinks removed unless we explicitly call device_link_add() (and th=
at
> > would
> > mean our previous assumptions are no longer valid).
>=20
> I saw your reasoning, but technically there are still gaps in the
> forced unbinding of consumers. If the consumer doesn't have a bus or
> doesn't have an explicit driver, it won't be force unbound. But this

It will never be the case for us. An IIO frontend (the consumer in here) wi=
ll
always be on a bus (typically spi or i2c) and have a driver. In fact, the I=
IO
ABI should be registered in this device.

> is all generic issues that need to be resolved at a driver core level.
> I'd really prefer drivers/frameworks not duplicating it all over.
>=20
> How about just checking for fw_devlink=3Don or better and not probe your
> supplier if it's not set? Or not allow unbinding your supplier if
> fw_devlink=3Don or better isn't there?
>=20

The problem with that is that we still want our IIO converter to work
even if fw_devlink is off (but if having the links is ever an issue - which
shouldn't be - then I should not be using the links already). but most
importantly, we would also need to put similar constrains and check the def=
erred
timeout parameter otherwise we could not rely on the links in the modules c=
ase.

I see your concern about drivers/frameworks doing unnecessary calls but, at
least, in here we do have a reason to rely on it and the simplification cod=
e it
gives us, really pays off. You mention we also need some fixes in the core =
so
maybe when we are in a better state I can drop the explicit call.

Also thinking in your suggestion, what I could do is not allow the IIO back=
end
to be registered in case fw_links are off or permissive (and hence the supp=
lier
should never probe). But then, we would also need to care about the module =
case
and I'm not seeing this checks being better than the explicit call, honestl=
y.

To sum it up, I would be fine with the constrain for the built-in case but =
we
definitely want things to work when compiled as modules. And the checks in =
there
would be odd (or telling users that they need to add that command line
parameter)

- Nuno S=C3=A1




