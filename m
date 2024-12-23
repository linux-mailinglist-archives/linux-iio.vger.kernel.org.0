Return-Path: <linux-iio+bounces-13762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119D9FB074
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2232B18829C6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865E1ABED7;
	Mon, 23 Dec 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKAoOXoP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEFE14287;
	Mon, 23 Dec 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734966098; cv=none; b=YXmqsui07FBGpGxxQyUQeuU+s6Kj44197KGmdk9qrBk55WSJJi1EiNAMRd8g/Zp8bFaX2eLScGwwftR0scUhkyDOiGfU3q+wPzg3tBjkcMXtrspcoACSyslFEBuWLjn5F93DTOGIE/1kprxEe42yg+vQOrDnyIK49zgS6X4QyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734966098; c=relaxed/simple;
	bh=an4SeWQiPCHHIReqJmBxnFGNIbXsUDYIwLUR2f1ETWY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=I5RlEPyENS4AyFsXSSFZuLHeY0ht6wcsZoDxVYq8Q0x04wMcfub6GdNZwxYURo9zfY4imfs221JCvLNNEKOcV5PyNo32SMNhH9NFbdxZ+2aAMdVTDnPe0AWkWIwb9fSt6SqKRE+XDrQCmtrH4Wse0/x0GzMN/M8ehcaIUlgl9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKAoOXoP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de59c1a0so2543365f8f.2;
        Mon, 23 Dec 2024 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734966095; x=1735570895; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fpcRZqV+2CjkH2PoWUtQ4apG/ejo4jlI5TwXjLEXMo=;
        b=UKAoOXoPPBnF+3quRBHRuh/yE4iYgjNulTHgcpGNdJuDaXiFLTPi74npFCJEH546RV
         5A9arssrirI1NdQBrjb8PQUaHeYBWZNkCvo7hjPB7SOl8QgCGhi+qV8dCWKh6Kndfg1O
         W0oMubIj/vhKPzeBHpj5YGKybx4hMyxAdmtz0j7jzDd2pJSsR6kGCoNEhWxF2grg2ThS
         jXjyOzrmubI3ohN7lplZw2IgPxuLcLvpQe2jnhS5hGa9/8zF6UAoJ+77ZZL9VwGEay/p
         XeYQiJDf7hMz2glXeBEF49AX5+rj4M74Uuck/7rTcp4WkKGKzGYpHNLqvTj98mIxlgMI
         /UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734966095; x=1735570895;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fpcRZqV+2CjkH2PoWUtQ4apG/ejo4jlI5TwXjLEXMo=;
        b=MeVx7sIOAS5tYQRpI0FFl6EPGctP3J4DwpxfPVibUz9/joUKgl+f2KrKE7/pQ7CZMi
         epunV8ZVJ1mZEe5x3eBSCq1g53uFyB9TLRIE9Op6PueOioNSOqSKa4YdgIyHFwAunaoI
         99oRHBlsxt6j0r0LxN5t6Z2w3ZyY300sO7mEf5sJzIv3Biq4rFRTvC/879IHbJ+JNWhL
         /SamS8WXn1aSytBfJTZYp56IiyzCJGIb7bQiXsPrFe5ZtZjeoOx+N8I+RpJxVeahp1MW
         j3W2ZB6MJYJx025tpFMnmnex4T+SLDUZvPssu0e5qKsMwkdI0+pHYvzuGhO1+Ohb2bYs
         wsQg==
X-Forwarded-Encrypted: i=1; AJvYcCU84454yxfMs/bfFXM2xRatYLj9JKsYEJ8KemaCF1E0J5+lvZioFj2TtnU+JsWZGIVQLmt9lo628Y2fSbVx@vger.kernel.org, AJvYcCVWHUEy3iH0nPwdPGYII0R9HsgJ9FA0O8/tm9ctCd8jBvsO5q+amKrcue+epHuCKZzX7Ma5Gj8I4B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzP1NGERAGbogGAbFERKJR/Sgf1aB79IaBkV4/oIgfT7l4iK7
	CwnIILtBeEZSTUgKqG5NtNGm7oCVDjqwybJ1tVQQye3+NVlxhE73
X-Gm-Gg: ASbGncuMHdXVyxM3vDQypszqZP8qScC+J93L6MwIMjEiYU98SMTPCb0bgY8yPXPkhp+
	naxum5Rl34e/koMN1BF+/dZpqvPdEv6eBl8UCTThzum9I6F2fGRCQXIIL5carUChtgll4f/oTkr
	tpJOOE8PQnB0017xkUmrXHLUYK17Izoj72+VS17vXFx66Jmv24V4x6sVfN9Tx7Oyxj0KdxbKOsV
	5dh2OOiH0B5gPSfJhhev8tfFESaVMGtZMXxNgNtt6efcWERuIqxl1e26lBu3i9jadmx22a/FNaf
	VNecxX0eKHxFdaYryFAKSjazW/q0XiW7GAkLJGQsT4s+q7y+xADa11PGvN6Sb3ousxo/zPayO5H
	l
