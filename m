Return-Path: <linux-iio+bounces-25862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C394EC2FB3F
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 08:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2559B1893ACD
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 07:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E930ACE9;
	Tue,  4 Nov 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9HkwYFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127826B08F
	for <linux-iio@vger.kernel.org>; Tue,  4 Nov 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242196; cv=none; b=Mh+8BFBlVhcifNB6Df6DBhZ/dWjz/ut5rGXcc3LchvNI9bZV4Oa0sLrQir2JcrTUmgsIpqnpUBnuTddU3ES6nKT4sX7XFgDnYpE89RXUnAgsng6cGg3YlqEW2biU7d1XNK5IJc/WS/N1WcXGk1djuflG+iUiq+28VftVp48/M/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242196; c=relaxed/simple;
	bh=EsDK7qhCQfrk3vH3U6A16IEHb3rXWzaDi+8vWrw21Fo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUqDiNRqruXov3lsg8j2qPmP8rPzDLo49dsUXl+/IQlsAsj+z0Bno09Ik8uI8zrUeuJb6B7naT6xoUi7TBkuUK2V6rvISAdF6VQ/DVmioOX7CWTGz5MHS23AkYuVrP935liQtg7ptWETIm7mZ4cESJX4lYlvYC/wOmnHw8wwL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9HkwYFK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477365fbdf9so18728465e9.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762242193; x=1762846993; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmIfp5CHSvN261h61usuE7H0B/pnLHCIYqGXEqHKHYU=;
        b=h9HkwYFKkCVtF5T7Hztw5hiZZjr4WSOPvK9SuPwhTEN63x9CPFEwYLZixuGrPm5Swt
         3rFogtCHMcd27cTeWiU9kQLaVDBXJly5swAKHFT2SPRU0en3yn3VxTCWUJ5mzT8SF8wH
         qkALBSagsJoaPXDAgJ5xzfdAcYlb4SYBSRVQ6rMUDeVlVaPeoLkDKOeukyWxxCRKTYfQ
         zV9wxM6Ny2cd2FzNyMYMUOT0LbKKTSdx6v5zSbUGKbc57ovFuLL68Avf0+gac2q70ZId
         hHzn/mz4zPa41lis1WNd1burDTzmjLvqCLZejkspJHJtCH2w6NgSQd0kEm6F8vv5C1lT
         +IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762242193; x=1762846993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmIfp5CHSvN261h61usuE7H0B/pnLHCIYqGXEqHKHYU=;
        b=dFBzkhpvXS/pdQ1wm+bxgkpz0df5WRdT+pIf7wKM26Afb7s93vsh36jvYOjC01eE23
         4ZpwSBXAIyHU+R1NBfXOec0+c22vvdic31xzrICE71RFRuUstxoyD5aofPRvVgwEGkf4
         9LZIRPiYDQCjeg4vZyaLxQz5Jjw/ytpcckhI1PvscEpePqAHmcEBdtWvNpEkDSTfya5v
         gJLgxHK6X2yE7Zgf8jdVsMZVUIie4faKMev5bRw/9N/cy98VL5ZRygPnKdkJUvD5q+B6
         0Kl4h3OejKJKjodX2UUUzcuWMWN4zF58f7iHvDVAUBwrM/8cJBcVHsBLkFaId+n2R7/P
         hdwA==
X-Forwarded-Encrypted: i=1; AJvYcCXf5qufpgkpc9MMIMoY5HKKnUTmt+rv52V4yf7zi1dp6ehs0AuPXPf/qYAXtlmlT7mChncAQSe2b1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5spj0tkzj0SGprLMUwb8PdE3K2XkQgUtXQ45K74/8jk7RCyw4
	Jf8/3cWUDpakpFgeB4jViKeiuJAPnEjne+fJD5pobJQy8tlK3Pa1unc0
