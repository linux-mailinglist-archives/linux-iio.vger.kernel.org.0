Return-Path: <linux-iio+bounces-1913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B532983C6A6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jan 2024 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6361B24A52
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jan 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A574E1E;
	Thu, 25 Jan 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF9Nlara"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395174E0B;
	Thu, 25 Jan 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196691; cv=none; b=ZIF5PXy4HDJrPu1tsA1SzXpm/IzJD3ECdtxUGCH1yfBNNy5JxrsE8IRjbRwnLQQ6jkxIbnlR8P6Slw5FJjiPs9qkxp0thfVaYaRKT2v4c3KTVinmmG6ZuBbly3ZovYYHtHPRVXiWotrHYHqgmV9atLQg5fmyJ2BIjNMvewrtuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196691; c=relaxed/simple;
	bh=zNfziP2hTMcLh6aM+pHvlEvv55LKnzBUgDLOFVAlOU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkrJC3EaY34vsGeGjsWVhWD7TjChSW2TUQ4jrJk6EwTxPu1Fce7Cr0EjRtBXl2qn80z/KOXHqE4+i1QmAv+XRfgO2Aa+T15h6AQzfESztP0nWAbX6WXT5kDcWPKywuTcPO/QIuNeIkVBRQKd9gv5PqOSuYNFdHueWsaYyncRQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF9Nlara; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bc332d49f6so298732939f.1;
        Thu, 25 Jan 2024 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706196689; x=1706801489; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zNfziP2hTMcLh6aM+pHvlEvv55LKnzBUgDLOFVAlOU8=;
        b=GF9NlaraAdXvAZ9JZ9M7Zx8xN0V+4kOdJmSCqQ3GBB03d3vlim4Dyme/q2uQ8yUM8M
         k+cpOYvSg0TXsOuQij8/+2RFqqf3oY9Hg6qV6C7cLm60suDUyzUmqlCG8F7savB6sxLY
         RUz2s4e4THrNpQSmLhDRv/R3zheXdW1iPIRyRu/ZdgFgLMCmGjd6kjAnQqWYva/ZRndg
         WgdJE8/ATP4JXfyELcxabyASlEN09ZtY45gsyLskMIXpiLmpWGs0HrufKrxXgVbQEp4B
         NgREzOlqEnDDlh/wKFGAnatUngTlT9ADM6cAgmZJrZwLg3JJ8B65sjropzN4U1jwou5q
         eTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196689; x=1706801489;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNfziP2hTMcLh6aM+pHvlEvv55LKnzBUgDLOFVAlOU8=;
        b=ALMHKhQ2K+MU3GJx5CXEBrkOYkB5IaK7OvXDNYuhfx2SSiEMTpWHAOPqZg3l+tyuuC
         aVb3gHqE5aIYXg4APnrFIalL0Hgy6PvhdGU1ViS0EFSIiO2ArJbrLVPrcvhMRjpRcoam
         GjJDz8OLcnPToGfL5Ee/oSPclPgDeWVcLGzkMOO9s1t7dz7xaXTfYDprGfxfBVBwLn01
         Vvx6SANuJGF4O0dl39trHS7w0lFHDU/J2tXOAVFXz4n8oV1lMoo1QtL2vWj1AahZshub
         AZAipbY4ZdoPKsqqRzyLwXsJEJdlTWfTUn9Ihek9Kfx3tBg6AWNfpKSQqAaT5yEO9bXG
         ZDyw==
X-Gm-Message-State: AOJu0YxO7QaKFXYVaRCCVV03WoKUI78AnIeiCbWaDh8dOXnKtyJv1EFd
	vLlhBgwXxNUYom7oASu7WUeBeU9Uqja0IwXFGB8EDefDIWpG4Lpa
X-Google-Smtp-Source: AGHT+IFaMMCAySJNmc4SIUNhsQpytb5lAB5OFNA4trGP8SanswulaffQ4p8FI1RTJZMS9bbnd3UQEA==
X-Received: by 2002:a6b:7d48:0:b0:7bf:8e8d:3412 with SMTP id d8-20020a6b7d48000000b007bf8e8d3412mr1612613ioq.20.1706196689021;
        Thu, 25 Jan 2024 07:31:29 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id i9-20020a05663813c900b0046e760beffesm4675075jaj.19.2024.01.25.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:31:28 -0800 (PST)
Message-ID: <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Thu, 25 Jan 2024 16:34:41 +0100
In-Reply-To: <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
>=20
> Hi Saravana,
>=20
> Thanks for your feedback,
>=20
> On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > If a device_link is previously created (eg: via
> > > fw_devlink_create_devlink()) before the supplier + consumer are both
> > > present and bound to their respective drivers, there's no way to set
> > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to allow
> > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> >=20
> > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > Especially if fw_devlink already created the link? You are effectively
> > trying to delete the link fw_devlink created if any of your devices
> > unbind.
> >=20
>=20
> Well, this is still useful in the modules case as the link will be relaxe=
d
> after
> all devices are initialized and that will already clear AUTOPROBE_CONSUME=
R
> AFAIU. But, more importantly, if I'm not missing anything, in [1], fw_dev=
links
> will be dropped after the consumer + supplier are bound which means I
> definitely
> want to create a link between my consumer and supplier.=C2=A0
>=20

Ok, so to add a bit more on this, there are two cases:

1) Both sup and con are modules and after boot up, the link is relaxed and =
thus
turned into a sync_state_only link. That means the link will be deleted any=
ways
and AUTOPROBE_CONSUMER is already cleared by the time we try to change the =
link.

2) The built-in case where the link is kept as created by fw_devlink and th=
is
patch effectively clears AUTOPROBE_CONSUMER.

Given the above, not sure what's the best option. I can think of 4:

1) Drop this patch and leave things as they are. DL_FLAG_AUTOREMOVE_CONSUME=
R is
pretty much ignored in my call but it will turn the link in a MANAGED one a=
nd
clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags as
DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;

2) Rework this patch so we can still change an existing link to accept
DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).

However, instead of clearing AUTOPROBE_CONSUMER, I would add some checks so=
 if
flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or DL_FLAG_AUTOREMOVE_CONSUME=
R and
AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right now, I th=
ink
one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends ups with
AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not allowed...

3) Keep it as-is... This one is likely a NACK as I'm getting the feeling th=
at
clearing stuff that might have been created by fw_devlinks is probably a no=
-go.

Let me know your thoughts...

- Nuno S=C3=A1


