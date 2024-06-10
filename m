Return-Path: <linux-iio+bounces-6135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1E901B8C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 09:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748D8B22075
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF991CD24;
	Mon, 10 Jun 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlIsVQbT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6591BF2A;
	Mon, 10 Jun 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003264; cv=none; b=OpBZyB/eNnZL72gdQ8XPP3FNu7/21cBmc0f6g3iZLHNEyNvz22cb1gU7GplKD8C+rLAitj9PYkNCnBVtyFTYEq41+rSU3UuVX2KOMRiiDWUGKtiedMsmmGQ2ZzfyAwhH0Dj7s9hr+xp1LUIfv8JzXXMhsyd/nzHirA0agN5eSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003264; c=relaxed/simple;
	bh=rclMQqGEozDHSLQO/TvjwfrxT2QCBhUHXn/GOcGA+tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEiWVQUl79lxWr0OprT62msg14AeubbZFfwcztBSXR4VQUZ8ea8IaghxI9K/4dk8Ow5XPWxe9ZcaZAlezYkCkpOrHHlC4fgBrBJpg39T19pTYI+4yTT82LvrxgOiavH7fjnh8IkQaC4wynk3u8EvOEC/1HOId4K0Tks2zLNOR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlIsVQbT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso5895932a12.0;
        Mon, 10 Jun 2024 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718003261; x=1718608061; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9XkB6KvYnfdznF+TEx3muL3K/bTdkLsfM+Ybwn3hwEM=;
        b=QlIsVQbTYJKox1g30KtTY8gm2tm1Jhts7SOHjtlFy3xgSsr/aMW1iYETtdiEO+PUey
         5qecnEORzqUQCB2XWR8o18gp3cmJ8n00sPRG9kGRALLvHgD14LcopZ23SSeStvclqwpo
         nUK2hD5JIoQXTTSXJXWc81DVJ3Z8/iBT1tUxH2qVeqSbr8epNkXI8S+j3WT0PDQScoil
         Q25pupMp4O/x5irwrBKMurrjOZDpCuGNaWgglfc+6/p3jd69A3hc5GDz+8D1PfvkKD94
         /bDwiP0IbQ4yMbbBDUyomzwLf0BzODrqXq2+w3u0q9aDQV+gPhqDs4ieV6hdDw2Kgz7z
         Dy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718003261; x=1718608061;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XkB6KvYnfdznF+TEx3muL3K/bTdkLsfM+Ybwn3hwEM=;
        b=QsaKM28f6S5+vR6XiwdoBZ+T6CfBao1jcoga50KUYaQnRsjiuDjz9i+g4UfwICv0jP
         OBRi/bvRAX4JnV7Ffu1Xzqb6/ulgU/X99yDpHmHWGXKBASpUPavKTpBAhcewPpjbFX8I
         kCN1hrUFDWCdfBuxRaJ6rZKEh9niAdraT5dyfT8C7BqzHVeG+7c29QdR+N9zyt9cMwr+
         eZqexxG4YftGl1zqEwMiLZYYmMDJiqOgRg8+U94j2yeNhPCKKSha6a62U7Qz1fXrGntx
         2HXvHoPoYUyo6PWN7iuQlnNQl05r3WtFoGG8yADQC/XeRZhc2Y61ZIa0JcgZm5fEPXmE
         ZQlA==
X-Forwarded-Encrypted: i=1; AJvYcCVs9+k19Vu7GFF66GJexVgNtkcKIM8tsRFS/eq+JQ9YItr2tcFILBJX+cEoqMnwdrMMOQPp1JuCQj68b3+qYGyTN4SDPgiFXbuydcaNU28htS1xv/B1ty/mb4cyUtAPRNwj7JnSqSkO
X-Gm-Message-State: AOJu0Yz0nfWstLbTJJAaqU8h5MeDp6DttetU+TdMonE5qiUfN9aJyXeY
	ClSnSKvetVxSxIYuBEykuFIsL20eN+BVDiCVHneGp3/6nemh5Gpa
X-Google-Smtp-Source: AGHT+IFd5ye8kICHk3VgJyXo4OhSJyan+mcKf8O/5rH86D2NtLWHg3MWYKcWqREL1nSJQBkHg/pC8A==
X-Received: by 2002:a50:d743:0:b0:57c:70a6:baf with SMTP id 4fb4d7f45d1cf-57c70a60bcamr2209722a12.40.1718003261044;
        Mon, 10 Jun 2024 00:07:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae13fff4sm7080982a12.53.2024.06.10.00.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 00:07:40 -0700 (PDT)
Message-ID: <2d7164356496ab910bdbcac471f91d874b9e075d.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti
 <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Mon, 10 Jun 2024 09:11:28 +0200
In-Reply-To: <20240608190600.622dfd7f@jic23-huawei>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	 <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
	 <20240608190600.622dfd7f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-08 at 19:06 +0100, Jonathan Cameron wrote:
> On Thu, 6 Jun 2024 09:22:38 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use dev_err_probe() (and variants) in the probe() path. While at it, ma=
de
> > some simple improvements:
> > =C2=A0* Explicitly included the err.h and errno.h headers;
> > =C2=A0* Removed some unnecessary line breaks;
> > =C2=A0* Removed a redundant 'else';
> > =C2=A0* Added some missing \n to prink.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
>=20
>=20
> > @@ -1296,8 +1268,8 @@ static int ltc2983_reg_access(struct iio_dev
> > *indio_dev,
> > =C2=A0
> > =C2=A0	if (readval)
> > =C2=A0		return regmap_read(st->regmap, reg, readval);
> > -	else
> > -		return regmap_write(st->regmap, reg, writeval);
> > +
> > +	return regmap_write(st->regmap, reg, writeval);
> > =C2=A0}
>=20
> Unrelated.
>=20
> Otherwise updates look correct to me.

Yeah, I know. It was simple enough that I sneaked it in and did mentioned i=
t in
the commit message hoping it would make the change acceptable in here :)

- Nuno S=C3=A1

