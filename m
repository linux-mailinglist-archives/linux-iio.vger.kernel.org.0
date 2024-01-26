Return-Path: <linux-iio+bounces-1924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A181083DBA1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 15:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BEEB260F0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D561C28F;
	Fri, 26 Jan 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxFlbT0i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E01B599;
	Fri, 26 Jan 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278977; cv=none; b=CVN/1Z8a2hl7DndME+ytV6NM+ZqY/Sf/1vzVzqTRqLo9aZqjg3u/1nkjj/ZgfSpNdlugRjCBYxfnNtgdKkt9Cy8W/CJtWX0n0ogd6V+D+3B9WSRKKCGU49Fv+NZ89l5LPla8Y1FKU4IsnJ/lS0eHBQUiYafYeylv7J552mHkDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278977; c=relaxed/simple;
	bh=5G4B/lNexcW+sZP3Jt2tcL3vHwChvmnMyh8NP6t8UaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VlUGf/r0PwjqcuXna1Lz30pAeoGbco9Y1RdGkEDfMyFn9zSsXtnhJMH2otRqZmjHe3CuMEjnEKY0BnJYD6Slv1E+Ljj2ctpIC7lZjPNMFVW6YllgaFVgigMWHup2sGoPLE1/hko70NJA4/KaJc9f3Wq2LWU+mOdTz+wKM9dDAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxFlbT0i; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso4428751fa.3;
        Fri, 26 Jan 2024 06:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706278974; x=1706883774; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5G4B/lNexcW+sZP3Jt2tcL3vHwChvmnMyh8NP6t8UaA=;
        b=jxFlbT0icbdQMM662tqdj6ToXwy99m389FloWgqS6X92b8l/QoNppcA6fh2sL7Uh1/
         4XClNPIopLSACWjlrW32fnrSjtXRWS22pluMjadekAVVImaB7rH/6HhEKg6zSGEhr3ND
         14IA8UtL3brhuKm6oRKhY+TgX7xmgvgsRCjT4dcBdjjvx2ZUal9ZvQzAxx1j19BWORzI
         LnSPx4k/WoXHLLJazj708+1Oaa+Pjsvw2ScGFIL4ZJAvR+DzWacRdf5cbaDQ93fA2O05
         tw4a5fj8snhOWTcOsLQQ+eTDk8gREaykpwkhrMWKPHbg2K/CYH8vbxeLGpYpkj3eTmn6
         uedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706278974; x=1706883774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5G4B/lNexcW+sZP3Jt2tcL3vHwChvmnMyh8NP6t8UaA=;
        b=Y9dgTuYcNxWiPWjGAlQRb6ljcgicnQ1BUBjABg6sAiDX7tRXRW2a123fJgLRaZwgDe
         59kA6xTIkMv6SbMKpU77zamu0nZhSrCDQvLabxgXlxxM6mgtu0rus7emUumWdktAhezq
         ZeU08YlNr+cQM3T0f19gewfivymthRQDA2w7nIwvMVUC4vkBOfioNi7fPzja8vcMoXwF
         DCpFvaluH2rRBlLW79nt5anc9ZEbuwgcSL++9VlOAcpp33j4XQdizRaCnCtoiejaCEVB
         EJuAfIsiCoaWDDu01nFmbQcTi8uyudZRclssIo0L+vaEO016BZJKrTtr//vPXv6220EM
         DonQ==
X-Gm-Message-State: AOJu0YyYIxzHjEVDZx2R2f193K3escm0sQ6xr7mKUP7TSqDw6aU/8+QD
	LSRk2+vbEnkIMTNjz05vzyY4Ya3RJ1ywEQjHzUvtvGKL/Ng+rS0c+qYMVrJA77HGDJWY
X-Google-Smtp-Source: AGHT+IFHW8kz/wYpatfFYBV8BEVcsA4Il4mVr0RAXaMHK65wStg0utCo12r2J2BdTh8/x85B+9CJ4A==
X-Received: by 2002:a2e:7e0c:0:b0:2cf:36a2:ce60 with SMTP id z12-20020a2e7e0c000000b002cf36a2ce60mr531521ljc.15.1706278973305;
        Fri, 26 Jan 2024 06:22:53 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id a2-20020a05640233c200b0055731d8f459sm644407edc.24.2024.01.26.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:22:52 -0800 (PST)
