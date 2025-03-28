Return-Path: <linux-iio+bounces-17303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7CAA74508
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6F189956D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66677212D8D;
	Fri, 28 Mar 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIQ0DVVE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A5169AE6;
	Fri, 28 Mar 2025 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149334; cv=none; b=uo2vTHR04vcQNVNYO3ZAQUxwzNTSaRz/IoN4SrCtp30otcttULtfkA9RbsLhhP5f8WQ8NKzK9P8qn4CiCKrDUu719uNEVtDkzxzqUJz6wfOVTVpmP6LqzTQW2BSqr+jnkI6JWJqyMdmK6JTbQ5r9M1jIWlCT0AJDTyzrPy+SEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149334; c=relaxed/simple;
	bh=InrNul7qa/lh5pXIjs1iXVFpj9hcpH6G0oj9uxoc6b0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2SIgRhkR8UYOi6F2PZN5hJ/6Q7xW+Xu0CvqP70Sok82EEO6Um5KBJUEKW3k8ZUVxQWaNJoQOfpW9VIuNAM5iFQdJlCEzW+A2Ve1Mf1Im1IBrmV8NIhUiSyni0GJ5otsH01Md55bVCWVv6kFQ0bz8kv2Oygepye6w8QcXmA4hMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIQ0DVVE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1037850f8f.2;
        Fri, 28 Mar 2025 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743149331; x=1743754131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O7ucuxPkv/euKxkasdPgWKRmfgNwA2ryVrGut1FSiZ8=;
        b=nIQ0DVVESdOisn7k8EN+VNZZalaY6algAASe4ZJPDKnjs1nRH3o9l0ZnVHDnMQt9jf
         DBClrTS+xgE5UpWfwsy6c9hdDwKqttNhmzvSB74w8Smxb/KPQxFmujvvd2Hdyu1g0zRj
         qG6XdtEnYQhsEREDiznRWIq+sfrFC9m+anniepjcxiPwtQVb7clx9jXwN3ss2s/7GqEI
         JgSSTblgyWepAPWJ5MuZYoVP3BGqUObegdvdgR+i2Aw3Y/WjvnDK/Bak17FkNJYUnVek
         0ClcikZRd0E3k6sfRhrlOx4ao3B4axY+XjtkJgsKICNahJKxRkfSpK9oyo8QxAp41fce
         5wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743149331; x=1743754131;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7ucuxPkv/euKxkasdPgWKRmfgNwA2ryVrGut1FSiZ8=;
        b=xUlaAGN88fq+vqYIae5zdhVSeica0S0h5waeWnLHlvqvCzvlemIOM4krPp7Yw4o9ZZ
         Z8JSwPCPPQitYFYmg4ft7wQWjzsvKluc0cCbQp5fOMLv+AH3tA7g9nW2dsfQ/sEWwNIf
         oPthf3Q5D0jxD308qykTlpLvvhdxRP8A948Iv0pq78FtMGltGW9jNLHxch0Nj3oXM669
         TLFZ2uLqZ5/Zz+t6cVGrECcZL0O7276TcxX6AJ48JGa5I6PY6L/D/72eCfMe/wCodIBc
         byL285FwX07RC8mDPBHl7IJHo9SNLTuiF7Geyef4qnbXW91gVGBXv0bnSuORSk5Mr4Qc
         8weg==
X-Forwarded-Encrypted: i=1; AJvYcCUY+dCY6MoCt26QD77XfvjCdda+WDOtd8MoQm8iZ+jrA+q2YK77M4PQi6bdnDi1n0E/HcRxJvnBZ+EB@vger.kernel.org, AJvYcCVujHD2sl1dS4veQOmXeqinNvqkvpfDSSy6YFk4CKc/kqzORizk5kY4wMWXpLYW18Us5nf7cmUXaU4=@vger.kernel.org, AJvYcCX/MG4RbmN3H35kRhbPyN9YshgeJl5v8QCpycIiuWB5sUqQtZRE2sZlkBaKwjquJb0x6zyWc+nqvidGCKl7@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJZk9+lSq0faLPwS5p5gBiphMF+m2bxJ9wpoAKARVPQ1o5Hbv
	L+pINogpcfzT5MxUCD5Q7tcVMo0RsdyEB150vfnb+Or2WJVwV7j8
