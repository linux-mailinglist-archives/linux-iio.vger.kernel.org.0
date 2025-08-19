Return-Path: <linux-iio+bounces-22970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99326B2BEA9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2063BCC7B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8860322549;
	Tue, 19 Aug 2025 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEzq4xM+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3431AF13;
	Tue, 19 Aug 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598425; cv=none; b=bcM2pIImQOGcIU5QKf7vpz4r8PQ3agKrNkQQE5VqFArXd0VywCTPq3SGc72nNHBvS/YSXVtG3l4apmUVXwA9B5KZ74zMzw5WxZ/Sd6yiTbqWgWYXvp/W37YqzuSh4l6SOWnWsw1I0bwaD3hdSFuBxw8Rc83hZpSOb7vASF/2YkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598425; c=relaxed/simple;
	bh=Sx1xRKhCMiBVSZvHk89ednrAQyd188BdTXI7cXzjjgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrZnNUPWbCYBOgxvS6S4px0nfCZTAXa5NOkR6wmfw7QZtD1wfzCHhwDT7kyO2nFUY5lCa4MhrBSQ7KNNdZKOWPUPDYGnxPSFv3JNvAM6TncL07vVlzYmkOBoS4fimW0p5EnqCqQWEl4PQDek0c5T18EkgX9otkRROwSUnw7hx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEzq4xM+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so9824766a12.0;
        Tue, 19 Aug 2025 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755598422; x=1756203222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igm9UNt35+r2bPukm0KDUvyKlEf5M3uSsYgBybP4fI8=;
        b=hEzq4xM+mEH1wv1XRUN/BzqCtW8StFCRIMt+sT9KZE/CUpD4GQvrsYQbtxC4MnzIfl
         Z6+TaY/WmjT4OyqDaAgX8LJJRWt/Tp7bIChyJzn7B/mrr2Xb9dM7t+/wqxK3whjvVTMS
         k6E3kGj5Hj5Zhg+40sCYQ/q3npTAh7JabfDpRX7xtEOsRTPAvBDUzWOfysaDBHQRqIfZ
         WhaWkdcvKKQrC+BKaKmWASsB0LrkxJX3htAXHVNlGVnOW1gbjBM+cC1InqDAieApLAf+
         /Xvkxa300bySVsANW1sQ8GeYxAyqJFV/fwKW0rJk1sUGkONztMWYCOfIlGWgYYlSTqPp
         /xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598422; x=1756203222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igm9UNt35+r2bPukm0KDUvyKlEf5M3uSsYgBybP4fI8=;
        b=JXCiHKGp/dDCDSXCoMLoccasIbxyfE74bJmx36+ri14sF9JkE1RU4yf0a5J57EPCU5
         JeWHiDnbAxZOcAP/k+j8W3muUBR+vNsh8cJ17Yv47b/Yds93Vo1uFSPiUTg0riyNtkOO
         gSWfZdreTX+uCS4V1tZjgxhsyVn3qmy9Rk88ivImDIYaMgsRo/Bck2ujFuqSKlDYOFOF
         Rfx/y7bybyW1Bit1wocYmJBW+l7G1dQnfb+dnKV1kS/0NXJF4wVEFWINPdqp0hu/aUJA
         zmGtC3QZYUmT95VDLu8TRLigK7WuWjSiANqBnRJKJIgw/u/MS+TyckP5AGWiVWTb2eVj
         Ep6A==
X-Forwarded-Encrypted: i=1; AJvYcCUsqiXti9d937VZ56gAw01C2Zy18KW8R3vtc9KUBvrDf+ezDorNZ+ju3k6xPIm3LT0DYB3PoDhpdbE=@vger.kernel.org, AJvYcCVnihwZc3xnpjMOpsT/a8cb3PVoK2ZIWuvuHyOoO8ueRo7Ubp6qeMDh5olwiv2MHPF+4zB6AVd2WLOCOMQZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tykWoTVdJsIKPftJ1bH6tkg9fdBqBNGnDKxC8mfIk+7a5W2Z
	rVqvgX64dOSBqxVqsJYvGPtq75NSCpULNHobgGTz+C0j8sNB1xe7oGBRcJ2RL8jfT8g5Hl+0c3d
	3Yn+s5IkFzpNE/7h+wAZnARq70iMGyfI=
X-Gm-Gg: ASbGncvZKOM4lnhSUEjxZ1YpSCyrjzGk3x7aUDuFTnPePmWFS0SR7bVMdz92QkvLlhS
	KEYkC6lJmhQ2BGID6e4TFxhhQwYcEjIFcMouqcmxXygdwtqPJoJ8Tpe4Lgovs6mPo8rTsobeyTm
	DkdE3DZQxI+UZOUfVCto4wae/X3RTO1X4hCmjcdoe6fZlaP2V79iKhYBBX5EyzfAFXfRe1zVebO
	iaW9GE=
X-Google-Smtp-Source: AGHT+IGDz618fgT4GCP+YY6LOssRsxMr1naIcF3EI3fbP+cw2/wkKeUXylV2nfI9ImUFL1yft5BxUG8OULWnXl7KhB0=
X-Received: by 2002:a17:906:6a1d:b0:ae3:ee3a:56ee with SMTP id
 a640c23a62f3a-afddf019718mr189932066b.3.1755598421806; Tue, 19 Aug 2025
 03:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819085542.538715-1-rongqianfeng@vivo.com>
 <CAHp75VdAySwLZ8gf_mDoQDX4KdC-hsCYL3VbkZSk_NSKNY5VTw@mail.gmail.com> <995cbacb-b01e-4799-84ab-44d58ab32ab7@vivo.com>
In-Reply-To: <995cbacb-b01e-4799-84ab-44d58ab32ab7@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 13:13:04 +0300
X-Gm-Features: Ac12FXySjWOMnzXdcY4RWnUwj1lo7idmpyTpZpYs7LqwdZHUeEkig6ia0yuRJjc
Message-ID: <CAHp75VecWJXd-kP8mhFtFZpiU-qcW3_nQz=w1Addq7SHTv=SSQ@mail.gmail.com>
Subject: Re: [PATCH] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:08=E2=80=AFPM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
> =E5=9C=A8 2025/8/19 17:46, Andy Shevchenko =E5=86=99=E9=81=93:
> > On Tue, Aug 19, 2025 at 11:56=E2=80=AFAM Qianfeng Rong <rongqianfeng@vi=
vo.com> wrote:

...

> > While this change is correct...

> >>          sensor->freq_avail =3D
> >> -               devm_kzalloc(&iio_dev->dev,
> >> -                            sizeof(*sensor->freq_avail) *
> >> -                                    (sensor->sensor_info->intervals.c=
ount * 2),
> >> +               devm_kcalloc(&iio_dev->dev,
> >> +                            sensor->sensor_info->intervals.count * 2,
> > ...I would also switch this to use array_size() instead of explicit
> > multiplication as it will check for boundaries that are not static in
> > this case.
>
> I don't understand what "will check for boundaries that are not static in
> this case" means. Could you explain it to me?

intervals.count may be anything and of any type. Compiler may or may
not proof that it holds the value less than size_t / 2 (which may be
=3D=3D int / 2 on 32-bit platforms). That's why it's better to use
array_size(intervals.count, 2),

> I've experimented with the following command and found that kmalloc_array=
()
> generates fewer instructions than kmalloc(array_size()):
> objdump -dSl --prefix-addresses <changed module>.o

It's about the second parameter in devm_kcalloc(), and of course it
may generate less instructions but it's irrelevant to my comment.


--=20
With Best Regards,
Andy Shevchenko

