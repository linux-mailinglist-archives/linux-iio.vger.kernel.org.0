Return-Path: <linux-iio+bounces-18548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D51A97A94
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F9116EEB3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DC2BE0E5;
	Tue, 22 Apr 2025 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq/w0eBq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F345199252;
	Tue, 22 Apr 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361532; cv=none; b=FiIVBKNGBl+Vsdv9PAg4jR1AtkNSOgawgL3olhwP4p2/jkz3QbPMj71Q/bIpESH+aTW0fjfotLG7FdxfZK86lI1ws2qZdQlKJmq7BdXX0U/H0uJkXMFt94gTxZ8kxb7QK9ReWdw4Yhdf+nS9ZRBh8q9ZnMoUKPl4J1ZeaeUnj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361532; c=relaxed/simple;
	bh=kaqUDjh/CKKK56Dj510ieL6xG1HbezkcWqAvGWfZr/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMxebnVn8JOvPYPhGJBf9C7nF2RgnvYhHNrh3cadzWtFgRVPSlO5sUkgQrOAUr3Dn0h7ryvpICcAljOFfDfPUIVSHy0ngq0NxBYp4nI3+gKpxR+GoYoE0PSIB/sK3Z9cv0aeUACYg6I5foIFf26NZ/v6/FJtNd3K4As1qlJd/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq/w0eBq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so8235315a12.2;
        Tue, 22 Apr 2025 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745361529; x=1745966329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaqUDjh/CKKK56Dj510ieL6xG1HbezkcWqAvGWfZr/w=;
        b=Xq/w0eBqtXdfiTgLdRbB/FT5H5VdDNo11e6fxMQg0+DRJRlqMITxezEnAHZ04TOpph
         YLNVv/go1EkX21EcpiUJvL4NWvovcFOwWFkXd6XsGofyNHsvRwcK97NA3qJD90cvAiPH
         yVzg1aq1tOu6B1mSaj+97qc/0Oqpbz34UB4bpaGMJxrRNEYmz6k6lNtJJVAnK08qND53
         rjz55Qfjnz84xq4Jh0SvcZE++T4QBtLRi7tmHFKNmfmKbzB2aI531ZF8LHt2UGljL+10
         pb8KgIhVYRxB+H1Vtp+YzP9kWexFRihLrkD5bcNI0OOhOYZjrFOCE1y3xrlS+bw3zf4a
         VydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361529; x=1745966329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaqUDjh/CKKK56Dj510ieL6xG1HbezkcWqAvGWfZr/w=;
        b=EyN6QpRbeY6aLEO7xuoagp2eJAS9+0UpsfHrgTBhFLm2hQi1yM6S5FobQ8j3Fwo6/K
         D+5hHtbvYR5wmIItr2zmpDt2CatkdIlPi0uvQLb6Aa9wkFA75DfgUno2leOFVLGh9DmY
         L3xXcWHLDzS3G60AzT2vA1YT5jai99ykRehWyOnM20NYcoHHLd/kfsTfij+BF/1C06AH
         A5DzJUHF+sTtgEQOugi4yEUbBFPKGZ7xDRdwXW7Or8v7z2KjwG+u+olEfsuUda7hTrcr
         rzXm542AJT+QA+HQ6LsVq8No2MDXgi9ckQsy98XSQXc9nelj/vkMNLgPd9IwH76W/BxV
         WB1g==
X-Forwarded-Encrypted: i=1; AJvYcCVVXjOypuZieVuh390dDSEQl782IC7nE4FpJi+m70pE1pAIBgfcV2MbP3hArEuqi/HdIaEeBWCA5adTWa1U@vger.kernel.org, AJvYcCWet92Ig8jCO+D+3oy1dnxdccyc9sKQcGlQtNrnCMrGcFQOl0CayTkMkPWDJaeAoxGM/jWU/A9LfzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUV8fRInSMR9qVTMHaR9Y6sLq0+NbbUlTbc+3aa1b4oEuDpiy5
	SimCcy6kcVczUhMpUGsLDkszMl1wRwqrRk/r2qyLKUSyA3Bw21QdWq8qhg75ty34o5FTCH45ny5
	TkLgYvhCrWe26yWq0/DDVu6SGEZjCsFEt
X-Gm-Gg: ASbGncvLQ0IAVFfRwY8OByBIMJdz4A0p4NoHYMhcvWb+gowqtV62RuDh3MvCQifUFHH
	XHRgz/fYDqh+7QWZ9uwUl2JtyO58lPuzI9Nwev4PBZChhcfUb5MtNEbmtisFhYHehpmTUFssmIK
	23//GOMls77K+20R7vKRa6Jw==
X-Google-Smtp-Source: AGHT+IGakYqoS84SZEv+/5JcKVOFbA6PvR0BhcUDIOM3LCgvNSRjlP8tQtztn+RosjORJ8TtTk7uwWfH5mB6ZlM1hlY=
X-Received: by 2002:a17:907:743:b0:aca:cac7:28e2 with SMTP id
 a640c23a62f3a-acb74d8310bmr1585212466b.40.1745361529329; Tue, 22 Apr 2025
 15:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
 <CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com>
 <12dac98d-3e6b-4c2b-8ac0-d526bdb5efd4@baylibre.com> <CAHp75VcHMTSGRrodixsLDS-xCi8KQJ0MtMSMi7tfATUgd3E5uA@mail.gmail.com>
 <22e934cd-117f-40fb-a788-edcfc0f8b0ba@baylibre.com>
In-Reply-To: <22e934cd-117f-40fb-a788-edcfc0f8b0ba@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:38:13 +0300
X-Gm-Features: ATxdqUGGq-rgnvyDpbeAKEQdErJNGwAT2gXF3TAgpshvaCKFt69V-aGeyzVdZtA
Message-ID: <CAHp75VdAw8T_3t8=2JLO07zddjy1_eYX0bSoG9R=7TFPY9pWbA@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: drop sensor_data array
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:32=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 4/22/25 5:19 PM, Andy Shevchenko wrote:
> > On Wed, Apr 23, 2025 at 12:22=E2=80=AFAM David Lechner <dlechner@baylib=
re.com> wrote:

...

> > Ah, I meant the plural: of the supported sensors. Otherwise are you
> > talking only about one sensor?
> >
> "each type of the sensors" doesn't sound right to me either.
>
> I am talking about more than one type, not more than one sensor. Sensor j=
ust
> describes what types I am talking about.
>
> So perhaps we could just avoid it with "each different sensor type".

Okay, it might be my misunderstanding... Use the original one if you
think it's better.

--=20
With Best Regards,
Andy Shevchenko

