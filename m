Return-Path: <linux-iio+bounces-27782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58296D1F126
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 14:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BD53019B8F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4C39B4B2;
	Wed, 14 Jan 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko0/PbqD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364921019E
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397500; cv=none; b=qeOAg+k/l8R7BZOP1BDZB/PgmeYrcL4rasa2OcYIIj6jHonHMMOrBKDONhjY6/56NRqwjNMdBu0zIPcMCs/JGc0cD0ToW6u54+ZyvtllHzjY2j78dtFLCBNtX9olVMwmBXJrcwvo/F+yqxk9FYx/5Zgfu2bA3zwmN+rnMQFW5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397500; c=relaxed/simple;
	bh=R7pvPqwiscPiyLq1VtjX66bP/Op4bNU7j66sLsRGARs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPhaBjRJ2oPlQp1NM/kOe7hEkYgkF9rqScBG8MWHhGMKRKwG2Cl+a83SqMk6nOv9BrB1YLJLcgoOoEkvgt5OUy2BBxS4JhhhbWXuz8A30EUdLnAKogclu3KiLZby0y9hitoABu3Ozb0vNiKxdSw39/rnm8aOvoK5YeuBd2qnYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko0/PbqD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so4851855e9.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 05:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768397497; x=1769002297; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7pvPqwiscPiyLq1VtjX66bP/Op4bNU7j66sLsRGARs=;
        b=ko0/PbqDWoqlbPtm5hBYB4y9/NLcinCZso56sYbt+BIz/SiBnTlpHf6Z1CorJMS+4v
         CmKDErsDqG8aBz/eWX5Vn2dSnGq5z2WO1c0JXNp0tnHmfkyJay2Cgjrh/09yjexT4xkl
         RcJiY/L72/rtB5UNr/eshsHRajcw5bU0MbbMjXMYyf1H9M5u+6KvrPq/gZlyJFsSjmVj
         pzFFofUnmI6tIb5B4QPthrobgrFHJtR+uPZkkvQK1uW9E+g1g8a3i7X+pLIqPPnLUrip
         17l2vqDaV0Kusgr0qi33BukFRIuqlhll5L0zr7Q0njQcZ/2+615TOyCPoQt2WMt/fvUO
         tROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768397497; x=1769002297;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7pvPqwiscPiyLq1VtjX66bP/Op4bNU7j66sLsRGARs=;
        b=f5RMXxCFVgJ0BaPv3JZNC2HpfaZjqFzVInyxEQLFa6Pa9SVIdFFxHDb4guiLVtAadD
         O9DUSG8GYzIukXMyMesiM6Jn95qavLjCQtdAkMfkCAMfaSWAD5yIdHzPp/L7XJNpwWCX
         v5kZAC9iSiVV79T5NsdEwt/Di50FeG0WD8BwHDNqJEQb7sCV8X7FOPuS6HkqPsXn/OyI
         9klU/146v4Iu9G6EpXU2WsZxOMuSeuopP2EyFVECpYiJHrU16xxb8rIf3hAxkfTZfPpO
         D6+hxK7h/6/Yfae9QxaxB2tNGz4pI3APjgok/N2lAMIIicwtEREbaAWRTWIT74qkNNjg
         czRA==
X-Gm-Message-State: AOJu0YwSug19NVlMjlfeSN7M8FqyM4B5wcoActzEcnjMMWRGusGCjp8r
	VNCzwoVp+/zoD9t55acZZS9yftlTADGY747QuyTjBcqPq+LMQoJ6c5/F
X-Gm-Gg: AY/fxX4RHHVYqn9vklC/MC1/3sk79UHY+esbs9OkazFuTnpVHu1m4igTEbr1XBIfs1o
	BQMIc9kiN/C/9iYHYGNXHrJzD5Hi8Q8NP99wm7FJlmpfkA57ltfyfz50bN7sxZ/oejDPENAIUBj
	Azx2MFqtMxwkA8mlsaL+8UYoIBHGfTmFtRuXWCJLubNbJRqQn1BjDqBATPgDM90oBKXPFDTTj5E
	3kBUhZVkokwNb7iW7bczSvHQKLy15dpjnrKKYgUVzLthTQfwbr7gBM14riNHM4fOdA61Ri0rxV4
	v+sC3SRc239a9VowD0uRz7fzmmvKPB7/hjsnJqfzep9MV16uIhwIl4ukLFrh1w0OhHCl57YEQAC
	0yuxLSw6XrRQT/ErKItSkp0N0BGDXTHrkmAD2YiYbLKeTAbNPjveC6YVIMewvy6j7eUPvDB+FIG
	GBAF3JgBT/lBzfg0oa6f8=
X-Received: by 2002:a05:6000:22c4:b0:430:ff0c:3615 with SMTP id ffacd0b85a97d-4342c55365bmr3394532f8f.53.1768397497373;
        Wed, 14 Jan 2026 05:31:37 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm50557298f8f.15.2026.01.14.05.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:31:37 -0800 (PST)
Message-ID: <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2026 13:32:19 +0000
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
> To facilitate backends with different set of features, add support
> for defining capabilites provided by the backend. These capabilites
> typically extend beyond a single operation and are therefore not
> directly linked to if a single function call is implemented or not.
> Furthermore, the capabilites determine if a certain set of operations
> should be attempted, or skipped by the frontend. This way
> the frontend driver can work with a minimalistic set of features and
> still have the device in fully functional state.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Hi Tomas,

> Changes in v3:
> - Reduce set of capabilities to only include calibration. The other
> =C2=A0 ones propsed in V2 can be seen as subset of calibration, or single
> =C2=A0 operation failing with opnotsupported

As stated in my patch comment. Using opnotsupported for buffers defeats
the CAPS idea.


But more importantly, how are your usecase supposed to work with this
series? I'm not seeing any new backend being added as part of the series.
Point is, if we are adding all of this, I would expect your usecase to
have fully upstream support. If I'm not missing nothing, we would at least
need a dummy backend providing stubs for enable()/disable()

- Nuno S=C3=A1

