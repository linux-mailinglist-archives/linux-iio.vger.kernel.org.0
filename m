Return-Path: <linux-iio+bounces-1112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01C81949B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 00:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D41F21F3B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Dec 2023 23:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77483DB97;
	Tue, 19 Dec 2023 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iXgzLxqi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6240BF7
	for <linux-iio@vger.kernel.org>; Tue, 19 Dec 2023 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e2bd8c396so4377263e87.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Dec 2023 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703028467; x=1703633267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wib2+T/twwwN/3BXe0yj7pCHfEZ8cIQ5+MZvHiZViLk=;
        b=iXgzLxqiePhff7jKystdfcjwNzwYmsPy/Pk/gYPA27zSG9G2ScITsc+zl4iJfsr/8j
         iF991C6eO9svijDDeqIYGaEyseTUoamip0QWjBcn+D5dOee0YIc4WGqvxxSqXpI+Hxby
         jRYRV1JyUe9dV+xC8e5DrR/uekUVQmPriVjQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703028467; x=1703633267;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wib2+T/twwwN/3BXe0yj7pCHfEZ8cIQ5+MZvHiZViLk=;
        b=aUq/Piw79JOUSuoe2vhuh5+JlhFSWTV8KXMzyEtRKGB1iTXi93w058XYhHBKM+hb9u
         aWwD2mOOKpriQbTHROjmLmqYnMUjrB/2eEm9V5QuUSoXqDtYxTWcIMUAsSKSDBHHkecW
         n4Wl1yaSq85ST4NZtNus8EY8h0GijqrDRHfv950EE+9ukkkzbbCEbkhbVVB5PxYWTr79
         WbL790c8qhsLwbfND9p9bszeMbbweZ22w38A6lOeJhcvAJuH2NgSM/cJ7j6++tDxTVes
         RQkrmPn2022i2uzTmCtiAgW5qRlQIe1tunax5dtIYHHcEuU6jet9zoPeGUsB3KBEULSl
         rVKg==
X-Gm-Message-State: AOJu0YwYqD0mue1JGo8yg8j0xE6euAJqazsy4yT9MWNZlC6HL5UeEfpo
	mNQedQG75qPuUKkV+eQt/mRE4ieYT0JddnYUThOyNDM+3h+Tujco
X-Google-Smtp-Source: AGHT+IFBw5KCb5vU7xJ+p2XS9GXuGS9FPMpi3yVFSCqsm9B6ldHxBfroB02RYzx+7K3tU1KZsZQ1ww5PdMu7JffeLOA=
X-Received: by 2002:a05:6512:102c:b0:50c:e98:1ded with SMTP id
 r12-20020a056512102c00b0050c0e981dedmr7072856lfr.132.1703028467520; Tue, 19
 Dec 2023 15:27:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Dec 2023 15:27:47 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219-strncpy-drivers-iio-proximity-sx9324-c-v4-1-d49ed29ee952@google.com>
References: <20231219-strncpy-drivers-iio-proximity-sx9324-c-v4-1-d49ed29ee952@google.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 19 Dec 2023 15:27:46 -0800
Message-ID: <CAE-0n515WA34B1ZJvz6dkvFiErmT0PL0K9bPWeV9JhkzXPxOGw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: sx9324: avoid copying property strings
To: Jonathan Cameron <jic23@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Justin Stitt (2023-12-19 13:34:15)
> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
>
> For the case where a format string is used, let's extract the parsing
> logic out into sx9324_parse_phase_prop(). We no longer need to create
> copies or allocate new memory.
>
> sx9324_parse_phase_prop() will simply return the default def value if it
> fails.
>
> This also cleans up some deprecated strncpy() uses [1].
>
> Furthermore, let's clean up this code further by removing some unused
> defines:
> |  #define SX9324_PIN_DEF "semtech,ph0-pin"
> |  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> |  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

