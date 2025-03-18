Return-Path: <linux-iio+bounces-17015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92186A67025
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 10:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AFF3AD4AA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3171EB5C7;
	Tue, 18 Mar 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7A/dh9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30917A2E5;
	Tue, 18 Mar 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291140; cv=none; b=Il1jjiFiDKFy91gHXWqXQwJkXN9OnNDSICrYCnKZcEhtAHQBGweNbm/JdJXNllwixLxsgH6MIphS4gFF+MC9ZCo/kU91rh44hjrHdo07cLASY2tlAqF54Vq2PX/xgzYzsW2u0KAY3qGxVgOy8GEljax8ox9+L48EyJETQ8RKTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291140; c=relaxed/simple;
	bh=NI+icNdHE/kjJDSc1Rv9EnAjGk02C1vXFp7hrpGJnJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q36U1i6pHOvI7mAyLdh0yYuig2VujDuJKYEWF4FCx4LrfcHtWsARgl9hOSnI+Z6O48FvsL1NIhtYvt7OewhBg7yy00ozlYv/BrTCZCKn3mDIdBDwnDQc0zUZBVKirHKzpRK0EBr+L+88sIi3tfNmt3wNtDoexJkhF5sU1VWPK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7A/dh9m; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6092c91a04so574174276.1;
        Tue, 18 Mar 2025 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742291134; x=1742895934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qn84JDuDA3xLk2r2LMBqE1c86PWyWTSDKpLau5Rwic=;
        b=Z7A/dh9mRWul6+Y3Y6tDOPZKHaDbTh6siopY0DOaFz9/+PWFIuK0f4ZRId3Mgc7CXG
         /4bM8FI/samtLkQrsM60xSu+kVBqLFjsp8AwsEsHNoQjo2Z/jOfeh4BMSQw97QQpM7jQ
         fOxjye78nhRy+pG5yaPQYve7dwGx+Nwil9syu09ptDxvjGdbdBMdXwu4NeYHugk/rH4U
         Vx0FFxzz/1iQpsBJWikeUpuapuKazoPNRm0xw8ci7kSaH+voGoOiVnHBI1byxg61TWHb
         wSP7AUHT4XI69JQsVt8V3rrgscMfx79Ohtu9axIPg6HjLJ4aL7WGzbmVy5/RppGmiRRn
         kSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291134; x=1742895934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qn84JDuDA3xLk2r2LMBqE1c86PWyWTSDKpLau5Rwic=;
        b=dZUA0eeEcnvI98HY22e5uu/Yn1B7WvaCBcWivUV/5g+YdAd9bnkOlv52DBCqNZG2sm
         5FfRC9jHR8xmtbHy9oyuTD5dkogNBGNtwdeHN5pG3Mu3GWmWM7mY9AmlTfnrw0FdPrQx
         aWBIJc30obcIfYRqY7OMHB3rH6eAcWCGO4fOPV0a7TbmQExh5WHTrP3Y16rO+7ctLXoW
         Gabi7JnhTC1v2Yml/Qwl5JSBPVK9NTNAvNHwwcoLa6a4hVpfpuq/twrzML7ixX8sJJ/s
         2pXWnIMBdC+wsmNbB6nw12sMG9OfYBi4ocXk7lpPg4Rc1iJKqjTnEGF/EvVbiPNp6vtZ
         4XFA==
X-Forwarded-Encrypted: i=1; AJvYcCVr7a+yhof1BrVExLkKU8XgXzEKnoHiyEauF8n77Up/Eqxv4oZzSy/uAyT27BPjWEj+c+JanX+PTN8=@vger.kernel.org, AJvYcCWU1Xu0DXTerCRB/l1GP7neqyiCRofgU9ygVpmzQGzriBmUI81G0MXxldVi7D2gK58QHkSSjiZATOt/Cvxa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4D7bW5gLpiIzo/pln3065m1rBDgmGM+uEF4be8VQRDvMmXr4
	bIwNaFlCEf5b+OJBbg0O+HzjdI7pOfgcoywSReFEJdwiVLqzKEEwCNVkqxIRdZDcY9OmfmF6WH8
	mKi/+su96nODfqa/5FSx9aa16tAY=