X-Google-Smtp-Source: AGHT+IExmRDuCL1JwkUN/8Ds2T9/PO+s5BLoVYrkyjssMPGS6UaHVG0hJVWBezvBVXIqNbKjq1CZzg==
X-Received: by 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr13749148f8f.40.1734966093291;
        Mon, 23 Dec 2024 07:01:33 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-fae0-6705-f8f3-4a91.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fae0:6705:f8f3:4a91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e261sm11758393f8f.76.2024.12.23.07.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 07:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 16:01:30 +0100
Message-Id: <D6J65ERWRL0K.3VNWPTLGI07RT@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/2] iio: veml3235: fix scale to conform to ABI
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
To: "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
 <20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
 <20241223112932.5d3439c3@jic23-huawei>
In-Reply-To: <20241223112932.5d3439c3@jic23-huawei>

On Mon Dec 23, 2024 at 12:29 PM CET, Jonathan Cameron wrote:
> On Fri, 20 Dec 2024 20:28:29 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
> > The current scale is not ABI-compliant as it is just the sensor gain
> > instead of the value that acts as a multiplier to be applied to the raw
> > value (there is no offset).
> >
> > Use the iio-gts helpers to obtain the proper scale values according to
> > the gain and integration time to match the resolution tables from the
> > datasheet.
> >
> > Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> Hi Javier,
>
> A few non fix related changes that make no functional difference made
> it in here. Those should be done in a additional patch after this one
> (to make the backport more minimal).
>
> This change is large enough I probably won't directly apply it as a fix a=
nyway.
> Most likely it's material for the next merge window that will then get
> backported after it is upstream.  That will give a small window in which
> the broken code is in a release kernel, but it should hit stable at .2/.3=
 or
> so and no one sane builds product before that point!
>
> Thanks,
>
> Jonathan
>

I am fine with applying this patch later if you think it makes more
sense. A couple of diffs will go away after dropping the code style
issues and the 'val' check, but it will still be a bit over 200 lines.

I am planning to fix the old veml6030 with a similar approach
after the iio-gts helpers become available. That code has been broken
from the beginning (around 5 years ago), and it did not seem to bother
anyone, so in that case it will make even more sense to apply it in the
merge window.

> > -	ret =3D regmap_field_write(data->rf.gain, new_gain);
> > -	if (ret) {
> > -		dev_err(data->dev, "failed to set gain: %d\n", ret);
> > +	ret =3D iio_gts_find_gain_sel_in_times(&data->gts, val, val2, &gain_s=
el,
> > +					     &time_sel);
> > +	if (ret)
> >  		return ret;
> > +
> > +	if (it_idx !=3D time_sel) {
>
> Not part of this series, but might be worth turning on regcache for this =
driver.
> Then you can do this sort of write unconditionally as it will hit in the =
cache
> and do nothing anyway.  Mind you, this isn't a high performance path, so =
maybe
> just write it anyway.
>

That makes sense, I will add a follow-up patch to use regcache. Even
though it is not a high performance path, doing it right will not cost
much more effort.

> > @@ -309,9 +323,12 @@ static int veml3235_write_raw(struct iio_dev *indi=
o_dev,
> >  {
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_INT_TIME:
> > -		return veml3235_set_it(indio_dev, val, val2);
> > +		if (val)
> > +			return -EINVAL;
>
> This yanking of the test out of the set function is fine, but maybe
> as a precursor patch so as to reduce noise in the main change.
>
> I'm not sure it's technically necessary either. More of a sensible
> cleanup?
>

Actually, it could just stay as it was before by checking val
internally, which drops this diff. I will do that for v2.

> > +
> > +		return veml3235_set_it(indio_dev, val2);
> >  	case IIO_CHAN_INFO_SCALE:
> > -		return veml3235_set_gain(indio_dev, val, val2);
> > +		return veml3235_set_scale(indio_dev, val, val2);
> >  static const struct iio_info veml3235_info =3D {
> > -	.read_raw  =3D veml3235_read_raw,
> > -	.read_avail  =3D veml3235_read_avail,
> > +	.read_raw =3D veml3235_read_raw,
> > +	.read_avail =3D veml3235_read_avail,
>
> Whilst it would be good to fix that indent, doesn't belong in this patch
> as it means the reader has to check very carefully that there are no subt=
le
> changes in this line.  Feel free to send a follow up white space cleanup
> patch that clearly states it makes not functional changes though.
>

I will move the code style fixes to another patch. I was a bit too lazy
here :)

Thanks for your feedback and best regards,
Javier Carrasco

