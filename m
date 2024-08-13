Return-Path: <linux-iio+bounces-8435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFA94FEC0
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 09:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4269B23456
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73D60B96;
	Tue, 13 Aug 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFLf2RaC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57A558B7;
	Tue, 13 Aug 2024 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534091; cv=none; b=GVjA4TAH6XhNm+eUXnU64Xydmict/IAlwyoxLbPZto7/VK76b9oAHSs4D9nSXtRrpe121JpFhI4+R6PyaW6kFpwgpDDGn/TC043GXnx8WjuhULhr7Vy2G1nXhKBjkM9W/mkULrSjViQdLgtaggMEvW0YWkAX5YoMKwJvk3p/xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534091; c=relaxed/simple;
	bh=/tDkBsUIpuefxByQq8Uj2vZDmHnHHDDLXynWe1SLD/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4cUF8VOWVFmkb4l0MIcYbLGBLzh9eR7DhehOKF2pZMj8H+Gj+eaQhsfnIe1aOc80DdnSMbvn+0Ive3f5bPHvl3AY9vCAtYR09djsx5vLavazVu6p1VxtWm711/icJWiizbtbKYEYLXBsA84HGXQ3ojpvOlH/ZbSkHjJHHiuLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFLf2RaC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca797fso38091445e9.2;
        Tue, 13 Aug 2024 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723534088; x=1724138888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tDkBsUIpuefxByQq8Uj2vZDmHnHHDDLXynWe1SLD/M=;
        b=MFLf2RaCC+6JK5HbhbKTjmv4bK24P7FT/OIcP0nvQBJUvYLBpKW3kPlFnIQwUBI2RG
         gMG+9rBxw8iYG1gGtbrZjfYDc8fLj7nh3yIVkBYleYYN4jB89efW3G1VSfYazBzkz7Y6
         JSJ0symZhA8FWMcuc194+NxnealvH0+GBF9ZHMVT2xIuWlRu5nP0meKN5W3FS07D+b5C
         LkPiTAOkjTqsjaCJL6MIjzXgRajNu6JMMb6p+IQXEy84XMEntTSpbCHA8e+QRMO0EEbz
         QJJuALTt5/8mKHi712Fsv6yHW4sA+EhRiXnM5MEmzDAQfns8Rue7H65D/KFaqznTtYvW
         WZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723534088; x=1724138888;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tDkBsUIpuefxByQq8Uj2vZDmHnHHDDLXynWe1SLD/M=;
        b=nAcDYs91QOVJYAc9w4g1QCadzrljNQbpEg6qkMeas45AYqhJD10YheA5pmsHWGGMN4
         gGRNoBiSfE204SmfGA8Yz5W4307SLkXQlFrtmleUAUofaJTZBL2cSBhjJQdjwc7Vd5M0
         C/pwTymx8KriNmq1zQVo11FwpcQnlApzl0Ba9v7mCuL4m42FtEa3Zz8YfngKRB9KPKua
         /aDdTKCXsABNmXHYQryZS+M4rp+4C9iEAlu9VQvCw+8GB1hcDqolawH7Sja5Cd2IysDj
         E3IKUaVwf3wFpOWRim5akRf8SEQn6eqEAhxGe9lofPqL0x1ftu3Cd4010ouyIJefhjTx
         fg/w==
X-Forwarded-Encrypted: i=1; AJvYcCUeqK8lcZlluwRTphnVYFMDw4FchczDx1eOqntvi9w7KEWMlcRvzz8R2ElME/IZhvrh2FCRjL8yhM+a4G1D1bS1Y58yB+2+AUfHtEjQpTVft2egeQSmQr87s/G7Q+kQ/AGiZEcgF2JgVJTJarRBAJkpBlvr+MHtSXFlqinyHBR60oIg
X-Gm-Message-State: AOJu0YzatZjMTOVVJcL8dU5X9pETsrfXfgDCM8/72BUQ3J8jV5BRwDsN
	N8gXzEukXQTyCZa4fxCW/g8jHtBaL8cSvvw/91GuUCjDXL5cLSqy
X-Google-Smtp-Source: AGHT+IHA16sYvqDYhNQilICtfAinzmxMrjB0slXGEd7wVi97HBQcaVlW9W6f8D/9T0VDOrH2ULpleg==
X-Received: by 2002:a05:600c:46c6:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-429d480d755mr16052595e9.14.1723534087689;
        Tue, 13 Aug 2024 00:28:07 -0700 (PDT)
Received: from ?IPv6:2001:a61:34fc:f301:5967:ab45:b87a:b14b? ([2001:a61:34fc:f301:5967:ab45:b87a:b14b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750f1easm126831115e9.18.2024.08.13.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 00:28:07 -0700 (PDT)
Message-ID: <8b32d9819e44436af39c5f32b095c41f8ebd77b1.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Tue, 13 Aug 2024 09:28:06 +0200
In-Reply-To: <4bdb10c2-057f-4254-864b-99bb7ac1509d@baylibre.com>
References: 
	<20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
	 <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
	 <20240810103540.03e758a5@jic23-huawei>
	 <4bdb10c2-057f-4254-864b-99bb7ac1509d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 12:03 -0500, David Lechner wrote:
> On 8/10/24 4:35 AM, Jonathan Cameron wrote:
> > On Wed,=C2=A0 7 Aug 2024 15:02:10 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >=20
> > > This implements buffered reads for the ad4695 driver using the typica=
l
> > > triggered buffer implementation, including adding a soft timestamp
> > > channel.
> > >=20
> > > The chip has 4 different modes for doing conversions. The driver is
> > > using the advanced sequencer mode since that is the only mode that
> > > allows individual configuration of all aspects each channel (e.g.
> > > bipolar config currently and oversampling to be added in the future).
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> >=20
> > Main thing in here is I think you can use available_scan_masks
> > to avoid the need for the error path on just the temperature channel
> > being enabled.
> >=20
> I had not thought about doing it that way, but now that I am
> thinking about it, it seems like we would need to have a scan
> mask in the list for every possible combination of channels.
> This would be 10s of thousands of possible scan masks for 16
> channel chips so that doesn't seem like the best way to go.
>=20
> But adding some special handling to make the temperature
> channel just work should be easy enough to add.
>=20

Not sure if the following is meaningful to this usecase but I used to think=
 like you
but then realized that iio_scan_mask_match() will do bitmap_subset(). So yo=
u only
need to enable a subset of the available scan mask for things to work (and =
with that
you should no longer need an insane number of combinations). The core will =
then take
care of demuxing the actual enabled channels. AFAIR, strict scan matching i=
s only
used for HW buffering.

- Nuno S=C3=A1