X-Gm-Gg: ASbGncuT2gzqLXIlUOM3HFw4uOcruwLTCS/3uQ1/9gYrInMiW3oNALdz5V2AEtTiDKR
	U+CBvesch52DlGpDHi3wk1RvyGJczymsIdntqG/8IQ6Ik12N172Pg+bRUfIjq4nkTZNlfjzMfXW
	2/9YFwAVWVVAQ5jqFLNC0yjaH3wrZrhQ2QG7aH0sw5WJaMwojj6QGN4iYfd+HA0qprJfVpQW9+j
	0Vz85RanX13Y7rN9PR/b8ogqPOF07fJsxNob1ZQ1YUZ38DRtxEy77PA7qhEDCvNiPBK9gfcQu8S
	ROE7dUwwoRlmZSOi+eod0GWoZrLwLu4VlvNzp2oLWycbgnW/FTQBmqRGUCsj1dE0ETdTwctt4wh
	D+s7/ayuQT/OFnTh9src2f1LzAaWQ0mwN6lmqZuFfI8bDDTsMstIJvxJxp6dke/tD0oI7vup2lh
	bH1h2yCfYLtN8MklLiIfHPVKY6iCQOXG/yggMXnfrm/30n9NK5K6awXbsXn1Q=
X-Google-Smtp-Source: AGHT+IFkC8FkiN8OBKQ4lbCIa/+FjxV40jag207Qy8JFCUJ2nSa1tA6ex6XHhxkx18+ex3uxZwg8Uw==
X-Received: by 2002:a05:600c:3146:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-477307af7e0mr121849255e9.10.1762242193084;
        Mon, 03 Nov 2025 23:43:13 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff79bsm195694575e9.6.2025.11.03.23.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:43:12 -0800 (PST)
Message-ID: <94c042be7ef7842f057d87d466ad7fffb17581ed.camel@gmail.com>
Subject: Re: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org,  Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko	 <andy@kernel.org>
Date: Tue, 04 Nov 2025 07:44:13 +0000
In-Reply-To: <aQkC4kev0hR9-yQU@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	 <20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
	 <20251101164612.449606c2@jic23-huawei>
	 <aQhcFl4fE5Akn397@smile.fi.intel.com>
	 <3c82c959e714ec8507d2c28494bb24d9146cfee3.camel@gmail.com>
	 <aQkC4kev0hR9-yQU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 21:30 +0200, Andy Shevchenko wrote:
> On Mon, Nov 03, 2025 at 10:40:20AM +0000, Nuno S=C3=A1 wrote:
> > On Mon, 2025-11-03 at 09:39 +0200, Andy Shevchenko wrote:
> > > On Sat, Nov 01, 2025 at 04:46:12PM +0000, Jonathan Cameron wrote:
> > > > On Fri, 31 Oct 2025 12:31:27 +0000
> > > > Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> w=
rote:
>=20
> ...
>=20
> > > > > +	st->d16 =3D cpu_to_be16(val);
> > > >=20
> > > > Should have an include for this.=C2=A0 Probably
> > > >=20
> > > > linux/byteorder/generic.h
> > > > though the kernel (and iio) has a random mix of that and
> > > > asm/byteorder.h
> >=20
> > Yeah, I did tried linux/byteorder/generic.h but it fails to compile if =
it's the
> > first=20
> > thing we include so I did not wanted to go that way :)
> > > Can somebody go and fix all of them to be asm/byteorder.h? Yeah, it m=
ight need
> > > some thinking as in some _rare_ cases the author might imply the expl=
icit
> > > choice of the algo in use. But then it might be problematic on some
> > > architectures
> > > as well...
> > >=20
> > > > Hmm. linux/unaligned.h is using asm/byteorder.h so maybe that's the=
 better
> > > > choice
> > >=20
> > > Yes.
> >=20
> > Hmm, so linux/unaligned.h or asm/byteorder.h? For the spi version I do =
have
> > linux/unaligned.h beacuse we use some APIs but for i2c there's no use o=
n
> > unaligned so
> > it feels a bit odd to include it?
>=20
> Maybe I misread what Jonathan said, but I meant that asm/byteorder.h is a
> better choice over other *byteorder*.h variants.

Ack. I was the one that got confused with your reply so I wanted to confirm
before v4.

- Nuno S=C3=A1

