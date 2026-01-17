Return-Path: <linux-iio+bounces-27903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A96D390A3
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D433014131
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A033F2DF717;
	Sat, 17 Jan 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQGbBfYF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B2281368
	for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768679115; cv=none; b=UI1Cz6GXQW0TrP1kcRr25Pp2K/Rmu1i1AUKCcA3V2jJkuI6mEMrwyqtMDf8MS9Z8ujmej8YugPppyPZnLcJhv1AVKSADZ432vdcVMI6BGBbZpsDYOmgHi0B/LYu9IIrDewUG/2IlAFwKYkNgLe9CRQ6wxUg1dLZvB6meYvIfnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768679115; c=relaxed/simple;
	bh=jpqBLBtcKEzVsS7UF6kIY4x735PGlJz3V7jBe9IpCYY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nTHInBJ16wmWVj7fXhsn1rROL1FQXXsc10T95KlM0Wp5VHYSUgr5TAjsRRXELjVulc4+/UZSSI/DfeAwtjTAAttwvAluX+0ZFixb7lrM4NYCxRoI9C8GijJGN9oYiymDWeJxQ+XmDXSFH8SeJ2An74FTx9MuunzbFl64xbT7+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQGbBfYF; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94388cfa259so908464241.3
        for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 11:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768679112; x=1769283912; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUH5YLlwfZi0OdbE0v9gLIiwvyrwpkrw6SV78GoWRsU=;
        b=DQGbBfYFU/rSrnUQdH8fIdgVI81v7H62y/i2ce0NUl3jOk9LTTp9LvGe0bHEsm5RZE
         UNe2hZ2o/CH5oRFSKZqP0nAaow/1azhMYTse5bSxgEZd6r2x3jg5YPKwvubNSOAcyiPL
         fONGwEBp5jJDHlGdYclUc1EbvLCe67/LbZ82EuxLpv8uEcztxSrZcrqG7tuQqF2xUAWO
         e7COComj+e4ZsfM9muDyYjAzwoZ/YzDK3yBXnksF4xSxkgOs1QREVHe2zrYIEyejPR3J
         bZb43Luf/o3aivvNpTL7yqziHtWJ9rGK4PCfm8ujc1WY+6dV4DRdsOhgW8A8sQspEuxH
         ztkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768679112; x=1769283912;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUH5YLlwfZi0OdbE0v9gLIiwvyrwpkrw6SV78GoWRsU=;
        b=wkt2ebPtDab9bdL421GzvxFWzAuoXbXB8bKv4BEYdeVH+i/KrVP0Fv88dwvvQtVc3l
         33ypUhQhZwH0GavVc+0V0pgDDsr1Ufs02iOnSYIzlJcLIJpOzuwCRRyeQxdk+VuuN8Xp
         ZFT/W+r0/7MHnOJm9ufT1IkXODoJhb+EpYI4o9XNTB50fX2o9WDnXu6EgdI3I6eMdTvx
         SHB1gmjpSyzLOnK9lJQt0q0dW9f0YlM7hQNi4/nYbyegoddV3LR4j5H6kumDrYyDggMa
         /OhgLvwo6z3qHp+U5kBaUtBD0w+3/ArqyDog3Eh9/luQ3P88a7fjdSyL8iP7WnXoUVJ8
         eTkg==
X-Forwarded-Encrypted: i=1; AJvYcCW7jjdg216CQBeiUpKGKRNARizCjA0/amJpvzoZD9fA4/Eekj81dXbnucxwNMnRdkEvKtMD3sWcN88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgvjWyPB79BPBa9v+9NZLtSylZM/fQzYEv/Dn7mgKYrCBQiyA
	zNpN7ZQyWI5L5UofBrpXP7VNYn4JEJEfnapLRH/GDrGdD8z0fPz5SzRh
