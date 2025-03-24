Return-Path: <linux-iio+bounces-17233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93BA6D7D4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72317A767D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFB625D554;
	Mon, 24 Mar 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eAjzf/Xr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15D1A08AF
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809499; cv=none; b=PT6cTCk+g6rT1SLBJdMnNAj9tT3d36BamiMupH9tOE3T+w4jLFOVV1G9ISegH7P8llXm77ciiP9dIHFgD8X3W+b5+NEe4Sd/03WCZcpO0qhiHvctBrsjRHc0wn3gwP5TWoMLj4tSi7aj59qEGzgJnI5XOn8sYgxE7gBHvCNjm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809499; c=relaxed/simple;
	bh=uBvvyXVbtCVfPrDMsRnbTbpvsdh50EoZp/C4cjrARJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpbLjXOEri42bppCs0FQUJtivja3HLB7oqgf5vUZQsJm0x5PmkYt3hAZN/ul1507uX+aQJmvaX0Hb/2iPD0MW+hMRiZC53Nl21WkPhRYn83hjHk7VGsqJv82a9QRBFDGVPOjdrwQbvSlN7hYuRyGXVjy5woWkGm9UfqKubYWc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eAjzf/Xr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so28166025e9.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742809495; x=1743414295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4dZXkjM3unLUYtxmAAiTLqotnfoOThhNnCPomlhJGw=;
        b=eAjzf/Xr/Ke3ugn50T1UKQd8bJERgGxiWI1POy8AKHw61+cyCobHzFPO1ItqY5wjvG
         Bolh1v36txZ783zzeFoShjHwtAoIqWjzEqibCwdrxLyk6iTpWeepj/wRvQkBTIiOBnh0
         C7BUXQh1+c5/Q67wVSAYWiGX6AH4ERrbTrPUreuN40nRJIEXX5iLLtiUS/v3GhSRhQbx
         mBL67ljkEF7JBApqMWRZqJp2VMtfaJg7Jm6MvzdYoUVlMFZVd8C/OQUViKkWHqUAfqsg
         7ONyC1ri18lNctQrUmCBA0/uOwzxLSWG7Rw8Mfn/+JkAVla4bvEmdFAIUS0hZXJViWHa
         487g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742809495; x=1743414295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4dZXkjM3unLUYtxmAAiTLqotnfoOThhNnCPomlhJGw=;
        b=HOsBGwFCiQFH1dMt2vSE/kwTmLNwgvqYqBm11EeDCw6lYsCdFdK1nrA0sqHSqdis6A
         PPNopuEkKcu0qCWbPCLvpdZzpp2hQ4G42T/5wqH8hYn+tNy+CkGE26T5UQrryp3qtB3O
         FgUNN8baHgI91+1fD3TNuhX/+JIPB5NdD6lSHY2VsAzGlO1FV2Fbm0gciOSDwrqA6eXQ
         9ZFLBfk/5Gibg7hc9m58SOlx4h5Zr2oGu46p9w+vhhtNZPTFZqfg+QEyMZvCXzsLEjPr
         AAwCxVegTmv3ATHl/IXI282cmaLJTWx7t3Y2hqs9vHvfWG1euZKr3RU5hMo8VhuS/BTC
         zDQw==
X-Forwarded-Encrypted: i=1; AJvYcCXzeG/zET+lhM2Ftfbna7Jm80sAgBb0gdskeTqtoE+MQjSAVd/9f/GMVP4y/WUy8jxxg5J5HunAJdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWr25KYIpQ8ZUSHTQ0D2HIHjRJG05Vug2vyeVtiLk1yICbWp9v
	L3Gg3kOT15I/qfhW0CsN4NjwdaErVNLPlgbS/EC6iGrEqgVfzwjY0aEsti1PRs9sVS+ctl6A50e
	u