X-Gm-Gg: ASbGncvEkAONmEGI4a+uZckGJcQyDmXjyWJZZMPX3IEa8lfZBfDPECg918O9autp42w
	CSamkpQ6abb30d6z21lnskFtXxKHwnutur4uvpCvikZ6aqSja4vrx0J3ft//B5LJpVPhWNuilgY
	YiIFTpPWos79qPHogrty1leX/+xTXnXeJZgzxLhUfGbZEvYXR9T26tWkg6KH2rREXFnpQ6aRZfS
	aSMRGbwK2FBULKzN7MQ7LHfWR6hkgoSXhSH7Lgt5RPUQvRlRywNHAmtfdX+XWvpWPPEi4S/xQ7U
	Ko+B3C5pAyvc+y4qAIrUeRHqVa5RPaTEe74D8SufnjZq3Xc+T8dEV2W44iJ8GY3TC0IewxupvVy
	9VDCoO02CdjVkKtAL+D0=
X-Google-Smtp-Source: AGHT+IEDCFyb76KgO8eEZlEodD/ErrzWE3zAEADds3uv5XxGcWPz0nUzqaFd0kliQQNvMHf6xlHtTQ==
X-Received: by 2002:a05:6000:2913:b0:391:3150:96ff with SMTP id ffacd0b85a97d-39ad17564camr5027564f8f.32.1743149330487;
        Fri, 28 Mar 2025 01:08:50 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbbfef2sm19503025e9.11.2025.03.28.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:08:49 -0700 (PDT)
Message-ID: <e21bebc869462071519bac95daf06c6c22953325.camel@gmail.com>
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Corbet
 <corbet@lwn.net>, Olivier Moysan <olivier.moysan@foss.st.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2025 08:09:06 +0000
In-Reply-To: <Z-VADhMDmmPFhlC5@debian-BULLSEYE-live-builder-AMD64>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
	 <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
	 <Z-R3E23hWiUKDc6q@debian-BULLSEYE-live-builder-AMD64>
	 <yxhvtline3ey3ekybqfe3k4y4sm6746wpqwpydxv2brryironl@u2ezr3sryqxs>
	 <Z-VADhMDmmPFhlC5@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-27 at 09:09 -0300, Marcelo Schmitt wrote:
> On 03/27, Angelo Dureghello wrote:
> > On 26.03.2025 18:52, Marcelo Schmitt wrote:
> > > Hello Angelo,
> > >=20
> > > Patch looks good to me.
> > > One minor comment bellow.
> > >=20
> > > On 03/21, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> ...
> > > > +
> > > > +static ssize_t ad3552r_hs_write_data_source(struct file *f,
> > > > +					=C2=A0=C2=A0=C2=A0 const char __user *userbuf,
> > > > +					=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> > > > +{
> > > > +	struct ad3552r_hs_state *st =3D file_inode(f)->i_private;
> > > > +	char buf[64];
> > > > +	int ret;
> > > > +
> > > > +	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbu=
f,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	buf[count] =3D 0;
> > > Shouldn't it be
> > > 	buf[count] =3D '\0';
> >=20
> > Why ? I am zero-terminating the string properly.
>=20
> Oh, okay. I was just more used to see '\0' as buffer/string terminator.
> I see now buf[count] =3D 0; should work too.
>=20

I agree with Marcelo that the more natural/readable way for terminating a s=
tring is
using the corresponding null character (ascii). Probably not a reason for a=
 v2
though...

- Nuno S=C3=A1=20


