Return-Path: <linux-iio+bounces-1925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682483DBB5
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBC5283D63
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB71C298;
	Fri, 26 Jan 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcAryFce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C51DDF8;
	Fri, 26 Jan 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279049; cv=none; b=Zhsejf/58AwER5i094pYKnmBnAEkVMYKII9s7ZGpmco94b/YFe5DdZv7YS9K0GliTxh01yk33OZYQd4F0cl7Ck8s/bD53rZZAiVwkUrG2qCg5a4dGMKcYxC+6w97av65Vz8D+0EbxLsDlLc66y10pVUDCichB5sHI/6aq8YhGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279049; c=relaxed/simple;
	bh=vagUOHF2Lunl2BO2OA4jMWY0HAMi684yyFXzkym1nAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vb4tLUWNGySUyes420ZTTmnNT6HstOaJNTOZUkYP7BHTu4PJ3ydjEPwGWyDCiUJggxhKV8VOk7SGqA+iN9K+nhodI+YR/U2Y0Pvl5UBwit6dl9+RF6gn/xZDuIfmJHClrJzUSGiZ/xf3pUmvBOgh/u7eObo+A5uurhrhI47keWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcAryFce; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so7580295e9.1;
        Fri, 26 Jan 2024 06:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706279046; x=1706883846; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vagUOHF2Lunl2BO2OA4jMWY0HAMi684yyFXzkym1nAg=;
        b=OcAryFceg/iAxifGxYse8Jm9ccnhgQxD5EHMEhUosiUvG2A1dgh2XYMwydr40ysxpj
         hWOmIB+LYSDDpv0qzfvFIyD4+ne61ZvUoS3As6vH5K4g0jDLkTNoTU8B4eXDggBatHek
         kZnyMgWWG1VRbemZP7VOFyrCF12NVkmaGkjHYv/sAhOS5O59A7uyU9/bS+IabiM3FgeH
         H9oyyn71hFQYW+ugxeUUojGa+TELAMaHqdMtas+SgZJcRQD1LrHhna6SmmjZfqsW58P3
         rkqs+0gSswzc38NOhtjcEeEL8cSHQ/IrwAY9gaROzhVj0coqn7c2vkC9VDoMOLxHgi88
         jwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279046; x=1706883846;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vagUOHF2Lunl2BO2OA4jMWY0HAMi684yyFXzkym1nAg=;
        b=SA40ybgOiuJkl3yPeRsnlQiByMlhqycZE/X0fiVvS2+mB3DDdkdqaC5yeYt7qYGSgX
         03S76S8NH5dQ1larPJPDHCk5W82tEbNrxrFNSSrPk29apVpQnLiB4WqOhMV0yGRP2Oa8
         k6L+2Hrb+o3siultONEoQ6vWJxUE4YHEhbztizb+WmMNNJTPHlUcZQh5khc3EeO5W2ZA
         AQ0KY0oUbdeDpr47FohHssIrhbE6tPVq3ltRYOEGpuhwwVVUEZIbb2l6DAQuFAdszlNm
         GNeQa92R4kGsIgsFyyVCeYpd2rHnMmfJum6ivuWsMNNsDd/a2ac1oSTMcfnOrNYH8jXS
         2VZg==
X-Gm-Message-State: AOJu0YwLSDB2weHPov1y/STbwRYlLuJJwSBU7LKqTLTdEJS91KStEYym
	SJBjJAT8TK34vnQMXFSzyGGoiBP/kdIT6WP1XR+sZF0RvuPmiBsC
X-Google-Smtp-Source: AGHT+IHVf+ru38l7q+iSE5Ol6151trWdoMqv0NFetoArb+s6iXdKIRkzuTedyuLV4ujuodmBaI4RqA==
X-Received: by 2002:a05:600c:5405:b0:40e:541e:d5b with SMTP id he5-20020a05600c540500b0040e541e0d5bmr868179wmb.192.1706279045770;
        Fri, 26 Jan 2024 06:24:05 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a2cd74b743csm686902ejn.3.2024.01.26.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:24:05 -0800 (PST)
Message-ID: <c459cc6766b741892cdf9de0b50832023eb4196d.camel@gmail.com>
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
Date: Fri, 26 Jan 2024 15:27:21 +0100
In-Reply-To: <865346908c9b76d72741e6f319a4535459de1ea6.camel@gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <CAGETcx_ScsW4gKpAK01dHYxB3XGs-pRjJQMygbZUNAdxV6BqtA@mail.gmail.com>
	 <865346908c9b76d72741e6f319a4535459de1ea6.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 09:13 +0100, Nuno S=C3=A1 wrote:
> On Thu, 2024-01-25 at 16:50 -0800, Saravana Kannan wrote:
> > On Thu, Jan 25, 2024 at 12:11=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > >=20
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
> > > FWIW, I was misunderstanding things since I thought
> > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > was needed to make sure the consumer is unbound before the supplier. =
But
> > > for
> > > that I think I can even pass 0 in the flags as I only need the link t=
o be
> > > MANAGED. Still, I think having DL_FLAG_AUTOREMOVE_CONSUMER makes sens=
e.
> >=20
> > As you noticed, your understanding of DL_FLAG_AUTOREMOVE_CONSUMER is
> > not correct. There's almost never a good reason to drop a device link.
> > Even when a device/driver are unbound, we still want future probe
> > attempts to make use of the dependency info and block a device from
> > probing if the supplier hasn't probed.
> >=20
>=20
> Yeah that makes sense and is making me thinking that I should change my c=
all
> (in
> patch 7 to use the MANAGED flag instead of AUTOREMOVE_CONSUMER). Sure,
> AUTOREMOVE_CONSUMER won't matter most cases but if someone disables
> fw_devlinks
> then it matters.
>=20

Yeah, just realized MANAGED is not a valid flag one can pass to
device_link_add() :)

- Nuno S=C3=A1
>=20