X-Gm-Gg: ASbGncurFPuN49/9r0WnhetcK9Ul/IiJtCPf7MD84l20uvAV/a32uPUAZJZdlShNOt2
	EXcx3U/L3H3KcjOtiAUpLwNyXZ3uHmw5LgwSLwCH7Euxyd+8tSFeBf0/H8HUz+9f4OUhWi8yMWt
	KZqCjLJ6UTFBSK+oHWiytcYQPeReEsb1LZ9s/n9IEoIVh4pt48DF8afWLl5E53RSzAPjhnaG4lE
	uFsz6hioQuORxDz8YlZkoSS6S2c1U03W2WM1kSo4sZu2VlO/ZSGwlIfXOwr2GI12Ky7b/HpGr4a
	qJ2JdN2sEbynOUyXDWnUNQSpViyY0xOcy54gQdyq+h1lBLlOpexqsWbREC14p/4KUL1GY3pkSUC
	iQb9I4X3H5PTpz+qgPcoNgA==
X-Google-Smtp-Source: AGHT+IF/xafnGZ8z2yT0RBDKHs4Ip1xN2eA3VEA6IdYB+ymd9PmXiJ8F7n7NmvpGnX9PbMF5ZmtBog==
X-Received: by 2002:a05:600c:1f8b:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43d50a4a938mr124865965e9.30.1742809494437;
        Mon, 24 Mar 2025 02:44:54 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd2798bsm117278755e9.20.2025.03.24.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 02:44:53 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:44:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adc: ad7124: Fix 3dB filter frequency reading
Message-ID: <fgd3vr46ijt3kr6onvtulmfulgbr2jpshcyk3dr2pvz7vqs2fq@mka4q2zqmpwe>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
 <20250317190031.22c822c4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3v22ezpain24ooh5"
Content-Disposition: inline
In-Reply-To: <20250317190031.22c822c4@jic23-huawei>


--3v22ezpain24ooh5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] iio: adc: ad7124: Fix 3dB filter frequency reading
MIME-Version: 1.0

Hello Jonathan,

On Mon, Mar 17, 2025 at 07:00:31PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 12:52:46 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Hello,
> >=20
> > (implicit) v1 of this patch set is available at
> > https://lore.kernel.org/linux-iio/cover.1741801853.git.u.kleine-koenig@=
baylibre.com
> > .
> >=20
> > Changes since then:
> >=20
> >  - Reorder patches to have the cleanup ("Make register naming
> >    consistent") last
> >  - Drop write support for the filter_low_pass_3db_frequency property
> >    which is completely broken.
> >  - trivially rebase to todays iio/togreg
> >=20
> > I wonder if there is a way to remove the writable permission of the
> > filter_low_pass_3db_frequency sysfs file instead of erroring out when a
> > value is written. Hints welcome.
>=20
> Unfortunately not. With a lot of hindsight that is a flaw in the way
> we generate sysfs attributes. IIRC when hwmon added similar they
> avoided that trap.  To retrofit it onto IIO now we'd have to have
> some form of complex permissions query or duplicate all the masks
> to allow r and w separately.

OK, fine for me, so I didn't miss anything :-)

I have another patch in my queue for ad7124. For that it would be great
to know if you intend to apply this patch set. If yes, I continue to
build on top of this stack.

Best regards
Uwe

--3v22ezpain24ooh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfhKZEACgkQj4D7WH0S
/k482AgAtDxGjIBVAjtQV1uMDR5ff6+//E0Oms+Gcr0oBmeTAqHQMqxtyq9NIusR
NCswsgPRQj0tAvCrblcsJm28qN7MLErFnOZjuVGsFXeDnOomscxhjReinw4SJd6x
Lerz7zGvIRQuCGEIIwY935k5QvCsC3sHCoj7kALXB+v8rVOz598c8zDZUZSozHsC
RZIF3hKTqxarfiWdXYLR8U8xDtILa6ljUFeTQe8N/M+f8Pwa0gNdobDEVYr3XycY
gnNMiKbIOQTyHXra0x9eygiw+9VMTyfQFjMTCDsoui4Vvja8SuPxZGa3MG7JOd+O
9bqPtzhzxk7zU5dl4zbK3Jk6hiqiyQ==
=SMP7
-----END PGP SIGNATURE-----

--3v22ezpain24ooh5--

