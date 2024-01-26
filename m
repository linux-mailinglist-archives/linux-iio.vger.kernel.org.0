Return-Path: <linux-iio+bounces-1918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110883D58E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 10:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3EB1F266CB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EC65BDD;
	Fri, 26 Jan 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW+sN2WV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29DF125C3;
	Fri, 26 Jan 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256131; cv=none; b=novuu8xShmKTllLi5ZX6LlmdxHGUsZS6FeMdtjg8oEYzcHJbLOjbI6OuHu3KW2DHNux4UOZkW5m6pjkdYTc+K5K0vB+W/SlLy0WtOdPsO8E09sqjXCc6cw0HTVpx34FH68pq/ZM/5paqrnZsNzMzhD2qoTY+TUCzP201ObrZGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256131; c=relaxed/simple;
	bh=W6kBCbqPak49u7mZpvZo9fueo6RRV4nRXDfGa/0BYng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7k3oy0jHdSjn0t8jw7fIF/miR3ziWezsbotZXr0F5DNDf/sye6WW0byb7lWBxiF+I/buAKqeAnnBnOQC4BUzajuKCfsU80Xf9H79LtDUsnXYsIRZ6Q/HoFVDOXrd2VlcBtc9fuXCYYA99sI1/gJyBWOEfjdIrY4S4vqufpFsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW+sN2WV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so21783066b.1;
        Fri, 26 Jan 2024 00:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256128; x=1706860928; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6kBCbqPak49u7mZpvZo9fueo6RRV4nRXDfGa/0BYng=;
        b=EW+sN2WVWLmlMZjv6qWjUFhaQJmL/fQQjeY57UIBj+O4bsB6RQ9hAchvJBYpEQAw4i
         Ug08eMof1p32DDita4gN2UCrH1y1ZCVAGK33AZKNHrLIPCtpd7HNoVFeYkMfp9twX+lI
         p1AcFRpFbI4xG8QpUa8RzQFS4sRURfcSTb25elAsi125b3qmuF6OQ/r5Ij5XCTQyYe83
         E8wBydmwZ5n2xkOTPal+++lWJxYuSJUZnK9ejTepMfF19wYJ26FvdKYZTSfalWgWjhcH
         ZNq53sJhCeyE0dK5g8Sy+x+ZJ9iDVAHZJPfm/wnDuSqfoYb+ahYr6FTO01OIPl/sQID6
         E8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256128; x=1706860928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6kBCbqPak49u7mZpvZo9fueo6RRV4nRXDfGa/0BYng=;
        b=FNpJV34h3pZwLONymz0SyCqrZIKi4d4odDPkoFxb/5F6jzENecVCkM+YnvUYBuLous
         ZSuP2qTVl3UaR7iye0a7VJ35XLQxuHlfyy+uwpnY57wjcoKQye2DIoZoVmfGxJXlLAFE
         ja/fTeS7XzakVEOtEBYOhTpLxdPraP8R0X8LgzGE6ZQKYiwJUx2oECUyyYrmokPU/tOi
         mtorsjvM9tPbLxD41Tka+ed86oYcAoz/dnNkrexK+mqPJBgMKdcT1r5OKalkBbqs+Mde
         0EcRGEXpS1Wu7sLBbJu0s31nvqtO1l7L8rv0S2gbJJZIznlvWV4y+Lj8qRb8ONKSdigF
         yLBA==
X-Gm-Message-State: AOJu0YzIgFJ/CL6FFvk5hp0TULS6o6x3PiLZbfS0+LfFfM2AjUeG6hkC
	7Fy6RICaYq0EHLuTmaryG9a/hdyXqGiHW8wi0xQhKRlSAjBssvct
X-Google-Smtp-Source: AGHT+IH7KOmidlxrpVP9hX1gWjylgpAULon7N2GxiwwnSd6mHJZX7IWuzyj6WVMVQxns+ot5wwIjdQ==
X-Received: by 2002:a17:906:370b:b0:a31:6c07:11bc with SMTP id d11-20020a170906370b00b00a316c0711bcmr452020ejc.35.1706256127245;
        Fri, 26 Jan 2024 00:02:07 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709066d4600b00a26a061eef8sm350513ejt.69.2024.01.26.00.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:02:06 -0800 (PST)
Message-ID: <91750ec1e167ba69648c7525ad0caf0d858ff0f9.camel@gmail.com>
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
Date: Fri, 26 Jan 2024 09:05:22 +0100
In-Reply-To: <CAGETcx8-WqrjhXLZdtGwnHzc3_VGkUcd2MUgnuAC0JaBHiVQpA@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
	 <CAGETcx8-WqrjhXLZdtGwnHzc3_VGkUcd2MUgnuAC0JaBHiVQpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 16:57 -0800, Saravana Kannan wrote:
> On Thu, Jan 25, 2024 at 7:31=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
> > >=20
> > > Hi Saravana,
> > >=20
> > > Thanks for your feedback,
> > >=20
> > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > >=20
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > If a device_link is previously created (eg: via
> > > > > fw_devlink_create_devlink()) before the supplier + consumer are b=
oth
> > > > > present and bound to their respective drivers, there's no way to =
set
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to al=
low
> > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > > >=20
> > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > Especially if fw_devlink already created the link? You are effectiv=
ely
> > > > trying to delete the link fw_devlink created if any of your devices
> > > > unbind.
> > > >=20
> > >=20
> > > Well, this is still useful in the modules case as the link will be re=
laxed
> > > after
> > > all devices are initialized and that will already clear AUTOPROBE_CON=
SUMER
> > > AFAIU. But, more importantly, if I'm not missing anything, in [1],
> > > fw_devlinks
> > > will be dropped after the consumer + supplier are bound which means I
> > > definitely
> > > want to create a link between my consumer and supplier.
> > >=20
> >=20
> > Ok, so to add a bit more on this, there are two cases:
> >=20
> > 1) Both sup and con are modules and after boot up, the link is relaxed =
and
> > thus
> > turned into a sync_state_only link. That means the link will be deleted
> > anyways
> > and AUTOPROBE_CONSUMER is already cleared by the time we try to change =
the
> > link.
> >=20
> > 2) The built-in case where the link is kept as created by fw_devlink an=
d
> > this
> > patch effectively clears AUTOPROBE_CONSUMER.
>=20
> I still don't see a good reason for you to set those flags. And if you
> see my other reply, I'm not sure you even need to make changes. Just
> use the existing command line arg.
>=20
> > Given the above, not sure what's the best option. I can think of 4:
> >=20
> > 1) Drop this patch and leave things as they are. DL_FLAG_AUTOREMOVE_CON=
SUMER
> > is
> > pretty much ignored in my call but it will turn the link in a MANAGED o=
ne
> > and
> > clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags as
> > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> >=20
> > 2) Rework this patch so we can still change an existing link to accept
> > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
> >=20
> > However, instead of clearing AUTOPROBE_CONSUMER, I would add some check=
s so
> > if
> > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or DL_FLAG_AUTOREMOVE_CON=
SUMER
> > and
> > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right now, =
I
> > think
> > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends ups wit=
h
> > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not allowed=
...
>=20
> This is all way too complicated and I still see no good reason to use
> those flags in whatever case you have in mind.
>=20
> And Rafael explained why your changes don't make sense. Once a link is
> created, any AUTOREMOVE flags should be set.

Yeah, Rafael reply made it clear...

- Nuno S=C3=A1