X-Gm-Gg: ASbGncvG7NosNQSznJNAPiBmT4jg0EvfhepL5jD5xLxH0K7OWaW7lw3shbGGsPcv7cw
	cFKJn/sN2v11SpU7AnWDAJKUsvbs8PNShGlxBLznQ5yBX21l4xYmNiz2MGM/BgvIRteMK/IlFLd
	eMxHSrMtr+bbVXIo9vB3u4tmfVCw==
X-Google-Smtp-Source: AGHT+IFSAlgMamzFOCoXfjaQGVzSafCF9qvzhVznUeZX2L++PcI5pep9UYdaYo16f0PeoPMfE6rRnPf1VdViqrA/iFA=
X-Received: by 2002:a05:6902:c0c:b0:e63:d1f5:b933 with SMTP id
 3f1490d57ef6-e63f64ee1damr9558401276.3.1742291133953; Tue, 18 Mar 2025
 02:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165049.48305-1-l.rubusch@gmail.com> <20250313165049.48305-5-l.rubusch@gmail.com>
 <Z9ctSODRTxI53jAY@surfacebook.localdomain> <20250317105540.4b4a586f@jic23-huawei>
 <CAHp75Vc=c=0yhtaKuiE4mZTTzQdrPywt89E7A1GuHha9=V=GUQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc=c=0yhtaKuiE4mZTTzQdrPywt89E7A1GuHha9=V=GUQ@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 18 Mar 2025 10:44:57 +0100
X-Gm-Features: AQ5f1JrBxAZfBdrAtWxp08TdjIs0DoPG4EvIEstqyKFgVYM4AEguMcYoIlXCvjE
Message-ID: <CAFXKEHacRWoGz59FYJJyYjOsg5CBTAFYPdwobvmF4jUqZJJAqw@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, Jonathan and IIO ML!

Pls, can you help me clarify a bit what to do best here.  Questions
inlined down below.

On Mon, Mar 17, 2025 at 4:52=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 17, 2025 at 12:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > On Sun, 16 Mar 2025 21:58:00 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > Thu, Mar 13, 2025 at 04:50:39PM +0000, Lothar Rubusch kirjoitti:
>
> ...
>
> > > > +static int adxl345_push_event(struct iio_dev *indio_dev, int int_s=
tat)
> > > > +{
> > > > +   struct adxl345_state *st =3D iio_priv(indio_dev);
> > > > +   int samples;
>
> > > > +   int ret =3D -ENOENT;
>
> Also note, this variable is redundant as far as I can see, just return
> the error code directly.

The pre-initialization of ret is actually needed in the follow up
patches. Anyway, I can return -ENOENT directly here.

Evaluation of the sensor events in follow up patches then uses the
ret. It is also possible that reading sensor events fails, then the
error is returned. It is possible, that no sensor event happened, then
it will fallback to -ENOENT. And, of course, if sensor event happened
and could be handled - no error is returned.

Is this approach acceptable? Say, if I'd describe it better in the
commit comment? Could you think of a better approach here? I think
returning 'samples' here does not make fully sense, though. First,
'samples' is not be used outside the called function. Second, I have
to distinguish a case "no event handled" - This covers then all
remaining events like e.g. OVERRUN, DATA READY,... which still need to
have status registers reset, but won't be pushed - currently this is
coveredy by the 'return -ENOENT;' fallback. Third, I need to be able
to return error codes.

>
> > > > +
> > > > +   if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> > > > +           samples =3D adxl345_get_samples(st);
> > > > +           if (samples < 0)
> > >
> > > > +                   return -EINVAL;
> > >
> > > In the original code it makes no difference, but if you are going to =
share
> > > this, I would expect to see
> > >
> > >                       return samples;
> > >
> > > here. Why the error code is shadowed? If it's trully needed, it has t=
o be
> > > explained in the comment.

As said above, 'samples' is just internally used inside this function.
Basic question here also,
since intuitively you'd expect it rather returning a samples number -
should I rename the function
to make it clearer?

Best,
L

> > >
> > >
> > > > +           if (adxl345_fifo_push(indio_dev, samples) < 0)
> > > > +                   return -EINVAL;
> > > > +   }
> > > > +
> > > > +   return ret;
> > > > +}
>
> ...
>
> > > Jonathan, I saw that you had applied it, but I guess the above needs
> > > a clarification.
> > Was right at the top of a tree I don't mind rebasing. So dropped
> > this patch (kept 1-3)
>
> Thank you!
>
> --
> With Best Regards,
> Andy Shevchenko

