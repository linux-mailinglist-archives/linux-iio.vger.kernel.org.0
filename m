Return-Path: <linux-iio+bounces-4030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7C8974AD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1206CB24A11
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFFB14A613;
	Wed,  3 Apr 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TuEH3ztd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91343433A8
	for <linux-iio@vger.kernel.org>; Wed,  3 Apr 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159726; cv=none; b=n0jYOuHeqrCTqPASBjMmEfk2T2IvcHjhzr+6MwqNQ5AiYa6wuxe3ppikZitEmv6jvi3GPk/hb32Jkok3eA8yMpQaQUo6nF/SsZBS/UrlvkOfn+Nop49iA3ai8a3eKuuuXN9pl6C8aNsJBue57YFTIppMbnGduiAgtiz6AyhiBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159726; c=relaxed/simple;
	bh=/o6IZyT1LfuupSF3G+8xq2Vg1z1nzIx/s7vaBZlSSG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQapbQPx3V+aqjTlHOeponDsBCvFdQ9FG5l3TqqHbFtH6ljLa+B2VBlHxvswT4z6Lyc8CHXHskb5kFyvh7CD7qMBbAhwgJFoQpUmmtw6xSmIDBflOyiXCBajiaFbTTQ/j/r7Hi5Ua6CLWx1hwU5Ab9wShT8ELN/QNXq48Qp3aKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TuEH3ztd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51588f70d2dso8557658e87.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Apr 2024 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712159723; x=1712764523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvSkYKcaQbv67yPHeuZ/wW0CyAcjTwHZKDOQEYRmRhg=;
        b=TuEH3ztd7pS/9HOa5LN2VfWm0C2PXLRlPxdPwTETRlga7kanYKnOs3xMnSdhUuwivN
         th3xKIHpfHEf6GKewqL9zwzsbaDvNN8FpFFJ3ed+uiho2NsyzsfpHxmzRx0AGgc2UUuO
         rxG/G+q5hGqfLNQc4wGmy4fe/5olY/wChLmk1/TOHXzutEOt1afJQzYm2c1pvBYsIxxx
         oh7aArthlbZYd4YHLKPFeFib+Z9FwcXQ8WQJSuLROGVbV1CPBWeQLEkg+ThEbS3lWxDW
         MRexxdd3tF9X2eYJOxAtU0OReWX3KExD6BMukD/iNqpTmO5H2u/QnDlG/kynPgAK5b+i
         bEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159723; x=1712764523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvSkYKcaQbv67yPHeuZ/wW0CyAcjTwHZKDOQEYRmRhg=;
        b=jB6A3hGDC69V49PnW7OJNclOs7a/z/4VqzGqYE1hiiVmdyRkNhFyxkaEwpIbAOjp9f
         K24NVrqLCms9ddaCTvklqu74swsJoOWnRgNDo4tAO8legmbnHKKM1Sp0OoanTKsXZ5KA
         GYjW7TlZqSWycYEFQoyWncxssoU/6pNR9Z8hZIsyG/eyT9uWv8IBx1KwXM/tABt9Wm+W
         Org5Ve9EertQ1JGEGPu+2CzJgmXrhpuW5MHmbnltjczh93u0Hp9ATE+lY6VqOvKzkYGV
         hIKGEvaw3kWpOSis8eV9SlOAuetjIvyVLiZtanlIk24/4VADZvFKxqOwbDSNpHB28nmf
         221Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCDThw2Mxn3tlH2jlsT26dA2U7rtJj+6L0rJY8jkK1lSHnY4GE+5CddS5mHQNSw9AD2kBABPemMfH5uuQOnf9x2ugx8GiWxY8/
X-Gm-Message-State: AOJu0Yzw0AKUhHNAEuRM9qRZ1y5P++ffN6xAbmvGLFF7Rllgz3KgFM+z
	40EDZluYi+yWQUpJYfeoYhuOYy/0HIh1iSBH6mNUu1o5yt0TwJNnKK6qwqY4T/b+7Xrj7vIigEn
	yeSqPDE2OvrBE3nmu1QNOItINRFnDIo8oN2R5xw==
X-Google-Smtp-Source: AGHT+IH/4+JhH3G1jUDn64Y/+eh5lyT/4m8lKfMLh68eVFUoan0LdJw5TkrgcxLN/CUrlMztFQihUcNA0I8iVYniD6U=
X-Received: by 2002:a2e:90c5:0:b0:2d7:447b:c30c with SMTP id
 o5-20020a2e90c5000000b002d7447bc30cmr33524ljg.48.1712159722851; Wed, 03 Apr
 2024 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-3-34618a9cc502@analog.com>
 <CAMknhBHo3xkkZymVfvauL7nBPn9+c1ZUoPwyk4mJO4syRJEhiQ@mail.gmail.com> <1d777161-7d86-4d45-91bc-c7653504b890@gmail.com>
In-Reply-To: <1d777161-7d86-4d45-91bc-c7653504b890@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 10:55:11 -0500
Message-ID: <CAMknhBFohF_0NUDeweO=dWdStREZrphpvTzke7F6Ngr-7rXriQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: ad7173: refactor channel configuration parsing
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:01=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
.com> wrote:
>
> On 01/04/2024 22:39, David Lechner wrote:
> > On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Move configurations regarding number of channels from
> >> *_fw_parse_device_config to *_fw_parse_channel_config.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >
> > Commit messages need to explain _why_ the change is being made [1]. It
> > is not obvious to me why this needs to be moved.
> >
> > [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#the-canonical-patch-format
>
>
> Jonathan Cameron:
>
> "
> > +     if (num_channels =3D=3D 0)
> > +             return dev_err_probe(dev, -ENODATA, "No channels specifie=
d\n");
> > +     indio_dev->num_channels =3D num_channels;
> > +     st->num_channels =3D num_channels;
>
> I'm not seeing benefit of duplication here really and logically it feels =
like
> a lot of this last chunk would sit better in ad7173_fw_parse_channel_conf=
ig()
>
> Perhaps that's a job for a future tidying up patch.
> "
> https://lore.kernel.org/all/20240303162148.3ad91aa2@jic23-huawei/
>

Thanks.

A Link: and Suggested-by: in the commit message with this info would
be a reasonable way to communicate this.

I looks like this is also adding an additional check "  if
(num_channels > st->info->num_channels)" in addition to moving
existing code. It would be helpful to have the reason for this in the
commit message as well.

With the suggested additions to the commit message...
Reviewed-by: David Lechner <dlechner@baylibre.com>