X-Gm-Gg: AY/fxX6y1HBIOMZO6iPekcalDP8fih7jNOAzgacY5sd3sYJIX5yqaPowG6laet0OscB
	PLKJe5ikJbdH4olY9mlJWaO5Af3fLya41oLdtg9Wnrv43pzhvbHR4+B2mq+r/Oq6lm9OFXVvuFL
	Kt19Y7MtG5zCRc/fPavIcVz5fLnAQHpS1uwDVDTbpjEn+oHOYn4r+WZI13ksz9l11EyiPDIMlgS
	KsPQjcSQhb/hxKCkhwttKFtrONn0WdAIJmHUL/msQ+WTjQMCsq8o16hrP+JvM0TNI6IEsOy8YAP
	xk73HiwEHd96Ad7WbiWU0wqL+L27nCYPRWDZ+kU+a4klEVsM4DEtNu445EfbF3RyUnA/ToZ0z87
	jAF64XURivMUxcj+bfljUwr6Sk4oH5oREYO4kSc59FSIz1uAw/JL00dQKDz7zyLboLw/b43LeI1
	wQww==
X-Received: by 2002:a05:6102:e08:b0:5ee:a0de:65d5 with SMTP id ada2fe7eead31-5f1a720aa52mr1737315137.41.1768679112408;
        Sat, 17 Jan 2026 11:45:12 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d03c2861sm1785523241.3.2026.01.17.11.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 11:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 14:45:04 -0500
Message-Id: <DFR4EZFDOSJS.2U76CKFU7TVT2@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v3 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260106-lock-impr-v3-2-1db909b192c0@gmail.com>
 <5a953bf8-857e-4c67-be43-d60cc9b5a34c@baylibre.com>
 <CAHp75Vei0q4bJrfuv28B+f-JOn2DGBkE3LT3UX8TiTnmUgDw_w@mail.gmail.com>
In-Reply-To: <CAHp75Vei0q4bJrfuv28B+f-JOn2DGBkE3LT3UX8TiTnmUgDw_w@mail.gmail.com>

On Sat Jan 17, 2026 at 7:01 AM -05, Andy Shevchenko wrote:
> =D0=BF=CA=BC=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D1=8F, 16 =D1=81=D1=96=D1=87=
=D0=BD=D1=8F 2026=E2=80=AF=D1=80. David Lechner <dlechner@baylibre.com> =D0=
=BF=D0=B8=D1=88=D0=B5:
>
>> On 1/6/26 2:06 AM, Kurt Borja wrote:
>> > In order to eventually unify the locking API, implement
>> > iio_device_claim_direct() fully inline, with the use of
>> > __iio_dev_mode_lock(), which takes care of sparse annotations.
>> >
>> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> > ---
>>
>> ...
>>
>> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> > index aecda887d833..3cf340208694 100644
>> > --- a/include/linux/iio/iio.h
>> > +++ b/include/linux/iio/iio.h
>> > @@ -664,31 +664,47 @@ int iio_push_event(struct iio_dev *indio_dev, u6=
4
>> ev_code, s64 timestamp);
>> >
>> >  void __iio_dev_mode_lock(struct iio_dev *indio_dev)
>> __acquires(indio_dev);
>> >  void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
>> __releases(indio_dev);
>> > -bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>> > -void __iio_device_release_direct(struct iio_dev *indio_dev);
>> >
>> >  /*
>> >   * Helper functions that allow claim and release of direct mode
>> >   * in a fashion that doesn't generate many false positives from spars=
e.
>> >   * Note this must remain static inline in the header so that sparse
>> > - * can see the __acquire() marking. Revisit when sparse supports
>> > - * __cond_acquires()
>> > + * can see the __acquires() and __releases() markings.
>> > + */
>> > +
>> nit: I think "attributes" would be more technically correct than
>> "markings" (since we are touching this).
>>
>
> The annotations is slightly better because these are for sparse and not f=
or
> compiler.

Hi Andy,

Yes, annotations also matches the Sparse documentation so I'll go with
that.


--=20
Thanks,
 ~ Kurt


