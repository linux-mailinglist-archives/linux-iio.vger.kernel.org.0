Return-Path: <linux-iio+bounces-16682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459EA59AD5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 17:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50173A3B73
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55922FE06;
	Mon, 10 Mar 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="AhYxiKbT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E622FDE2
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623644; cv=none; b=gbHzv+ZQtcZDtifgPfkuurUiYq8m2v20bvy33TjrmwJtOrAecF8j7x503qh0Bod8V5cFq8+AwThApvCETBox0/YTBz2TbJfo6ebN7VgsnppRpQKUxpvOiEBumqKl+p5uZsfMCt3b8Rz9qUYZH83mrYUFCuQ3au3MUI/8JPygMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623644; c=relaxed/simple;
	bh=T6iOa1jZH3wgWTSAzUB8I9yXEJW5ocA2pmnyyr8ieeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORciKdksaRTK8oaH6V3WmAFpvWPPoNp4jt9Ko5RBgyKMhAfI+SL0EVsFbmIzvBCk5sJaInEkJYXjGNcHFrC6xR5YnaMc1wJknLSuEFCvl37rxzfuFVWTSnXD7c3r9olf3i4ixRH20hQzzuRhGCsNDcdH2SEn2FtG1lqZBDhKARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=AhYxiKbT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff07872097so3104537b3.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741623641; x=1742228441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6iOa1jZH3wgWTSAzUB8I9yXEJW5ocA2pmnyyr8ieeg=;
        b=AhYxiKbTLT4VCSsgd/ZD5OXeuMxASNKAwHr7HvvzaO4vwMZoGbYlrHD6Sa9pGd9CHg
         7m49janNLJoL1FwCox9pf/Ep/f1IliG3xry20IaT1nuuXwNBRcYulToYfH0BQwImiN0Z
         hZdfyaZJPHQ4JyoamfqHyT/2dzMLfKjNydcIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623641; x=1742228441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6iOa1jZH3wgWTSAzUB8I9yXEJW5ocA2pmnyyr8ieeg=;
        b=fMlI16swTNbpg3F7FlSZr3FVAOAXw/up0/CeWUSZiKNU9JYPOxAObIpEj5suWOIb/U
         33lYSnZznUdAj95PrC8I0wQerd5QsP8iHfm2KxXLDsqcMRay1oEmdzEutFmaey+sIvNg
         //P9sBwOBU7YcXNJNrO60qKpMtBTelROg3szFqPRTkzcIXCxOvY6CCOj6sUzzO/ZOpSy
         60WkwyvN3q+8euvsM6KSDum8H9ebVQ8Udf4SbFBz2CtxT6WsnquDxpQCY+5Q3M3SwMA7
         qdzDftSI6YQqm6TdP9K0/jqWhv+KHajvMJjDlHudIeutnwUhJgrvuXk2RSpAADzl3GT4
         VAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyCGLmpFU0UIUjwrMLmIsSJLge6tOUYcgQuHWh1ol3iHpHljOqpl0C7suroMOqnMPApEJUu8uwtRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZn5yrj9bNS9KvCVSPQC5g+6ykZUmYAbciiWaCb+/lza71mOX
	2EVF5rNGgK4cKjIvmPBbijlqhvYtg2p9Vaqa04Hqjq2QtwZIpIXr6CxF0fqBLN5C3uUadRbGqEW
	vGLwmWMydJpBl39qJ1V3fj9G1XZwv6rvxzvFd
X-Gm-Gg: ASbGncu9ms019Dt2rjGaR2ZZdaJ83Lcf7TdxoiM6JJ9LfodRchwhzd8meIrz2ce+oET
	LPYEXWvgdZrRxHe2mSUg+3yaGEEVOnM5iU4S2bbqOGtxb/JgmmqjSTpNmXy1Ufa/C+wPo7izhIg
	Kjbo9jShr/5OWxCxfRto1tX1c4nds=
X-Google-Smtp-Source: AGHT+IEATwLgs4c10Hn/o/KpnRHaC9/EmHSULlF6S+MyWOY6uz29zZxyL5phU+mos9IlnqhGr01S3PTPa3io7zY2X1g=
X-Received: by 2002:a05:690c:6109:b0:6f9:56a2:80f9 with SMTP id
 00721157ae682-6febf3c2cc9mr176692547b3.27.1741623641365; Mon, 10 Mar 2025
 09:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z88Bstpob7Jueugd@lore-desk>
In-Reply-To: <Z88Bstpob7Jueugd@lore-desk>
From: Silvano Seva <s.seva@4sigma.it>
Date: Mon, 10 Mar 2025 17:20:30 +0100
X-Gm-Features: AQ5f1Jo2J-5qX7H_tLcvyVqMf_OJ7vZ7IojegLdd57E2VU8_5xZ7EmyYnmvUOLQ
Message-ID: <CALKJsrr6iahFVT-cycrvzkOKQAOvzAxo4trvWvXK0D1cEOy33Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:13=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> I guess it was v3 in this case :)
>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Regards,
> Lorenzo
>

Yes, sorry. Is the first patch I submit and I still need to get used
to some some parts of the workflow.

Thank you,
Silvano.