Message-ID: <f6cfd587242001326ea6fdb9678359c1289202e5.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, nuno.sa@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Fri, 26 Jan 2024 15:26:08 +0100
In-Reply-To: <ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
	 <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
	 <ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 09:04 +0100, Nuno S=C3=A1 wrote:
> On Thu, 2024-01-25 at 17:57 +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote:
> > >=20
> > > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
> > > >=20
> > > > Hi Saravana,
> > > >=20
> > > > Thanks for your feedback,
> > > >=20
> > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > > >=20
> > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > >=20
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
> > > > >=20
> > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > > Especially if fw_devlink already created the link? You are effect=
ively
> > > > > trying to delete the link fw_devlink created if any of your devic=
es
> > > > > unbind.
> > > > >=20
> > > >=20
> > > > Well, this is still useful in the modules case as the link will be
> > > > relaxed
> > > > after
> > > > all devices are initialized and that will already clear
> > > > AUTOPROBE_CONSUMER
> > > > AFAIU. But, more importantly, if I'm not missing anything, in [1],
> > > > fw_devlinks
> > > > will be dropped after the consumer + supplier are bound which means=
 I
> > > > definitely
> > > > want to create a link between my consumer and supplier.
> > > >=20
> > >=20
> > > Ok, so to add a bit more on this, there are two cases:
> > >=20
> > > 1) Both sup and con are modules and after boot up, the link is relaxe=
d and
> > > thus
> > > turned into a sync_state_only link. That means the link will be delet=
ed
> > > anyways
> > > and AUTOPROBE_CONSUMER is already cleared by the time we try to chang=
e the
> > > link.
> > >=20
> > > 2) The built-in case where the link is kept as created by fw_devlink =
and
> > > this
> > > patch effectively clears AUTOPROBE_CONSUMER.
> > >=20
> > > Given the above, not sure what's the best option. I can think of 4:
> > >=20
> > > 1) Drop this patch and leave things as they are.
> > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > is
> > > pretty much ignored in my call but it will turn the link in a MANAGED=
 one
> > > and
> > > clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags as
> > > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> > >=20
> > > 2) Rework this patch so we can still change an existing link to accep=
t
> > > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
> > >=20
> > > However, instead of clearing AUTOPROBE_CONSUMER, I would add some che=
cks
> > > so
> > > if
> > > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or
> > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > and
> > > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right now=
, I
> > > think
> > > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends ups w=
ith
> > > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not allow=
ed...
> >=20
> > No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the link
> > flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there and the
> > former replaces the latter.
> >=20
>=20
> Oh yes, I missed that extra if() against the DL_FLAG_AUTOREMOVE_CONSUMER
> flag...
>=20
> > Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flags if
> > AUTOPROBE_CONSUMER is set in there.
> >=20
> > > 3) Keep it as-is... This one is likely a NACK as I'm getting the feel=
ing
> > > that
> > > clearing stuff that might have been created by fw_devlinks is probabl=
y a
> > > no-
> > > go.
> > >=20
> > > Let me know your thoughts...
> >=20
> > If the original creator of the link didn't indicate either
> > DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, they are
> > expected to need the link to stay around until it is explicitly
> > deleted.
> >=20
> > Therefore adding any of these flags for an existing link where they
> > both are unset would be a mistake, because it would effectively cause
> > the link to live shorter than expected by the original creator and
> > that might lead to correctness issues.
> >=20
> > Thanks!
>=20
> Thanks Rafael, your last two paragraphs make it really clear what's the
> reasoning and why this patch is wrong.
>=20
> Jonathan, if nothing else comes that I need a re-spin, can you drop this =
patch
> when applying?
>=20
> I think we can keep the DL_FLAG_AUTOREMOVE_CONSUMER in the device_link_ad=
d()
> call as it will be ignored if fw_devlinks already created the link but mi=
ght
> be
> important if the kernel command line fw_devlink is set to 'off'.
>=20
> Or maybe, as Saravan mentioned in his reply we can just pass DL_FLAG_MANA=
GED
> as

Forget about this as I just realized DL_FLAG_MANAGED is not a proper flag w=
e can
pass...

- Nuno S=C3=A1


