Return-Path: <linux-iio+bounces-26954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D87CAE334
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 22:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD8930647BA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C32DEA80;
	Mon,  8 Dec 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN1qyvL3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53182D7803
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228370; cv=none; b=MjHTDq/lOFwiev5KxRBeveEQSXmyyKWrTT3Umqn5GnjZyZZCdaYAje6RmwSL2PRfjnwiOIqNvHwhrsw1ImJL4S7O4jOf57wpNLbRzvuFc0qHiXP9Y5m5WfeOTBaIt+apMqI2ntZqqsjMSxdT/MsutK5D6CK8j69u1Chkxu4iaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228370; c=relaxed/simple;
	bh=/eT67ox63Y2ukyMLEkJ7o4b1T9x/HDKX33n+Cz5ZXX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSXJdt+HupjQPlTt+Nub6cEUJEqTFbJQ1aPbmtOfFJwKCBCz7Ke0bQCQed6XIUYL9iCDDZmgIjs0ngUGMmFQckeBXc1u3p02WbSAOJVtlYfeTPql8uiX69JnjSf3JY4PvWKuIaSpCcFLAJzuPgoGUlIi4vEb1vFOyw6/ND3r9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN1qyvL3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b47f662a0so2981533f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 13:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765228366; x=1765833166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rv7pv8F5RO+cWw9DM2GqkbgxyRJgD6vx59IxXgSv8+A=;
        b=cN1qyvL3CuoYUrWP6lMSGlsWS+dW7HAOaUGuL4MorolNH1Be3bero3WQi4OYnUiCi6
         5ejAcNsAtpfY3LL1Ce1a8zGNtfJP5k9ojjYZj7NMsT1iLwsvU3BMuq100YSHiPKTAmZ0
         93aNu+gDtOluYvSNpr+lbIdvLQvweQsyiLOAKcOZCBCD1YXb4MrOS9juZ7c5VSoRwHex
         8rb2bAXPj6xfEd9MPCyhqVvH8tWV3C0gXvffzoIKf7c9tR2ulcwWzwWDYkKelakMUeeH
         8Wwxti7Wxxby0wHoXHclTCmFRVrcjX0ygnO74ErBxUbbBlbJbnel6J9lHzXUASrNtP3r
         TaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228366; x=1765833166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv7pv8F5RO+cWw9DM2GqkbgxyRJgD6vx59IxXgSv8+A=;
        b=pYADWUB19AOxILO7nlKBtcXqJzx9Qcq27ASYjIuKpfs/Auc/4Op9WIW9JhCFK3X8Rv
         lovGatIif/Mm/S9qvolfbWmlSWSIYuDwaaL8YGvqcfofFpHuwnwQRK+UT7rEuO5oBWPB
         EA4kVTcW62e6+zf5eXTLIkjiMhmjulz3SyFCVokE+rJDCbV4WbLef8LSeaeaUvg34T8J
         dcD/WWyMPrL9AD/34xypaj7x3ywr3UcbIm7aq1CsVWfC59En/0YfHuG5oaDxPslQTOL9
         FGyDdB1HFM1p+jVM6D8C8gLRppqQ8lveiomNn/QRVXUqMRVRBEbYRCRYBM8GS2CuZA0G
         V4fw==
X-Forwarded-Encrypted: i=1; AJvYcCVV3RB5gh3fiP98LpHOIaxdb8C0FcdyTvPaG657SdISeY87UEEZWkxOC6tc43wc2L2qV1YgYkkN/iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoeZGfsM2nVzUf1ZcT/EvFDDF/bQr+0pImu4nbOYO9y9IYlnx
	wvjlHHJGaAhKXNkcCwEaxfAPJ91+Omlekx1A7OAWw0USF5hR3ggErdIK
X-Gm-Gg: ASbGncsTuainarRHTJV2G3VoRMDA6G8J29LYu9KTR+YDRJZLPdvyJ/+wJW/CP6aFhO9
	Ej1CEZKTUQOBEnlUeodLKcpa77PmnCkOXrMZxO/nxNmZEbuYwnmJpT4ppEWb/HVw4wqpF2Bbu5S
	8ywR82gjulsqN5KLYN3AM4tTdJQUzb2TrpCQUA41W4nkYLJjVuGDJXXOZa+fgAn/JiIdbijuw4S
	Nr4HgiRefygn/mx7EBY5SwVGa2LgYwa12K5Cue4mZCW/QH/LkqOeljGeabFkdQux4JU6FxWeboF
	glLgz6bskle+0upBmXg+cFfZ/H2hxFao8YSmgBvsrQHJakIpYvi1iKkOuUvjCSiJg+PpraMVbdj
	8A68yPaetoZ/NN5FB8KAAJLRu6/sTEJxbFwd+YRPbVaoBQlUJPOGZRzHyLHnaEq/1HZPsSkUPj7
	R9EpCtJ0mid13krmHvqqBC5CSAPdjZlIWbSAs9rYQe3kqZv6E1Ej6Tr0LvT4UOgKhH5iE=
X-Google-Smtp-Source: AGHT+IGziC8WJUD4dISbRmg+IA/4zSrbcv8g/8vcOpn2B+LAP5qj3Xlp2TJThfuKL3AT7cfP8cG91w==
X-Received: by 2002:a5d:4741:0:b0:429:cacf:1065 with SMTP id ffacd0b85a97d-42f9def752dmr564283f8f.17.1765228366006;
        Mon, 08 Dec 2025 13:12:46 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1226:7701:cdbc:9893:8abf:1309])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm27548839f8f.11.2025.12.08.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 13:12:45 -0800 (PST)
Date: Mon, 8 Dec 2025 22:12:43 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/9] iio: adc: ad4062: Add IIO Events support
Message-ID: <trpmhlupu3vwzrulnctewwnfxwtlbr6iovtw6whyzfpjbwnpdh@rcdykddqwoal>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
 <20251205-staging-ad4062-v3-7-8761355f9c66@analog.com>
 <20251206175231.3522233f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206175231.3522233f@jic23-huawei>

On Sat, Dec 06, 2025 at 05:52:31PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 16:12:08 +0100
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
> > Either signal, if not present, fallback to an I3C IBI with the same
> > role.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
Hi Jonathan,

> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> 
> Similar to below. Consider factoring out this stuff or I guess wait
> for an ACQUIRE() based standard solution.
> 
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> 
> Whilst I do plan to take a look at whether we can do an ACQUIRE pattern
> like the runtime pm ones, for now (unless you fancy taking that on)
> I'd be tempt	ed to factor out this stuff under the direct mode claim into
> a helper that can then do direct returns. That should end up easier to ready
> that this.
I will factor out, adding _dispatch() methods to return directly, so

	if (st->wait_event)
		return -EBUSY;

	switch (type) {
	case IIO_EV_TYPE_THRESH:
		switch (info) {
		case IIO_EV_INFO_VALUE:
			return __ad4062_write_event_info_value(st, dir, val);
	// ...

> > +	if (st->wait_event) {
> > +		ret = -EBUSY;
> > +		goto out_release;
> > +	}
> > +
> > +	switch (type) {
> > +	case IIO_EV_TYPE_THRESH:
> > +		switch (info) {
> > +		case IIO_EV_INFO_VALUE:
> > +			ret = __ad4062_write_event_info_value(st, dir, val);
> > +			break;
> > +		case IIO_EV_INFO_HYSTERESIS:
> > +			ret = __ad4062_write_event_info_hysteresis(st, dir, val);
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
Best regards,
Jorge

