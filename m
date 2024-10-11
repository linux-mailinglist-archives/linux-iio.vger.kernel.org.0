Return-Path: <linux-iio+bounces-10432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19747999CD9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 08:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8491F225C2
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 06:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73606208993;
	Fri, 11 Oct 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB9Ii7+9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C711CC140;
	Fri, 11 Oct 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628969; cv=none; b=MqpIWuhTB/ev5S7uMSC2Y+lJIsfLto0jOCLnTqJwd4hgqbWttPso1b/9GDd0xroYGI1ZgH+MYDZTv2MCJHh0RP/ojfrr5lwQ68RRRfJSuSyPJ0USehrivUctXxbfOPjEu9itw9RDnZoaBAmHQprpcGafGXWzNU+9ZQMj4Ry5xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628969; c=relaxed/simple;
	bh=D14SokNvb70cT9cjqKdaSVHsuVfofziDB/m6BXyScws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1L11wVZBLBKBoLADj+ZgU9aG/vt4+2ou6dETHXnWfQvZRpSgWwozarTl2ZkTIO0ZmBnkrzcTVt9RrUpJt2h+wILX8A7jBnzGTmC7Q22UUuTInxbF551B8y+fkT5l8ByApaFfdyg5NRllLGaYHf6OhOPBMpOrNm0anahHVj8jmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB9Ii7+9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so842771f8f.1;
        Thu, 10 Oct 2024 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628966; x=1729233766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D14SokNvb70cT9cjqKdaSVHsuVfofziDB/m6BXyScws=;
        b=LB9Ii7+957pU2J2IBNNAIBbBZtRBEGTO6Hen8rvJI0fzKl+x4tCoktNflLmyIJYYQl
         FChmEJQO2z7QR5PHvZbdwyyYtXOZrPliVuWXulE7gp43rQvKKL1smdBovFGbNmSvOjVh
         JzVCvMyliwti7gqjK3jhv++b2y6Q0KuVEzvsgVZQ6thOa9EsdNOtQTF1MLcHlpQBFGMZ
         /3f1oVwlSaOoEeMNQS+989iIW8lmSuCj1ZHKtgUPVjViycCWeaWTVUwgwSIHaywEZFrU
         RJO4LeCurScVD13E31m4w5vBiUJvIu8fFT6q75QPl0lTY2rpKAR0KO+ejFDj3lN3afCT
         vj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628966; x=1729233766;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D14SokNvb70cT9cjqKdaSVHsuVfofziDB/m6BXyScws=;
        b=dJQ2oDZEEWvwwtVxJiaKTa5aN13bPh6Hi5YzTNdeZDw8CowccVMyaXzPg421hBsY7o
         RIsxgWcPwnSu7YcZJB/IAYVktMqEGBdYKVL7NjvF/Oz3XDZS5Ym2OCDbrCwm6BR27/pm
         DCK2/bO/L9UJByuUPKuWOP/WUYDGxBJcqkSdVa3af9pzOLTBU5eBZD+hxO8KBb1+YxCg
         1X4FDLbiKgdKLrU/bER+nMlFGTYjqC670DlxKvBHgh3pCCVvjmfAltlzD8vhtRRc4Za3
         6n66LS3Z/f+4+j+GnrXZezreca/L78C9vElrkOkxQi7+FhWFBO6ipj/yO/OJD9BAjJX7
         L+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWOHr8ne+gg145T+CGPD0pz/6XVdkBN94y1yV4LXiULWlusGCU6MyzsTf9ZQafT2hmwAtQw4b1wXz5aErI@vger.kernel.org, AJvYcCVIvYrXS4t+pJlRw4bXwfRFW+7MTy/Qx+MiUofZvO2kOgHZwRZzlXR9YVYFS5EDiJtJ1vx3auIOSbPu@vger.kernel.org, AJvYcCXMJbo9WAlF264PH0E6Ab2lzFJyEzMT+bD5ga8G7oJZSJ40O/DZ0fGWF4jXzLwE3Ijv4PhInJQKvoC8@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuP1MwrNnMyiWuJ4uGHhTXVFuQ0BlinmyXj8cYZyYZQtQhOPX
	DxyPlCsEMMhTabGu6KhJFHZN18ybHGZbSt8+ueGGuU8AQqSrCt95
X-Google-Smtp-Source: AGHT+IEaDiKj6/tyn+Va/XZKxhAg0mGtUjFKeI0Xc/pJX8QNyUHh2G13fJs68r4b1kEXlAwFqynpyQ==
X-Received: by 2002:a05:6000:128d:b0:37d:4332:e91d with SMTP id ffacd0b85a97d-37d5529f8f0mr1118580f8f.52.1728628965664;
        Thu, 10 Oct 2024 23:42:45 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf45df4sm65754215e9.13.2024.10.10.23.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:42:45 -0700 (PDT)
Message-ID: <34ce8e9c13a3680c7a3ab44e5c91ab80042ad009.camel@gmail.com>
Subject: Re: [PATCH v5 02/10] iio: dac: adi-axi-dac: update register names
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 dletchner@baylibre.com, Mark Brown <broonie@kernel.org>
Date: Fri, 11 Oct 2024 08:47:00 +0200
In-Reply-To: <eyx4gykoki4b4gwf6rmtnjgqec3ltdgtszbjugidtf37uei4pn@jqczhf3thuka>
References: 
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
	 <a02f256c54089da4faa3ee1807c01b9cb6e70bc6.camel@gmail.com>
	 <eyx4gykoki4b4gwf6rmtnjgqec3ltdgtszbjugidtf37uei4pn@jqczhf3thuka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 19:52 +0200, Angelo Dureghello wrote:
> Hi Nuno,
>=20
> On 10.10.2024 14:59, Nuno S=C3=A1 wrote:
> > On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Non functional, readability change.
> > >=20
> > > Update register names so that register bitfields can be more easily
> > > linked to the register name.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> >=20
> > I don't fully agree that this is so much better that's worth the churn.=
..
> >=20
> > From a quick a look I saw (I think) some defines where _REG seems to be
> > missing.
> > Those is fine to change for consistency but I don't really seeing the b=
ig
> > benefit in changing them all.
> >=20
> > (Sorry for only complaining in v5 about this...)
> >=20
>=20
> no problem,
>=20
> the change was suggested from Jonathan, was not something i need,=20
> let's see if he has further feedbacks, in case i can roll back
> easily.
>=20

Oh, I see... Well, still don't think it's worth the churn but he has the la=
st
word on this :)

- Nuno S=C3=A1

